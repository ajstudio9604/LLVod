//
//  AHCommentModel.swift
//  LLVod
//
//  评论模块数据模型，对应 AHSP API 的 /comments 与 /notices
//

import SwiftUI

// MARK: - 评论

struct AHComment: Identifiable, Equatable {

    let id: Int
    let userId: Int
    let content: String
    let parentCommentId: Int?
    let rootCommentId: Int?
    let createdAt: TimeInterval
    let nickname: String
    let avatarURL: String
    let parentUserNickname: String?
    let replyCount: Int

    init?(json: [String: Any]) {
        guard let id = AHCommentJSON.int(json["id"]) else { return nil }

        self.id = id
        userId = AHCommentJSON.int(json["user_id"]) ?? 0
        content = AHCommentJSON.string(json["content"])
        // 接口根评论是 null；个别实现会给 0，统一当成「无父评论」
        parentCommentId = AHCommentJSON.positiveInt(json["parent_comment_id"])
        rootCommentId = AHCommentJSON.positiveInt(json["root_comment_id"])
        createdAt = AHCommentJSON.double(json["created_at"]) ?? 0
        nickname = AHCommentJSON.string(json["nickname"])
        avatarURL = AHCommentJSON.string(json["avatar_url"])
        replyCount = AHCommentJSON.int(json["reply_count"]) ?? 0

        let parentNickname = AHCommentJSON.string(json["parent_user_nickname"])
        parentUserNickname = parentNickname.isEmpty ? nil : parentNickname
    }

    var displayName: String {
        nickname.isEmpty ? "用户\(userId)" : nickname
    }

    var isRoot: Bool {
        parentCommentId == nil
    }

    var isReply: Bool {
        !isRoot
    }

    var relativeTime: String {
        guard createdAt > 0 else { return "" }

        let interval = Date().timeIntervalSince1970 - createdAt
        switch interval {
        case ..<60:
            return "刚刚"
        case ..<3600:
            return "\(Int(interval / 60))分钟前"
        case ..<86400:
            return "\(Int(interval / 3600))小时前"
        case ..<(86400 * 30):
            return "\(Int(interval / 86400))天前"
        default:
            return AHCommentDateFormatter.day.string(
                from: Date(timeIntervalSince1970: createdAt)
            )
        }
    }
}

// MARK: - 公告

struct AHCommentNotice: Identifiable {

    let id: Int
    let title: String
    let content: String
    let linkURL: String
    let icon: String
    let backgroundColor: Color
    let textColor: Color

    init?(json: [String: Any]) {
        guard let id = AHCommentJSON.int(json["id"]) else { return nil }

        self.id = id
        title = AHCommentJSON.string(json["title"])
        content = AHCommentJSON.string(json["content"])
        linkURL = AHCommentJSON.string(json["link_url"])
        icon = AHCommentJSON.string(json["icon"])
        backgroundColor = AHCommentColorHex.color(
            AHCommentJSON.string(json["bg_color"]),
            fallback: Color(red: 31 / 255, green: 41 / 255, blue: 55 / 255)
        )
        textColor = AHCommentColorHex.color(
            AHCommentJSON.string(json["text_color"]),
            fallback: .white
        )
    }
}

// MARK: - 分页

struct AHCommentPage {
    let list: [AHComment]
    let notices: [AHCommentNotice]
    let total: Int
    let hasMore: Bool
}

// MARK: - 登录用户

struct AHCommentUser: Codable, Equatable {

    let id: Int
    let account: String
    let nickname: String
    let avatarURL: String
    let bio: String
    let title: String
    let vip: Bool
    let vipExpiresAt: TimeInterval
    let createdAt: TimeInterval

    enum CodingKeys: String, CodingKey {
        case id, account, nickname, avatarURL, bio, title, vip, vipExpiresAt, createdAt
    }

    init(json: [String: Any]) {
        id = AHCommentJSON.int(json["id"]) ?? 0
        account = AHCommentJSON.string(json["account"])
        nickname = AHCommentJSON.string(json["nickname"])
        avatarURL = AHCommentJSON.string(json["avatar_url"])
        bio = AHCommentJSON.string(json["bio"])
        title = AHCommentJSON.string(json["title"])
        vip = AHCommentJSON.bool(json["vip"])
        vipExpiresAt = AHCommentJSON.double(json["vip_expires_at"]) ?? 0
        createdAt = AHCommentJSON.double(json["created_at"]) ?? 0
    }

    init(
        id: Int,
        account: String,
        nickname: String,
        avatarURL: String,
        bio: String = "",
        title: String = "",
        vip: Bool = false,
        vipExpiresAt: TimeInterval = 0,
        createdAt: TimeInterval = 0
    ) {
        self.id = id
        self.account = account
        self.nickname = nickname
        self.avatarURL = avatarURL
        self.bio = bio
        self.title = title
        self.vip = vip
        self.vipExpiresAt = vipExpiresAt
        self.createdAt = createdAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        account = try container.decode(String.self, forKey: .account)
        nickname = try container.decode(String.self, forKey: .nickname)
        avatarURL = try container.decode(String.self, forKey: .avatarURL)
        bio = try container.decodeIfPresent(String.self, forKey: .bio) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        vip = try container.decodeIfPresent(Bool.self, forKey: .vip) ?? false
        vipExpiresAt = try container.decodeIfPresent(TimeInterval.self, forKey: .vipExpiresAt) ?? 0
        createdAt = try container.decodeIfPresent(TimeInterval.self, forKey: .createdAt) ?? 0
    }

    var displayName: String {
        nickname.isEmpty ? account : nickname
    }

    func updating(
        nickname: String? = nil,
        avatarURL: String? = nil,
        bio: String? = nil,
        title: String? = nil,
        vip: Bool? = nil,
        vipExpiresAt: TimeInterval? = nil
    ) -> AHCommentUser {
        AHCommentUser(
            id: id,
            account: account,
            nickname: nickname ?? self.nickname,
            avatarURL: avatarURL ?? self.avatarURL,
            bio: bio ?? self.bio,
            title: title ?? self.title,
            vip: vip ?? self.vip,
            vipExpiresAt: vipExpiresAt ?? self.vipExpiresAt,
            createdAt: createdAt
        )
    }
}

// MARK: - 解析工具

enum AHCommentJSON {

    static func int(_ value: Any?) -> Int? {
        if value is NSNull { return nil }
        switch value {
        case let number as NSNumber:
            return number.intValue
        case let text as String:
            return Int(text)
        default:
            return nil
        }
    }

    static func positiveInt(_ value: Any?) -> Int? {
        guard let number = int(value), number > 0 else { return nil }
        return number
    }

    static func double(_ value: Any?) -> Double? {
        switch value {
        case let number as NSNumber:
            return number.doubleValue
        case let text as String:
            return Double(text)
        default:
            return nil
        }
    }

    static func string(_ value: Any?) -> String {
        switch value {
        case let text as String:
            return text
        case let number as NSNumber:
            return number.stringValue
        default:
            return ""
        }
    }

    static func bool(_ value: Any?) -> Bool {
        switch value {
        case let flag as Bool:
            return flag
        case let number as NSNumber:
            return number.boolValue
        case let text as String:
            let normalized = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            return normalized == "1" || normalized == "true" || normalized == "yes"
        default:
            return (int(value) ?? 0) != 0
        }
    }

    static func dictionary(_ value: Any?) -> [String: Any] {
        value as? [String: Any] ?? [:]
    }

    static func array(_ value: Any?) -> [[String: Any]] {
        value as? [[String: Any]] ?? []
    }
}

enum AHCommentColorHex {

    static func color(_ hex: String, fallback: Color) -> Color {
        var text = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return fallback }

        if text.hasPrefix("#") {
            text = String(text.dropFirst())
        }
        if text.hasPrefix("0x") || text.hasPrefix("0X") {
            text = String(text.dropFirst(2))
        }
        guard text.count == 6 || text.count == 8 else { return fallback }

        var value: UInt64 = 0
        guard Scanner(string: text).scanHexInt64(&value) else { return fallback }

        // 8 位按 RRGGBBAA 处理
        let hasAlpha = text.count == 8
        let red = Double((value >> (hasAlpha ? 24 : 16)) & 0xFF) / 255
        let green = Double((value >> (hasAlpha ? 16 : 8)) & 0xFF) / 255
        let blue = Double((value >> (hasAlpha ? 8 : 0)) & 0xFF) / 255
        let alpha = hasAlpha ? Double(value & 0xFF) / 255 : 1

        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}

enum AHCommentDateFormatter {
    static let day: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
