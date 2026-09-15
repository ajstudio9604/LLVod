//
//  AHDanmakuService.swift
//  LLVod
//
//  弹幕拉取与发送，对应 Flutter DanmakuService（play/util/danmu/DanmakuService.dart）
//  以及 controller_overlay.dart 里的发送弹幕逻辑
//
//  依赖的订阅配置项（与 Flutter 同名）：
//  弹幕总开关cache / 官方弹幕apicache / 官方弹幕搜索apicache / 自建弹幕apicache
//  弹幕关键词cache / 发送弹幕apicache
//

import Foundation

enum AHDanmakuService {

    private static let signSecret = "aha&sparkle$888"

    // MARK: - 拉取

    static func fetchDanmaku(context: AHVodDanmakuContext) async -> [AHDanmakuRawItem] {
        // 本地视频优先读随片下载的 danmaku.json
        if context.zypath.isEmpty || AHLocalMediaServer.isLocalURL(context.playURL) || context.playURL.hasPrefix("file:") {
            return loadLocal(videoPath: context.playURL)
        }

        // 弹幕接口来自 /app/config，冷启动后直接进详情页时配置可能还没落地
        await AHAppConfigService.ensureLoaded()

        guard isMasterSwitchOn else {
            return []
        }

        for url in buildURLs(context: context) {
            if let items = try? await tryFetch(url), !items.isEmpty {
                return items
            }
        }

        return []
    }

    private static func buildURLs(context: AHVodDanmakuContext) -> [String] {
        let defaults = UserDefaults.standard
        let officialAPIs = parseAPIList(defaults.string(forKey: "官方弹幕apicache"))
        let searchAPIs = parseAPIList(defaults.string(forKey: "官方弹幕搜索apicache"))
        let selfHostedAPI = defaults.string(forKey: "自建弹幕apicache") ?? ""

        var urls: [String] = []

        // 1. 源标识名命中弹幕关键词，直接用官方接口
        if !context.sourceTag.isEmpty {
            let keywords = (defaults.string(forKey: "弹幕关键词cache") ?? "")
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespaces) }

            if keywords.contains(context.sourceTag) {
                urls = officialAPIs.map {
                    $0.replacingOccurrences(of: "{url}", with: context.episodePath)
                }
            }
        }

        // 2. 没命中就走官方搜索接口，需要 HMAC-SHA256 签名
        if urls.isEmpty && !searchAPIs.isEmpty {
            urls = searchAPIs.compactMap {
                signedSearchURL(api: $0, title: context.title, episodeIndex: max(1, context.episodeIndex))
            }
        }

        // 3. 最后兜底自建接口
        if urls.isEmpty && !selfHostedAPI.isEmpty {
            let player = CryptoUtil.md5Hex("\(context.title) - \(context.episodeTitle)")
            urls = [selfHostedAPI.replacingOccurrences(of: "{url}", with: player)]
        }

        return urls
    }

    static func parseAPIList(_ raw: String?) -> [String] {
        guard let raw else { return [] }
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return [] }

        guard trimmed.hasPrefix("[") else { return [trimmed] }

        guard let data = trimmed.data(using: .utf8),
              let list = try? JSONSerialization.jsonObject(with: data) as? [Any] else {
            return []
        }

        return list.compactMap { $0 as? String }.filter { !$0.isEmpty }
    }

    private static func signedSearchURL(api: String, title: String, episodeIndex: Int) -> String? {
        guard var components = URLComponents(string: api) else { return nil }

        let params: [(String, String)] = [
            ("name", title),
            ("episode", String(episodeIndex)),
            ("ts", String(Int(Date().timeIntervalSince1970 * 1000))),
            ("nonce", randomNonce())
        ]

        let bodyHash = CryptoUtil.sha256Hex("")
        let query = canonicalQuery(params)
        let payload = "GET\n\(components.path)\n\(query)\n\(bodyHash)"

        guard let sign = try? CryptoUtil.hmacSha256(payload, secret: signSecret) else {
            return nil
        }

        components.queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
            + [URLQueryItem(name: "sign", value: sign)]

        return components.url?.absoluteString
    }

    private static func canonicalQuery(_ params: [(String, String)]) -> String {
        params
            .filter { $0.0 != "sign" }
            .sorted { $0.0 == $1.0 ? $0.1 < $1.1 : $0.0 < $1.0 }
            .map { "\(encodeRfc3986($0.0))=\(encodeRfc3986($0.1))" }
            .joined(separator: "&")
    }

    private static func encodeRfc3986(_ value: String) -> String {
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: "-._~")
        return value.addingPercentEncoding(withAllowedCharacters: allowed) ?? value
    }

    private static func randomNonce(_ length: Int = 16) -> String {
        let chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<length).compactMap { _ in chars.randomElement() })
    }

    private static func tryFetch(_ url: String) async throws -> [AHDanmakuRawItem] {
        let text = try await AHDownloadHTTP.text(
            url,
            headers: [
                "Content-Type": "application/x-www-form-urlencoded;charset=utf-8",
                "Content-Encoding": "gzip"
            ]
        )

        guard let data = text.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return []
        }

        return AHDanmakuParser.parse(json)
    }

    // MARK: - 发送

    static func send(
        context: AHVodDanmakuContext,
        request payload: AHDanmakuSendRequest
    ) async -> AHDanmakuSendResult {
        let text = payload.text.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let api = UserDefaults.standard.string(forKey: "发送弹幕apicache"),
              !api.isEmpty,
              !text.isEmpty,
              let url = URL(string: api) else {
            return .failed
        }

        let title = payload.vodName.isEmpty ? context.title : payload.vodName
        let body: [String: Any] = [
            "player": CryptoUtil.md5Hex("\(title) - \(context.episodeTitle)"),
            "author": "DIYgod",
            "time": Int(payload.time.rounded(.up)),
            "text": text,
            "color": String(decimalColor(from: payload.colorHex)),
            "type": "right",
            "size": "25"
        ]

        guard let data = try? JSONSerialization.data(withJSONObject: body) else {
            return .failed
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.timeoutInterval = 15
        request.setValue(
            "application/x-www-form-urlencoded;charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )
        request.setValue("gzip", forHTTPHeaderField: "Content-Encoding")
        request.setValue(SearchUserAgent.generate(), forHTTPHeaderField: "User-Agent")

        guard let (responseData, response) = try? await URLSession.shared.data(for: request),
              let http = response as? HTTPURLResponse,
              200...299 ~= http.statusCode else {
            return .failed
        }

        return parseSendResponse(responseData)
    }

    static func parseSendResponse(_ data: Data) -> AHDanmakuSendResult {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            // 老接口可能只回个空体，有 2xx 就当发出去了
            return .success
        }

        // danmuku 给 true 是收下了，给字符串就是拒收的说明
        if let accepted = json["danmuku"] as? Bool {
            return accepted ? .success : .rejected(nil)
        }

        let reason = json["danmuku"] as? String ?? json["msg"] as? String

        if let code = (json["code"] as? NSNumber)?.intValue, code >= 0, reason == nil {
            return .success
        }

        return .rejected(reason)
    }

    private static func decimalColor(from hex: String) -> Int {
        let cleaned = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        let rgb = UInt32(cleaned, radix: 16) ?? 0xFFFFFF
        return Int(Int32(bitPattern: 0xFF00_0000 | (rgb & 0xFFFFFF)))
    }

    // MARK: - 播放器里的弹幕偏好

    static var isMasterSwitchOn: Bool {
        UserDefaults.standard.bool(forKey: "弹幕总开关cache")
    }

    static var canSend: Bool {
        !(UserDefaults.standard.string(forKey: "发送弹幕apicache") ?? "").isEmpty
    }

    static var sendColorHex: String {
        get {
            let defaults = UserDefaults.standard
            if let text = defaults.string(forKey: "发送弹幕颜色cache"), text.hasPrefix("#") {
                return text
            }

            guard defaults.object(forKey: "发送弹幕颜色cache") != nil else { return "#FFFFFF" }
            let value = UInt32(bitPattern: Int32(truncatingIfNeeded: defaults.integer(forKey: "发送弹幕颜色cache")))
            return String(format: "#%06X", value & 0xFFFFFF)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "发送弹幕颜色cache")
        }
    }

    // MARK: - 本地弹幕

    static func localDanmakuURL(videoPath: String) -> URL? {
        guard !videoPath.isEmpty else { return nil }

        let fileURL: URL
        if AHLocalMediaServer.isLocalURL(videoPath), let url = URL(string: videoPath) {
            let relativePath = url.path.hasPrefix("/") ? String(url.path.dropFirst()) : url.path
            guard !relativePath.isEmpty else { return nil }
            fileURL = AHDownloadPaths.absoluteURL(relativePath: relativePath)
        } else if videoPath.hasPrefix("file:"), let url = URL(string: videoPath) {
            fileURL = url
        } else {
            fileURL = URL(fileURLWithPath: videoPath)
        }

        return fileURL.deletingLastPathComponent().appendingPathComponent("danmaku.json")
    }

    static func loadLocal(videoPath: String) -> [AHDanmakuRawItem] {
        guard let url = localDanmakuURL(videoPath: videoPath),
              let data = try? Data(contentsOf: url) else {
            return []
        }

        return AHDanmakuParser.decodeLocal(data)
    }

    static func saveLocal(_ items: [AHDanmakuRawItem], to directory: URL) {
        guard let data = AHDanmakuParser.encodeLocal(items) else { return }

        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        try? data.write(to: directory.appendingPathComponent("danmaku.json"))
    }
}
