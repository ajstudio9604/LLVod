//
//  AHDownloadManager.swift
//  LLVod
//
//  m3u8 / 直链下载管理，对应 Flutter DownloadM3U8Util
//
//  m3u8 的处理方式：把媒体播放列表里的分片逐个下到任务目录，
//  同时改写出一份只引用本地文件名的 index.m3u8，AVPlayer 直接播这个文件就能离线看。
//

import Foundation
import Combine

@MainActor
final class AHDownloadManager: ObservableObject {

    static let shared = AHDownloadManager()

    @Published private(set) var tasks: [AHDownloadTask] = []

    private var runningTaskId: String?
    private var pausedIds: Set<String> = []
    private var pumpTask: Task<Void, Never>?

    private let segmentConcurrency = 6

    private let storageKey = "影片下载任务cache"

    private init() {
        // 离线播放要用，提前拉起来省掉首次播放的等待
        AHLocalMediaServer.shared.warmUp()
        load()
        // 上次进程被杀时留下的 downloading 状态要退回等待，否则永远不会被调度
        for index in tasks.indices where tasks[index].status == .downloading {
            tasks[index].status = .pending
        }
        save()
        pump()
    }

    // MARK: - 对外接口

    func task(title: String, subtitle: String) -> AHDownloadTask? {
        let id = AHDownloadTask.makeId(title: title, subtitle: subtitle)
        return tasks.first { $0.id == id }
    }

    func completedTasks(title: String) -> [AHDownloadTask] {
        tasks.filter { $0.title == title && $0.status == .completed }
    }

    @discardableResult
    func addToQueue(
        url: String,
        title: String,
        subtitle: String,
        pic: String,
        zypath: String = "",
        headers: [String: String] = [:]
    ) -> AHDownloadTask {
        let kind: AHDownloadKind = url.contains(".m3u8") ? .m3u8 : .file
        var task = AHDownloadTask(
            url: url,
            title: title,
            subtitle: subtitle,
            pic: pic,
            zypath: zypath,
            headers: headers,
            kind: kind
        )

        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            // 已存在的任务：完成的不动，其它情况用新地址重来
            guard tasks[index].status != .completed else { return tasks[index] }
            task.status = .pending
            tasks[index] = task
        } else {
            tasks.insert(task, at: 0)
        }

        pausedIds.remove(task.id)
        save()
        pump()
        return task
    }

    func pause(_ id: String) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        guard tasks[index].isActive else { return }

        pausedIds.insert(id)
        tasks[index].status = .paused
        save()
    }

    func resume(_ id: String) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        guard tasks[index].status == .paused || tasks[index].status == .failed else { return }

        pausedIds.remove(id)
        tasks[index].status = .pending
        tasks[index].errorMessage = nil
        save()
        pump()
    }

    func remove(_ id: String) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        let task = tasks[index]

        pausedIds.insert(id)
        tasks.remove(at: index)
        save()

        let directory = AHDownloadPaths.directory(for: task)
        Task.detached {
            try? FileManager.default.removeItem(at: directory)
        }
    }

    func localPlayURL(for task: AHDownloadTask) -> URL? {
        guard task.status == .completed, let relativePath = task.localFilePath else { return nil }

        let fileURL = AHDownloadPaths.absoluteURL(relativePath: relativePath)
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return nil }

        guard task.kind == .m3u8 else { return fileURL }
        return AHLocalMediaServer.shared.url(forRelativePath: relativePath)
    }

    // MARK: - 调度

    private func pump() {
        guard pumpTask == nil else { return }

        pumpTask = Task { [weak self] in
            while true {
                guard let self, let next = self.nextPendingTask() else { break }
                await self.run(next)
            }
            self?.pumpTask = nil
        }
    }

    private func nextPendingTask() -> AHDownloadTask? {
        tasks.first { $0.status == .pending && !pausedIds.contains($0.id) }
    }

    private func run(_ task: AHDownloadTask) async {
        runningTaskId = task.id
        update(task.id) {
            $0.status = .downloading
            $0.errorMessage = nil
        }

        do {
            let relativePath: String
            switch task.kind {
            case .m3u8:
                relativePath = try await downloadM3U8(task)
            case .file:
                relativePath = try await downloadFile(task)
            }

            if pausedIds.contains(task.id) {
                update(task.id) { $0.status = .paused }
            } else {
                update(task.id) {
                    $0.status = .completed
                    $0.progress = 1
                    $0.localFilePath = relativePath
                    $0.completionTime = Date()
                }
            }
        } catch is CancellationError {
            update(task.id) { $0.status = .paused }
        } catch {
            if pausedIds.contains(task.id) {
                update(task.id) { $0.status = .paused }
            } else {
                update(task.id) {
                    $0.status = .failed
                    $0.errorMessage = error.localizedDescription
                }
            }
        }

        runningTaskId = nil
        save()
    }

    // MARK: - m3u8

    private func downloadM3U8(_ task: AHDownloadTask) async throws -> String {
        let directory = AHDownloadPaths.directory(for: task)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)

        // 有广告规则就用过滤后的播放列表，没有就取原始的
        var playlist = await AHHlsAdFilter.filteredPlaylist(
            playURL: task.url,
            zypath: task.zypath,
            headers: task.headers
        )

        if playlist == nil {
            playlist = await AHHlsAdFilter.filter(
                m3u8URL: task.url,
                headers: task.headers,
                adRegexPattern: "(?!)"
            )
        }

        guard let playlist, !playlist.isEmpty else {
            throw AHDownloadError.playlistUnavailable
        }

        let parsed = AHM3U8Playlist(content: playlist)
        guard !parsed.segmentURLs.isEmpty else {
            throw AHDownloadError.noSegments
        }

        update(task.id) {
            $0.totalSegments = parsed.segmentURLs.count
            $0.completedSegments = 0
        }

        // 加密 key 和 fMP4 的初始化分片也要落地，否则离线播不了
        var localNames: [String: String] = [:]
        for (index, resource) in parsed.attributeURIs.enumerated() {
            let absolute = parsed.absoluteURI(resource)
            let name = "res\(index).\(URL(string: absolute)?.pathExtension ?? "key")"
            let destination = directory.appendingPathComponent(name)
            if !FileManager.default.fileExists(atPath: destination.path) {
                let data = try await AHDownloadHTTP.data(absolute, headers: task.headers)
                try data.write(to: destination)
            }
            localNames[resource] = name
        }

        let localPlaylist = parsed.rewritten(resourceNames: localNames)
        let indexURL = directory.appendingPathComponent("index.m3u8")
        try localPlaylist.write(to: indexURL, atomically: true, encoding: .utf8)

        try await downloadSegments(
            parsed.segmentURLs,
            task: task,
            directory: directory
        )

        return "\(task.relativeDirectory)/index.m3u8"
    }

    private func downloadSegments(
        _ urls: [String],
        task: AHDownloadTask,
        directory: URL
    ) async throws {
        let headers = task.headers
        let total = urls.count
        let taskId = task.id

        try await withThrowingTaskGroup(of: Void.self) { group in
            var nextIndex = 0
            var completed = 0

            while nextIndex < min(segmentConcurrency, total) {
                let url = urls[nextIndex]
                let destination = directory.appendingPathComponent(
                    AHM3U8Playlist.segmentName(nextIndex, url: url)
                )
                group.addTask {
                    try await AHDownloadManager.fetchSegment(
                        url: url,
                        headers: headers,
                        destination: destination
                    )
                }
                nextIndex += 1
            }

            while try await group.next() != nil {
                if pausedIds.contains(taskId) {
                    group.cancelAll()
                    throw CancellationError()
                }

                completed += 1
                update(taskId) {
                    $0.completedSegments = completed
                    $0.progress = Double(completed) / Double(total)
                }

                // 每 20 片写一次盘，避免频繁序列化
                if completed % 20 == 0 {
                    save()
                }

                if nextIndex < total {
                    let url = urls[nextIndex]
                    let destination = directory.appendingPathComponent(
                        AHM3U8Playlist.segmentName(nextIndex, url: url)
                    )
                    group.addTask {
                        try await AHDownloadManager.fetchSegment(
                            url: url,
                            headers: headers,
                            destination: destination
                        )
                    }
                    nextIndex += 1
                }
            }
        }
    }

    private nonisolated static func fetchSegment(
        url: String,
        headers: [String: String],
        destination: URL
    ) async throws {
        // 已存在的分片直接跳过，等于断点续传
        if FileManager.default.fileExists(atPath: destination.path) {
            return
        }

        let data = try await AHDownloadHTTP.data(url, headers: headers)
        try data.write(to: destination)
    }

    // MARK: - 直链

    private func downloadFile(_ task: AHDownloadTask) async throws -> String {
        let directory = AHDownloadPaths.directory(for: task)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)

        let ext = URL(string: task.url)?.pathExtension ?? ""
        let name = ext.isEmpty ? "video.mp4" : "video.\(ext)"
        let destination = directory.appendingPathComponent(name)

        if !FileManager.default.fileExists(atPath: destination.path) {
            let data = try await AHDownloadHTTP.data(task.url, headers: task.headers)
            try data.write(to: destination)
        }

        update(task.id) {
            $0.totalSegments = 1
            $0.completedSegments = 1
            $0.progress = 1
        }

        return "\(task.relativeDirectory)/\(name)"
    }

    // MARK: - 持久化

    private func update(_ id: String, _ transform: (inout AHDownloadTask) -> Void) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        transform(&tasks[index])
    }

    private func load() {
        guard let raw = UserDefaults.standard.string(forKey: storageKey),
              let data = raw.data(using: .utf8),
              let list = try? JSONDecoder().decode([AHDownloadTask].self, from: data) else {
            tasks = []
            return
        }
        tasks = list
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(tasks),
              let text = String(data: data, encoding: .utf8) else {
            return
        }
        UserDefaults.standard.set(text, forKey: storageKey)
    }
}

enum AHDownloadError: LocalizedError {
    case playlistUnavailable
    case noSegments

    var errorDescription: String? {
        switch self {
        case .playlistUnavailable:
            return ""
        case .noSegments:
            return ""
        }
    }
}

struct AHM3U8Playlist {

    private let lines: [String]
    let segmentURLs: [String]

    let attributeURIs: [String]

    init(content: String) {
        let lines = content
            .split(separator: "\n", omittingEmptySubsequences: false)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        self.lines = lines
        self.segmentURLs = lines.filter { !$0.hasPrefix("#") }

        var uris: [String] = []
        for line in lines where AHM3U8Playlist.carriesResource(line) {
            guard let uri = AHM3U8Playlist.attributeURI(in: line), !uris.contains(uri) else { continue }
            uris.append(uri)
        }
        self.attributeURIs = uris
    }

    static func segmentName(_ index: Int, url: String) -> String {
        let ext = URL(string: url)?.pathExtension.lowercased() ?? ""
        let known = ["ts", "mp4", "m4s", "m4a", "aac", "mp3"]
        return "seg\(index).\(known.contains(ext) ? ext : "ts")"
    }

    func absoluteURI(_ uri: String) -> String {
        guard let base = segmentURLs.first(where: { $0.hasPrefix("http") }) else { return uri }
        return AHHlsAdFilter.joinURL(base: base, relative: uri)
    }

    func rewritten(resourceNames: [String: String]) -> String {
        var segmentIndex = 0

        var output = lines.map { line -> String in
            if AHM3U8Playlist.carriesResource(line) {
                guard let uri = AHM3U8Playlist.attributeURI(in: line),
                      let name = resourceNames[uri] else {
                    return line
                }
                return line.replacingOccurrences(of: uri, with: name)
            }

            if line.hasPrefix("#") {
                return line
            }

            let name = AHM3U8Playlist.segmentName(segmentIndex, url: line)
            segmentIndex += 1
            return name
        }

        // 缺 ENDLIST 会被当成直播流，一直重载播放列表
        if !output.contains("#EXT-X-ENDLIST") {
            output.append("#EXT-X-ENDLIST")
        }

        return output.joined(separator: "\n")
    }

    private static func carriesResource(_ line: String) -> Bool {
        line.hasPrefix("#EXT-X-KEY") || line.hasPrefix("#EXT-X-MAP")
    }

    private static func attributeURI(in line: String) -> String? {
        guard let range = line.range(of: "URI=\"") else { return nil }
        let rest = line[range.upperBound...]
        guard let end = rest.firstIndex(of: "\"") else { return nil }
        let uri = String(rest[..<end])
        return uri.isEmpty ? nil : uri
    }
}
