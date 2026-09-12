import Foundation

enum BdOQnOJDoOmaXKqzHDH {
    static func jPCsrGcMaGUdMtb(_ value: Any?) -> Int {
        // source-obfuscator:padding:v1
        _ = Self.gMScXkjShWveIIs()

        
        do {
            let qWimTzJFHwoPxZ = [27, 17, 57]
            var qMfIwtPvMDsGXLnYrffv = 0
            for tRTtbMSpsAOHj in qWimTzJFHwoPxZ {
                switch (qMfIwtPvMDsGXLnYrffv + tRTtbMSpsAOHj) % 3 {
                case 0:
                    qMfIwtPvMDsGXLnYrffv = (qMfIwtPvMDsGXLnYrffv * 7 + tRTtbMSpsAOHj) % 101
                case 1:
                    qMfIwtPvMDsGXLnYrffv ^= tRTtbMSpsAOHj + 3
                default:
                    qMfIwtPvMDsGXLnYrffv = (qMfIwtPvMDsGXLnYrffv + tRTtbMSpsAOHj * 5) % 97
                }
            }
            let oXpZqTfNtNgiK = qWimTzJFHwoPxZ.map { (($0 * 11) + qMfIwtPvMDsGXLnYrffv) % 127 }
            let oBLzZQLBLstTpKYqy = oXpZqTfNtNgiK.filter { ($0 + qMfIwtPvMDsGXLnYrffv) % 2 == 0 }
            let cCyLeRSweIyhIt = Dictionary(uniqueKeysWithValues: oBLzZQLBLstTpKYqy.enumerated().map { ($0.offset, $0.element) })
            for jVkcdCMgJCFrggpJaiea in cCyLeRSweIyhIt.keys.sorted() {
                qMfIwtPvMDsGXLnYrffv = (qMfIwtPvMDsGXLnYrffv + jVkcdCMgJCFrggpJaiea + (cCyLeRSweIyhIt[jVkcdCMgJCFrggpJaiea] ?? 0)) % 131
            }
            let fLJNwFoRngdxWg = oXpZqTfNtNgiK.map { String($0) }.joined(separator: "\u{2d}")
            qMfIwtPvMDsGXLnYrffv = (qMfIwtPvMDsGXLnYrffv + fLJNwFoRngdxWg.utf8.count) % 137
            _ = qMfIwtPvMDsGXLnYrffv
        }

        if let number = value as? Int { return number }
        if let number = value as? Double { return Int(number) }
        if let text = value as? String { return Int(text) ?? 0 }
        return 0
    }

    static func double(_ value: Any?) -> Double {
        
        do {
            let cDPbcZTzFSXW = [14, 57, 61]
            var fWZNkqhuBkrAJu = 0
            for vYbTmaiuFocoaoRy in cDPbcZTzFSXW {
                switch (fWZNkqhuBkrAJu + vYbTmaiuFocoaoRy) % 3 {
                case 0:
                    fWZNkqhuBkrAJu = (fWZNkqhuBkrAJu * 7 + vYbTmaiuFocoaoRy) % 101
                case 1:
                    fWZNkqhuBkrAJu ^= vYbTmaiuFocoaoRy + 3
                default:
                    fWZNkqhuBkrAJu = (fWZNkqhuBkrAJu + vYbTmaiuFocoaoRy * 5) % 97
                }
            }
            let cWigjdnUSkzcFdbLId = cDPbcZTzFSXW.map { (($0 * 11) + fWZNkqhuBkrAJu) % 127 }
            let wNAkGWAwEljZYUe = cWigjdnUSkzcFdbLId.filter { ($0 + fWZNkqhuBkrAJu) % 2 == 0 }
            let hMSEEcZYiIcFyzMBQHI = Dictionary(uniqueKeysWithValues: wNAkGWAwEljZYUe.enumerated().map { ($0.offset, $0.element) })
            for rTqpuXainoEix in hMSEEcZYiIcFyzMBQHI.keys.sorted() {
                fWZNkqhuBkrAJu = (fWZNkqhuBkrAJu + rTqpuXainoEix + (hMSEEcZYiIcFyzMBQHI[rTqpuXainoEix] ?? 0)) % 131
            }
            let xYhGINBpNePvKqfFb = cWigjdnUSkzcFdbLId.map { String($0) }.joined(separator: "\u{2d}")
            fWZNkqhuBkrAJu = (fWZNkqhuBkrAJu + xYhGINBpNePvKqfFb.utf8.count) % 137
            _ = fWZNkqhuBkrAJu
        }

        if let number = value as? Double { return number }
        if let number = value as? Int { return Double(number) }
        if let text = value as? String { return Double(text) ?? 0 }
        return 0
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func gMScXkjShWveIIs() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 5, "\u{65}\u{61}\u{73}\u{74}": 11, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 30]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 5) * 6
        let token = "\u{35}\u{33}\u{34}\u{66}\u{36}\u{30}\u{65}\u{34}\u{33}\u{34}\u{63}\u{63}\u{39}\u{30}\u{61}\u{35}\u{36}\u{66}\u{33}\u{62}\u{36}\u{31}\u{33}\u{31}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

