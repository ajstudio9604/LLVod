//
//  HomeApiViewModel.swift
//  LLVod
//
//  Created by minusapple on 2026/7/13.
//

import Foundation
import Combine

@MainActor
final class HomeApiViewModel: ObservableObject {

    // 首页顶部 Tab 固定数据
    let homeTypes: [AHHomeTabItem] = [
        AHHomeTabItem(name: "推荐", mode: 0),
        AHHomeTabItem(name: "电视剧", mode: 1),
        AHHomeTabItem(name: "电影", mode: 2),
        AHHomeTabItem(name: "动漫", mode: 3),
        AHHomeTabItem(name: "综艺", mode: 4),
    ]

    @Published private(set) var hotMovieList: [HotMediaItem] = []

    @Published private(set) var hotTVList: [HotMediaItem] = []

    @Published private(set) var hotAnimeList: [HotMediaItem] = []

    @Published private(set) var hotVarietyList: [HotMediaItem] = []

    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private var hasLoaded = false

    private let session: URLSession
    private let frodoAPIKey = "0ac44ae016490db2204ce0a042db2916"

    init(session: URLSession = .shared) {
        self.session = session
    }

    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        await getHttp(force: false)
    }

    func getHttp() async {
        await getHttp(force: true)
    }

    private func getHttp(force: Bool) async {
        if !force, hasLoaded { return }
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        // 请求放独立 Task 里跑：切走 TabBar / Pager 会取消视图的 .task，
        // 不摘出来的话 URLSession 会被一起掐掉，表现为「网络出问题」
        let result = await ahDetachedResult { try await self.fetchAll() }
        isLoading = false

        switch result {
        case .failure(let error):
            report(error, action: "首页请求失败")
        case .success(let page):
            hotMovieList = page.movies
            hotTVList = page.television
            hotAnimeList = page.anime
            hotVarietyList = page.variety

            // 四个接口各自独立，只要有一块成功就算加载过，
            // 避免动漫被风控时整页永远停在转圈、切回来又重打
            if page.hasAnyData {
                hasLoaded = true
            } else if let message = page.firstErrorMessage {
                errorMessage = message
            }
        }
    }

    private struct Page {
        var movies: [HotMediaItem] = []
        var television: [HotMediaItem] = []
        var anime: [HotMediaItem] = []
        var variety: [HotMediaItem] = []
        var firstErrorMessage: String?

        var hasAnyData: Bool {
            !movies.isEmpty || !television.isEmpty || !anime.isEmpty || !variety.isEmpty
        }
    }

    private func fetchAll() async throws -> Page {
        async let movies = settle { try await fetchCollection(collectionName: "movie_real_time_hotest") }
        async let television = settle { try await fetchCollection(collectionName: "tv_real_time_hotest") }
        async let anime = settle { try await fetchAnime() }
        async let variety = settle { try await fetchCollection(collectionName: "show_hot") }

        let results = await (movies, television, anime, variety)
        var page = Page()

        switch results.0 {
        case .success(let items): page.movies = items
        case .failure(let error): page.firstErrorMessage = error.localizedDescription
        }

        switch results.1 {
        case .success(let items): page.television = items
        case .failure(let error):
            page.firstErrorMessage = page.firstErrorMessage ?? error.localizedDescription
        }

        switch results.2 {
        case .success(let items): page.anime = items
        case .failure(let error):
            break
        }

        switch results.3 {
        case .success(let items): page.variety = items
        case .failure(let error):
            page.firstErrorMessage = page.firstErrorMessage ?? error.localizedDescription
        }

        return page
    }

    private func settle<T>(
        _ operation: () async throws -> T
    ) async -> Result<T, Error> {
        do {
            return .success(try await operation())
        } catch {
            return .failure(error)
        }
    }

    private func report(_ error: Error, action: String) {
       
        if error is CancellationError { return }
        if let urlError = error as? URLError, urlError.code == .cancelled { return }
        errorMessage = error.localizedDescription
    }

    private func fetchCollection(
        collectionName: String
    ) async throws -> [HotMediaItem] {

        var components = URLComponents(
            string: "https://frodo.douban.com/api/v2/subject_collection/\(collectionName)/items"
        )

        components?.queryItems = [
            URLQueryItem(name: "apikey", value: frodoAPIKey),
            URLQueryItem(name: "start", value: "0"),
            URLQueryItem(name: "count", value: "10")
        ]

        guard let url = components?.url else {
            throw NetworkError2.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        applyFrodoHeaders(to: &request)

        let response: DoubanCollectionResponse = try await requestJSON(
            request,
            responseType: DoubanCollectionResponse.self
        )

        return response.subjectCollectionItems.map { item in
            HotMediaItem(
                title: item.title,
                subtitle: item.cardSubtitle ?? "",
                imageURL: item.pic?.normal ?? ""
            )
        }
    }

    private func fetchAnime() async throws -> [HotMediaItem] {
        var components = URLComponents(
            string: "https://movie.douban.com/j/new_search_subjects"
        )

        components?.queryItems = [
            URLQueryItem(name: "sort", value: "U"),
            URLQueryItem(name: "tags", value: "动漫"),
            URLQueryItem(name: "range", value: "0,10"),
            URLQueryItem(name: "start", value: "0")
        ]

        guard let url = components?.url else {
            throw NetworkError2.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        applyMovieHeaders(to: &request)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError2.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw NetworkError2.httpError(httpResponse.statusCode)
        }

        // 被风控时仍是 HTTP 200，body 是 {"msg":"...","r":1}，没有 data
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           json["data"] == nil {
            let message = json["msg"] as? String ?? "动漫列表暂不可用"
            throw NetworkError2.requestFailed(message)
        }

        let decoded = try JSONDecoder().decode(DoubanAnimeResponse.self, from: data)
        return decoded.data.map { item in
            HotMediaItem(
                title: item.title,
                subtitle: item.rate ?? "",
                imageURL: item.cover ?? ""
            )
        }
    }

    private func requestJSON<T: Decodable>(
        _ request: URLRequest,
        responseType: T.Type
    ) async throws -> T {

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError2.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw NetworkError2.httpError(httpResponse.statusCode)
        }

        guard !data.isEmpty else {
            throw NetworkError2.emptyData
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            
            throw error
        }
    }

    private func applyFrodoHeaders(to request: inout URLRequest) {
        request.setValue(
            """
            Mozilla/5.0 (Windows NT 6.1; WOW64) \
            AppleWebKit/537.36 (KHTML, like Gecko) \
            Chrome/53.0.2785.143 Safari/537.36 \
            MicroMessenger/7.0.9.501 NetType/WIFI \
            MiniProgramEnv/Windows WindowsWechat
            """,
            forHTTPHeaderField: "User-Agent"
        )
        request.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(
            "https://servicewechat.com/wx2f9b06c1de1ccfca/84/page-frame.html",
            forHTTPHeaderField: "Referer"
        )
    }

    private func applyMovieHeaders(to request: inout URLRequest) {
        request.setValue(
            """
            Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) \
            AppleWebKit/605.1.15 (KHTML, like Gecko) \
            Version/18.0 Mobile/15E148 Safari/604.1
            """,
            forHTTPHeaderField: "User-Agent"
        )
        request.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        request.setValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
        request.setValue("https://movie.douban.com/", forHTTPHeaderField: "Referer")
    }
}
