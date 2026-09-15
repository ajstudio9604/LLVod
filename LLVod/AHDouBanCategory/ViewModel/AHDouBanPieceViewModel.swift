//
//  AHDouBanPieceViewModel.swift
//  LLVod
//

import Foundation
import Combine

@MainActor
final class AHDouBanPieceViewModel: ObservableObject {

    @Published private(set) var items: [AHDouBanPlaylistItem] = []
    @Published private(set) var isRefreshing = false
    @Published private(set) var isLoadingMore = false
    @Published var errorMessage: String?

    let category: String

    private var nextStart = 0
    private var hasMore = true
    private var hasLoaded = false

    private let pageSize = 30
    private let session: URLSession

    private let baseURL = "https://frodo.douban.com/api/v2/skynet/new_playlists"
    private let signSecret = "bf7dddc7c9cfe6f7"

    init(category: String, session: URLSession = .shared) {
        self.category = category
        self.session = session
    }

    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        await refresh()
    }

    func refresh() async {
        guard !isRefreshing else { return }

        isRefreshing = true
        errorMessage = nil

        defer { isRefreshing = false }

        do {
            let newItems = try await fetchPlaylists(start: 0)
            items = Self.deduplicated(newItems)
            nextStart = newItems.count
            hasMore = !newItems.isEmpty
            // 只有真拉到了才算加载过：失败或被切 tab 打断时不记，
            // 这一页下次露出来会重试，不会一直停在「暂无片单」
            hasLoaded = true
        } catch {
            report(error, action: "片单刷新失败")
        }
    }

    func loadMoreIfNeeded(currentItem: AHDouBanPlaylistItem) async {
        guard hasMore,
              !isLoadingMore,
              !isRefreshing,
              items.last?.id == currentItem.id else {
            return
        }

        isLoadingMore = true
        defer { isLoadingMore = false }

        do {
            let newItems = try await fetchPlaylists(start: nextStart)

            guard !newItems.isEmpty else {
                hasMore = false
                return
            }

            nextStart += newItems.count

            // 整页都是重复的就当到底了，否则末尾会一直挂着加载指示
            if append(newItems) == 0 {
                hasMore = false
            }
        } catch {
            report(error, action: "片单加载更多失败")
        }
    }

    @discardableResult
    private func append(_ newItems: [AHDouBanPlaylistItem]) -> Int {
        var seen = Set(items.map(\.id))
        let before = items.count

        for item in newItems where seen.insert(item.id).inserted {
            items.append(item)
        }

        return items.count - before
    }

    private static func deduplicated(
        _ newItems: [AHDouBanPlaylistItem]
    ) -> [AHDouBanPlaylistItem] {
        var seen = Set<String>()
        return newItems.filter { seen.insert($0.id).inserted }
    }

    private func report(_ error: Error, action: String) {
  
        if error is CancellationError { return }
        if let urlError = error as? URLError, urlError.code == .cancelled { return }

        errorMessage = error.localizedDescription
    }

    private func fetchPlaylists(start: Int) async throws -> [AHDouBanPlaylistItem] {
        let time = Int(Date().timeIntervalSince1970)
        let udid = Self.generateUdid()

        let pathPart = baseURL.components(separatedBy: ".com").dropFirst().joined(separator: ".com")
        let arg1 = pathPart.replacingOccurrences(of: "/", with: "%2F")
        let arg2 = String(time)
        let signInput = "GET&\(arg1)&\(arg2)"
        let sig = try CryptoUtil.hmacSha1(signInput, secret: signSecret, outputBase64: true)

        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "subject_type", value: "movie"),
            URLQueryItem(name: "category", value: category),
            URLQueryItem(name: "loc_id", value: "0"),
            URLQueryItem(name: "start", value: String(start)),
            URLQueryItem(name: "count", value: String(pageSize)),
            URLQueryItem(name: "udid", value: udid),
            URLQueryItem(name: "uuid", value: udid),
            URLQueryItem(name: "rom", value: "android"),
            URLQueryItem(name: "apikey", value: "0dad551ec0f84ed02907ff5c42e8ec70"),
            URLQueryItem(name: "s", value: "rexxar_new"),
            URLQueryItem(name: "channel", value: "Yingyongbao_Market"),
            URLQueryItem(name: "timezone", value: "Asia/Shanghai"),
            URLQueryItem(name: "device_id", value: udid),
            URLQueryItem(name: "os_rom", value: "android"),
            URLQueryItem(name: "apple", value: "c52fbb99b908be4d026954cc4374f16d"),
            URLQueryItem(name: "mooncake", value: "0f607264fc6318a92b9e13c65db7cd3c"),
            URLQueryItem(name: "sugar", value: "0"),
            URLQueryItem(name: "_ts", value: String(time)),
        ]

        // 签名是 base64，里面的 + / = 必须转义后再拼进 query。
        // URLComponents 不会转 +，服务端会把它当成空格，接口直接回
        // 996「签名错误」——大约三分之一的请求会中招，表现就是时好时坏
        guard var resolved = components else {
            throw NetworkError2.invalidURL
        }

        resolved.percentEncodedQuery = [
            resolved.percentEncodedQuery,
            "_sig=\(Self.escaped(sig))"
        ]
        .compactMap { $0 }
        .joined(separator: "&")

        guard let url = resolved.url else {
            throw NetworkError2.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        request.setValue(
            """
            Rexxar-Core/0.1.3 api-client/1 com.douban.frodo/7.9.0(216) \
            Android/28 product/Xiaomi11 rom/android network/wifi udid/\(udid) \
            platform/mobile com.douban.frodo/7.9.0(216) Rexxar/1.2.151 \
            platform/mobile 1.2.151
            """,
            forHTTPHeaderField: "User-Agent"
        )

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError2.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw NetworkError2.httpError(httpResponse.statusCode)
        }

        let decoded = try JSONDecoder().decode(DoubanPlaylistResponse.self, from: data)
        let rawItems = decoded.data.first?.items ?? []

        return rawItems.map { item in
            AHDouBanPlaylistItem(
                id: item.id,
                title: item.title,
                coverURL: item.coverURL ?? "",
                headerBgImage: item.headerBgImage ?? "",
                itemsCount: item.itemsCount ?? 0
            )
        }
    }

    private static let unreservedCharacters = CharacterSet(
        charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.!~*'()"
    )

    private static func escaped(_ value: String) -> String {
        value.addingPercentEncoding(withAllowedCharacters: unreservedCharacters) ?? value
    }

    private static func generateUdid() -> String {
        let chars = Array("abcdefghijklmnopqrstuvwxyz0123456789")
        return String((0..<40).map { _ in chars.randomElement()! })
    }
}
