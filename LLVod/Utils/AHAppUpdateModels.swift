//
//  AHAppUpdateModels.swift
//  LLVod
//
//  公告 / 版本更新数据，对应 Flutter gx (2).dart + UpdateDialog / AppNoticeDialog
//

import Foundation

struct AHAppNoticeInfo: Identifiable, Equatable {
    let id = UUID()
    let content: String
}

struct AHAppUpdateInfo: Identifiable, Equatable {
    let id = UUID()
    let version: String
    let sizeText: String
    let changelog: String
    let isForce: Bool
    let downloadURL: String
    let downloadMode: String

    var title: String { "发现新版本 \(version)" }

    var bodyText: String {
        var lines: [String] = []
        if !sizeText.isEmpty {
            lines.append("新版大小：\(sizeText)MB")
            lines.append("")
        }
        if !changelog.isEmpty {
            lines.append(changelog)
        }
        return lines.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var updateButtonTitle: String {
        downloadMode == "AppStore" ? "前往 App Store" : "立即更新"
    }
}

enum AHAppVersionCompare {

    static func compare(current: String, latest: String) -> Int? {
        guard let left = parse(current), let right = parse(latest) else { return nil }
        let count = max(left.count, right.count)
        for index in 0..<count {
            let a = index < left.count ? left[index] : 0
            let b = index < right.count ? right[index] : 0
            if a != b { return a < b ? -1 : 1 }
        }
        return 0
    }

    private static func parse(_ version: String) -> [Int]? {
        let trimmed = version.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let match = trimmed.range(of: #"^\d+(?:\.\d+)*"#, options: .regularExpression) else {
            return nil
        }
        return trimmed[match].split(separator: ".").compactMap { Int($0) }
    }

    static var currentShortVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    static var bundleIdentifier: String {
        Bundle.main.bundleIdentifier ?? ""
    }
}
