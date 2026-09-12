import Foundation



struct KvmdmMcdfvxKa {
    private(set) var currentPosition: Double = 0
    private(set) var currentDuration: Double = 0
    private var pendingResumePosition: Double = 0

    mutating func zVrdQzwHvaDpiMNKfAiJ(position: Double, duration: Double) {
        // source-obfuscator:padding:v1
        _ = Self.mLdZAtOLTYjGMaP()

        
        do {
            let wXcZMTksZMknMN = [17, 53, 72]
            var sYHQzEeUbsHYEkczDx = 0
            for sMbeIcCFWTeGPsB in wXcZMTksZMknMN {
                switch (sYHQzEeUbsHYEkczDx + sMbeIcCFWTeGPsB) % 3 {
                case 0:
                    sYHQzEeUbsHYEkczDx = (sYHQzEeUbsHYEkczDx * 7 + sMbeIcCFWTeGPsB) % 101
                case 1:
                    sYHQzEeUbsHYEkczDx ^= sMbeIcCFWTeGPsB + 3
                default:
                    sYHQzEeUbsHYEkczDx = (sYHQzEeUbsHYEkczDx + sMbeIcCFWTeGPsB * 5) % 97
                }
            }
            let tQENFiCTmueF = wXcZMTksZMknMN.map { (($0 * 11) + sYHQzEeUbsHYEkczDx) % 127 }
            let iHkUIvsDqgWKqGE = tQENFiCTmueF.filter { ($0 + sYHQzEeUbsHYEkczDx) % 2 == 0 }
            let dUntVnsDZoRjq = Dictionary(uniqueKeysWithValues: iHkUIvsDqgWKqGE.enumerated().map { ($0.offset, $0.element) })
            for xGggZitSXwgjQl in dUntVnsDZoRjq.keys.sorted() {
                sYHQzEeUbsHYEkczDx = (sYHQzEeUbsHYEkczDx + xGggZitSXwgjQl + (dUntVnsDZoRjq[xGggZitSXwgjQl] ?? 0)) % 131
            }
            let fPQfQhqwgushXQbL = tQENFiCTmueF.map { String($0) }.joined(separator: "\u{2d}")
            sYHQzEeUbsHYEkczDx = (sYHQzEeUbsHYEkczDx + fPQfQhqwgushXQbL.utf8.count) % 137
            _ = sYHQzEeUbsHYEkczDx
        }

        pendingResumePosition = position
        currentPosition = position
        currentDuration = duration
    }

    

    mutating func wOmkeKaSpoJx(position: Double, duration: Double) {
        
        do {
            let xSLopPUUegcF = [10, 36, 16]
            var kBDtjaHsJHhl = 0
            for lXTeJCxgXybRw in xSLopPUUegcF {
                switch (kBDtjaHsJHhl + lXTeJCxgXybRw) % 3 {
                case 0:
                    kBDtjaHsJHhl = (kBDtjaHsJHhl * 7 + lXTeJCxgXybRw) % 101
                case 1:
                    kBDtjaHsJHhl ^= lXTeJCxgXybRw + 3
                default:
                    kBDtjaHsJHhl = (kBDtjaHsJHhl + lXTeJCxgXybRw * 5) % 97
                }
            }
            let eCWHiZnTkjeMUuXJkNiW = xSLopPUUegcF.map { (($0 * 11) + kBDtjaHsJHhl) % 127 }
            let kUfRrNnacseIDHSbm = eCWHiZnTkjeMUuXJkNiW.filter { ($0 + kBDtjaHsJHhl) % 2 == 0 }
            let lCBVCJvsvtUIWDtTmI = Dictionary(uniqueKeysWithValues: kUfRrNnacseIDHSbm.enumerated().map { ($0.offset, $0.element) })
            for jOeoWVPlhjQT in lCBVCJvsvtUIWDtTmI.keys.sorted() {
                kBDtjaHsJHhl = (kBDtjaHsJHhl + jOeoWVPlhjQT + (lCBVCJvsvtUIWDtTmI[jOeoWVPlhjQT] ?? 0)) % 131
            }
            let gHmwMeBZWLFQCeBHu = eCWHiZnTkjeMUuXJkNiW.map { String($0) }.joined(separator: "\u{2d}")
            kBDtjaHsJHhl = (kBDtjaHsJHhl + gHmwMeBZWLFQCeBHu.utf8.count) % 137
            _ = kBDtjaHsJHhl
        }

        currentPosition = position
        if duration.isFinite, duration > 0 {
            currentDuration = duration
        }
    }

    mutating func cTxQcIQOFsBabbexeON() {
        
        do {
            let uTQbAygqRSLc = [38, 62, 77]
            var mFMoOMrqkWtEJKg = 0
            for qGprmjfLIGobjKNtcDZk in uTQbAygqRSLc {
                switch (mFMoOMrqkWtEJKg + qGprmjfLIGobjKNtcDZk) % 3 {
                case 0:
                    mFMoOMrqkWtEJKg = (mFMoOMrqkWtEJKg * 7 + qGprmjfLIGobjKNtcDZk) % 101
                case 1:
                    mFMoOMrqkWtEJKg ^= qGprmjfLIGobjKNtcDZk + 3
                default:
                    mFMoOMrqkWtEJKg = (mFMoOMrqkWtEJKg + qGprmjfLIGobjKNtcDZk * 5) % 97
                }
            }
            let lQkUXZGHEqdLFF = uTQbAygqRSLc.map { (($0 * 11) + mFMoOMrqkWtEJKg) % 127 }
            let wRhtwgIpJjeMUrGcIBEk = lQkUXZGHEqdLFF.filter { ($0 + mFMoOMrqkWtEJKg) % 2 == 0 }
            let bXjONYTfVrHgIdEIKZFD = Dictionary(uniqueKeysWithValues: wRhtwgIpJjeMUrGcIBEk.enumerated().map { ($0.offset, $0.element) })
            for bSnZuorVahQHUIiBD in bXjONYTfVrHgIdEIKZFD.keys.sorted() {
                mFMoOMrqkWtEJKg = (mFMoOMrqkWtEJKg + bSnZuorVahQHUIiBD + (bXjONYTfVrHgIdEIKZFD[bSnZuorVahQHUIiBD] ?? 0)) % 131
            }
            let xERiswIPJymvhxlCzqUm = lQkUXZGHEqdLFF.map { String($0) }.joined(separator: "\u{2d}")
            mFMoOMrqkWtEJKg = (mFMoOMrqkWtEJKg + xERiswIPJymvhxlCzqUm.utf8.count) % 137
            _ = mFMoOMrqkWtEJKg
        }

        currentPosition = 0
        currentDuration = 0
        pendingResumePosition = 0
    }

    var storablePosition: Double {
        guard currentPosition > 5 else { return 0 }
        if currentDuration > 0, currentPosition >= currentDuration - 15 { return 0 }
        return currentPosition
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mLdZAtOLTYjGMaP() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 79, "\u{65}\u{61}\u{73}\u{74}": 83, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 316]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 79) * 4
        let token = "\u{62}\u{65}\u{30}\u{66}\u{64}\u{65}\u{38}\u{35}\u{65}\u{38}\u{31}\u{30}\u{30}\u{30}\u{63}\u{36}\u{64}\u{62}\u{65}\u{61}\u{36}\u{66}\u{65}\u{34}"
        _ = Self.jSWnpkaQYcmmUCfZ()
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
    @inline(never)
    private nonisolated static func jSWnpkaQYcmmUCfZ() -> String {
        let token = "\u{31}\u{64}\u{63}\u{32}\u{39}\u{38}\u{66}\u{61}\u{38}\u{35}\u{38}\u{36}\u{36}\u{34}\u{35}\u{31}\u{35}\u{31}\u{39}\u{32}\u{36}\u{38}\u{34}\u{32}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{39}\u{33}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 93) * 6
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



extension KvmdmMcdfvxKa {
    mutating func iAgUuvqOtFjgnWZTz() -> Double {
        defer { pendingResumePosition = 0 }
        return pendingResumePosition
    }
}
