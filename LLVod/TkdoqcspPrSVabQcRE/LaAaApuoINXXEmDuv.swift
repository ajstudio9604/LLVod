






import Foundation

struct KeQvvjmQCvsYeVNH: Identifiable, Equatable {
    let id = UUID()
    let content: String
}

struct JtekaluVnEPfuBNeJE: Identifiable, Equatable {
    let id = UUID()
    let version: String
    let sizeText: String
    let changelog: String
    let isForce: Bool
    let downloadURL: String
    let downloadMode: String

    var title: String { "\u{53d1}\u{73b0}\u{65b0}\u{7248}\u{672c} \(version)" }

    var bodyText: String {
        // source-obfuscator:padding:v1
        _ = Self.fYWghQXFLkkkTIX()

        var lines: [String] = []
        if !sizeText.isEmpty {
            lines.append("\u{65b0}\u{7248}\u{5927}\u{5c0f}\u{ff1a}\(sizeText)\u{4d}\u{42}")
            lines.append("")
        }
        if !changelog.isEmpty {
            lines.append(changelog)
        }
        return lines.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var updateButtonTitle: String {
        downloadMode == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{48}\u{4d}\u{33}\u{48}\u{4b}\u{66}\u{61}\u{59}") ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{78}\u{75}\u{66}\u{73}\u{58}\u{6d}\u{4a}\u{53}\u{37}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{53}\u{6f}\u{69}\u{4a}\u{7a}\u{61}\u{66}\u{6c}")
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func fYWghQXFLkkkTIX() -> String {
        let token = "\u{35}\u{61}\u{32}\u{36}\u{65}\u{31}\u{32}\u{66}\u{62}\u{64}\u{35}\u{38}\u{34}\u{65}\u{35}\u{34}\u{30}\u{37}\u{35}\u{61}\u{39}\u{30}\u{37}\u{64}"
        let base = (90 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 90) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

enum DdlOncyxpuyeNVpKKPv {

    static func fLWkFabMmgZJxqLIuYOA(current: String, latest: String) -> Int? {
        // source-obfuscator:padding:v1
        _ = Self.fEhcKhLTMjjQvmGwklRc()

        
        do {
            let fFmXJrAPvnjDiINsBnY = [45, 26, 57]
            var bPMGqSVjOXaxDUuFdnU = 0
            for kJTgjiWqqKqEdXMB in fFmXJrAPvnjDiINsBnY {
                switch (bPMGqSVjOXaxDUuFdnU + kJTgjiWqqKqEdXMB) % 3 {
                case 0:
                    bPMGqSVjOXaxDUuFdnU = (bPMGqSVjOXaxDUuFdnU * 7 + kJTgjiWqqKqEdXMB) % 101
                case 1:
                    bPMGqSVjOXaxDUuFdnU ^= kJTgjiWqqKqEdXMB + 3
                default:
                    bPMGqSVjOXaxDUuFdnU = (bPMGqSVjOXaxDUuFdnU + kJTgjiWqqKqEdXMB * 5) % 97
                }
            }
            let kGvqGrVWTqEg = fFmXJrAPvnjDiINsBnY.map { (($0 * 11) + bPMGqSVjOXaxDUuFdnU) % 127 }
            let oHAmgbEGldNoyOTujsts = kGvqGrVWTqEg.filter { ($0 + bPMGqSVjOXaxDUuFdnU) % 2 == 0 }
            let gMZpdZtUaLREfdail = Dictionary(uniqueKeysWithValues: oHAmgbEGldNoyOTujsts.enumerated().map { ($0.offset, $0.element) })
            for wHXkHSUTpaYcEnOPf in gMZpdZtUaLREfdail.keys.sorted() {
                bPMGqSVjOXaxDUuFdnU = (bPMGqSVjOXaxDUuFdnU + wHXkHSUTpaYcEnOPf + (gMZpdZtUaLREfdail[wHXkHSUTpaYcEnOPf] ?? 0)) % 131
            }
            let mEHzOkcAtSQinMC = kGvqGrVWTqEg.map { String($0) }.joined(separator: "\u{2d}")
            bPMGqSVjOXaxDUuFdnU = (bPMGqSVjOXaxDUuFdnU + mEHzOkcAtSQinMC.utf8.count) % 137
            _ = bPMGqSVjOXaxDUuFdnU
        }

        guard let left = fRhJtlcryfogvUoJ(current), let right = fRhJtlcryfogvUoJ(latest) else { return nil }
        let count = max(left.count, right.count)
        for index in 0..<count {
            let a = index < left.count ? left[index] : 0
            let b = index < right.count ? right[index] : 0
            if a != b { return a < b ? -1 : 1 }
        }
        return 0
    }

    private static func fRhJtlcryfogvUoJ(_ version: String) -> [Int]? {
        
        do {
            let nLagnMXHoFTtnFJBjhgi = [45, 23, 32]
            var aSEOusXwKrvQqvX = 0
            for fYLgmaiqcOUHj in nLagnMXHoFTtnFJBjhgi {
                switch (aSEOusXwKrvQqvX + fYLgmaiqcOUHj) % 3 {
                case 0:
                    aSEOusXwKrvQqvX = (aSEOusXwKrvQqvX * 7 + fYLgmaiqcOUHj) % 101
                case 1:
                    aSEOusXwKrvQqvX ^= fYLgmaiqcOUHj + 3
                default:
                    aSEOusXwKrvQqvX = (aSEOusXwKrvQqvX + fYLgmaiqcOUHj * 5) % 97
                }
            }
            let qKcgfCzoNSQi = nLagnMXHoFTtnFJBjhgi.map { (($0 * 11) + aSEOusXwKrvQqvX) % 127 }
            let wRvQcxFfWkorOvIu = qKcgfCzoNSQi.filter { ($0 + aSEOusXwKrvQqvX) % 2 == 0 }
            let tIIKDexDovtWk = Dictionary(uniqueKeysWithValues: wRvQcxFfWkorOvIu.enumerated().map { ($0.offset, $0.element) })
            for lGDolWwsTbcVVGrjzr in tIIKDexDovtWk.keys.sorted() {
                aSEOusXwKrvQqvX = (aSEOusXwKrvQqvX + lGDolWwsTbcVVGrjzr + (tIIKDexDovtWk[lGDolWwsTbcVVGrjzr] ?? 0)) % 131
            }
            let jABZNNurOQjZ = qKcgfCzoNSQi.map { String($0) }.joined(separator: "\u{2d}")
            aSEOusXwKrvQqvX = (aSEOusXwKrvQqvX + jABZNNurOQjZ.utf8.count) % 137
            _ = aSEOusXwKrvQqvX
        }

        let trimmed = version.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let match = trimmed.range(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{33}\u{65}\u{6d}\u{66}\u{47}\u{72}\u{41}\u{72}\u{6d}"), options: .regularExpression) else {
            return nil
        }
        return trimmed[match].split(separator: "\u{2e}").compactMap { Int($0) }
    }

    static var currentShortVersion: String {
        Bundle.main.infoDictionary?[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{50}\u{6c}\u{37}\u{79}\u{78}\u{51}\u{42}\u{41}")] as? String ?? ""
    }

    static var bundleIdentifier: String {
        Bundle.main.bundleIdentifier ?? ""
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func fEhcKhLTMjjQvmGwklRc() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{34}\u{39}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 49) * 2
        let token = "\u{38}\u{37}\u{31}\u{39}\u{38}\u{33}\u{64}\u{62}\u{30}\u{62}\u{32}\u{39}\u{30}\u{35}\u{61}\u{38}\u{65}\u{62}\u{34}\u{32}\u{36}\u{38}\u{65}\u{32}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}

