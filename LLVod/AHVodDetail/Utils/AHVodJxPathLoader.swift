//
//  AHVodJxPathLoader.swift
//  LLVod
//
//  对应 Flutter rslz("jx${zypath}")
//

import Foundation

enum AHVodJxPathLoader {

    private static let cacheKeyPrefix = "jx"

    static func load(zypath: String) -> [[String: Any]] {
        if let subscription = AHSearchSubscriptionLoader.load(), subscription.zypath == zypath {
            cache(zypath: zypath, jxpath: subscription.jxpath)
            return subscription.jxpath
        }

        let cached = SearchStorage.rslzDictionaryList(cacheKey(for: zypath))
        if !cached.isEmpty {
            return cached
        }

        return []
    }

    static func buildJxOptions(
        jxpath: [[String: Any]],
        keyword: String,
        builtInParseURL: String
    ) -> [AHVodJxOption] {
        var options: [AHVodJxOption] = []

        if !builtInParseURL.isEmpty {
            options.append(
                AHVodJxOption(
                    id: "built-in",
                    name: "源内置解析",
                    type: "json",
                    api: builtInParseURL,
                    userAgent: "",
                    sniffWhitelist: "",
                    sniffBlacklist: ""
                )
            )
        }

        guard let group = jxpath.first(where: { ($0["解析关键词"] as? String) == keyword }),
              let configs = group["解析配置"] as? [[String: Any]] else {
            return options
        }

        for (index, item) in configs.enumerated() {
            let api = item["jxapi"] as? String ?? ""
            guard !api.isEmpty else { continue }

            options.append(
                AHVodJxOption(
                    id: "\(keyword)-\(index)",
                    name: item["jxname"] as? String ?? "解析\(index + 1)",
                    type: item["jxlx"] as? String ?? "json",
                    api: api,
                    userAgent: item["jxua"] as? String ?? "",
                    sniffWhitelist: item["jxb"] as? String ?? "",
                    sniffBlacklist: item["jxh"] as? String ?? ""
                )
            )
        }

        return options
    }

    static func resolveKeyword(sourceTag: String, episodeURL: String) -> String {
        if !sourceTag.isEmpty {
            return sourceTag
        }

        let lower = episodeURL.lowercased()
        if lower.contains("qq.com") || lower.contains("v.qq") {
            return "qq"
        }
        if lower.contains("mgtv") {
            return "mgtv"
        }
        if lower.contains("bilibili") || lower.contains("b23.tv") {
            return "bilibli"
        }
        if lower.contains("iqiyi") || lower.contains("qiyi") {
            return "qiyi"
        }
        if lower.contains("360") {
            return "360"
        }
        return sourceTag
    }

    private static func cacheKey(for zypath: String) -> String {
        cacheKeyPrefix + zypath
    }

    private static func cache(zypath: String, jxpath: [[String: Any]]) {
        SearchStorage.saveDictionaryList(cacheKey(for: zypath), list: jxpath)
    }
}
