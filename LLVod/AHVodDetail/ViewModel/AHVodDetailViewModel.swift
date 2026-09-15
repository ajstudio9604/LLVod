//
//  AHVodDetailViewModel.swift
//  LLVod
//

import Foundation
import Combine

@MainActor
final class AHVodDetailViewModel: ObservableObject {

    let route: AHVodDetailRoute

    @Published private(set) var isLoading = true
    @Published private(set) var payload: AHVodDetailPayload?
    @Published var errorMessage: String?

    @Published var selectedLineIndex = 0
    @Published var selectedEpisodeIndex = 0
    @Published private(set) var resolvedPlayURL = ""
    @Published private(set) var resolvedPlayHeaders: [String: String] = [:]
    @Published private(set) var isResolvingPlayURL = false
    @Published private(set) var playStatusMessage = "请选择集数"
    @Published private(set) var usedParserName = ""
    @Published private(set) var jxOptions: [AHVodJxOption] = []
    @Published var selectedJxIndex = 0
    @Published private(set) var isFavorited = false

    private var resolveTask: Task<Void, Never>?
    private var loadTask: Task<Void, Never>?

    private(set) var isActive = true

    private var pendingResumePosition: Double = 0

    private var currentPosition: Double = 0
    private var currentDuration: Double = 0

    private let resumeRecord: AHVodPlayRecord?

    init(route: AHVodDetailRoute, resumeRecord: AHVodPlayRecord? = nil) {
        self.route = route
        self.resumeRecord = resumeRecord
        self.isFavorited = AHVodLocalStore.isFavorited(route: route)
    }

    func activate() {
        isActive = true
    }

    func deactivate() {
        isActive = false
        resolveTask?.cancel()
        resolveTask = nil
        loadTask?.cancel()
        loadTask = nil
        isResolvingPlayURL = false
    }

    var currentLine: AHVodSourceLine? {
        guard let payload, payload.sourceLines.indices.contains(selectedLineIndex) else {
            return nil
        }
        return payload.sourceLines[selectedLineIndex]
    }

    var currentEpisodes: [AHVodEpisode] {
        currentLine?.episodes ?? []
    }

    var currentEpisode: AHVodEpisode? {
        guard currentEpisodes.indices.contains(selectedEpisodeIndex) else { return nil }
        return currentEpisodes[selectedEpisodeIndex]
    }

    func loadDetail() {
        loadTask?.cancel()
        activate()

        loadTask = Task {
            isLoading = true
            errorMessage = nil

            do {
                let loaded = try await AHVodDetailLoader.load(route: route)
                guard !Task.isCancelled, isActive else { return }

                let result = injectDownloadedEpisodes(into: loaded)
                payload = result
                restoreLastPlayed(in: result)
                reloadJxOptions()
                resolvePlayURL()
            } catch {
                guard !Task.isCancelled, isActive else { return }
                errorMessage = error.localizedDescription
            }

            if isActive {
                isLoading = false
            }
        }
    }

    func selectLine(at index: Int) {
        guard payload?.sourceLines.indices.contains(index) == true else { return }
        selectedLineIndex = index
        selectedEpisodeIndex = 0
        resetPlayProgress()
        reloadJxOptions()
        resolvePlayURL()
    }

    func selectEpisode(at index: Int) {
        guard currentEpisodes.indices.contains(index) else { return }
        selectedEpisodeIndex = index
        resetPlayProgress()
        resolvePlayURL()
    }

    func toggleFavorite() {
        isFavorited = AHVodLocalStore.toggleFavorite(
            route: route,
            title: payload?.title ?? route.name,
            pic: payload?.pic ?? route.pic
        )
    }

    func selectParser(at index: Int) {
        guard jxOptions.indices.contains(index) else { return }
        selectedJxIndex = index
        resolvePlayURL()
    }

    func retryResolve() {
        resolvePlayURL()
    }

    func playNextEpisode() {
        let next = selectedEpisodeIndex + 1
        guard currentEpisodes.indices.contains(next) else { return }
        selectEpisode(at: next)
    }

    private func injectDownloadedEpisodes(into payload: AHVodDetailPayload) -> AHVodDetailPayload {
        let title = payload.title.isEmpty ? route.name : payload.title
        let completed = AHDownloadManager.shared.completedTasks(title: title)
        guard !completed.isEmpty else { return payload }

        let episodes: [AHVodEpisode] = completed.enumerated().compactMap { index, task in
            guard let url = AHDownloadManager.shared.localPlayURL(for: task) else { return nil }
            return AHVodEpisode(id: index + 1, title: task.subtitle, path: url.absoluteString)
        }

        guard !episodes.isEmpty else { return payload }

        let localLine = AHVodSourceLine(
            id: "ah-local-cache",
            name: "本地缓存",
            episodes: episodes,
            parseURL: "",
            sourceTag: ""
        )

        return AHVodDetailPayload(
            title: payload.title,
            pic: payload.pic,
            actor: payload.actor,
            status: payload.status,
            intro: payload.intro,
            sourceLines: payload.sourceLines + [localLine],
            sourceConfig: payload.sourceConfig
        )
    }

    private func restoreLastPlayed(in payload: AHVodDetailPayload) {
        selectedLineIndex = 0
        selectedEpisodeIndex = 0
        resetPlayProgress()

        guard let record = resumeRecord ?? AHVodLocalStore.playRecord(route: route),
              !payload.sourceLines.isEmpty else {
            return
        }

        if let lineIndex = resolveLineIndex(record: record, in: payload) {
            selectedLineIndex = lineIndex
        }

        let episodes = payload.sourceLines[selectedLineIndex].episodes
        guard let episodeIndex = resolveEpisodeIndex(record: record, in: episodes) else {
            return
        }

        selectedEpisodeIndex = episodeIndex

        guard record.position > 0 else { return }
        pendingResumePosition = record.position
        currentPosition = record.position
        currentDuration = record.duration
    }

    private func resolveLineIndex(
        record: AHVodPlayRecord,
        in payload: AHVodDetailPayload
    ) -> Int? {
        let lines = payload.sourceLines

        if !record.lineName.isEmpty,
           lines.indices.contains(record.lineIndex),
           lines[record.lineIndex].name == record.lineName {
            return record.lineIndex
        }

        if !record.lineName.isEmpty,
           let index = lines.firstIndex(where: { $0.name == record.lineName }) {
            return index
        }

        for (index, line) in lines.enumerated() {
            if episodeIndex(in: line.episodes, record: record) != nil {
                return index
            }
        }

        return nil
    }

    private func resolveEpisodeIndex(
        record: AHVodPlayRecord,
        in episodes: [AHVodEpisode]
    ) -> Int? {
        episodeIndex(in: episodes, record: record)
    }

    private func episodeIndex(
        in episodes: [AHVodEpisode],
        record: AHVodPlayRecord
    ) -> Int? {
        if !record.episodePath.isEmpty,
           let index = episodes.firstIndex(where: { $0.path == record.episodePath }) {
            return index
        }

        if !record.episodeTitle.isEmpty,
           let index = episodes.firstIndex(where: {
               Self.episodeTitlesMatch($0.title, record.episodeTitle)
           }) {
            return index
        }

        if record.episodeIndex > 0, episodes.indices.contains(record.episodeIndex) {
            return record.episodeIndex
        }

        return nil
    }

    private static func episodeTitlesMatch(_ lhs: String, _ rhs: String) -> Bool {
        let a = normalizeEpisodeTitle(lhs)
        let b = normalizeEpisodeTitle(rhs)
        return !a.isEmpty && a == b
    }

    private static func normalizeEpisodeTitle(_ raw: String) -> String {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        let digits = trimmed.filter(\.isNumber)
        if let number = Int(digits) {
            return String(number)
        }
        return trimmed
    }

    func takeResumePosition() -> Double {
        let position = pendingResumePosition
        pendingResumePosition = 0
        return position
    }

    func savePlayProgress(position: Double, duration: Double, syncRemoteImmediately: Bool = false) {
        guard position.isFinite, position > 0 else { return }

        currentPosition = position
        currentDuration = duration.isFinite && duration > 0 ? duration : currentDuration
        savePlayRecord(syncRemoteImmediately: syncRemoteImmediately)
    }

    private func resetPlayProgress() {
        pendingResumePosition = 0
        currentPosition = 0
        currentDuration = 0
    }

    private func savePlayRecord(syncRemoteImmediately: Bool = false) {
        guard let payload, let line = currentLine, let episode = currentEpisode else { return }

        AHVodLocalStore.savePlayRecord(
            AHVodPlayRecord(
                title: payload.title.isEmpty ? route.name : payload.title,
                path: route.path,
                videoLinkId: route.videoLinkId,
                sourceName: route.sourceName,
                pic: payload.pic.isEmpty ? route.pic : payload.pic,
                zypath: route.zypath,
                lineIndex: selectedLineIndex,
                lineName: line.name,
                episodeIndex: selectedEpisodeIndex,
                episodeTitle: episode.title,
                episodePath: episode.path,
                position: storablePosition,
                duration: currentDuration
            ),
            syncRemoteImmediately: syncRemoteImmediately
        )
    }

    private var storablePosition: Double {
        guard currentPosition > 5 else { return 0 }
        if currentDuration > 0, currentPosition >= currentDuration - 15 { return 0 }
        return currentPosition
    }

    private func reloadJxOptions() {
        guard let line = currentLine else {
            jxOptions = []
            return
        }

        let keyword = AHVodJxPathLoader.resolveKeyword(
            sourceTag: line.sourceTag,
            episodeURL: line.episodes.first?.path ?? ""
        )
        jxOptions = AHVodJxPathLoader.buildJxOptions(
            jxpath: AHVodJxPathLoader.load(zypath: route.zypath),
            keyword: keyword,
            builtInParseURL: line.parseURL
        )
        selectedJxIndex = 0
    }

    private func resolvePlayURL() {
        resolveTask?.cancel()

        guard let payload, let line = currentLine, let episode = currentEpisode else {
            resolvedPlayURL = ""
            resolvedPlayHeaders = [:]
            playStatusMessage = "请选择集数"
            usedParserName = ""
            return
        }

        // 开始播放即写入记录并立刻同步远端
        savePlayRecord(syncRemoteImmediately: true)

        // 本地缓存的集不用解析，直接播（m3u8 走本地 HTTP 服务，直链是 file://）
        if episode.path.hasPrefix("file://") || AHLocalMediaServer.isLocalURL(episode.path) {
            resolvedPlayHeaders = [:]
            resolvedPlayURL = episode.path
            usedParserName = "本地缓存"
            playStatusMessage = ""
            isResolvingPlayURL = false
            return
        }

        resolveTask = Task {
            isResolvingPlayURL = true
            playStatusMessage = "正在解析播放地址..."
            resolvedPlayURL = ""
            resolvedPlayHeaders = [:]
            usedParserName = ""

            do {
                let result = try await AHVodPlayResolver.resolve(
                    episodeURL: episode.path,
                    detailPath: route.path,
                    sourceConfig: payload.sourceConfig,
                    sourceLine: line,
                    zypath: route.zypath,
                    preferredParserIndex: selectedJxIndex
                )

                // 退出页面或换集都会取消：完成结果一律丢掉，别再去起播
                guard !Task.isCancelled, isActive else { return }

                resolvedPlayHeaders = result.playerHeaders
                resolvedPlayURL = result.url
                usedParserName = result.usedParserName
                playStatusMessage = result.url.isEmpty ? "解析失败" : ""
            } catch {
                guard !Task.isCancelled, isActive else { return }
                resolvedPlayURL = ""
                resolvedPlayHeaders = [:]
                playStatusMessage = error.localizedDescription
            }

            if isActive {
                isResolvingPlayURL = false
            }
        }
    }
}
