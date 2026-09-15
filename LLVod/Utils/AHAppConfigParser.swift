//
//  AHAppConfigParser.swift
//  LLVod
//
//  /app/config 的响应解析，对应 Flutter gx.dart 里 getgx 的解码和取值部分
//

import Foundation

enum AHAppConfigParser {

    static func decode(_ body: String) -> [String: Any]? {
        let trimmed = body.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }

        if let object = decodeBase64JSON(trimmed) {
            return object
        }

        guard let data = trimmed.data(using: .utf8),
              let wrapper = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }

        if let text = wrapper["data"] as? String {
            return decodeBase64JSON(text)
        }

        return wrapper["data"] as? [String: Any]
    }

    private static func decodeBase64JSON(_ text: String) -> [String: Any]? {
        let cleaned = text
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\r", with: "")

        guard let decoded = Data(base64Encoded: cleaned),
              let object = try? JSONSerialization.jsonObject(with: decoded) as? [String: Any] else {
            return nil
        }

        return object
    }

    static func bool(_ value: Any?, default defaultValue: Bool = false) -> Bool {
        if let flag = value as? Bool { return flag }

        if let text = value as? String {
            switch text.trimmingCharacters(in: .whitespaces).lowercased() {
            case "true", "1": return true
            case "false", "0": return false
            default: return defaultValue
            }
        }

        if let number = value as? NSNumber { return number.intValue != 0 }
        return defaultValue
    }

    static func string(_ value: Any?) -> String {
        if let text = value as? String { return text.trimmingCharacters(in: .whitespaces) }
        if let number = value as? NSNumber { return number.stringValue }
        return ""
    }

    static func configURL(from server: String) -> String? {
        let trimmed = server.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return nil }

        let withScheme = trimmed.contains("://") ? trimmed : "https://\(trimmed)"
        guard let url = URL(string: withScheme), url.host != nil else { return nil }

        if url.path.isEmpty || url.path == "/" {
            return withScheme.hasSuffix("/") ? "\(withScheme)app/config" : "\(withScheme)/app/config"
        }

        return withScheme
    }
}
