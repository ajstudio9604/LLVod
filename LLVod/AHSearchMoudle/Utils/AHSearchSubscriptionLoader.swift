//
//  AHSearchSubscriptionLoader.swift
//  LLVod
//
//  订阅站源从远端 xdy.json 取：拉回来按 Aes128EcbDecrypt 解密（GCM1. 走 AES-256-GCM，
//  旧数据走 AES-128-ECB），解析后覆盖本地 json 以及 SearchStorage 里已有的站源 / 解析配置。
//

import Foundation

struct AHSearchSubscription {
    let name: String
    let author: String
    let version: String
    let zypath: String
    let sources: [[String: Any]]
    let jxpath: [[String: Any]]
}

enum AHSearchSubscriptionLoader {

    private static var inFlight: Task<AHSearchSubscription, Error>?

    private static var memo: (updatedAt: Date, subscription: AHSearchSubscription)?

    static func load() -> AHSearchSubscription? {
        cached()
    }

    static func ensureLoaded() async throws -> AHSearchSubscription {
        if let cached = cached() {
            return cached
        }
        return try await refresh()
    }

    static func prefetch() async {
        _ = try? await refresh()
    }

    @discardableResult
    static func refresh() async throws -> AHSearchSubscription {
        if let inFlight {
            return try await inFlight.value
        }

        let task = Task { try await fetchFromEndpoints() }
        inFlight = task

        defer { inFlight = nil }
        return try await task.value
    }

    // MARK: - 远端

    private static func fetchFromEndpoints() async throws -> AHSearchSubscription {
        var lastError: Error?

        for endpoint in ["https://login.yiys07.com/xdy.json", "https://login.yiys06.com/xdy.json"] { 
            do {
                return try await fetch(endpoint)
            } catch {
                lastError = error
            }
        }

        throw lastError ?? URLError(.cannotLoadFromNetwork)
    }

    private static func fetch(_ endpoint: String) async throws -> AHSearchSubscription {
        let body = try await SearchHTTPClient.get(
            endpoint,
            headers: ["User-Agent": SearchUserAgent.generate()],
            cachePolicy: .reloadIgnoringLocalCacheData
        )

        let plain = try AHAes128Ecb.decrypt(body)

        guard let data = plain.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let subscription = parse(json) else {
            throw URLError(.cannotParseResponse)
        }

        try persist(plain, subscription: subscription)
        return subscription
    }

    private static func persist(_ plain: String, subscription: AHSearchSubscription) throws {
        try AHSearchSubscriptionCache.save(plain)
        memo = (AHSearchSubscriptionCache.updatedAt ?? Date(), subscription)

        SearchStorage.saveDictionaryList("xdycache", list: [[
            "订阅标题": subscription.name,
            "作者": subscription.author
        ]])
        SearchStorage.saveDictionaryList(subscription.zypath, list: subscription.sources)
        SearchStorage.saveDictionaryList("jx\(subscription.zypath)", list: subscription.jxpath)
    }

    // MARK: - 本地

    private static func cached() -> AHSearchSubscription? {
        guard let updatedAt = AHSearchSubscriptionCache.updatedAt else { return nil }

        if let memo, memo.updatedAt == updatedAt {
            return memo.subscription
        }

        guard let json = AHSearchSubscriptionCache.read(),
              let subscription = parse(json) else {
            return nil
        }

        memo = (updatedAt, subscription)
        return subscription
    }

    private static func parse(_ json: [String: Any]) -> AHSearchSubscription? {
        guard let sources = json["zypath"] as? [[String: Any]], !sources.isEmpty else {
            return nil
        }

        let name = json["name"] as? String ?? "壹影视订阅"

        return AHSearchSubscription(
            name: name,
            author: json["author"] as? String ?? "admin",
            version: json["bb"] as? String ?? "",
            zypath: "dyy\(name)",
            sources: sources,
            jxpath: json["jxpath"] as? [[String: Any]] ?? []
        )
    }
}
