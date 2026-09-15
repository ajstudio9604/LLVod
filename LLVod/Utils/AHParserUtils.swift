//
//  AHParserUtils.swift
//  LLVod
//
//  解析工具集，对应 Flutter ParserUtils（parser_utils.dart）
//  之前这些逻辑分散在 AHVodDetailLoader / AHVodPlayResolver / SearchJsRuleEngine 里各写一份，
//  这里统一收口，避免三处实现出现细微差异。
//

import Foundation

enum AHParserUtils {

    // MARK: - 请求头

    static func parseHeaders(
        _ raw: String,
        extra: [String: String] = [:],
        systemUserAgent: String? = nil
    ) -> [String: String] {
        var headers: [String: String] = [:]

        for part in raw.split(separator: ",").map(String.init) {
            guard let equalIndex = part.firstIndex(of: "=") else { continue }

            let key = String(part[..<equalIndex]).trimmingCharacters(in: .whitespaces)
            var value = String(part[part.index(after: equalIndex)...])
                .trimmingCharacters(in: .whitespaces)

            if value == "系统UA" {
                value = systemUserAgent ?? SearchUserAgent.generate()
            }
            if !key.isEmpty {
                headers[key] = value
            }
        }

        headers.merge(extra) { _, new in new }
        return headers
    }

    static func headersOrDefault(_ raw: String) -> [String: String] {
        guard !raw.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return ["User-Agent": SearchUserAgent.generate()]
        }
        return parseHeaders(raw)
    }

    // MARK: - 播放地址

    static func extractVideoURL(
        from body: String,
        isEncrypted: Bool = false,
        fallbackToPlainJson: Bool = false
    ) -> String? {
        let json: [String: Any]?

        if isEncrypted {
            if let decrypted = tryAesDecryptJSON(body) {
                json = decrypted
            } else if fallbackToPlainJson {
                json = plainJSON(body)
            } else {
                return nil
            }
        } else {
            json = plainJSON(body)
        }

        guard let json else { return nil }

        if let url = stringValue(json["url"]) {
            return url
        }
        if let data = json["data"] as? [String: Any],
           let url = stringValue(data["url"]) {
            return url
        }
        return nil
    }

    static func tryAesDecryptJSON(_ input: String) -> [String: Any]? {
        for key in ["xxsp123456789011", "ahsp123456789012"] {
            if let decrypted = try? CryptoUtil.aesDecryptECB(input, key: key),
               let json = plainJSON(decrypted) {
                return json
            }
        }
        return nil
    }

    static func plainJSON(_ body: String) -> [String: Any]? {
        guard let data = body.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        return json
    }

    // MARK: - 剧集

    static func parseEpisodes(_ detail: Any?, reverse: Bool = false) -> [AHVodEpisode] {
        var pairs: [(name: String, url: String)] = []

        if let list = detail as? [Any] {
            // 整体就是一条 [标题, 链接] 时不要再往下遍历
            if let single = structuredPair(list) {
                pairs.append(single)
            } else {
                for item in list {
                    if let text = item as? String, text.contains("#") {
                        pairs.append(contentsOf: delimitedPairs(text))
                    } else if let pair = structuredPair(item) {
                        pairs.append(pair)
                    }
                }
            }
        } else if let text = detail as? String {
            pairs = delimitedPairs(text)
        } else if let detail {
            pairs = delimitedPairs(String(describing: detail))
        }

        let ordered = reverse ? Array(pairs.reversed()) : pairs

        return ordered.enumerated().map { index, pair in
            AHVodEpisode(id: index + 1, title: pair.name, path: pair.url)
        }
    }

    static func parseEpisodesAsync(_ detail: Any?, reverse: Bool = false) async -> [AHVodEpisode] {
        if let text = detail as? String, text.utf8.count >= 64 * 1024 {
            return await Task.detached(priority: .userInitiated) {
                parseEpisodes(text, reverse: reverse)
            }.value
        }
        if let list = detail as? [Any], list.count >= 200 {
            // Array 跨线程需要拷成 Sendable 友好的结构；这里转成字符串再解析成本更高，
            // 直接在后台用 NSArray 桥接的不可变快照解析
            let snapshot = list as NSArray
            return await Task.detached(priority: .userInitiated) {
                parseEpisodes(snapshot as? [Any] ?? Array(snapshot), reverse: reverse)
            }.value
        }
        return parseEpisodes(detail, reverse: reverse)
    }

    static func countDelimitedEpisodesAsync(_ detail: Any?) async -> Int {
        let text = detail.map { String(describing: $0) } ?? ""
        guard !text.isEmpty else { return 0 }
        if text.utf8.count < 64 * 1024 {
            return countDelimitedEpisodes(text)
        }
        return await Task.detached(priority: .userInitiated) {
            countDelimitedEpisodes(text)
        }.value
    }

    private static func countDelimitedEpisodes(_ text: String) -> Int {
        var count = 0
        var start = text.startIndex
        while start < text.endIndex {
            let separator = text[start...].firstIndex(of: "#")
            let end = separator ?? text.endIndex
            if end > start {
                if let dollar = text[start..<end].firstIndex(of: "$"),
                   dollar > start,
                   text.index(after: dollar) < end {
                    count += 1
                }
            }
            guard let separator else { break }
            start = text.index(after: separator)
        }
        return count
    }

    private static func structuredPair(_ value: Any?) -> (name: String, url: String)? {
        if let list = value as? [Any], list.count >= 2 {
            // 嵌套结构说明这是外层容器，不是一条剧集
            let isNested = list[0] is [Any] || list[0] is [String: Any]
                || list[1] is [Any] || list[1] is [String: Any]
            if !isNested {
                let name = String(describing: list[0])
                let url = String(describing: list[1])
                if !name.isEmpty, !url.isEmpty,
                   !name.contains("#"), !name.contains("$"), !url.contains("$") {
                    return (name, url)
                }
            }
        }

        if let map = value as? [String: Any] {
            let name = stringValue(map["name"])
                ?? stringValue(map["title"])
                ?? stringValue(map["vod_name"])
            let url = stringValue(map["url"])
                ?? stringValue(map["playUrl"])
                ?? stringValue(map["link"])

            if let name, let url {
                return (name, url)
            }
        }

        return nil
    }

    private static func delimitedPairs(_ text: String) -> [(name: String, url: String)] {
        text.split(separator: "#", omittingEmptySubsequences: true).compactMap { chunk in
            delimitedPair(String(chunk))
        }
    }

    private static func delimitedPair(_ value: String) -> (name: String, url: String)? {
        guard let separator = value.firstIndex(of: "$") else { return nil }

        let name = String(value[..<separator])
        let url = String(value[value.index(after: separator)...])

        guard !name.isEmpty, !url.isEmpty else { return nil }
        return (name, url)
    }

    // MARK: - 文本

    static func extractPart(_ text: String, pattern: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(
                in: text,
                range: NSRange(text.startIndex..., in: text)
              ),
              match.numberOfRanges > 1,
              let range = Range(match.range(at: 1), in: text) else {
            return nil
        }
        return String(text[range])
    }

    static func isHTMLResponse(_ body: String) -> Bool {
        body.contains("<title>") || body.contains("<html>")
    }

    static func filterNewlines(_ input: String) -> String {
        input.replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\r", with: "")
    }

    static func stringValue(_ value: Any?) -> String? {
        guard let value, !(value is NSNull) else { return nil }
        let text = String(describing: value).trimmingCharacters(in: .whitespacesAndNewlines)
        return text.isEmpty ? nil : text
    }
}
