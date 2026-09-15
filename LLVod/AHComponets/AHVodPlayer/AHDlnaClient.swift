//
//  AHDlnaClient.swift
//  LLVod
//
//  DLNA / UPnP 发现与投屏，对应 Flutter dlna_dart：
//  SSDP 搜 MediaRenderer，点选后 SetAVTransportURI + Play。
//

import Foundation
import Darwin
import Combine

struct AHDlnaDevice: Identifiable, Hashable {
    var id: String { usn.isEmpty ? controlURL : usn }
    let usn: String
    let name: String
    let location: String
    let controlURL: String
}

@MainActor
final class AHDlnaSearcher: ObservableObject {

    @Published private(set) var devices: [AHDlnaDevice] = []
    @Published private(set) var isSearching = false
    @Published var statusMessage: String?

    private var engine: AHDlnaSearchEngine?
    private var knownNames = Set<String>()

    func start() {
        stop()
        devices = []
        knownNames = []
        isSearching = true
        statusMessage = nil

        let engine = AHDlnaSearchEngine()
        self.engine = engine
        engine.onDevice = { [weak self] device in
            Task { @MainActor in
                self?.append(device)
            }
        }
        engine.start()
    }

    func stop() {
        engine?.stop()
        engine = nil
        isSearching = false
    }

    func cast(to device: AHDlnaDevice, url: String, title: String) async -> String? {
        do {
            try await AHDlnaSOAP.setURL(controlURL: device.controlURL, url: url, title: title)
            try await AHDlnaSOAP.play(controlURL: device.controlURL)
            return nil
        } catch {
            return error.localizedDescription
        }
    }

    private func append(_ device: AHDlnaDevice) {
        // 对齐 Flutter：跳过 Wireless 名称，并按 friendlyName 去重
        if device.name.contains("Wireless") { return }
        if knownNames.contains(device.name) { return }
        knownNames.insert(device.name)
        devices.append(device)
    }
}

// MARK: - SSDP

final class AHDlnaSearchEngine {

    var onDevice: ((AHDlnaDevice) -> Void)?

    private let queue = DispatchQueue(label: "com.llvod.dlna.ssdp")
    private var socketFD: Int32 = -1
    private var running = false
    private var seenLocations = Set<String>()

    private let searchTargets = [
        "urn:schemas-upnp-org:service:AVTransport:1",
        "urn:schemas-upnp-org:device:MediaRenderer:1"
    ]

    func start() {
        queue.async { [weak self] in
            self?.runLoop()
        }
    }

    func stop() {
        running = false
        if socketFD >= 0 {
            Darwin.close(socketFD)
            socketFD = -1
        }
    }

    private func runLoop() {
        running = true
        seenLocations.removeAll()

        let fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)
        guard fd >= 0 else { return }
        socketFD = fd

        var reuse: Int32 = 1
        setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &reuse, socklen_t(MemoryLayout<Int32>.size))
        var ttl: Int32 = 4
        setsockopt(fd, IPPROTO_IP, IP_MULTICAST_TTL, &ttl, socklen_t(MemoryLayout<Int32>.size))

        var timeout = timeval(tv_sec: 1, tv_usec: 0)
        setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout, socklen_t(MemoryLayout<timeval>.size))

        var addr = sockaddr_in()
        addr.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        addr.sin_family = sa_family_t(AF_INET)
        addr.sin_port = in_port_t(0).bigEndian
        addr.sin_addr = in_addr(s_addr: INADDR_ANY.bigEndian)
        _ = withUnsafePointer(to: &addr) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                bind(fd, $0, socklen_t(MemoryLayout<sockaddr_in>.size))
            }
        }

        let deadline = Date().addingTimeInterval(18)
        var lastSend = Date.distantPast

        while running, Date() < deadline {
            if Date().timeIntervalSince(lastSend) >= 2.5 {
                sendSearch(fd: fd)
                lastSend = Date()
            }
            receiveOnce(fd: fd)
        }

        if socketFD == fd {
            Darwin.close(fd)
            socketFD = -1
        }
    }

    private func sendSearch(fd: Int32) {
        var dest = sockaddr_in()
        dest.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        dest.sin_family = sa_family_t(AF_INET)
        dest.sin_port = in_port_t(1900).bigEndian
        dest.sin_addr.s_addr = inet_addr("239.255.255.250")

        for target in searchTargets {
            let packet = """
            M-SEARCH * HTTP/1.1\r
            HOST: 239.255.255.250:1900\r
            MAN: "ssdp:discover"\r
            MX: 3\r
            ST: \(target)\r
            \r

            """
            packet.withCString { bytes in
                withUnsafePointer(to: &dest) {
                    $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { pointer in
                        sendto(fd, bytes, strlen(bytes), 0, pointer, socklen_t(MemoryLayout<sockaddr_in>.size))
                    }
                }
            }
        }
    }

    private func receiveOnce(fd: Int32) {
        var buffer = [UInt8](repeating: 0, count: 4096)
        let count = recv(fd, &buffer, buffer.count, 0)
        guard count > 0 else { return }

        let text = String(bytes: buffer.prefix(Int(count)), encoding: .utf8) ?? ""
        guard let location = AHDlnaXML.headerValue(text, name: "LOCATION")
            ?? AHDlnaXML.headerValue(text, name: "Location") else { return }

        let usn = AHDlnaXML.headerValue(text, name: "USN") ?? location
        queue.async { [weak self] in
            self?.fetchDescription(location: location, usn: usn)
        }
    }

    private func fetchDescription(location: String, usn: String) {
        let key = location.lowercased()
        if seenLocations.contains(key) { return }
        seenLocations.insert(key)

        guard let url = URL(string: location) else { return }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        request.setValue("text/xml", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
            guard let self, self.running else { return }
            guard let data, let xml = String(data: data, encoding: .utf8) else { return }
            guard let device = AHDlnaXML.parseDevice(xml: xml, location: location, usn: usn) else {
                return
            }
            self.onDevice?(device)
        }
        task.resume()
    }
}

// MARK: - SOAP

enum AHDlnaSOAPError: LocalizedError {
    case invalidURL
    case http(Int)
    case failed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return ""
        case .http(let code):
            return ""
        case .failed:
            return ""
        }
    }
}

enum AHDlnaSOAP {

    static func setURL(controlURL: String, url: String, title: String) async throws {
        let didl = """
        <DIDL-Lite xmlns="urn:schemas-upnp-org:metadata-1-0/DIDL-Lite/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:upnp="urn:schemas-upnp-org:metadata-1-0/upnp/"><item id="0" parentID="-1" restricted="1"><dc:title>\(AHDlnaXML.escape(title))</dc:title><upnp:class>object.item.videoItem</upnp:class><res protocolInfo="http-get:*:video/mp4:*">\(AHDlnaXML.escape(url))</res></item></DIDL-Lite>
        """
        let body = """
        <u:SetAVTransportURI xmlns:u="urn:schemas-upnp-org:service:AVTransport:1">
          <InstanceID>0</InstanceID>
          <CurrentURI>\(AHDlnaXML.escape(url))</CurrentURI>
          <CurrentURIMetaData>\(AHDlnaXML.escape(didl))</CurrentURIMetaData>
        </u:SetAVTransportURI>
        """
        try await post(
            controlURL: controlURL,
            action: "urn:schemas-upnp-org:service:AVTransport:1#SetAVTransportURI",
            innerXML: body
        )
    }

    static func play(controlURL: String) async throws {
        let body = """
        <u:Play xmlns:u="urn:schemas-upnp-org:service:AVTransport:1">
          <InstanceID>0</InstanceID>
          <Speed>1</Speed>
        </u:Play>
        """
        try await post(
            controlURL: controlURL,
            action: "urn:schemas-upnp-org:service:AVTransport:1#Play",
            innerXML: body
        )
    }

    private static func post(controlURL: String, action: String, innerXML: String) async throws {
        guard let url = URL(string: controlURL) else { throw AHDlnaSOAPError.invalidURL }

        let envelope = """
        <?xml version="1.0" encoding="utf-8"?>
        <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
          <s:Body>
            \(innerXML)
          </s:Body>
        </s:Envelope>
        """

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 8
        request.setValue("text/xml; charset=\"utf-8\"", forHTTPHeaderField: "Content-Type")
        request.setValue("\"\(action)\"", forHTTPHeaderField: "SOAPACTION")
        request.httpBody = envelope.data(using: .utf8)

        let (data, response) = try await URLSession.shared.data(for: request)
        let code = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard (200...299).contains(code) else {
 
            throw AHDlnaSOAPError.http(code)
        }
    }
}

// MARK: - XML 小工具

enum AHDlnaXML {

    static func headerValue(_ text: String, name: String) -> String? {
        for line in text.split(whereSeparator: \.isNewline) {
            let raw = String(line)
            guard raw.lowercased().hasPrefix(name.lowercased() + ":") else { continue }
            return raw.dropFirst(name.count + 1)
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return nil
    }

    static func parseDevice(xml: String, location: String, usn: String) -> AHDlnaDevice? {
        let name = firstTag(xml, "friendlyName")?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !name.isEmpty else { return nil }

        guard let control = avTransportControlURL(in: xml, location: location) else {
            return nil
        }

        return AHDlnaDevice(usn: usn, name: name, location: location, controlURL: control)
    }

    static func escape(_ text: String) -> String {
        text
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&apos;")
    }

    private static func avTransportControlURL(in xml: String, location: String) -> String? {
        let pattern = #"<service>([\s\S]*?)</service>"#
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }

        let nsxml = xml as NSString
        let matches = regex.matches(in: xml, range: NSRange(location: 0, length: nsxml.length))
        for match in matches {
            let block = nsxml.substring(with: match.range(at: 1))
            let type = firstTag(block, "serviceType") ?? ""
            guard type.lowercased().contains("avtransport") else { continue }
            guard let control = firstTag(block, "controlURL") else { continue }
            return resolve(control, against: location)
        }
        return nil
    }

    private static func firstTag(_ xml: String, _ tag: String) -> String? {
        let pattern = "<\(tag)[^>]*>([\\s\\S]*?)</\(tag)>"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }
        let nsxml = xml as NSString
        guard let match = regex.firstMatch(in: xml, range: NSRange(location: 0, length: nsxml.length)),
              match.numberOfRanges > 1 else {
            return nil
        }
        return nsxml.substring(with: match.range(at: 1))
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&amp;", with: "&")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func resolve(_ path: String, against location: String) -> String {
        let trimmed = path.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.lowercased().hasPrefix("http://") || trimmed.lowercased().hasPrefix("https://") {
            return trimmed
        }
        guard let base = URL(string: location) else { return trimmed }
        return URL(string: trimmed, relativeTo: base)?.absoluteString ?? trimmed
    }
}
