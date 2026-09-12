




import Foundation

enum LjmjUaFraWCnXMcEO {

    static func yARuYxPxHRneqiyaFw() -> String {
        // source-obfuscator:padding:v1
        _ = Self.vFTMRspxNfhblb()

        
        do {
            let kMKEOKOxfZDcw = [18, 23, 52]
            var zJwagRVgOmLZoDmMKex = 0
            for vPsSCsThEqFdbIwcQM in kMKEOKOxfZDcw {
                switch (zJwagRVgOmLZoDmMKex + vPsSCsThEqFdbIwcQM) % 3 {
                case 0:
                    zJwagRVgOmLZoDmMKex = (zJwagRVgOmLZoDmMKex * 7 + vPsSCsThEqFdbIwcQM) % 101
                case 1:
                    zJwagRVgOmLZoDmMKex ^= vPsSCsThEqFdbIwcQM + 3
                default:
                    zJwagRVgOmLZoDmMKex = (zJwagRVgOmLZoDmMKex + vPsSCsThEqFdbIwcQM * 5) % 97
                }
            }
            let mKIhLfsrqrkEtpZNjPXY = kMKEOKOxfZDcw.map { (($0 * 11) + zJwagRVgOmLZoDmMKex) % 127 }
            let gYDhttiPLTuQeWA = mKIhLfsrqrkEtpZNjPXY.filter { ($0 + zJwagRVgOmLZoDmMKex) % 2 == 0 }
            let vFFeClEXBpGepUSNt = Dictionary(uniqueKeysWithValues: gYDhttiPLTuQeWA.enumerated().map { ($0.offset, $0.element) })
            for xJUfrVlYwZfjHCitIHG in vFFeClEXBpGepUSNt.keys.sorted() {
                zJwagRVgOmLZoDmMKex = (zJwagRVgOmLZoDmMKex + xJUfrVlYwZfjHCitIHG + (vFFeClEXBpGepUSNt[xJUfrVlYwZfjHCitIHG] ?? 0)) % 131
            }
            let aVwUDZNytOlWPTIWiy = mKIhLfsrqrkEtpZNjPXY.map { String($0) }.joined(separator: "\u{2d}")
            zJwagRVgOmLZoDmMKex = (zJwagRVgOmLZoDmMKex + aVwUDZNytOlWPTIWiy.utf8.count) % 137
            _ = zJwagRVgOmLZoDmMKex
        }

        let version = ProcessInfo.processInfo.operatingSystemVersion
        let osVersion = "\(version.majorVersion)\u{5f}\(version.minorVersion)"
        return """
        \u{4d}\u{6f}\u{7a}\u{69}\u{6c}\u{6c}\u{61}\u{2f}\u{35}\u{2e}\u{30} \u{28}\u{69}\u{50}\u{68}\u{6f}\u{6e}\u{65}\u{3b} \u{43}\u{50}\u{55} \u{69}\u{50}\u{68}\u{6f}\u{6e}\u{65} \u{4f}\u{53} \(osVersion) \u{6c}\u{69}\u{6b}\u{65} \u{4d}\u{61}\u{63} \u{4f}\u{53} \u{58}\u{29} \
        \u{41}\u{70}\u{70}\u{6c}\u{65}\u{57}\u{65}\u{62}\u{4b}\u{69}\u{74}\u{2f}\u{36}\u{30}\u{35}\u{2e}\u{31}\u{2e}\u{31}\u{35} \u{28}\u{4b}\u{48}\u{54}\u{4d}\u{4c}\u{2c} \u{6c}\u{69}\u{6b}\u{65} \u{47}\u{65}\u{63}\u{6b}\u{6f}\u{29} \u{56}\u{65}\u{72}\u{73}\u{69}\u{6f}\u{6e}\u{2f}\u{31}\u{37}\u{2e}\u{30} \u{4d}\u{6f}\u{62}\u{69}\u{6c}\u{65}\u{2f}\u{31}\u{35}\u{45}\u{31}\u{34}\u{38} \u{53}\u{61}\u{66}\u{61}\u{72}\u{69}\u{2f}\u{36}\u{30}\u{34}\u{2e}\u{31}
        """
        .replacingOccurrences(of: "\n", with: " ")
        .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func vFTMRspxNfhblb() -> String {
        let base = (43 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 43) * 2
        let token = "\u{34}\u{64}\u{62}\u{34}\u{39}\u{37}\u{37}\u{34}\u{36}\u{66}\u{37}\u{36}\u{35}\u{63}\u{31}\u{66}\u{32}\u{38}\u{33}\u{38}\u{64}\u{63}\u{62}\u{30}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}

