//
//  AHSearchViewModel.swift
//  LLVod
//

import Foundation
import Combine

@MainActor
final class AHSearchViewModel: ObservableObject {

    @Published var keyword = ""
    @Published private(set) var pageState: AHSearchPageState = .idle
    @Published private(set) var hotItems: [AHSearchHotItem] = []
    @Published private(set) var historyItems: [String] = []
    @Published private(set) var suggestionItems: [String] = []
    @Published private(set) var sourceNames: [String] = []
    @Published private(set) var selectedSource: String?
    @Published private(set) var isSearching = false
    @Published var errorMessage: String?

    private var sourceResults: [String: [AHSearchResultItem]] = [:]
    private var vodMap: [String: FilmItemModel] = [:]
    private var activeZypath: String?

    private var suggestionTask: Task<Void, Never>?
    private var searchTask: Task<Void, Never>?
    private let batchManager = SearchBatchRequestManager()

    private var lastSearchedKeyword: String?

    var showHistorySection: Bool {
        !historyItems.isEmpty
    }

    var currentResults: [AHSearchResultItem] {
        guard let selectedSource else { return [] }
        return sourceResults[selectedSource] ?? []
    }

    func loadInitialData() {
        loadHistory()
        loadHotSearch()
    }

    func configure(initialKeyword: String?) {
        guard let initialKeyword, !initialKeyword.isEmpty else { return }

        // 从详情返回时 .task 会再跑；同关键词已有结果就别重搜
        let trimmed = initialKeyword.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed == lastSearchedKeyword,
           pageState == .results || pageState == .searching || pageState == .empty {
            keyword = trimmed
            return
        }

        keyword = initialKeyword
        performSearch(keyword: initialKeyword)
    }

    func onKeywordChanged(_ text: String) {
        keyword = text

        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty {
            clearKeyword()
            return
        }

        // 刚搜过的词说明这次变化来自回填，不能再拉建议把结果盖掉
        guard trimmed != lastSearchedKeyword else { return }

        suggestionTask?.cancel()
        suggestionTask = Task {
            try? await Task.sleep(nanoseconds: 220_000_000)
            guard !Task.isCancelled else { return }
            await fetchSuggestions(for: text)
        }
    }

    func clearKeyword() {
        suggestionTask?.cancel()
        searchTask?.cancel()
        keyword = ""
        suggestionItems = []
        sourceNames = []
        sourceResults = [:]
        selectedSource = nil
        activeZypath = nil
        lastSearchedKeyword = nil
        isSearching = false
        pageState = .idle
    }

    func submitSearch() {
        let trimmed = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            errorMessage = "搜索内容不可为空"
            return
        }

        performSearch(keyword: trimmed)
    }

    func search(with keyword: String) {
        self.keyword = keyword
        performSearch(keyword: keyword)
    }

    func selectSource(_ source: String) {
        selectedSource = source
    }

    func detailRoute(for item: AHSearchResultItem) -> AHVodDetailRoute? {
        guard let zypath = activeZypath else { return nil }

        return AHVodDetailRoute(
            name: item.title,
            path: item.path,
            sourceName: item.sourceName,
            videoLinkId: item.pathId,
            pic: item.imageURL,
            zypath: zypath
        )
    }

    func vod(for item: AHSearchResultItem) -> FilmItemModel? {
        if let cached = vodMap[item.id] {
            return cached
        }

        let vod = makeFilmItem(from: item)
        vodMap[item.id] = vod
        return vod
    }

    func clearHistory() {
        historyItems = []
        UserDefaults.standard.removeObject(forKey: AHSearchStorage.historyKey)
    }

    func removeHistory(at index: Int) {
        guard historyItems.indices.contains(index) else { return }
        historyItems.remove(at: index)

        if historyItems.isEmpty {
            UserDefaults.standard.removeObject(forKey: AHSearchStorage.historyKey)
        } else {
            SearchStorage.saveStringList(AHSearchStorage.historyKey, list: historyItems)
        }
    }

    private func performSearch(keyword: String) {
        suggestionTask?.cancel()
        searchTask?.cancel()
        suggestionItems = []
        lastSearchedKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines)

        searchTask = Task {
            isSearching = true
            pageState = .searching
            errorMessage = nil
            sourceNames = []
            sourceResults = [:]
            selectedSource = nil
            vodMap.removeAll()

            defer {
                isSearching = false
            }

            let normalized = normalizeSearchText(keyword)

            do {
                try await Task.sleep(nanoseconds: 200_000_000)
                guard !Task.isCancelled else { return }

                await batchManager.cancelAll()

                let subscription = try await AHSearchSubscriptionService.loadActiveSubscription()
                activeZypath = subscription.zypath

                let factories = AHSearchEngine.makeRequestParamFactories(
                    sources: subscription.sources,
                    keyword: normalized
                )

                guard !factories.isEmpty else {
                    errorMessage = "当前订阅没有可用的搜索源"
                    pageState = .empty
                    return
                }

                let sourceOrder = subscription.sources.compactMap { $0["源名字"] as? String }

                // 对齐 Flutter batchRequestAsReady：JS 建参完成即发 HTTP
                await batchManager.batchRequestAsReady(factories) { result in
                    guard !Task.isCancelled else { return }
                    guard result.statusCode == 200,
                          let response = result.data,
                          !response.isEmpty,
                          result.index < subscription.sources.count else {
                        return
                    }

                    let source = subscription.sources[result.index]
                    // 自定义规则源要走 JS，解析本身是异步的
                    let items = await AHSearchEngine.parseResponse(
                        source: source,
                        response: response,
                        realURI: result.realURI
                    )

                    await MainActor.run {
                        guard !Task.isCancelled else { return }
                        guard !items.isEmpty else { return }

                        let sourceName = source["源名字"] as? String ?? "搜索结果"
                        var grouped = self.sourceResults
                        grouped[sourceName, default: []].append(contentsOf: items)

                        for item in items {
                            self.vodMap[item.id] = self.makeFilmItem(from: item)
                        }

                        self.sourceResults = grouped
                        // 按订阅站源顺序展示，不要按字母排序（否则和 Android 侧栏差很多）
                        self.sourceNames = sourceOrder.filter { grouped[$0] != nil }
                        if self.selectedSource == nil {
                            self.selectedSource = self.sourceNames.first
                        }

                        // 慢源还在跑，先把已到的结果显示出来，不用等全部返回
                        self.pageState = .results
                    }
                }

                if Task.isCancelled { return }

                if sourceResults.isEmpty {
                    pageState = .empty
                } else {
                    saveHistory(normalized)
                    pageState = .results
                }
            } catch {
                if !Task.isCancelled {
                    sourceNames = []
                    sourceResults = [:]
                    selectedSource = nil
                    errorMessage = error.localizedDescription
                    pageState = .empty
                }
            }
        }
    }

    private func fetchSuggestions(for text: String) async {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        do {
            let encoded = trimmed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? trimmed
            let url = "https://suggest.video.iqiyi.com/?if=mobile&key=\(encoded)"
            let response = try await SearchHTTPClient.get(
                url,
                headers: [
                    "Content-Type": "application/x-www-form-urlencoded;charset=utf-8",
                    "Content-Encoding": "gzip"
                ]
            )

            guard keyword.trimmingCharacters(in: .whitespacesAndNewlines) == trimmed else {
                return
            }

            let decoded = try JSONDecoder().decode(
                IQiyiSuggestResponse.self,
                from: Data(response.utf8)
            )
            let names = (decoded.data ?? []).prefix(10).map(\.name)

            if names.isEmpty {
                suggestionItems = []
                pageState = .idle
            } else {
                suggestionItems = Array(names)
                pageState = .suggesting
            }
        } catch {
            suggestionItems = []
        }
    }

    private func loadHotSearch() {
        hotItems = AHSearchHotService.loadCachedHotItems()

        Task {
            await AHSearchHotService.fetchAndCacheHotSearch()
            let refreshed = AHSearchHotService.loadHotItemsAfterFetch()
            if !refreshed.isEmpty {
                hotItems = refreshed
            }
        }
    }

    private func loadHistory() {
        historyItems = Array(
            SearchStorage.rslzStringList(AHSearchStorage.historyKey)
                .prefix(AHSearchStorage.maxHistoryCount)
        )
    }

    private func saveHistory(_ keyword: String) {
        var list = historyItems
        list.removeAll { $0 == keyword }
        list.insert(keyword, at: 0)
        list = Array(list.prefix(AHSearchStorage.maxHistoryCount))
        historyItems = list
        SearchStorage.saveStringList(AHSearchStorage.historyKey, list: list)
    }

    private func normalizeSearchText(_ text: String) -> String {
        var result = text

        if let colonIndex = result.firstIndex(where: { $0 == ":" || $0 == "：" || $0 == " " }) {
            result = String(result[..<colonIndex])
        }

        return result.replacingOccurrences(of: ",", with: "，")
    }

    private func makeFilmItem(from item: AHSearchResultItem) -> FilmItemModel {
        let vod = FilmItemModel()
        vod.id = item.pathId.isEmpty ? item.id : item.pathId
        vod.name = item.title
        vod.remark = item.status

        let cover = FilmCoverImageModel()
        cover.thumbnailPath = item.imageURL
        vod.coverImage = cover

        let video = VideosItemModel()
        video.id = item.pathId
        video.path = item.path
        video.sourceCn = item.sourceName
        video.source = item.sourceName
        vod.videos = [video]

        return vod
    }
}
