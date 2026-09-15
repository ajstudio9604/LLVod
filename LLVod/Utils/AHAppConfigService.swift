//
//  AHAppConfigService.swift
//  LLVod
//
//  拉取 /app/config，把弹幕接口等配置写进本地，对应 Flutter gx.dart 的 getgx。
//  同时解析公告 / 版本更新（含强制更新），键名与 Flutter gx (2).dart 对齐。
//

import Foundation
import Combine
import UIKit

@MainActor
final class AHAppConfig: ObservableObject {
    static let shared = AHAppConfig()

    @Published private(set) var isDanmakuAvailable = false

    @Published private(set) var canSendDanmaku = false

    @Published private(set) var websiteURL = ""

    @Published private(set) var qqGroupURL = ""
    @Published private(set) var tgGroupURL = ""

    @Published var pendingNotice: AHAppNoticeInfo?

    @Published var pendingUpdate: AHAppUpdateInfo?

    var canJoinCommunity: Bool {
        !qqGroupURL.isEmpty || !tgGroupURL.isEmpty
    }

    private init() {
        reload()
    }

    fileprivate func reload() {
        let defaults = UserDefaults.standard
        isDanmakuAvailable = AHDanmakuService.isMasterSwitchOn
        canSendDanmaku = AHDanmakuService.canSend
        websiteURL = defaults.string(forKey: "官网cache") ?? ""
        qqGroupURL = defaults.string(forKey: "QQ群cahce") ?? ""
        tgGroupURL = defaults.string(forKey: "TG群cahce") ?? ""
    }

    func dismissNotice(neverShowAgain: Bool) {
        if neverShowAgain, let content = pendingNotice?.content {
            UserDefaults.standard.set(content, forKey: "公告提示数据cache")
        }
        pendingNotice = nil
    }

    func dismissUpdate() {
        // 强制更新不允许关掉
        guard let pendingUpdate, !pendingUpdate.isForce else { return }
        self.pendingUpdate = nil
    }

    func openUpdateURL() {
        guard let raw = pendingUpdate?.downloadURL.trimmingCharacters(in: .whitespacesAndNewlines),
              !raw.isEmpty else { return }

        var text = raw
        if !text.contains("://") {
            text = "https://\(text)"
        }
        guard let url = URL(string: text) else { return }
        UIApplication.shared.open(url)
    }
}

enum AHAppConfigService {

    private static let danmakuKeys: [(key: String, field: String)] = [
        ("自建弹幕apicache", "danmaku_custom_api"),
        ("官方弹幕apicache", "danmaku_official_api"),
        ("官方弹幕搜索apicache", "danmaku_search_api"),
        ("发送弹幕apicache", "danmaku_send_api"),
        ("弹幕关键词cache", "danmaku_keywords")
    ]

    private static let serverKeys = [
        "x主服务器域名cahce",
        "x主服务器域名cahce1",
        "x主服务器域名cahce2"
    ]

    private static var task: Task<Bool, Never>?
    private static var isLoaded = false
    private static var didEvaluatePrompts = false

    static func ensureLoaded() async {
        if isLoaded { return }

        if let task {
            _ = await task.value
            return
        }

        let task = Task { await refresh() }
        Self.task = task
        let applied = await task.value

        // 这个域名会偶发 TLS 失败和超时，失败不能记住，
        // 否则一次启动里再也不重试，弹幕整局都是关的
        Self.task = nil
        isLoaded = applied
    }

    static func reload(showPrompts: Bool = true) async {
        task = nil
        isLoaded = false
        if showPrompts {
            didEvaluatePrompts = false
        }
        await ensureLoaded()
    }

    private static func refresh() async -> Bool {
        for endpoint in endpoints() {
            guard let config = await fetch(endpoint) else { continue }

            apply(config)
            return true
        }

        return false
    }

    private static func endpoints() -> [String] {
        let defaults = UserDefaults.standard

        // 配置里下发的主服务器域名优先，其次内置的主备地址
        var list = serverKeys.compactMap { key in
            AHAppConfigParser.configURL(from: defaults.string(forKey: key) ?? "")
        }

        list.append("https://login.yiys07.com/app/config")
        list.append("https://login.yiys06.com/app/config")

        var seen = Set<String>()
        return list.filter { seen.insert($0).inserted }
    }

    private static func fetch(_ endpoint: String) async -> [String: Any]? {
        guard let url = URL(string: endpoint) else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 15
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.setValue(SearchUserAgent.generate(), forHTTPHeaderField: "User-Agent")

        guard let (data, response) = try? await URLSession.shared.data(for: request),
              let http = response as? HTTPURLResponse,
              200...299 ~= http.statusCode,
              let body = String(data: data, encoding: .utf8) else {
            return nil
        }

        return AHAppConfigParser.decode(body)
    }

    private static func apply(_ config: [String: Any]) {
        let defaults = UserDefaults.standard

        let currentVersion = AHAppVersionCompare.currentShortVersion
        if !currentVersion.isEmpty {
            defaults.set(currentVersion, forKey: "版本号cahce")
        }

        defaults.set(
            AHAppConfigParser.bool(config["danmaku_enabled"]),
            forKey: "弹幕总开关cache"
        )

        for item in danmakuKeys {
            defaults.set(AHAppConfigParser.string(config[item.field]), forKey: item.key)
        }

        let servers = ["server_main", "server_main1", "server_main2"]
        for (key, field) in zip(serverKeys, servers) {
            let value = AHAppConfigParser.string(config[field])
            if value.isEmpty {
                defaults.removeObject(forKey: key)
            } else {
                defaults.set(value, forKey: key)
            }
        }

        // 个人中心用：官网 / QQ群 / TG群，键名跟 Flutter gx.dart 对齐
        let community: [(key: String, field: String)] = [
            ("官网cache", "website"),
            ("QQ群cahce", "qq_group"),
            ("TG群cahce", "tg_group"),
        ]
        for item in community {
            let value = AHAppConfigParser.string(config[item.field])
            if value.isEmpty {
                defaults.removeObject(forKey: item.key)
            } else {
                defaults.set(value, forKey: item.key)
            }
        }

        let notice = evaluateNotice(from: config)
        let update = evaluateUpdate(from: config, currentVersion: currentVersion)

        Task { @MainActor in
            AHAppConfig.shared.reload()
            guard !didEvaluatePrompts else { return }
            didEvaluatePrompts = true
            AHAppConfig.shared.pendingNotice = notice
            AHAppConfig.shared.pendingUpdate = update
        }
    }

    // MARK: - 公告 / 更新

    private static func evaluateNotice(from config: [String: Any]) -> AHAppNoticeInfo? {
        let enabled = AHAppConfigParser.bool(config["notice_enabled"])
        let content = AHAppConfigParser.string(config["notice_content"])
        guard enabled, !content.isEmpty else { return nil }

        let cached = UserDefaults.standard.string(forKey: "公告提示数据cache") ?? ""
        guard cached != content else { return nil }
        return AHAppNoticeInfo(content: content)
    }

    private static func evaluateUpdate(
        from config: [String: Any],
        currentVersion: String
    ) -> AHAppUpdateInfo? {
        var enabled = AHAppConfigParser.bool(config["ios_update_enabled"])
        var isForce = AHAppConfigParser.bool(config["ios_force_update"])

        // 包名过滤：配置了白名单且当前 Bundle ID 不在其中 → 不更新
        let packagesRaw = AHAppConfigParser.string(config["ios_update_packages"])
        if enabled, !packagesRaw.isEmpty {
            let allowed = packagesRaw
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { !$0.isEmpty }
            let bundleId = AHAppVersionCompare.bundleIdentifier
            if !allowed.isEmpty, !allowed.contains(bundleId) {
                enabled = false
                isForce = false
            }
        }

        guard enabled else { return nil }

        let latest = AHAppConfigParser.string(config["ios_app_version"])
        guard !latest.isEmpty, !currentVersion.isEmpty else { return nil }
        guard let comparison = AHAppVersionCompare.compare(current: currentVersion, latest: latest),
              comparison < 0 else {
            return nil
        }

        return AHAppUpdateInfo(
            version: latest,
            sizeText: AHAppConfigParser.string(config["ios_app_size"]),
            changelog: AHAppConfigParser.string(config["ios_changelog"]),
            isForce: isForce,
            downloadURL: AHAppConfigParser.string(config["ios_download_url"]),
            downloadMode: AHAppConfigParser.string(config["ios_download_mode"])
        )
    }
}
