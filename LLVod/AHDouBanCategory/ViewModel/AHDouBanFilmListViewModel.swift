//
//  AHDouBanFilmListViewModel.swift
//  LLVod
//

import Foundation
import Combine

@MainActor
final class AHDouBanFilmListViewModel: ObservableObject {

    @Published private(set) var items: [AHFilterMediaItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var isLoadingMore = false
    @Published var errorMessage: String?

    private let playlistID: String
    private let expectedCount: Int

    private var totalCount = 0
    private var nextStart = 0
    private var hasMore = true
    private var hasLoaded = false

    private let pageSize = 30
    private let signSecret = "bf7dddc7c9cfe6f7"
    private let session: URLSession

    init(playlistID: String, expectedCount: Int, session: URLSession = .shared) {
        self.playlistID = playlistID
        self.expectedCount = expectedCount
        self.session = session
    }

    private var baseURL: String {
        let isDoulist = !playlistID.isEmpty && playlistID.allSatisfy(\.isNumber)

        return isDoulist
            ? "https://frodo.douban.com/api/v2/doulist/\(playlistID)/posts"
            : "https://frodo.douban.com/api/v2/subject_collection/\(playlistID)/items"
    }

    func loadIfNeeded() async {
        guard !hasLoaded, !isLoading else { return }
        await reload()
    }

    func reload() async {
        isLoading = true
        errorMessage = nil
        hasMore = true

        let result = await ahDetachedResult { try await self.fetchItems(start: 0) }
        isLoading = false

        switch result {
        case .failure(let error):
            report(error, action: "片单详情加载失败")
        case .success(let page):
            items = Self.deduplicated(page.items)
            totalCount = page.total
            nextStart = page.items.count
            hasMore = !page.items.isEmpty && !reachedEnd
            // 只有真拉到了才算加载过，失败或被打断时下次进来还会重试
            hasLoaded = true
        }
    }

    func loadMoreIfNeeded(currentItem: AHFilterMediaItem) async {
        guard hasMore,
              !isLoadingMore,
              !isLoading,
              items.last?.id == currentItem.id else {
            return
        }

        isLoadingMore = true
        defer { isLoadingMore = false }

        let result = await ahDetachedResult { try await self.fetchItems(start: self.nextStart) }

        switch result {
        case .failure(let error):
            report(error, action: "片单详情加载更多失败")
        case .success(let page):
            guard !page.items.isEmpty else {
                hasMore = false
                return
            }

            if page.total > 0 {
                totalCount = page.total
            }
            nextStart += page.items.count

            // 整页都是已有的就当到底了，否则底部会一直挂着加载指示
            if append(page.items) == 0 {
                hasMore = false
                return
            }

            hasMore = !reachedEnd
        }
    }

    private var reachedEnd: Bool {
        let total = totalCount > 0 ? totalCount : expectedCount
        guard total > 0 else { return false }
        return items.count >= total
    }

    @discardableResult
    private func append(_ newItems: [AHFilterMediaItem]) -> Int {
        var seen = Set(items.map(Self.contentKey))
        let before = items.count

        for item in newItems where seen.insert(Self.contentKey(item)).inserted {
            items.append(item)
        }

        return items.count - before
    }

    private static func deduplicated(
        _ newItems: [AHFilterMediaItem]
    ) -> [AHFilterMediaItem] {
        var seen = Set<String>()
        return newItems.filter { seen.insert(contentKey($0)).inserted }
    }

    private static func contentKey(_ item: AHFilterMediaItem) -> String {
        "\(item.title)|\(item.imageURL)"
    }

    private func report(_ error: Error, action: String) {
      
        if error is CancellationError { return }
        if let urlError = error as? URLError, urlError.code == .cancelled { return }

        errorMessage = error.localizedDescription
    }

    private struct Page {
        let items: [AHFilterMediaItem]
        let total: Int
    }

    private func fetchItems(start: Int) async throws -> Page {
        let time = Int(Date().timeIntervalSince1970)
        let udid = Self.generateUdid()
        let endpoint = baseURL

        let pathPart = endpoint
            .components(separatedBy: ".com")
            .dropFirst()
            .joined(separator: ".com")
        let arg1 = pathPart.replacingOccurrences(of: "/", with: "%2F")
        let signInput = "GET&\(arg1)&\(time)"
        let sig = try CryptoUtil.hmacSha1(signInput, secret: signSecret, outputBase64: true)

        guard var components = URLComponents(string: endpoint) else {
            throw NetworkError2.invalidURL
        }

        components.queryItems = [
            URLQueryItem(name: "start", value: String(start)),
            URLQueryItem(name: "count", value: String(pageSize)),
            URLQueryItem(name: "updated_at", value: ""),
            URLQueryItem(name: "items_only", value: "1"),
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
        // URLComponents 不会转 +，服务端会把它当成空格，接口直接回 996「签名错误」
        components.percentEncodedQuery = [
            components.percentEncodedQuery,
            "_sig=\(Self.escaped(sig))"
        ]
        .compactMap { $0 }
        .joined(separator: "&")

        guard let url = components.url else {
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

        let decoded = try JSONDecoder().decode(DoubanFilmListResponse.self, from: data)

        let items = decoded.subjects.compactMap { subject -> AHFilterMediaItem? in
            guard let title = subject.title, !title.isEmpty else { return nil }

            return AHFilterMediaItem(
                title: title,
                subtitle: subject.displaySubtitle,
                imageURL: subject.posterURL
            )
        }

        return Page(items: items, total: decoded.total ?? 0)
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
