//
//  AHSearchHotService.swift
//  LLVod
//
//  对应 Flutter getrstj() + pagev1.getrs()
//

import Foundation

enum AHSearchHotService {

    private static let defaultKeywords = [
        "完美世界",
        "姜子牙",
        "心理罪",
        "活着",
        "当家主母",
        "湄公河行动"
    ]

    private static let fallbackKeywords = [
        "完美世界",
        "凡人修仙传",
        "心理罪",
        "活着",
        "当家主母",
        "湄公河行动"
    ]

    static func loadCachedHotItems() -> [AHSearchHotItem] {
        do {
            if let cached = UserDefaults.standard.string(forKey: AHSearchStorage.hotCacheKey),
               let data = cached.data(using: .utf8),
               let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let items = json["data"] as? [[String: Any]] {
                let hot = items.prefix(6).compactMap { dict -> AHSearchHotItem? in
                    guard let query = dict["query"] as? String, !query.isEmpty else {
                        return nil
                    }
                    return AHSearchHotItem(title: query)
                }

                if !hot.isEmpty {
                    return hot
                }
            }
        } catch {
            return fallbackKeywords.map { AHSearchHotItem(title: $0) }
        }

        return defaultKeywords.map { AHSearchHotItem(title: $0) }
    }

    static func fetchAndCacheHotSearch() async {
        do {
            let response = try await SearchHTTPClient.get("https://search.video.iqiyi.com/m?if=hotQuery&p=15&is_qipu_platform=1")
            UserDefaults.standard.set(response, forKey: AHSearchStorage.hotCacheKey)
        } catch {   }
    }

    static func loadHotItemsAfterFetch() -> [AHSearchHotItem] {
        loadCachedHotItems()
    }
}
