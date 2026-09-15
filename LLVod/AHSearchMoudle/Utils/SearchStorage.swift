//
//  SearchStorage.swift
//  LLVod
//
//  对应 Flutter mmkv + slz / rslz
//

import Foundation

enum SearchStorage {

    static func slz(_ value: Any) -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: value),
              let text = String(data: data, encoding: .utf8) else {
            return "[]"
        }
        return text
    }

    static func rslzStringList(_ key: String) -> [String] {
        guard let raw = UserDefaults.standard.string(forKey: key),
              let data = raw.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) else {
            return []
        }

        if let list = json as? [String] {
            return list
        }

        if let list = json as? [Any] {
            return list.compactMap { $0 as? String }
        }

        return []
    }

    static func rslzDictionaryList(_ key: String) -> [[String: Any]] {
        guard let raw = UserDefaults.standard.string(forKey: key),
              let data = raw.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) else {
            return []
        }

        if let list = json as? [[String: Any]] {
            return list
        }

        if let list = json as? [Any] {
            return list.compactMap { $0 as? [String: Any] }
        }

        return []
    }

    static func saveStringList(_ key: String, list: [String]) {
        UserDefaults.standard.set(slz(list), forKey: key)
    }

    static func saveDictionaryList(_ key: String, list: [[String: Any]]) {
        UserDefaults.standard.set(slz(list), forKey: key)
    }

    static func isSubscriptionEnabled(title: String) -> Bool {
        !UserDefaults.standard.bool(forKey: title)
    }

    static func setSubscriptionEnabled(title: String, enabled: Bool) {
        if enabled {
            UserDefaults.standard.removeObject(forKey: title)
        } else {
            UserDefaults.standard.set(true, forKey: title)
        }
    }
}
