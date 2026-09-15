//
//  AHRankViewModel.swift
//  LLVod
//
//  豆瓣榜单：周榜合并侧栏 + 年度 / 类型(地区)切换 + 合集明细
//

import Foundation
import Combine

@MainActor
final class AHRankViewModel: ObservableObject {

    enum Mode: Equatable {
        case weekly
        case year(String)
        case category(kind: Kind, key: String)
    }

    enum Kind: String {
        case movie
        case tv
    }

    @Published private(set) var sidebar: [AHRankCollection] = []
    @Published private(set) var selectedCollection: AHRankCollection?
    @Published private(set) var items: [AHRankItem] = []
    @Published private(set) var yearTabs: [AHRankTab] = []
    @Published private(set) var movieCategoryTabs: [AHRankTab] = []
    @Published private(set) var tvCategoryTabs: [AHRankTab] = []
    @Published private(set) var mode: Mode = .weekly
    @Published private(set) var isLoadingShell = false
    @Published private(set) var isLoadingItems = false
    @Published var errorMessage: String?

    private var weeklySidebar: [AHRankCollection] = []
    private var hasLoadedShell = false
    private let decoder = JSONDecoder()

    // MARK: - Public

    func loadIfNeeded() async {
        guard !hasLoadedShell, !isLoadingShell else { return }
        await reloadShell()
    }

    func reloadShell() async {
        isLoadingShell = true
        errorMessage = nil
        defer { isLoadingShell = false }

        let result = await ahDetachedResult { try await self.fetchWeeklyShell() }

        switch result {
        case .failure(let error):
            report(error, action: "榜单壳加载失败")
        case .success(let shell):
            yearTabs = shell.yearTabs
            movieCategoryTabs = shell.movieCategoryTabs
            tvCategoryTabs = shell.tvCategoryTabs
            weeklySidebar = shell.weekly
            mode = .weekly
            sidebar = weeklySidebar
            hasLoadedShell = true

            let preferred = weeklySidebar.first(where: { $0.id == "tv_global_best_weekly" })
                ?? weeklySidebar.first
            if let preferred {
                await selectCollection(preferred)
            }
        }
    }

    func selectCollection(_ collection: AHRankCollection) async {
        guard selectedCollection?.id != collection.id || items.isEmpty else { return }
        selectedCollection = collection
        await loadItems(for: collection.id)
    }

    func selectWeekly() async {
        mode = .weekly
        sidebar = weeklySidebar
        let target = selectedCollection.flatMap { current in
            weeklySidebar.first(where: { $0.id == current.id })
        } ?? weeklySidebar.first
        if let target {
            await selectCollection(target)
        }
    }

    func selectYear(_ year: String) async {
        isLoadingShell = true
        errorMessage = nil
        defer { isLoadingShell = false }

        let result = await ahDetachedResult { try await self.fetchYearRanks(year: year) }
        switch result {
        case .failure(let error):
            report(error, action: "年度榜单加载失败")
        case .success(let collections):
            guard !collections.isEmpty else {
                errorMessage = "暂无 \(year) 年度榜单"
                return
            }
            mode = .year(year)
            sidebar = collections
            await selectCollection(collections[0])
        }
    }

    func selectCategory(kind: Kind, key: String) async {
        isLoadingShell = true
        errorMessage = nil
        defer { isLoadingShell = false }

        let result = await ahDetachedResult {
            try await self.fetchCategoryRanks(kind: kind, category: key)
        }
        switch result {
        case .failure(let error):
            report(error, action: "类型榜单加载失败")
        case .success(let collections):
            guard !collections.isEmpty else {
                errorMessage = "暂无该分类榜单"
                return
            }
            mode = .category(kind: kind, key: key)
            sidebar = collections
            await selectCollection(collections[0])
        }
    }

    // MARK: - Fetch

    private struct Shell {
        let weekly: [AHRankCollection]
        let yearTabs: [AHRankTab]
        let movieCategoryTabs: [AHRankTab]
        let tvCategoryTabs: [AHRankTab]
    }

    private func fetchWeeklyShell() async throws -> Shell {
        async let movieData = AHDouBanFrodoClient.get(path: "/api/v2/movie/rank_list")
        async let tvData = AHDouBanFrodoClient.get(path: "/api/v2/tv/rank_list")

        let movie = try decoder.decode(AHRankListResponse.self, from: try await movieData)
        let tv = try decoder.decode(AHRankListResponse.self, from: try await tvData)

        let movieWeekly = movie.groups
            .first(where: { $0.type == "weekly" })?
            .selectedCollections ?? []
        let tvWeekly = tv.groups
            .first(where: { $0.type == "weekly" })?
            .selectedCollections ?? []

        // 截图侧栏：电影口碑 + 电视四周榜（不含实时热门 / Top250）
        var weekly: [AHRankCollection] = []
        if let movieBest = movieWeekly.first(where: { $0.id == "movie_weekly_best" }) {
            weekly.append(movieBest)
        }
        let tvOrder = [
            "tv_chinese_best_weekly",
            "tv_global_best_weekly",
            "show_chinese_best_weekly",
            "show_global_best_weekly"
        ]
        for id in tvOrder {
            if let item = tvWeekly.first(where: { $0.id == id }) {
                weekly.append(item)
            }
        }
        if weekly.isEmpty {
            weekly = Array(movieWeekly.prefix(1)) + tvWeekly
        }

        let yearTabs = (movie.groups.first(where: { $0.type == "year" })?.tabs).flatMap { $0.isEmpty ? nil : $0 }
            ?? tv.groups.first(where: { $0.type == "year" })?.tabs
            ?? []

        return Shell(
            weekly: weekly,
            yearTabs: yearTabs,
            movieCategoryTabs: movie.groups.first(where: { $0.type == "category" })?.tabs ?? [],
            tvCategoryTabs: tv.groups.first(where: { $0.type == "category" })?.tabs ?? []
        )
    }

    private func fetchYearRanks(year: String) async throws -> [AHRankCollection] {
        async let movieData = AHDouBanFrodoClient.get(
            path: "/api/v2/movie/year_ranks",
            extraQuery: [URLQueryItem(name: "year", value: year)]
        )
        async let tvData = AHDouBanFrodoClient.get(
            path: "/api/v2/tv/year_ranks",
            extraQuery: [URLQueryItem(name: "year", value: year)]
        )

        let movie = try decoder.decode(AHRankYearResponse.self, from: try await movieData)
        let tv = try decoder.decode(AHRankYearResponse.self, from: try await tvData)

        let movieCols = movie.groups.flatMap(\.selectedCollections)
        let tvCols = tv.groups.flatMap(\.selectedCollections)
        return movieCols + tvCols
    }

    private func fetchCategoryRanks(kind: Kind, category: String) async throws -> [AHRankCollection] {
        let path = kind == .movie
            ? "/api/v2/movie/category_ranks"
            : "/api/v2/tv/category_ranks"

        let data = try await AHDouBanFrodoClient.get(
            path: path,
            extraQuery: [
                URLQueryItem(name: "category", value: category),
                URLQueryItem(name: "start", value: "0"),
                URLQueryItem(name: "count", value: "20")
            ]
        )
        let response = try decoder.decode(AHRankCategoryResponse.self, from: data)
        return response.selectedCollections
    }

    private func loadItems(for collectionID: String) async {
        guard !collectionID.isEmpty else { return }
        isLoadingItems = true
        defer { isLoadingItems = false }

        let result = await ahDetachedResult {
            try await self.fetchItems(collectionID: collectionID)
        }

        switch result {
        case .failure(let error):
            items = []
            report(error, action: "榜单明细加载失败")
        case .success(let page):
            items = page.items
            if let meta = page.collection {
                selectedCollection = meta
            }
        }
    }

    private struct ItemsPage {
        let items: [AHRankItem]
        let collection: AHRankCollection?
    }

    private func fetchItems(collectionID: String) async throws -> ItemsPage {
        let data = try await AHDouBanFrodoClient.get(
            path: "/api/v2/subject_collection/\(collectionID)/items",
            extraQuery: [
                URLQueryItem(name: "start", value: "0"),
                URLQueryItem(name: "count", value: "30"),
                URLQueryItem(name: "updated_at", value: ""),
                URLQueryItem(name: "items_only", value: "0")
            ]
        )
        let response = try decoder.decode(AHRankItemsResponse.self, from: data)
        return ItemsPage(
            items: response.subjectCollectionItems,
            collection: response.subjectCollection
        )
    }

    private func report(_ error: Error, action: String) {
          if error is CancellationError { return }
        if let urlError = error as? URLError, urlError.code == .cancelled { return }
        errorMessage = error.localizedDescription
    }
}
