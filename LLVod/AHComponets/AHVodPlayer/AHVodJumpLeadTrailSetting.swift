//
//  AHVodJumpLeadTrailSetting.swift
//  LLVod
//

import Foundation

struct AHVodJumpLeadTrail: Codable {
    var leading: Double = 0
    var trail: Double = 0
}

final class AHVodJumpLeadTrailStore {
    static let shared = AHVodJumpLeadTrailStore()

    private let key = "ah.vodjump.settings"

    func load() -> AHVodJumpLeadTrail {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let settings = try? JSONDecoder().decode(AHVodJumpLeadTrail.self, from: data)
        else {
            return AHVodJumpLeadTrail()
        }
        return settings
    }

    func save(_ settings: AHVodJumpLeadTrail) {
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
