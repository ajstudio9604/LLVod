//
//  AHFilterViewModel.swift
//  LLVod
//

import Foundation
import Combine

@MainActor
final class AHFilterViewModel: ObservableObject {

    @Published private(set) var items: [AHFilterMediaItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var isLoadingMore = false
    @Published var errorMessage: String?

    @Published var selectedMediaTypeIndex = 0
    @Published var selectedGenreIndex = 0
    @Published var selectedRegionIndex = 0
    @Published var selectedYearIndex = 0
    @Published var selectedSortIndex = 0

    let yearOptions = AHFilterOptions.yearOptions()

    var selectedFilterSummary: String {
        [
            AHFilterOptions.mediaTypes[selectedMediaTypeIndex],
            AHFilterOptions.genres[selectedGenreIndex],
            AHFilterOptions.regions[selectedRegionIndex],
            yearOptions[selectedYearIndex],
            AHFilterOptions.sortOptions[selectedSortIndex]
        ].joined(separator: "·")
    }

    private var nextStart = 0
    private var hasMore = true
    private var hasLoaded = false
    private var generation = 0

    private let pageSize = 24
    private let signSecret = "bf7dddc7c9cfe6f7"
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        await reload()
    }

    func selectMediaType(at index: Int) async {
        guard selectedMediaTypeIndex != index else { return }
        selectedMediaTypeIndex = index
        await reload()
    }

    func selectGenre(at index: Int) async {
        guard selectedGenreIndex != index else { return }
        selectedGenreIndex = index
        await reload()
    }

    func selectRegion(at index: Int) async {
        guard selectedRegionIndex != index else { return }
        selectedRegionIndex = index
        await reload()
    }

    func selectYear(at index: Int) async {
        guard selectedYearIndex != index else { return }
        selectedYearIndex = index
        await reload()
    }

    func selectSort(at index: Int) async {
        guard selectedSortIndex != index else { return }
        selectedSortIndex = index
        await reload()
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

        let requestedGeneration = generation
        let result = await ahDetachedResult { try await self.fetchItems(start: self.nextStart) }

        // 期间换过筛选条件，这一页已经不属于当前列表了
        guard requestedGeneration == generation else { return }

        switch result {
        case .failure(let error):
            report(error, action: "分类加载更多失败")
        case .success(let newItems):
            guard !newItems.isEmpty else {
                hasMore = false
                return
            }

            nextStart += newItems.count
            // 整页都是已有内容就当到底了，否则末尾会一直挂着加载指示
            if append(newItems) == 0 {
                hasMore = false
            }
        }
    }

    private func reload() async {
        isLoading = true
        errorMessage = nil
        hasMore = true
        generation += 1

        let requestedGeneration = generation
        let result = await ahDetachedResult { try await self.fetchItems(start: 0) }

        // 连着点两个筛选条件时，先发的那次结果已经过期：直接丢掉，
        // 也不要把 isLoading 关掉，界面等最后那次请求收尾就行
        guard requestedGeneration == generation else { return }
        isLoading = false

        switch result {
        case .failure(let error):
            items = []
            nextStart = 0
            report(error, action: "分类请求失败")
        case .success(let newItems):
            items = Self.deduplicated(newItems)
            nextStart = newItems.count
            hasMore = !newItems.isEmpty
            // 只有真拉到了才算加载过：首屏失败或被切页面打断时不记，
            // 这一页下次露出来会重试，不会一直停在「暂无内容」
            hasLoaded = true
        }
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

    private func fetchItems(start: Int) async throws -> [AHFilterMediaItem] {
        let mediaType = AHFilterOptions.mediaTypes[selectedMediaTypeIndex]
        let genre = AHFilterOptions.genres[selectedGenreIndex]
        let region = AHFilterOptions.regions[selectedRegionIndex]
        let year = yearOptions[selectedYearIndex]
        let sortOption = AHFilterOptions.sortOptions[selectedSortIndex]

        let apiPath = mediaType == "电影"
            ? "/api/v2/movie/recommend"
            : "/api/v2/tv/recommend"

        let tags = buildTags(
            mediaType: mediaType,
            genre: genre,
            region: region,
            year: year
        )

        let sort = buildSortCode(from: sortOption)
        let timestamp = Int(Date().timeIntervalSince1970)
        let udid = Self.generateUdid()
        let encodedPath = apiPath.replacingOccurrences(of: "/", with: "%2F")
        let signInput = "GET&\(encodedPath)&\(timestamp)"
        let signature = try CryptoUtil.hmacSha1(signInput, secret: signSecret, outputBase64: true)

        var components = URLComponents()
        components.scheme = "https"
        components.host = "frodo.douban.com"
        components.path = apiPath
        components.queryItems = [
            URLQueryItem(name: "tags", value: tags),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(
                name: "selected_categories",
                value: "{\"类型\":\"\",\"地区\":\"\"}"
            ),
            URLQueryItem(name: "refresh", value: "0"),
            URLQueryItem(name: "start", value: String(start)),
            URLQueryItem(name: "count", value: String(pageSize)),
            URLQueryItem(name: "udid", value: udid),
            URLQueryItem(name: "rom", value: "android"),
            URLQueryItem(name: "apikey", value: "0dad551ec0f84ed02907ff5c42e8ec70"),
            URLQueryItem(name: "s", value: "rexxar_new"),
            URLQueryItem(name: "channel", value: "Xiaomi_Market"),
            URLQueryItem(name: "timezone", value: "Asia/Shanghai"),
            URLQueryItem(name: "device_id", value: udid),
            URLQueryItem(name: "os_rom", value: "android"),
            URLQueryItem(name: "sugar", value: "0"),
            URLQueryItem(name: "loc_id", value: "108288"),
            URLQueryItem(name: "_ts", value: String(timestamp)),
        ]

        // 签名是 base64，里面的 + / = 必须转义后再拼进 query。
        // URLComponents 不会转 +，服务端会把它当成空格，接口直接回 996「签名错误」；
        // 而 .urlPathAllowed 这个字符集本身就包含 + / =，拿它转义等于没转，
        // 大约六成请求会中招，表现就是页面时好时坏
        let encodedQuery = components.percentEncodedQuery ?? ""
        components.percentEncodedQuery = "\(encodedQuery)&_sig=\(Self.escaped(signature))"

        guard let url = components.url else {
            throw NetworkError2.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        request.setValue(
            """
            Rexxar-Core/0.1.3 api-client/1 com.douban.frodo/7.122.0(349) Android/28 \
            udid/\(udid) douban_udid/\(udid) model/Vidda 85VX3S brand/Hisense \
            rom/android network/wifi platform/AndroidPad foldable/0 \
            product/Vidda 85VX3S vendor/Hisense Rexxar/1.2.151 platform/AndroidPad 1.2.151
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

        let decoded = try JSONDecoder().decode(DoubanRecommendResponse.self, from: data)
        return (decoded.items ?? []).map(mapItem)
    }

    private func buildTags(
        mediaType: String,
        genre: String,
        region: String,
        year: String
    ) -> String {
        let typeFilter = genre == "全部" ? "" : ",\(genre)"

        var normalizedRegion = region == "全部" ? "" : region
        switch normalizedRegion {
        case "大陆":
            normalizedRegion = "中国大陆"
        case "香港":
            normalizedRegion = "中国香港"
        case "台湾":
            normalizedRegion = "中国台湾"
        default:
            break
        }

        let areaFilter = normalizedRegion.isEmpty ? "" : ",\(normalizedRegion)"

        var yearFilter = ""
        if year != "全部" {
            if year.contains("-") {
                yearFilter = ",\(year.replacingOccurrences(of: "-", with: ","))"
            } else {
                yearFilter = ",\(year)"
            }
        }

        return "\(mediaType)\(typeFilter)\(areaFilter)\(yearFilter)"
    }

    private func buildSortCode(from option: String) -> String {
        switch option {
        case "热门":
            return "T"
        case "热度":
            return "R"
        case "评分":
            return "S"
        default:
            return "U"
        }
    }

    private func mapItem(_ item: DoubanRecommendItem) -> AHFilterMediaItem {
        var subtitle = item.rating?.displayValue ?? ""
        if subtitle.isEmpty {
            subtitle = item.cardSubtitle ?? item.type ?? ""
        }

        return AHFilterMediaItem(
            title: item.title,
            subtitle: subtitle,
            imageURL: item.pic?.bestURL ?? ""
        )
    }

    private static func generateUdid() -> String {
        let chars = Array("0123456789abcdef")
        return String((0..<40).map { _ in chars.randomElement()! })
    }

    private static let unreservedCharacters = CharacterSet(
        charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.!~*'()"
    )

    private static func escaped(_ value: String) -> String {
        value.addingPercentEncoding(withAllowedCharacters: unreservedCharacters) ?? value
    }
}
