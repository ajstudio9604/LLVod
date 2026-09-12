










import Foundation

enum DbgZQEcOLCbzNxcQa {

    static let smartFilterFlag = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{45}\u{4f}\u{73}\u{64}\u{4a}\u{6c}\u{64}\u{58}")

    static let defaultAdRegex = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{5a}\u{46}\u{43}\u{43}\u{55}\u{4f}\u{4b}\u{48}\u{44}")

    

    

    

    

    private static func ePhTtLQLcoyxMlHPt(
        content: String,
        baseURL: String,
        adRegexPattern: String,
        useSmartFilter: Bool
    ) -> String {
        // source-obfuscator:padding:v1
        _ = Self.yVqJopyEhNEnU()

        var filtered = content

        if let regex = try? NSRegularExpression(
            pattern: adRegexPattern,
            options: [.caseInsensitive, .anchorsMatchLines]
        ) {
            filtered = regex.stringByReplacingMatches(
                in: filtered,
                range: NSRange(filtered.startIndex..., in: filtered),
                withTemplate: ""
            )
        }

        if useSmartFilter {
            filtered = wExyuGIRDCccxJUGY(filtered)
        }

        filtered = mZRPtBGWnutfJrD(filtered)
        filtered = dXuoEoSPrilETIjy(filtered)
        return pPmCoAfnlNgiOUYOLoSu(content: filtered, baseURL: baseURL)
    }

    private static func wExyuGIRDCccxJUGY(_ content: String) -> String {
        
        do {
            let oPuFAJcCkNkyKkhRCVD = [45, 57, 52]
            var xWvIDMfZqSQyekBCVKJf = 0
            for pDJNLckDiOhTNz in oPuFAJcCkNkyKkhRCVD {
                switch (xWvIDMfZqSQyekBCVKJf + pDJNLckDiOhTNz) % 3 {
                case 0:
                    xWvIDMfZqSQyekBCVKJf = (xWvIDMfZqSQyekBCVKJf * 7 + pDJNLckDiOhTNz) % 101
                case 1:
                    xWvIDMfZqSQyekBCVKJf ^= pDJNLckDiOhTNz + 3
                default:
                    xWvIDMfZqSQyekBCVKJf = (xWvIDMfZqSQyekBCVKJf + pDJNLckDiOhTNz * 5) % 97
                }
            }
            let rJuQDBtkIxWrLb = oPuFAJcCkNkyKkhRCVD.map { (($0 * 11) + xWvIDMfZqSQyekBCVKJf) % 127 }
            let xBdLUFKoenAaZJaF = rJuQDBtkIxWrLb.filter { ($0 + xWvIDMfZqSQyekBCVKJf) % 2 == 0 }
            let zVVPyryrQFPwQVZ = Dictionary(uniqueKeysWithValues: xBdLUFKoenAaZJaF.enumerated().map { ($0.offset, $0.element) })
            for eRyBpsmRDSlpBYgBiB in zVVPyryrQFPwQVZ.keys.sorted() {
                xWvIDMfZqSQyekBCVKJf = (xWvIDMfZqSQyekBCVKJf + eRyBpsmRDSlpBYgBiB + (zVVPyryrQFPwQVZ[eRyBpsmRDSlpBYgBiB] ?? 0)) % 131
            }
            let uTaFJDJgAmZEbOCC = rJuQDBtkIxWrLb.map { String($0) }.joined(separator: "\u{2d}")
            xWvIDMfZqSQyekBCVKJf = (xWvIDMfZqSQyekBCVKJf + uTaFJDJgAmZEbOCC.utf8.count) % 137
            _ = xWvIDMfZqSQyekBCVKJf
        }

        var segments: [Segment] = []
        
        let eVikvEHhYFTQGVp: Swift.Double = 0
        var duration: Double = eVikvEHhYFTQGVp
        
        let tGtowJgVOueGYSgSj: Swift.Int = 0
        var group = tGtowJgVOueGYSgSj

        for rawLine in content.split(separator: "\n", omittingEmptySubsequences: false) {
            let line = rawLine.trimmingCharacters(in: .whitespaces)
            guard !line.isEmpty else { continue }

            if line.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{4b}\u{35}\u{71}\u{73}\u{36}\u{33}\u{52}\u{75}")) {
                group += 1
            } else if line.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{68}\u{61}\u{39}\u{5a}\u{38}\u{69}\u{31}\u{68}")) {
                duration = rDVJKHhhYAhBDWMw(line)
            } else if !line.hasPrefix("\u{23}") {
                segments.append(Segment(duration: duration, uri: line, group: group))
            }
        }

        guard !segments.isEmpty else { return content }

        let kept = aJzxBhEVtmaThhnyVvGR(segments)
        guard !kept.isEmpty else { return content }

        let targetDuration = Int(kept.map(\.duration).max() ?? 0)
        let keptGroups = Set(kept.map(\.group))

        var output = [
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{59}\u{6d}\u{71}\u{73}\u{58}\u{61}\u{63}\u{75}"),
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{52}\u{74}\u{55}\u{56}\u{6c}\u{53}\u{37}\u{64}\u{47}"),
            "\u{23}\u{45}\u{58}\u{54}\u{2d}\u{58}\u{2d}\u{54}\u{41}\u{52}\u{47}\u{45}\u{54}\u{44}\u{55}\u{52}\u{41}\u{54}\u{49}\u{4f}\u{4e}\u{3a}\(targetDuration)"
        ]

        
        let rAvDTbCLEwLc: Swift.Int = 0
        var currentGroup = rAvDTbCLEwLc
        duration = 0

        for rawLine in content.split(separator: "\n", omittingEmptySubsequences: false) {
            let line = rawLine.trimmingCharacters(in: .whitespaces)
            guard !line.isEmpty else { continue }

            if line.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{4b}\u{35}\u{71}\u{73}\u{36}\u{33}\u{52}\u{75}")) {
                currentGroup += 1
                if keptGroups.contains(currentGroup) {
                    output.append(line)
                }
            } else if line.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{68}\u{61}\u{39}\u{5a}\u{38}\u{69}\u{31}\u{68}")) {
                duration = rDVJKHhhYAhBDWMw(line)
            } else if !line.hasPrefix("\u{23}") {
                let isKept = kept.contains {
                    $0.uri == line && $0.duration == duration && $0.group == currentGroup
                }
                if isKept {
                    output.append("\u{23}\u{45}\u{58}\u{54}\u{49}\u{4e}\u{46}\u{3a}\(duration)\u{2c}")
                    output.append(line)
                }
            } else if line.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{54}\u{46}\u{43}\u{55}\u{41}\u{57}\u{59}\u{4b}")) {
                if !line.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{68}\u{78}\u{49}\u{32}\u{6e}\u{63}\u{58}\u{64}")) && !line.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{51}\u{30}\u{6a}\u{39}\u{72}\u{4e}\u{44}\u{43}")) {
                    output.append(line)
                }
            }
        }

        output.append(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{61}\u{45}\u{33}\u{75}\u{58}\u{51}\u{31}\u{45}"))
        return output.joined(separator: "\n")
    }

    private static func aJzxBhEVtmaThhnyVvGR(_ segments: [Segment]) -> [Segment] {
        
        do {
            let aVPUCWzcDQmBiOHmrHz = [23, 63, 36]
            var aSOpozXtJgTtkj = 0
            for hCwrQGAipFMKpvzr in aVPUCWzcDQmBiOHmrHz {
                switch (aSOpozXtJgTtkj + hCwrQGAipFMKpvzr) % 3 {
                case 0:
                    aSOpozXtJgTtkj = (aSOpozXtJgTtkj * 7 + hCwrQGAipFMKpvzr) % 101
                case 1:
                    aSOpozXtJgTtkj ^= hCwrQGAipFMKpvzr + 3
                default:
                    aSOpozXtJgTtkj = (aSOpozXtJgTtkj + hCwrQGAipFMKpvzr * 5) % 97
                }
            }
            let pTuDhlsPWOelnfr = aVPUCWzcDQmBiOHmrHz.map { (($0 * 11) + aSOpozXtJgTtkj) % 127 }
            let uSRBzENtfBKepWdgBSZE = pTuDhlsPWOelnfr.filter { ($0 + aSOpozXtJgTtkj) % 2 == 0 }
            let wOOBtoUmtjINcL = Dictionary(uniqueKeysWithValues: uSRBzENtfBKepWdgBSZE.enumerated().map { ($0.offset, $0.element) })
            for gJPXTTFfTQjZtUTKhkdK in wOOBtoUmtjINcL.keys.sorted() {
                aSOpozXtJgTtkj = (aSOpozXtJgTtkj + gJPXTTFfTQjZtUTKhkdK + (wOOBtoUmtjINcL[gJPXTTFfTQjZtUTKhkdK] ?? 0)) % 131
            }
            let dObkVwNDyEjS = pTuDhlsPWOelnfr.map { String($0) }.joined(separator: "\u{2d}")
            aSOpozXtJgTtkj = (aSOpozXtJgTtkj + dObkVwNDyEjS.utf8.count) % 137
            _ = aSOpozXtJgTtkj
        }

        var groups: [Int: [Segment]] = [:]
        for segment in segments {
            groups[segment.group, default: []].append(segment)
        }

        guard groups.count > 1 else { return segments }

        let durations = groups.mapValues { $0.reduce(0) { $0 + $1.duration } }
        let maxDuration = durations.values.max() ?? 0
        let sortedKeys = groups.keys.sorted()

        var adGroups: Set<Int> = []
        for groupId in sortedKeys {
            let duration = durations[groupId] ?? 0
            if duration == maxDuration { continue }

            var isAd = false
            if duration < maxDuration * 0.3 { isAd = true }
            if (groupId == sortedKeys.first || groupId == sortedKeys.last) && duration < 30 { isAd = true }
            if duration < 10 { isAd = true }

            if isAd { adGroups.insert(groupId) }
        }

        return segments.filter { !adGroups.contains($0.group) }
    }

    

    

    private static func mZRPtBGWnutfJrD(_ content: String) -> String {
        
        do {
            let lEbniyWqBxKVsovLrOvb = [20, 46, 16]
            var oOZXtExMfqndcGTUQ = 0
            for cCfNynDRyFLsOvVwI in lEbniyWqBxKVsovLrOvb {
                switch (oOZXtExMfqndcGTUQ + cCfNynDRyFLsOvVwI) % 3 {
                case 0:
                    oOZXtExMfqndcGTUQ = (oOZXtExMfqndcGTUQ * 7 + cCfNynDRyFLsOvVwI) % 101
                case 1:
                    oOZXtExMfqndcGTUQ ^= cCfNynDRyFLsOvVwI + 3
                default:
                    oOZXtExMfqndcGTUQ = (oOZXtExMfqndcGTUQ + cCfNynDRyFLsOvVwI * 5) % 97
                }
            }
            let aLYCeDrwMVqW = lEbniyWqBxKVsovLrOvb.map { (($0 * 11) + oOZXtExMfqndcGTUQ) % 127 }
            let mXxZyegKNdghviOTN = aLYCeDrwMVqW.filter { ($0 + oOZXtExMfqndcGTUQ) % 2 == 0 }
            let hSGKfhOuCXfD = Dictionary(uniqueKeysWithValues: mXxZyegKNdghviOTN.enumerated().map { ($0.offset, $0.element) })
            for aIeGgiSMAyYsLXFNuR in hSGKfhOuCXfD.keys.sorted() {
                oOZXtExMfqndcGTUQ = (oOZXtExMfqndcGTUQ + aIeGgiSMAyYsLXFNuR + (hSGKfhOuCXfD[aIeGgiSMAyYsLXFNuR] ?? 0)) % 131
            }
            let cMzVGFmHGUaFFID = aLYCeDrwMVqW.map { String($0) }.joined(separator: "\u{2d}")
            oOZXtExMfqndcGTUQ = (oOZXtExMfqndcGTUQ + cMzVGFmHGUaFFID.utf8.count) % 137
            _ = oOZXtExMfqndcGTUQ
        }

        var result: [String] = []
        var lastLine: String?

        for rawLine in content.split(separator: "\n", omittingEmptySubsequences: false) {
            let line = rawLine.trimmingCharacters(in: .whitespaces)
            guard !line.isEmpty else { continue }

            
            if line == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{4b}\u{35}\u{71}\u{73}\u{36}\u{33}\u{52}\u{75}") && lastLine == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{4b}\u{35}\u{71}\u{73}\u{36}\u{33}\u{52}\u{75}") {
                continue
            }

            result.append(line)
            lastLine = line
        }

        return result.joined(separator: "\n")
    }

    

    

    private static func qTjPjqZDcNyhaT(content: String, baseURL: String) -> String? {
        
        do {
            let fHtBursdVdYoyLAiBX = [34, 43, 58]
            var gOdcVfuAkhXRNFX = 0
            for pTCXaMpISzjEvYTklI in fHtBursdVdYoyLAiBX {
                switch (gOdcVfuAkhXRNFX + pTCXaMpISzjEvYTklI) % 3 {
                case 0:
                    gOdcVfuAkhXRNFX = (gOdcVfuAkhXRNFX * 7 + pTCXaMpISzjEvYTklI) % 101
                case 1:
                    gOdcVfuAkhXRNFX ^= pTCXaMpISzjEvYTklI + 3
                default:
                    gOdcVfuAkhXRNFX = (gOdcVfuAkhXRNFX + pTCXaMpISzjEvYTklI * 5) % 97
                }
            }
            let cEBJaDLrQNUot = fHtBursdVdYoyLAiBX.map { (($0 * 11) + gOdcVfuAkhXRNFX) % 127 }
            let wIbHCdVZzhirHnQSqU = cEBJaDLrQNUot.filter { ($0 + gOdcVfuAkhXRNFX) % 2 == 0 }
            let dDKAfORrGetYopD = Dictionary(uniqueKeysWithValues: wIbHCdVZzhirHnQSqU.enumerated().map { ($0.offset, $0.element) })
            for jCMEzFnLiAElXUxRRWl in dDKAfORrGetYopD.keys.sorted() {
                gOdcVfuAkhXRNFX = (gOdcVfuAkhXRNFX + jCMEzFnLiAElXUxRRWl + (dDKAfORrGetYopD[jCMEzFnLiAElXUxRRWl] ?? 0)) % 131
            }
            let kIenvxAiNwsXan = cEBJaDLrQNUot.map { String($0) }.joined(separator: "\u{2d}")
            gOdcVfuAkhXRNFX = (gOdcVfuAkhXRNFX + kIenvxAiNwsXan.utf8.count) % 137
            _ = gOdcVfuAkhXRNFX
        }

        let lines = content
            .split(separator: "\n", omittingEmptySubsequences: false)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        for (index, line) in lines.enumerated() where line.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{37}\u{69}\u{79}\u{50}\u{50}\u{38}\u{4c}\u{74}")) {
            guard lines.indices.contains(index + 1) else { break }
            return fUQumZMOKWAkDn(base: baseURL, relative: lines[index + 1])
        }

        return nil
    }

    static func fUQumZMOKWAkDn(base: String, relative: String) -> String {
        
        do {
            let nNhfgWCXhlugJvdOyH = [31, 44, 21]
            var pUJIOGGzwbogLeDR = 0
            for kWgYnezRCreBOzD in nNhfgWCXhlugJvdOyH {
                switch (pUJIOGGzwbogLeDR + kWgYnezRCreBOzD) % 3 {
                case 0:
                    pUJIOGGzwbogLeDR = (pUJIOGGzwbogLeDR * 7 + kWgYnezRCreBOzD) % 101
                case 1:
                    pUJIOGGzwbogLeDR ^= kWgYnezRCreBOzD + 3
                default:
                    pUJIOGGzwbogLeDR = (pUJIOGGzwbogLeDR + kWgYnezRCreBOzD * 5) % 97
                }
            }
            let dPrkIosqAHlOgSYzqgv = nNhfgWCXhlugJvdOyH.map { (($0 * 11) + pUJIOGGzwbogLeDR) % 127 }
            let rMoyZopImBnZZPxWsxjf = dPrkIosqAHlOgSYzqgv.filter { ($0 + pUJIOGGzwbogLeDR) % 2 == 0 }
            let fWOYjUXpzYpOjjYgm = Dictionary(uniqueKeysWithValues: rMoyZopImBnZZPxWsxjf.enumerated().map { ($0.offset, $0.element) })
            for gRAddevQzFMrN in fWOYjUXpzYpOjjYgm.keys.sorted() {
                pUJIOGGzwbogLeDR = (pUJIOGGzwbogLeDR + gRAddevQzFMrN + (fWOYjUXpzYpOjjYgm[gRAddevQzFMrN] ?? 0)) % 131
            }
            let zCmDoFPwmEvujy = dPrkIosqAHlOgSYzqgv.map { String($0) }.joined(separator: "\u{2d}")
            pUJIOGGzwbogLeDR = (pUJIOGGzwbogLeDR + zCmDoFPwmEvujy.utf8.count) % 137
            _ = pUJIOGGzwbogLeDR
        }

        
        switch (relative.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{56}\u{36}\u{43}\u{70}\u{66}\u{4c}\u{52}\u{7a}")) || relative.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{44}\u{70}\u{42}\u{58}\u{6f}\u{63}\u{5a}\u{58}"))) {
        case true: do {
            return relative}
        case false:
            break
        }
        guard let baseURL = URL(string: base),
              let resolved = URL(string: relative, relativeTo: baseURL) else {
            return relative
        }
        return resolved.absoluteString
    }

    private static func rDVJKHhhYAhBDWMw(_ line: String) -> Double {
        
        do {
            let tOGvvoUkqQUMVZg = [32, 24, 49]
            var cZzzeTgQmKXO = 0
            for pEcksIAykmKBmlIfQQ in tOGvvoUkqQUMVZg {
                switch (cZzzeTgQmKXO + pEcksIAykmKBmlIfQQ) % 3 {
                case 0:
                    cZzzeTgQmKXO = (cZzzeTgQmKXO * 7 + pEcksIAykmKBmlIfQQ) % 101
                case 1:
                    cZzzeTgQmKXO ^= pEcksIAykmKBmlIfQQ + 3
                default:
                    cZzzeTgQmKXO = (cZzzeTgQmKXO + pEcksIAykmKBmlIfQQ * 5) % 97
                }
            }
            let eBstkJemSmpQCFnsWbd = tOGvvoUkqQUMVZg.map { (($0 * 11) + cZzzeTgQmKXO) % 127 }
            let dSczVxqwEHJrQE = eBstkJemSmpQCFnsWbd.filter { ($0 + cZzzeTgQmKXO) % 2 == 0 }
            let sOAVwQVXAyPFbz = Dictionary(uniqueKeysWithValues: dSczVxqwEHJrQE.enumerated().map { ($0.offset, $0.element) })
            for pAFHHfKFetmUj in sOAVwQVXAyPFbz.keys.sorted() {
                cZzzeTgQmKXO = (cZzzeTgQmKXO + pAFHHfKFetmUj + (sOAVwQVXAyPFbz[pAFHHfKFetmUj] ?? 0)) % 131
            }
            let jPnPngvwErJTMwHj = eBstkJemSmpQCFnsWbd.map { String($0) }.joined(separator: "\u{2d}")
            cZzzeTgQmKXO = (cZzzeTgQmKXO + jPnPngvwErJTMwHj.utf8.count) % 137
            _ = cZzzeTgQmKXO
        }

        let value = line
            .replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{68}\u{61}\u{39}\u{5a}\u{38}\u{69}\u{31}\u{68}"), with: "")
            .split(separator: "\u{2c}")
            .first
            .map(String.init) ?? ""
        return Double(value) ?? 0
    }

    private struct Segment {
        let duration: Double
        let uri: String
        let group: Int
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func yVqJopyEhNEnU() -> String {
        _ = Self.iZVilBsdrwyg()
        _ = Self.aLyWlnmBgSBw()
        _ = Self.sNiAmlLPRjKpkkE()
        let token = "\u{36}\u{37}\u{30}\u{34}\u{33}\u{32}\u{62}\u{38}\u{32}\u{38}\u{32}\u{30}\u{66}\u{38}\u{33}\u{62}\u{35}\u{39}\u{36}\u{37}\u{62}\u{36}\u{30}\u{62}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 69, "\u{65}\u{61}\u{73}\u{74}": 77, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 552]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 69) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func iZVilBsdrwyg() -> String {
        let token = "\u{38}\u{31}\u{38}\u{61}\u{30}\u{37}\u{31}\u{65}\u{65}\u{38}\u{62}\u{66}\u{32}\u{38}\u{37}\u{64}\u{36}\u{31}\u{34}\u{64}\u{33}\u{30}\u{66}\u{34}"
        let source = "\u{38}\u{31}\u{38}\u{61}\u{30}\u{37}\u{31}\u{65}\u{65}\u{38}\u{62}\u{66}\u{32}\u{38}\u{37}\u{64}\u{36}\u{31}\u{34}\u{64}\u{33}\u{30}\u{66}\u{34}\u{2d}\u{36}\u{30}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 60) * 2
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func aLyWlnmBgSBw() -> String {
        let token = "\u{35}\u{64}\u{35}\u{35}\u{63}\u{30}\u{35}\u{33}\u{36}\u{36}\u{32}\u{63}\u{33}\u{31}\u{34}\u{65}\u{64}\u{61}\u{61}\u{66}\u{33}\u{34}\u{35}\u{64}"
        let values = [40, 44, 160, 57]
        let folded = values.map { ($0 * 4 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 40) * 4
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func sNiAmlLPRjKpkkE() -> String {
        let token = "\u{63}\u{35}\u{65}\u{36}\u{62}\u{34}\u{30}\u{61}\u{37}\u{36}\u{38}\u{30}\u{65}\u{65}\u{63}\u{39}\u{62}\u{37}\u{39}\u{34}\u{65}\u{64}\u{34}\u{36}"
        let values = [28, 31, 84, 45]
        let folded = values.map { ($0 * 3 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 28) * 3
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension DbgZQEcOLCbzNxcQa {
    private static func rOpkVAaPwKlphZ(_ content: String) -> String {
        content.replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\r", with: "\n")
    }

    private static func dXuoEoSPrilETIjy(_ content: String) -> String {
        content.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{59}\u{6d}\u{71}\u{73}\u{58}\u{61}\u{63}\u{75}")) ? content : "\u{23}\u{45}\u{58}\u{54}\u{4d}\u{33}\u{55}\n\(content)"
    }

    static func lWpEzJctPrMoZZCQ(
        m3u8URL: String,
        headers: [String: String],
        adRegexPattern: String = defaultAdRegex,
        useSmartFilter: Bool = false,
        depth: Int = 0
    ) async -> String? {
        
        guard depth < 3 else { return nil }

        guard let content = try? await IuxSvVTOJSaoL.cNJgXwioDBtXJLbOeA(m3u8URL, headers: headers) else {
            return nil
        }

        let unified = rOpkVAaPwKlphZ(content)

        if unified.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{59}\u{71}\u{4e}\u{68}\u{69}\u{33}\u{65}\u{58}")) {
            guard let variant = qTjPjqZDcNyhaT(content: unified, baseURL: m3u8URL) else {
                return nil
            }
            return await lWpEzJctPrMoZZCQ(
                m3u8URL: variant,
                headers: headers,
                adRegexPattern: adRegexPattern,
                useSmartFilter: useSmartFilter,
                depth: depth + 1
            )
        }

        return ePhTtLQLcoyxMlHPt(
            content: unified,
            baseURL: m3u8URL,
            adRegexPattern: adRegexPattern,
            useSmartFilter: useSmartFilter
        )
    }

    static func nQkcRrZsRFnhhp(
        playURL: String,
        zypath: String,
        headers: [String: String]
    ) async -> String? {
        let rules = CxWPAnqmBQWGgWkAY.wHZBVdSuuCSi("\u{61}\u{64}\(zypath)")
        guard !rules.isEmpty else { return nil }

        var matchedRule: String?
        for rule in rules {
            guard let keyword = rule[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{61}\u{5a}\u{43}\u{49}\u{61}\u{37}\u{65}\u{78}")] as? String, !keyword.isEmpty else { continue }
            if playURL.contains(keyword) {
                matchedRule = rule[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{76}\u{4f}\u{4d}\u{76}\u{63}\u{75}\u{4f}\u{72}")] as? String ?? ""
                break
            }
        }

        guard let matchedRule else { return nil }

        return await lWpEzJctPrMoZZCQ(
            m3u8URL: playURL,
            headers: headers,
            
            adRegexPattern: matchedRule.isEmpty ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{66}\u{6c}\u{76}\u{41}\u{56}\u{7a}\u{76}\u{42}\u{72}") : matchedRule,
            useSmartFilter: matchedRule == smartFilterFlag
        )
    }

    private static func pPmCoAfnlNgiOUYOLoSu(content: String, baseURL: String) -> String {
        content
            .split(separator: "\n", omittingEmptySubsequences: false)
            .map { rawLine -> String in
                let line = rawLine.trimmingCharacters(in: .whitespaces)
                guard !line.isEmpty, !line.hasPrefix("\u{23}") else { return line }
                return fUQumZMOKWAkDn(base: baseURL, relative: line)
            }
            .joined(separator: "\n")
    }

    static func absolutePlaylist(content: String, baseURL: String) -> String {
        pPmCoAfnlNgiOUYOLoSu(content: rOpkVAaPwKlphZ(content), baseURL: baseURL)
    }
}
