//
//  AHDownloadModels.swift
//  LLVod
//
//  下载任务模型，对应 Flutter DownloadM3U8Util 的任务字段
//

import Foundation

enum AHDownloadStatus: String, Codable {
    case pending
    case downloading
    case paused
    case completed
    case failed

    var text: String {
        switch self {
        case .pending: return "等待中"
        case .downloading: return "下载中"
        case .paused: return "已暂停"
        case .completed: return "已完成"
        case .failed: return "失败"
        }
    }
}

enum AHDownloadKind: String, Codable {
    case m3u8
    case file
}

struct AHDownloadTask: Identifiable, Codable, Equatable {
    let id: String
    var url: String
    let title: String
    let subtitle: String
    let pic: String
    let zypath: String
    let headers: [String: String]
    var kind: AHDownloadKind
    var status: AHDownloadStatus
    var progress: Double
    var totalSegments: Int
    var completedSegments: Int
    var localFilePath: String?
    var errorMessage: String?
    var startTime: Date
    var completionTime: Date?

    static func makeId(title: String, subtitle: String) -> String {
        CryptoUtil.md5Hex("\(title)-\(subtitle)")
    }

    init(
        url: String,
        title: String,
        subtitle: String,
        pic: String,
        zypath: String,
        headers: [String: String],
        kind: AHDownloadKind
    ) {
        self.id = AHDownloadTask.makeId(title: title, subtitle: subtitle)
        self.url = url
        self.title = title
        self.subtitle = subtitle
        self.pic = pic
        self.zypath = zypath
        self.headers = headers
        self.kind = kind
        self.status = .pending
        self.progress = 0
        self.totalSegments = 0
        self.completedSegments = 0
        self.startTime = Date()
    }

    var relativeDirectory: String {
        "video/\(AHDownloadPaths.sanitize(title))/\(AHDownloadPaths.sanitize(subtitle))"
    }

    var isActive: Bool {
        status == .pending || status == .downloading
    }
}

enum AHDownloadPaths {

    static var root: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent("AHDownload", isDirectory: true)
    }

    static func directory(for task: AHDownloadTask) -> URL {
        root.appendingPathComponent(task.relativeDirectory, isDirectory: true)
    }

    static func absoluteURL(relativePath: String) -> URL {
        root.appendingPathComponent(relativePath)
    }

    static func sanitize(_ name: String) -> String {
        let invalid = CharacterSet(charactersIn: "/\\:*?\"<>|")
        let cleaned = name.components(separatedBy: invalid).joined(separator: "_")
        return cleaned.isEmpty ? "未命名" : cleaned
    }

    static func freeBytes() -> Int64 {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        guard let values = try? url.resourceValues(
            forKeys: [.volumeAvailableCapacityForImportantUsageKey]
        ) else {
            return 0
        }
        return Int64(values.volumeAvailableCapacityForImportantUsage ?? 0)
    }

    static func formatBytes(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useGB, .useMB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: bytes)
    }
}
