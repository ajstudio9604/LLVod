//
//  AHVodLocalStore.swift
//  LLVod
//
//  收藏与播放记录的本地存储，对应 Flutter 的 mmkv 方案：
//  - 收藏：`影片收藏记录cache` 列表，按 链接 + 链接id 判重
//  - 播放记录：Flutter 用 `线路${title}`、`title -> 集URL` 两个裸键；
//    iOS 侧合并成一条记录存进 `影片播放记录cache`，避免用影片标题当 UserDefaults 键，
//    否则会和 SearchStorage.isSubscriptionEnabled(title:) 的 Bool 键撞类型。
//

import Foundation

extension Notification.Name {
    static let ahVodFavoriteDidChange = Notification.Name("ahVodFavoriteDidChange")
}

struct AHVodFavoriteRecord: Identifiable {
    var id: String { "\(path)-\(videoLinkId)" }

    let title: String
    let path: String
    let videoLinkId: String
    let sourceName: String
    let pic: String
    let zypath: String
    let timestamp: Double

    var route: AHVodDetailRoute {
        AHVodDetailRoute(
            name: title,
            path: path,
            sourceName: sourceName,
            videoLinkId: videoLinkId,
            pic: pic,
            zypath: zypath
        )
    }

    var dictionary: [String: Any] {
        [
            "标题": title,
            "链接": path,
            "链接id": videoLinkId,
            "源名字": sourceName,
            "图片": pic,
            "订阅": zypath,
            "时间": timestamp
        ]
    }

    init(
        title: String,
        path: String,
        videoLinkId: String,
        sourceName: String,
        pic: String,
        zypath: String,
        timestamp: Double = Date().timeIntervalSince1970
    ) {
        self.title = title
        self.path = path
        self.videoLinkId = videoLinkId
        self.sourceName = sourceName
        self.pic = pic
        self.zypath = zypath
        self.timestamp = timestamp
    }

    init?(dictionary: [String: Any]) {
        guard let path = dictionary["链接"] as? String else { return nil }
        self.title = dictionary["标题"] as? String ?? ""
        self.path = path
        self.videoLinkId = dictionary["链接id"] as? String ?? ""
        // 兼容 Flutter 云同步字段：来源 / zypath
        self.sourceName = (dictionary["源名字"] as? String)
            ?? (dictionary["来源"] as? String)
            ?? ""
        self.pic = dictionary["图片"] as? String ?? ""
        self.zypath = (dictionary["订阅"] as? String)
            ?? (dictionary["zypath"] as? String)
            ?? ""
        self.timestamp = AHVodLocalStore.double(dictionary["时间"])
    }
}

struct AHVodPlayRecord: Identifiable {
    var id: String { "\(path)-\(videoLinkId)" }

    let title: String
    let path: String
    let videoLinkId: String
    let sourceName: String
    let pic: String
    let zypath: String
    let lineIndex: Int
    let lineName: String
    let episodeIndex: Int
    let episodeTitle: String
    let episodePath: String
    let position: Double
    let duration: Double
    let timestamp: Double

    var route: AHVodDetailRoute {
        AHVodDetailRoute(
            name: title,
            path: path,
            sourceName: sourceName,
            videoLinkId: videoLinkId,
            pic: pic,
            zypath: zypath
        )
    }

    var dictionary: [String: Any] {
        [
            "标题": title,
            "链接": path,
            "链接id": videoLinkId,
            "源名字": sourceName,
            "图片": pic,
            "订阅": zypath,
            "线路索引": lineIndex,
            "线路名": lineName,
            "集索引": episodeIndex,
            "集名": episodeTitle,
            "集链接": episodePath,
            "进度": position,
            "总时长": duration,
            "时间": timestamp
        ]
    }

    init(
        title: String,
        path: String,
        videoLinkId: String,
        sourceName: String,
        pic: String,
        zypath: String,
        lineIndex: Int,
        lineName: String,
        episodeIndex: Int,
        episodeTitle: String,
        episodePath: String,
        position: Double = 0,
        duration: Double = 0,
        timestamp: Double = Date().timeIntervalSince1970
    ) {
        self.title = title
        self.path = path
        self.videoLinkId = videoLinkId
        self.sourceName = sourceName
        self.pic = pic
        self.zypath = zypath
        self.lineIndex = lineIndex
        self.lineName = lineName
        self.episodeIndex = episodeIndex
        self.episodeTitle = episodeTitle
        self.episodePath = episodePath
        self.position = position
        self.duration = duration
        self.timestamp = timestamp
    }

    init?(dictionary: [String: Any]) {
        guard let path = dictionary["链接"] as? String else { return nil }
        self.title = dictionary["标题"] as? String ?? ""
        self.path = path
        self.videoLinkId = dictionary["链接id"] as? String ?? ""
        // 兼容 Flutter 云同步字段：来源 / zypath / 集数
        self.sourceName = (dictionary["源名字"] as? String)
            ?? (dictionary["来源"] as? String)
            ?? ""
        self.pic = dictionary["图片"] as? String ?? ""
        self.zypath = (dictionary["订阅"] as? String)
            ?? (dictionary["zypath"] as? String)
            ?? ""
        self.lineIndex = AHVodLocalStore.int(dictionary["线路索引"])
        self.lineName = dictionary["线路名"] as? String ?? ""
        self.episodeIndex = AHVodLocalStore.int(dictionary["集索引"])
        self.episodeTitle = (dictionary["集名"] as? String)
            ?? (dictionary["集数"] as? String)
            ?? ""
        self.episodePath = dictionary["集链接"] as? String ?? ""
        self.position = AHVodLocalStore.double(dictionary["进度"])
        self.duration = AHVodLocalStore.double(dictionary["总时长"])
        self.timestamp = AHVodLocalStore.double(dictionary["时间"])
    }
}

enum AHVodLocalStore {

    private static let favoriteKey = "影片收藏记录cache"
    private static let playRecordKey = "影片播放记录cache"

    static var playRecordStorageKey: String { playRecordKey }

    private static let favoriteLimit = 100
    private static let playRecordLimit = 200

    // MARK: - 收藏

    static func favorites() -> [AHVodFavoriteRecord] {
        SearchStorage.rslzDictionaryList(favoriteKey)
            .compactMap(AHVodFavoriteRecord.init(dictionary:))
    }

    static func isFavorited(route: AHVodDetailRoute) -> Bool {
        SearchStorage.rslzDictionaryList(favoriteKey).contains {
            isSameVod($0, path: route.path, videoLinkId: route.videoLinkId)
        }
    }

    static func removeFavorite(_ record: AHVodFavoriteRecord) {
        var list = SearchStorage.rslzDictionaryList(favoriteKey)
        list.removeAll {
            isSameVod($0, path: record.path, videoLinkId: record.videoLinkId)
        }
        SearchStorage.saveDictionaryList(favoriteKey, list: list)
        notifyFavoriteChanged()
        AHYunCloudService.uploadNow()
    }

    static func clearFavorites() {
        SearchStorage.saveDictionaryList(favoriteKey, list: [])
        notifyFavoriteChanged()
        AHYunCloudService.uploadNow()
    }

    @discardableResult
    static func toggleFavorite(route: AHVodDetailRoute, title: String, pic: String) -> Bool {
        var list = SearchStorage.rslzDictionaryList(favoriteKey)

        if let index = list.firstIndex(where: {
            isSameVod($0, path: route.path, videoLinkId: route.videoLinkId)
        }) {
            list.remove(at: index)
            SearchStorage.saveDictionaryList(favoriteKey, list: list)
            notifyFavoriteChanged()
            AHYunCloudService.uploadNow()
            return false
        }

        let record = AHVodFavoriteRecord(
            title: title.isEmpty ? route.name : title,
            path: route.path,
            videoLinkId: route.videoLinkId,
            sourceName: route.sourceName,
            pic: pic.isEmpty ? route.pic : pic,
            zypath: route.zypath
        )

        // 同名去重，新的插到最前面
        list.removeAll { ($0["标题"] as? String) == record.title }
        list.insert(record.dictionary, at: 0)

        if list.count > favoriteLimit {
            list = Array(list.prefix(favoriteLimit))
        }

        SearchStorage.saveDictionaryList(favoriteKey, list: list)
        notifyFavoriteChanged()
        AHYunCloudService.uploadNow()
        return true
    }

    // MARK: - 播放记录

    static func playRecords() -> [AHVodPlayRecord] {
        SearchStorage.rslzDictionaryList(playRecordKey)
            .compactMap(AHVodPlayRecord.init(dictionary:))
            .sorted { $0.timestamp > $1.timestamp }
    }

    static func playRecord(route: AHVodDetailRoute) -> AHVodPlayRecord? {
        SearchStorage.rslzDictionaryList(playRecordKey)
            .first { isSameVod($0, path: route.path, videoLinkId: route.videoLinkId) }
            .flatMap(AHVodPlayRecord.init(dictionary:))
    }

    static func savePlayRecord(_ record: AHVodPlayRecord, syncRemoteImmediately: Bool = false) {
        var list = SearchStorage.rslzDictionaryList(playRecordKey)
        list.removeAll { isSameVod($0, path: record.path, videoLinkId: record.videoLinkId) }
        list.insert(record.dictionary, at: 0)

        if list.count > playRecordLimit {
            list = Array(list.prefix(playRecordLimit))
        }

        SearchStorage.saveDictionaryList(playRecordKey, list: list)
        notifyPlayRecordChanged()
        if syncRemoteImmediately {
            AHYunCloudService.uploadNow()
        } else {
            AHYunCloudService.scheduleUploadAfterHistoryChange()
        }
    }

    static func removePlayRecord(_ record: AHVodPlayRecord) {
        var list = SearchStorage.rslzDictionaryList(playRecordKey)
        list.removeAll { isSameVod($0, path: record.path, videoLinkId: record.videoLinkId) }
        SearchStorage.saveDictionaryList(playRecordKey, list: list)
        notifyPlayRecordChanged()
        AHYunCloudService.uploadNow()
    }

    static func clearPlayRecords() {
        SearchStorage.saveDictionaryList(playRecordKey, list: [])
        notifyPlayRecordChanged()
        AHYunCloudService.uploadNow()
    }

    // MARK: - 工具

    private static func isSameVod(
        _ dictionary: [String: Any],
        path: String,
        videoLinkId: String
    ) -> Bool {
        (dictionary["链接"] as? String) == path
            && (dictionary["链接id"] as? String) == videoLinkId
    }

    private static func notifyFavoriteChanged() {
        NotificationCenter.default.post(name: .ahVodFavoriteDidChange, object: nil)
    }

    private static func notifyPlayRecordChanged() {
        NotificationCenter.default.post(name: .ahVodPlayRecordDidChange, object: nil)
    }

    static func int(_ value: Any?) -> Int {
        if let number = value as? Int { return number }
        if let number = value as? Double { return Int(number) }
        if let text = value as? String { return Int(text) ?? 0 }
        return 0
    }

    static func double(_ value: Any?) -> Double {
        if let number = value as? Double { return number }
        if let number = value as? Int { return Double(number) }
        if let text = value as? String { return Double(text) ?? 0 }
        return 0
    }
}
