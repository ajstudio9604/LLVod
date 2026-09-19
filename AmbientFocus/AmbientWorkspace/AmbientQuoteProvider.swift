import Foundation

/// 全屏播放页展示的一句文案：正文加可选出处，来自网络接口或场景内置副标题。
struct AmbientQuote: Codable, Equatable, Sendable {
    let text: String
    /// 出处或注解，例如“温庭筠《更漏子》”或英文原句；没有时不显示第二行。
    let attribution: String?
}

/// 依次轮换三个免费文案接口拉取一句话，成功后写入本地缓存；全部失败时返回 nil，由界面回退到内置文案。
@MainActor
final class AmbientQuoteProvider {
    static let shared = AmbientQuoteProvider()

    /// 文案来源，按顺序轮换；一次拉取从当前来源开始，失败则顺延到下一个，直到全部尝试一遍。
    private enum Source: CaseIterable {
        case jinrishici, hitokoto, iciba
    }

    private static let cacheKey = "com.workspace.playback.quote.cache"
    private static let tokenKey = "com.workspace.playback.quote.jinrishici.token"
    private let session: URLSession
    private var nextSourceIndex = Int.random(in: 0..<Source.allCases.count)
    private var inflight: Task<AmbientQuote?, Never>?

    /// 最近一次成功拉取的文案，进入全屏时先展示它，等待新文案到达后再平滑替换。
    private(set) var cached: AmbientQuote? {
        didSet {
            guard let cached else { return }
            UserDefaults.standard.set(try? JSONEncoder().encode(cached), forKey: Self.cacheKey)
        }
    }

    private init() {
        let configuration = URLSessionConfiguration.ephemeral
        // 单个来源最多等待 6 秒，避免弱网下长时间占用；界面在等待期间已展示缓存或内置文案。
        configuration.timeoutIntervalForRequest = 6
        configuration.timeoutIntervalForResource = 8
        configuration.waitsForConnectivity = false
        session = URLSession(configuration: configuration)
        if let data = UserDefaults.standard.data(forKey: Self.cacheKey),
           let saved = try? JSONDecoder().decode(AmbientQuote.self, from: data) {
            cached = saved
        }
    }

    /// 启动时预热一次缓存，不关心结果。
    func prefetch() {
        Task { _ = await fetch() }
    }

    /// 拉取一句新文案；同一时间只保留一个进行中的请求，并发调用共享同一结果。
    /// 传入 avoiding 时会跳过与当前展示相同的文案，尽量保证轻点后内容有变化。
    func fetch(avoiding current: AmbientQuote? = nil) async -> AmbientQuote? {
        if let inflight { return await inflight.value }
        let task = Task { [weak self] () -> AmbientQuote? in
            guard let self else { return nil }
            let sources = Source.allCases
            let start = nextSourceIndex
            nextSourceIndex = (start + 1) % sources.count
            for offset in 0..<sources.count {
                if Task.isCancelled { return nil }
                let source = sources[(start + offset) % sources.count]
                guard let quote = await load(from: source), quote != current else { continue }
                cached = quote
                return quote
            }
            return nil
        }
        inflight = task
        let result = await task.value
        inflight = nil
        return result
    }

    // MARK: - 各来源请求与解析

    private func load(from source: Source) async -> AmbientQuote? {
        guard let request = request(for: source) else { return nil }
        guard let (data, response) = try? await session.data(for: request),
              let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else { return nil }
        guard let object = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
        switch source {
        case .jinrishici: return parseJinrishici(object)
        case .hitokoto: return parseHitokoto(object)
        case .iciba: return parseIciba(object)
        }
    }

    private func request(for source: Source) -> URLRequest? {
        let url: URL?
        switch source {
        case .jinrishici: url = URL(string: "https://v2.jinrishici.com/one.json")
        // 只取文学、诗词与哲思分类，并限制 25 字以内，避免拖动控件换行过多。
        case .hitokoto: url = URL(string: "https://v1.hitokoto.cn/?c=d&c=i&c=j&encode=json&max_length=25")
        case .iciba: url = URL(string: "https://open.iciba.com/dsapi/")
        }
        guard let url else { return nil }
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        // 今日诗词首次调用会下发 Token，之后带上它推荐才会连贯，且不会重复下发。
        if source == .jinrishici, let token = UserDefaults.standard.string(forKey: Self.tokenKey) {
            request.setValue(token, forHTTPHeaderField: "X-User-Token")
        }
        return request
    }

    /// 今日诗词：正文取 data.content，出处拼成“作者《题名》”，并记住返回的 Token。
    private func parseJinrishici(_ object: [String: Any]) -> AmbientQuote? {
        guard object["status"] as? String == "success", let data = object["data"] as? [String: Any],
              let text = cleaned(data["content"]) else { return nil }
        if let token = object["token"] as? String, !token.isEmpty {
            UserDefaults.standard.set(token, forKey: Self.tokenKey)
        }
        let origin = data["origin"] as? [String: Any]
        let author = cleaned(origin?["author"])
        let title = cleaned(origin?["title"])
        var attribution = author ?? ""
        if let title { attribution += "《\(title)》" }
        return AmbientQuote(text: text, attribution: attribution.isEmpty ? nil : attribution)
    }

    /// 一言：正文取 hitokoto，出处优先“作者《作品》”，只有作品时单独展示作品名。
    private func parseHitokoto(_ object: [String: Any]) -> AmbientQuote? {
        guard let text = cleaned(object["hitokoto"]) else { return nil }
        let from = cleaned(object["from"])
        let author = cleaned(object["from_who"])
        var attribution = ""
        if let author, author != from { attribution = author }
        if let from { attribution += "《\(from)》" }
        return AmbientQuote(text: text, attribution: attribution.isEmpty ? nil : attribution)
    }

    /// 金山词霸每日一句：中文译文 note 作为正文，英文原句 content 作为第二行注解。
    private func parseIciba(_ object: [String: Any]) -> AmbientQuote? {
        guard let text = cleaned(object["note"]) else { return nil }
        return AmbientQuote(text: text, attribution: cleaned(object["content"]))
    }

    /// 去掉首尾空白与换行，空字符串视为缺失。
    private func cleaned(_ value: Any?) -> String? {
        guard let string = value as? String else { return nil }
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}
