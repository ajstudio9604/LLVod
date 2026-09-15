//
//  AHYunCloudService.swift
//  LLVod
//
//  历史 / 收藏云同步。打开影片、收藏立刻上传；拉取时用远端整份覆盖本地。
//

import Foundation

extension Notification.Name {
    static let ahVodPlayRecordDidChange = Notification.Name("ahVodPlayRecordDidChange")
    static let ahYunCloudDidMerge = Notification.Name("ahYunCloudDidMerge")
}

enum AHYunCloudService {

    private static let historyFlutterKey = "历史观看记录cache"
    private static let favoriteKey = "影片收藏记录cache"
    private static let cloudMergeCap = 50

    private static let historyUploadInterval: TimeInterval = 3 * 60

    private static let lastUploadKey = "ah_yuncloud_last_upload_at"
    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 30
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: configuration)
    }()

    private static let lock = NSLock()
    private static var isUploading = false
    private static var pendingUpload = false
    private static var pullTask: Task<Void, Never>?

    // MARK: - Public

    static func syncIfLoggedIn() async {
        guard accountID()?.isEmpty == false else { return }
        await pullAndMerge()
    }

    static func pullAndMerge() async {
        let task: Task<Void, Never>
        lock.lock()
        if let pullTask {
            task = pullTask
            lock.unlock()
            await task.value
            return
        }
        task = Task { await performPullAndMerge() }
        pullTask = task
        lock.unlock()

        await task.value

        lock.lock()
        if pullTask == task {
            pullTask = nil
        }
        lock.unlock()
    }

    private static func performPullAndMerge() async {
        guard let userid = accountID(), !userid.isEmpty else { return }

        let encoded = userid.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? userid
        guard let url = URL(string: "https://login.yiys07.com/APPyun/\(encoded)") else { return }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(
                "application/x-www-form-urlencoded;charset=utf-8",
                forHTTPHeaderField: "Content-Type"
            )

            let (data, _) = try await session.data(for: request)
            guard let root = decodeCloudPayload(data) else { return }

            let key = "ahsp123456789012"
            replaceHistory(fromCipher: root["ls"] as? String ?? "", key: key)
            replaceFavorites(fromCipher: root["sc"] as? String ?? "", key: key)

            await MainActor.run {
                NotificationCenter.default.post(name: .ahYunCloudDidMerge, object: nil)
                NotificationCenter.default.post(name: .ahVodFavoriteDidChange, object: nil)
                NotificationCenter.default.post(name: .ahVodPlayRecordDidChange, object: nil)
            }
        } catch { }
    }

    static func uploadNow() {
        guard isLoggedInCached() else { return }
        Task.detached(priority: .utility) {
            await upload()
        }
    }

    static func upload() async {
        lock.lock()
        if isUploading {
            pendingUpload = true
            lock.unlock()
            return
        }
        isUploading = true
        lock.unlock()

        defer {
            var shouldRepeat = false
            lock.lock()
            isUploading = false
            if pendingUpload {
                pendingUpload = false
                shouldRepeat = true
            }
            lock.unlock()
            if shouldRepeat {
                Task.detached(priority: .utility) {
                    await upload()
                }
            }
        }

        guard let userid = accountID(), !userid.isEmpty else { return }

        do {
            let key = "ahsp123456789012"
            let lsPlain = flutterHistoryJSONString()
            let scPlain = flutterFavoriteJSONString()
            let ls = try CryptoUtil.aesEncrypt(lsPlain, key: key, iv: key, mode: "ECB")
            let sc = try CryptoUtil.aesEncrypt(scPlain, key: key, iv: key, mode: "ECB")

            // 与 Flutter 一致：CaH 为 JSON 字符串，且 body 不做百分号编码
            // （Base64 含 +/=，URLQueryItem 编码后部分 PHP 解析会踩坑）
            let cah = #"{"ls":"\#(ls)","sc":"\#(sc)"}"#
            let tm = CryptoUtil.md5Hex(hourStamp())
            let body = "tm=\(tm)&userid=\(userid)&CaH=\(cah)"

            let url = URL(string: "https://login.yiys07.com/yuncloud.php")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue(
                "application/x-www-form-urlencoded;charset=utf-8",
                forHTTPHeaderField: "Content-Type"
            )
            request.httpBody = Data(body.utf8)

            let (_, response) = try await session.data(for: request)
            
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: lastUploadKey)
        } catch {  }
    }

    static func scheduleUploadAfterHistoryChange() {
        scheduleUpload(minInterval: historyUploadInterval)
    }

    static func scheduleUploadAfterFavoriteChange() {
        uploadNow()
    }

    // MARK: - Replace local with remote

    private static func decodeCloudPayload(_ data: Data) -> [String: Any]? {
        if let root = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            return root
        }

        guard let text = String(data: data, encoding: .utf8)?
            .trimmingCharacters(in: .whitespacesAndNewlines),
              let utf8 = text.data(using: .utf8),
              let root = try? JSONSerialization.jsonObject(with: utf8) as? [String: Any] else {
            return nil
        }
        return root
    }

    private static func replaceHistory(fromCipher cipher: String, key: String) {
        guard !cipher.isEmpty, let remote = decryptDictionaryList(cipher, key: key) else {
            return
        }

        let list = Array(
            remote
                .filter { !(($0["标题"] as? String) ?? "").isEmpty }
                .prefix(cloudMergeCap)
                .map(normalizedPlayDictionary)
        )

        SearchStorage.saveDictionaryList(AHVodLocalStore.playRecordStorageKey, list: list)

        let flutterList: [[String: Any]] = list.map { item in
            [
                "标题": item["标题"] as? String ?? "",
                "集数": (item["集名"] as? String) ?? (item["集数"] as? String) ?? "",
                "链接": item["链接"] as? String ?? "",
                "来源": (item["源名字"] as? String) ?? (item["来源"] as? String) ?? "",
                "链接id": item["链接id"] as? String ?? "",
                "图片": item["图片"] as? String ?? "",
                "zypath": (item["订阅"] as? String) ?? (item["zypath"] as? String) ?? ""
            ]
        }
        UserDefaults.standard.set(SearchStorage.slz(flutterList), forKey: historyFlutterKey)
    }

    private static func replaceFavorites(fromCipher cipher: String, key: String) {
        guard !cipher.isEmpty, let remote = decryptDictionaryList(cipher, key: key) else {
            return
        }

        let list = Array(
            remote
                .filter { !(($0["标题"] as? String) ?? "").isEmpty }
                .prefix(cloudMergeCap)
                .map(normalizedFavoriteDictionary)
        )

        SearchStorage.saveDictionaryList(favoriteKey, list: list)
    }

    private static func decryptDictionaryList(_ cipher: String, key: String) -> [[String: Any]]? {
        do {
            let plain = try CryptoUtil.aesDecrypt(cipher, key: key, iv: key, mode: "ECB")
            if plain == "null" || plain.isEmpty { return nil }
            guard
                let data = plain.data(using: .utf8),
                let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]]
            else { return nil }
            return json
        } catch { 
            return nil
        }
    }

    private static func normalizedPlayDictionary(_ item: [String: Any]) -> [String: Any] {
        let source = (item["源名字"] as? String)
            ?? (item["来源"] as? String)
            ?? ""
        let zypath = (item["订阅"] as? String)
            ?? (item["zypath"] as? String)
            ?? ""
        let episode = (item["集名"] as? String)
            ?? (item["集数"] as? String)
            ?? ""

        return [
            "标题": item["标题"] as? String ?? "",
            "链接": item["链接"] as? String ?? "",
            "链接id": item["链接id"] as? String ?? "",
            "源名字": source,
            "图片": item["图片"] as? String ?? "",
            "订阅": zypath,
            "线路索引": AHVodLocalStore.int(item["线路索引"]),
            "线路名": item["线路名"] as? String ?? "",
            "集索引": AHVodLocalStore.int(item["集索引"]),
            "集名": episode,
            "集链接": item["集链接"] as? String ?? "",
            "进度": AHVodLocalStore.double(item["进度"]),
            "总时长": AHVodLocalStore.double(item["总时长"]),
            "时间": AHVodLocalStore.double(item["时间"])
        ]
    }

    private static func normalizedFavoriteDictionary(_ item: [String: Any]) -> [String: Any] {
        let source = (item["源名字"] as? String)
            ?? (item["来源"] as? String)
            ?? ""
        let zypath = (item["订阅"] as? String)
            ?? (item["zypath"] as? String)
            ?? ""

        return [
            "标题": item["标题"] as? String ?? "",
            "链接": item["链接"] as? String ?? "",
            "链接id": item["链接id"] as? String ?? "",
            "源名字": source,
            "图片": item["图片"] as? String ?? "",
            "订阅": zypath,
            "时间": AHVodLocalStore.double(item["时间"])
        ]
    }

    // MARK: - Upload payload

    private static func flutterHistoryJSONString() -> String {
        let list: [[String: Any]] = AHVodLocalStore.playRecords().map { record in
            [
                "标题": record.title,
                "集数": record.episodeTitle,
                "链接": record.path,
                "来源": record.sourceName,
                "链接id": record.videoLinkId,
                "图片": record.pic,
                "zypath": record.zypath,
                "线路名": record.lineName,
                "线路索引": record.lineIndex,
                "集索引": record.episodeIndex,
                "集链接": record.episodePath,
                "进度": record.position,
                "总时长": record.duration
            ]
        }
        // 同时写入 Flutter 键，便于与其它端对齐
        let text = SearchStorage.slz(list)
        UserDefaults.standard.set(text, forKey: historyFlutterKey)
        return text
    }

    private static func flutterFavoriteJSONString() -> String {
        let list: [[String: Any]] = AHVodLocalStore.favorites().map { record in
            [
                "标题": record.title,
                "简介": "",
                "链接": record.path,
                "来源": record.sourceName,
                "链接id": record.videoLinkId,
                "图片": record.pic,
                "zypath": record.zypath
            ]
        }
        return SearchStorage.slz(list)
    }

    // MARK: - Helpers

    private static func accountID() -> String? {
        let defaults = UserDefaults.standard
        if let zh = defaults.string(forKey: "zhcache"), !zh.isEmpty {
            return zh
        }
        return nil
    }

    private static func isLoggedInCached() -> Bool {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "ah_comment_access_token_v1") ?? ""
        let zh = defaults.string(forKey: "zhcache") ?? ""
        return !token.isEmpty && !zh.isEmpty
    }

    private static func hourStamp() -> String {
        let calendar = Calendar.current
        let now = Date()
        let year = calendar.component(.year, from: now)
        let month = String(format: "%02d", calendar.component(.month, from: now))
        let day = String(format: "%02d", calendar.component(.day, from: now))
        let hour = String(format: "%02d", calendar.component(.hour, from: now))
        return "\(year)\(month)\(day)\(hour)"
    }

    private static func scheduleUpload(minInterval: TimeInterval) {
        guard isLoggedInCached() else { return }

        let last = UserDefaults.standard.double(forKey: lastUploadKey)
        let now = Date().timeIntervalSince1970
        if last > 0, now - last < minInterval {
            return
        }

        Task.detached(priority: .utility) {
            await upload()
        }
    }
}
