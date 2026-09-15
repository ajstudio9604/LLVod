//
//  AHSearchSubscriptionCache.swift
//  LLVod
//
//  远端 xdy.json 解密后就落地成本地 json，之后各处都读这一份
//

import Foundation

enum AHSearchSubscriptionCache {

    private static let directoryName = "AHSubscription"
    private static let fileName = "xdy.json"

    static var fileURL: URL? {
        guard let support = FileManager.default.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first else {
            return nil
        }

        return support
            .appendingPathComponent(directoryName, isDirectory: true)
            .appendingPathComponent(fileName)
    }

    static func read() -> [String: Any]? {
        guard let fileURL,
              let data = try? Data(contentsOf: fileURL),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }

        return json
    }

    static func save(_ json: String) throws {
        guard let fileURL, let data = json.data(using: .utf8) else {
            throw CocoaError(.fileWriteUnknown)
        }

        try FileManager.default.createDirectory(
            at: fileURL.deletingLastPathComponent(),
            withIntermediateDirectories: true
        )

        try data.write(to: fileURL, options: .atomic)
    }

    static var updatedAt: Date? {
        guard let fileURL,
              let attributes = try? FileManager.default.attributesOfItem(atPath: fileURL.path) else {
            return nil
        }

        return attributes[.modificationDate] as? Date
    }
}
