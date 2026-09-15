//
//  AHLocalMediaServer.swift
//  LLVod
//
//  本地 HTTP 服务，只监听 127.0.0.1，用来播放已下载的 m3u8。
//
//  AVPlayer 不支持从 file:// 播 HLS（播放列表必须来自 http/https），
//  所以下载好的 index.m3u8 和分片要经过这一层才能离线播放。
//

import Foundation
import Network

final class AHLocalMediaServer {

    static let shared = AHLocalMediaServer()

    private let queue = DispatchQueue(label: "com.llvod.localmediaserver")
    private let lock = NSLock()

    private var listener: NWListener?
    private var listeningPort: UInt16?

    private let root: URL

    private let chunkSize = 256 * 1024

    private init() {
        root = AHDownloadPaths.root
    }

    // MARK: - 对外接口

    func warmUp() {
        queue.async { [weak self] in
            _ = self?.ensureRunning()
        }
    }

    func url(forRelativePath relativePath: String) -> URL? {
        guard let port = ensureRunning() else { return nil }

        var components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = Int(port)
        components.path = relativePath.hasPrefix("/") ? relativePath : "/\(relativePath)"
        return components.url
    }

    static func isLocalURL(_ text: String) -> Bool {
        guard let host = URL(string: text)?.host else { return false }
        return host == "127.0.0.1" || host == "localhost"
    }

    // MARK: - 启动

    private func currentPort() -> UInt16? {
        lock.lock()
        defer { lock.unlock() }
        return listeningPort
    }

    private func ensureRunning() -> UInt16? {
        if let port = currentPort() { return port }

        startListener()

        // 正常几毫秒就绪，warmUp 之后这里基本不会真的等
        let deadline = Date().addingTimeInterval(1.5)
        while Date() < deadline {
            if let port = currentPort() { return port }
            Thread.sleep(forTimeInterval: 0.01)
        }

        return nil
    }

    private func startListener() {
        lock.lock()
        guard listener == nil else {
            lock.unlock()
            return
        }

        let parameters = NWParameters.tcp
        parameters.allowLocalEndpointReuse = true
        // 只绑回环，不对外暴露
        parameters.requiredLocalEndpoint = NWEndpoint.hostPort(host: "127.0.0.1", port: .any)

        guard let listener = try? NWListener(using: parameters) else {
            lock.unlock()
            return
        }

        self.listener = listener
        lock.unlock()

        listener.stateUpdateHandler = { [weak self] state in
            guard let self else { return }

            switch state {
            case .ready:
                self.lock.lock()
                self.listeningPort = listener.port?.rawValue
                self.lock.unlock()

            case .failed, .cancelled:
                self.lock.lock()
                self.listeningPort = nil
                self.listener = nil
                self.lock.unlock()

            default:
                break
            }
        }

        listener.newConnectionHandler = { [weak self] connection in
            self?.accept(connection)
        }

        listener.start(queue: queue)
    }

    // MARK: - 连接处理

    private func accept(_ connection: NWConnection) {
        connection.stateUpdateHandler = { state in
            switch state {
            case .failed, .cancelled:
                connection.cancel()
            default:
                break
            }
        }

        connection.start(queue: queue)
        receiveHead(connection, buffer: Data())
    }

    private func receiveHead(_ connection: NWConnection, buffer: Data) {
        connection.receive(minimumIncompleteLength: 1, maximumLength: 8192) { [weak self] data, _, isComplete, error in
            guard let self else {
                connection.cancel()
                return
            }

            var buffer = buffer
            if let data {
                buffer.append(data)
            }

            if let range = buffer.range(of: Data("\r\n\r\n".utf8)) {
                let head = String(decoding: buffer[..<range.lowerBound], as: UTF8.self)
                self.respond(head: head, on: connection)
                return
            }

            // 请求头异常大或者连接断了就丢掉
            if error != nil || isComplete || buffer.count > 32 * 1024 {
                connection.cancel()
                return
            }

            self.receiveHead(connection, buffer: buffer)
        }
    }

    private func respond(head: String, on connection: NWConnection) {
        let lines = head.split(separator: "\r\n", omittingEmptySubsequences: false).map(String.init)
        let parts = (lines.first ?? "").split(separator: " ").map(String.init)

        guard parts.count >= 2 else {
            send(status: "400 Bad Request", on: connection)
            return
        }

        let method = parts[0].uppercased()
        guard method == "GET" || method == "HEAD" else {
            send(status: "405 Method Not Allowed", on: connection)
            return
        }

        guard let fileURL = resolve(path: parts[1]) else {
            send(status: "404 Not Found", on: connection)
            return
        }

        guard let size = try? FileManager.default
            .attributesOfItem(atPath: fileURL.path)[.size] as? UInt64 ?? 0 else {
            send(status: "404 Not Found", on: connection)
            return
        }

        let requested = range(in: lines, fileSize: size)

        var headers = [
            "Content-Type: \(Self.contentType(for: fileURL))",
            "Content-Length: \(requested.length)",
            "Accept-Ranges: bytes",
            "Connection: close"
        ]

        var status = "200 OK"
        if requested.isPartial {
            status = "206 Partial Content"
            headers.append(
                "Content-Range: bytes \(requested.offset)-\(requested.offset + requested.length - 1)/\(size)"
            )
        }

        guard method == "GET", requested.length > 0 else {
            send(status: status, headers: headers, on: connection)
            return
        }

        guard let handle = try? FileHandle(forReadingFrom: fileURL) else {
            send(status: "500 Internal Server Error", on: connection)
            return
        }

        let head = "HTTP/1.1 \(status)\r\n\(headers.joined(separator: "\r\n"))\r\n\r\n"
        connection.send(
            content: Data(head.utf8),
            completion: .contentProcessed { [weak self] error in
                guard error == nil else {
                    try? handle.close()
                    connection.cancel()
                    return
                }
                self?.sendBody(
                    handle: handle,
                    offset: requested.offset,
                    remaining: requested.length,
                    on: connection
                )
            }
        )
    }

    private func sendBody(
        handle: FileHandle,
        offset: UInt64,
        remaining: UInt64,
        on connection: NWConnection
    ) {
        guard remaining > 0 else {
            try? handle.close()
            connection.cancel()
            return
        }

        let length = Int(min(UInt64(chunkSize), remaining))
        handle.seek(toFileOffset: offset)
        let data = handle.readData(ofLength: length)

        guard !data.isEmpty else {
            try? handle.close()
            connection.cancel()
            return
        }

        connection.send(
            content: data,
            completion: .contentProcessed { [weak self] error in
                guard error == nil, let self else {
                    try? handle.close()
                    connection.cancel()
                    return
                }

                self.sendBody(
                    handle: handle,
                    offset: offset + UInt64(data.count),
                    remaining: remaining - UInt64(data.count),
                    on: connection
                )
            }
        )
    }

    private func send(
        status: String,
        headers: [String] = ["Content-Length: 0", "Connection: close"],
        on connection: NWConnection
    ) {
        let response = "HTTP/1.1 \(status)\r\n\(headers.joined(separator: "\r\n"))\r\n\r\n"
        connection.send(
            content: Data(response.utf8),
            completion: .contentProcessed { _ in
                connection.cancel()
            }
        )
    }

    // MARK: - 路径与 Range

    private func resolve(path: String) -> URL? {
        let raw = path.split(separator: "?").first.map(String.init) ?? path
        guard let decoded = raw.removingPercentEncoding ?? Optional(raw), !decoded.isEmpty else {
            return nil
        }

        let relative = decoded.hasPrefix("/") ? String(decoded.dropFirst()) : decoded
        guard !relative.isEmpty, !relative.contains("..") else { return nil }

        let fileURL = root.appendingPathComponent(relative).standardizedFileURL

        // 防目录穿越
        guard fileURL.path.hasPrefix(root.standardizedFileURL.path),
              FileManager.default.fileExists(atPath: fileURL.path) else {
            return nil
        }

        return fileURL
    }

    private struct RequestedRange {
        let offset: UInt64
        let length: UInt64
        let isPartial: Bool
    }

    private func range(in lines: [String], fileSize: UInt64) -> RequestedRange {
        let full = RequestedRange(offset: 0, length: fileSize, isPartial: false)

        guard let header = lines.first(where: { $0.lowercased().hasPrefix("range:") }),
              let value = header.split(separator: ":").last?
                .trimmingCharacters(in: .whitespaces)
                .replacingOccurrences(of: "bytes=", with: ""),
              !value.isEmpty else {
            return full
        }

        let bounds = value.split(separator: "-", omittingEmptySubsequences: false).map(String.init)
        guard let first = bounds.first else { return full }

        // bytes=-500 表示最后 500 字节
        if first.isEmpty {
            guard bounds.count > 1, let suffix = UInt64(bounds[1]), suffix > 0 else { return full }
            let length = min(suffix, fileSize)
            return RequestedRange(offset: fileSize - length, length: length, isPartial: true)
        }

        guard let start = UInt64(first), start < fileSize else { return full }

        var end = fileSize - 1
        if bounds.count > 1, let parsed = UInt64(bounds[1]), parsed >= start {
            end = min(parsed, fileSize - 1)
        }

        return RequestedRange(offset: start, length: end - start + 1, isPartial: true)
    }

    private static func contentType(for url: URL) -> String {
        switch url.pathExtension.lowercased() {
        case "m3u8", "m3u":
            return "application/vnd.apple.mpegurl"
        case "ts":
            return "video/mp2t"
        case "mp4", "m4s", "m4v":
            return "video/mp4"
        case "m4a":
            return "audio/mp4"
        case "aac":
            return "audio/aac"
        case "vtt":
            return "text/vtt"
        default:
            return "application/octet-stream"
        }
    }
}
