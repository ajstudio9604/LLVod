//
//  AHDanmakuParser.swift
//  LLVod
//
//  弹幕接口返回和本地弹幕文件的解析，对应 Flutter DanmakuService 的 tryFetch /
//  loadLocalDanmaku / saveLocalDanmaku 里的数据处理部分
//

import Foundation

enum AHDanmakuParser {

    static func parse(_ json: [String: Any]) -> [AHDanmakuRawItem] {
        // 新格式（dandanplay）{"comments":[{"p":"时间,模式,颜色,来源","m":"内容","t":0}]}
        if let comments = json["comments"] as? [[String: Any]] {
            return comments.compactMap { comment in
                let p = (comment["p"] as? String) ?? ""
                let text = (comment["m"] as? String) ?? ""
                guard !p.isEmpty, !text.isEmpty else { return nil }

                let parts = p.split(separator: ",").map(String.init)
                // p 的首字段是精确到小数的时间，t 只是整秒的辅助字段，
                // 而且经常是 0，先取 p 才不会让这些弹幕全挤到片头
                let time = double(parts.first) ?? double(comment["t"]) ?? 0
                let mode = parts.count > 1 ? Int(parts[1]) ?? 1 : 1
                let colorHex = parts.count > 2 ? hexColor(from: parts[2]) : "#FFFFFF"

                return AHDanmakuRawItem(time: time, text: text, colorHex: colorHex, type: mode)
            }
        }

        // 旧格式（DPlayer）{"danmuku":[[时间, 位置, 颜色, 作者, 内容]]}
        if let list = json["danmuku"] as? [[Any]] {
            return list.compactMap { row in
                guard row.count > 4 else { return nil }
                guard let text = row[4] as? String, !text.isEmpty else { return nil }

                return AHDanmakuRawItem(
                    time: double(row[0]) ?? 0,
                    text: text,
                    colorHex: hexColor(from: row[2]),
                    type: dPlayerMode(row[1])
                )
            }
        }

        return []
    }

    // MARK: - 本地弹幕文件

    static func encodeLocal(_ items: [AHDanmakuRawItem]) -> Data? {
        let list = items
            .sorted { $0.time < $1.time }
            .map {
                [
                    "time": $0.time,
                    "text": $0.text,
                    "color": $0.colorHex,
                    "mode": $0.type
                ] as [String: Any]
            }

        guard !list.isEmpty else { return nil }
        return try? JSONSerialization.data(withJSONObject: list)
    }

    static func decodeLocal(_ data: Data) -> [AHDanmakuRawItem] {
        guard let list = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }

        // color / mode 是本项目额外存的，Flutter 存的老文件里没有，按白色滚动处理
        return list.compactMap { item in
            guard let text = item["text"] as? String, !text.isEmpty else { return nil }

            return AHDanmakuRawItem(
                time: double(item["time"]) ?? 0,
                text: text,
                colorHex: hexColor(from: item["color"]),
                type: Int(double(item["mode"]) ?? 1)
            )
        }
    }

    // MARK: - 字段兜底

    static func hexColor(from value: Any?) -> String {
        if let text = value as? String, text.hasPrefix("#") {
            return text
        }

        guard let number = double(value) else { return "#FFFFFF" }
        return String(format: "#%06X", UInt32(bitPattern: Int32(truncatingIfNeeded: Int(number))) & 0xFFFFFF)
    }

    static func dPlayerMode(_ value: Any?) -> Int {
        if let text = value as? String {
            switch text.lowercased() {
            case "top": return 5
            case "bottom": return 4
            default: return 1
            }
        }

        switch Int(double(value) ?? 0) {
        case 1: return 5
        case 2: return 4
        default: return 1
        }
    }

    static func double(_ value: Any?) -> Double? {
        if let number = value as? Double { return number }
        if let number = value as? Int { return Double(number) }
        if let number = value as? NSNumber { return number.doubleValue }
        if let text = value as? String { return Double(text) }
        return nil
    }
}
