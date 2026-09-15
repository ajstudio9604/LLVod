//
//  AHSearchSubscriptionService.swift
//  LLVod
//
//  搜索站源加载：远端 xdy.json 解密后存本地，读本地那一份
//

import Foundation

enum AHSearchSubscriptionError: LocalizedError {
    case subscriptionUnavailable
    case noEnabledSubscription
    case noSources(String)

    var errorDescription: String? {
        switch self {
        case .subscriptionUnavailable:
            return ""
        case .noEnabledSubscription:
            return ""
        case .noSources(let title):
            return ""
        }
    }
}

struct AHSearchActiveSubscription {
    let title: String
    let zypath: String
    let sources: [[String: Any]]
}

enum AHSearchSubscriptionService {

    static func loadActiveSubscription() async throws -> AHSearchActiveSubscription {
        if let subscription = try? await AHSearchSubscriptionLoader.ensureLoaded() {
            SearchStorage.saveDictionaryList("xdycache", list: [[
                "订阅标题": subscription.name,
                "作者": subscription.author
            ]])
            SearchStorage.saveDictionaryList(subscription.zypath, list: subscription.sources)

            return AHSearchActiveSubscription(
                title: subscription.name,
                zypath: subscription.zypath,
                sources: subscription.sources
            )
        }

        return try fallbackToStoredSubscription()
    }

    private static func fallbackToStoredSubscription() throws -> AHSearchActiveSubscription {
        let subscriptions = SearchStorage.rslzDictionaryList("xdycache")
        guard !subscriptions.isEmpty else {
            throw AHSearchSubscriptionError.subscriptionUnavailable
        }

        guard let active = pickEnabledSubscription(from: subscriptions) else {
            throw AHSearchSubscriptionError.noEnabledSubscription
        }

        let zypath = "dyy\(active.title)"
        let sources = SearchStorage.rslzDictionaryList(zypath)

        guard !sources.isEmpty else {
            throw AHSearchSubscriptionError.noSources(active.title)
        }

        return AHSearchActiveSubscription(
            title: active.title,
            zypath: zypath,
            sources: sources
        )
    }

    private static func pickEnabledSubscription(
        from subscriptions: [[String: Any]]
    ) -> (title: String, item: [String: Any])? {
        for item in subscriptions {
            guard let title = item["订阅标题"] as? String, !title.isEmpty else {
                continue
            }

            if SearchStorage.isSubscriptionEnabled(title: title) {
                return (title, item)
            }
        }
        return nil
    }
}
