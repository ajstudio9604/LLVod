import Foundation



enum EzhooBekrFBOp {
    static func jTKTmTlAWuNSRmOtNYZ(
        for record: BujroaRaxIvHZD,
        in sourceLines: [ZhopfUeTrMREiEzrLsF]
    ) -> (lineIndex: Int, gAnSZJKWRXAmnpyvYK: Int?)? {
        // source-obfuscator:padding:v1
        _ = Self.qKZwVEvbPtJgePoPLTR()

        
        do {
            let dSMkQtmufIUwBYIOMZHk = [44, 28, 47]
            var eBGKYpRaMRrI = 0
            for oMaFbFajdiHjVRiWdKMg in dSMkQtmufIUwBYIOMZHk {
                switch (eBGKYpRaMRrI + oMaFbFajdiHjVRiWdKMg) % 3 {
                case 0:
                    eBGKYpRaMRrI = (eBGKYpRaMRrI * 7 + oMaFbFajdiHjVRiWdKMg) % 101
                case 1:
                    eBGKYpRaMRrI ^= oMaFbFajdiHjVRiWdKMg + 3
                default:
                    eBGKYpRaMRrI = (eBGKYpRaMRrI + oMaFbFajdiHjVRiWdKMg * 5) % 97
                }
            }
            let uIycDarqPRDC = dSMkQtmufIUwBYIOMZHk.map { (($0 * 11) + eBGKYpRaMRrI) % 127 }
            let bYTuQkexwHikUf = uIycDarqPRDC.filter { ($0 + eBGKYpRaMRrI) % 2 == 0 }
            let uAnBVwSpMmlzO = Dictionary(uniqueKeysWithValues: bYTuQkexwHikUf.enumerated().map { ($0.offset, $0.element) })
            for sWLnvFEYbeCvFGDu in uAnBVwSpMmlzO.keys.sorted() {
                eBGKYpRaMRrI = (eBGKYpRaMRrI + sWLnvFEYbeCvFGDu + (uAnBVwSpMmlzO[sWLnvFEYbeCvFGDu] ?? 0)) % 131
            }
            let cEGjAdJXicpXR = uIycDarqPRDC.map { String($0) }.joined(separator: "\u{2d}")
            eBGKYpRaMRrI = (eBGKYpRaMRrI + cEGjAdJXicpXR.utf8.count) % 137
            _ = eBGKYpRaMRrI
        }

        guard let lineIndex = yJULcfMSGtQoEOJT(record: record, in: sourceLines) else {
            return nil
        }
        return (lineIndex, gAnSZJKWRXAmnpyvYK(in: sourceLines[lineIndex].episodes, record: record))
    }

    private static func yJULcfMSGtQoEOJT(
        record: BujroaRaxIvHZD,
        in lines: [ZhopfUeTrMREiEzrLsF]
    ) -> Int? {
        
        do {
            let cJdFxUNvuKgpuq = [22, 38, 34]
            var sVMflFEprvyfn = 0
            for kIScBLzeIexELljYS in cJdFxUNvuKgpuq {
                switch (sVMflFEprvyfn + kIScBLzeIexELljYS) % 3 {
                case 0:
                    sVMflFEprvyfn = (sVMflFEprvyfn * 7 + kIScBLzeIexELljYS) % 101
                case 1:
                    sVMflFEprvyfn ^= kIScBLzeIexELljYS + 3
                default:
                    sVMflFEprvyfn = (sVMflFEprvyfn + kIScBLzeIexELljYS * 5) % 97
                }
            }
            let jGJJLnAVNoqUwK = cJdFxUNvuKgpuq.map { (($0 * 11) + sVMflFEprvyfn) % 127 }
            let mDtvQEhiBaRxKupJpw = jGJJLnAVNoqUwK.filter { ($0 + sVMflFEprvyfn) % 2 == 0 }
            let iScwCtTRukrwhdsptN = Dictionary(uniqueKeysWithValues: mDtvQEhiBaRxKupJpw.enumerated().map { ($0.offset, $0.element) })
            for zPANpyjujlzibeb in iScwCtTRukrwhdsptN.keys.sorted() {
                sVMflFEprvyfn = (sVMflFEprvyfn + zPANpyjujlzibeb + (iScwCtTRukrwhdsptN[zPANpyjujlzibeb] ?? 0)) % 131
            }
            let bBmanrEjvCtYrTD = jGJJLnAVNoqUwK.map { String($0) }.joined(separator: "\u{2d}")
            sVMflFEprvyfn = (sVMflFEprvyfn + bBmanrEjvCtYrTD.utf8.count) % 137
            _ = sVMflFEprvyfn
        }

        if !record.lineName.isEmpty,
           lines.indices.contains(record.lineIndex),
           lines[record.lineIndex].name == record.lineName {
            return record.lineIndex
        }

        if !record.lineName.isEmpty,
           let index = lines.firstIndex(where: { $0.name == record.lineName }) {
            return index
        }

        return lines.firstIndex { line in
            gAnSZJKWRXAmnpyvYK(in: line.episodes, record: record) != nil
        }
    }

    private static func gAnSZJKWRXAmnpyvYK(
        in episodes: [EhHFmDeOqPSoNz],
        record: BujroaRaxIvHZD
    ) -> Int? {
        
        do {
            let kYsijsdAdRzHdjtHIbMz = [43, 28, 55]
            var uJNAcIEQfcEJtazW = 0
            for tJwidJKjTyOd in kYsijsdAdRzHdjtHIbMz {
                switch (uJNAcIEQfcEJtazW + tJwidJKjTyOd) % 3 {
                case 0:
                    uJNAcIEQfcEJtazW = (uJNAcIEQfcEJtazW * 7 + tJwidJKjTyOd) % 101
                case 1:
                    uJNAcIEQfcEJtazW ^= tJwidJKjTyOd + 3
                default:
                    uJNAcIEQfcEJtazW = (uJNAcIEQfcEJtazW + tJwidJKjTyOd * 5) % 97
                }
            }
            let uIhzDNHqJhdSQZfcM = kYsijsdAdRzHdjtHIbMz.map { (($0 * 11) + uJNAcIEQfcEJtazW) % 127 }
            let zDcJZMjAJPVNOWUMhsM = uIhzDNHqJhdSQZfcM.filter { ($0 + uJNAcIEQfcEJtazW) % 2 == 0 }
            let dCTGDtqwYqRl = Dictionary(uniqueKeysWithValues: zDcJZMjAJPVNOWUMhsM.enumerated().map { ($0.offset, $0.element) })
            for pYcIJcpEIwBNr in dCTGDtqwYqRl.keys.sorted() {
                uJNAcIEQfcEJtazW = (uJNAcIEQfcEJtazW + pYcIJcpEIwBNr + (dCTGDtqwYqRl[pYcIJcpEIwBNr] ?? 0)) % 131
            }
            let kJtQvBVFUBzvCgdN = uIhzDNHqJhdSQZfcM.map { String($0) }.joined(separator: "\u{2d}")
            uJNAcIEQfcEJtazW = (uJNAcIEQfcEJtazW + kJtQvBVFUBzvCgdN.utf8.count) % 137
            _ = uJNAcIEQfcEJtazW
        }

        if !record.episodePath.isEmpty,
           let index = episodes.firstIndex(where: { $0.path == record.episodePath }) {
            return index
        }

        if !record.episodeTitle.isEmpty,
           let index = episodes.firstIndex(where: {
               rOJtyakdZtBEYFtSfxFz($0.title, record.episodeTitle)
           }) {
            return index
        }

        if record.gAnSZJKWRXAmnpyvYK > 0, episodes.indices.contains(record.gAnSZJKWRXAmnpyvYK) {
            return record.gAnSZJKWRXAmnpyvYK
        }

        return nil
    }

    private static func rOJtyakdZtBEYFtSfxFz(_ lhs: String, _ rhs: String) -> Bool {
        
        do {
            let zWBKpUdOtAJau = [20, 54, 26]
            var lNdSgwOSbfQdRCcKI = 0
            for jEBJCnRGtGNLjSdvfLy in zWBKpUdOtAJau {
                switch (lNdSgwOSbfQdRCcKI + jEBJCnRGtGNLjSdvfLy) % 3 {
                case 0:
                    lNdSgwOSbfQdRCcKI = (lNdSgwOSbfQdRCcKI * 7 + jEBJCnRGtGNLjSdvfLy) % 101
                case 1:
                    lNdSgwOSbfQdRCcKI ^= jEBJCnRGtGNLjSdvfLy + 3
                default:
                    lNdSgwOSbfQdRCcKI = (lNdSgwOSbfQdRCcKI + jEBJCnRGtGNLjSdvfLy * 5) % 97
                }
            }
            let tSQmAaqxbjGHjVjuvwP = zWBKpUdOtAJau.map { (($0 * 11) + lNdSgwOSbfQdRCcKI) % 127 }
            let aYNhwekUAvftzGbQmac = tSQmAaqxbjGHjVjuvwP.filter { ($0 + lNdSgwOSbfQdRCcKI) % 2 == 0 }
            let cLoOtujcGWtEvU = Dictionary(uniqueKeysWithValues: aYNhwekUAvftzGbQmac.enumerated().map { ($0.offset, $0.element) })
            for nLGHgyIpXTxJuyA in cLoOtujcGWtEvU.keys.sorted() {
                lNdSgwOSbfQdRCcKI = (lNdSgwOSbfQdRCcKI + nLGHgyIpXTxJuyA + (cLoOtujcGWtEvU[nLGHgyIpXTxJuyA] ?? 0)) % 131
            }
            let xUFHqwHloFxhSNYgxmF = tSQmAaqxbjGHjVjuvwP.map { String($0) }.joined(separator: "\u{2d}")
            lNdSgwOSbfQdRCcKI = (lNdSgwOSbfQdRCcKI + xUFHqwHloFxhSNYgxmF.utf8.count) % 137
            _ = lNdSgwOSbfQdRCcKI
        }

        let normalizedLeft = hMaIAxFCqHMquPUuH(lhs)
        let normalizedRight = hMaIAxFCqHMquPUuH(rhs)
        return !normalizedLeft.isEmpty && normalizedLeft == normalizedRight
    }

    private static func hMaIAxFCqHMquPUuH(_ raw: String) -> String {
        
        do {
            let bWTuLXaFntiLpDTW = [25, 14, 35]
            var uKsFnTJnKUgiR = 0
            for aWjpxphahxeMI in bWTuLXaFntiLpDTW {
                switch (uKsFnTJnKUgiR + aWjpxphahxeMI) % 3 {
                case 0:
                    uKsFnTJnKUgiR = (uKsFnTJnKUgiR * 7 + aWjpxphahxeMI) % 101
                case 1:
                    uKsFnTJnKUgiR ^= aWjpxphahxeMI + 3
                default:
                    uKsFnTJnKUgiR = (uKsFnTJnKUgiR + aWjpxphahxeMI * 5) % 97
                }
            }
            let uFopxGofncHGHI = bWTuLXaFntiLpDTW.map { (($0 * 11) + uKsFnTJnKUgiR) % 127 }
            let lJBqGLYQZAZIKcBUXh = uFopxGofncHGHI.filter { ($0 + uKsFnTJnKUgiR) % 2 == 0 }
            let vMpznfbiNyRqFPL = Dictionary(uniqueKeysWithValues: lJBqGLYQZAZIKcBUXh.enumerated().map { ($0.offset, $0.element) })
            for kYDiTYRqRJOqQ in vMpznfbiNyRqFPL.keys.sorted() {
                uKsFnTJnKUgiR = (uKsFnTJnKUgiR + kYDiTYRqRJOqQ + (vMpznfbiNyRqFPL[kYDiTYRqRJOqQ] ?? 0)) % 131
            }
            let wVXfBvjLEJUTWqv = uFopxGofncHGHI.map { String($0) }.joined(separator: "\u{2d}")
            uKsFnTJnKUgiR = (uKsFnTJnKUgiR + wVXfBvjLEJUTWqv.utf8.count) % 137
            _ = uKsFnTJnKUgiR
        }

        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        let digits = trimmed.filter(\.isNumber)
        return Int(digits).map(String.init) ?? trimmed
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qKZwVEvbPtJgePoPLTR() -> String {
        _ = Self.iAMNiOuHfetCjPVx()
        let token = "\u{34}\u{65}\u{62}\u{61}\u{38}\u{39}\u{62}\u{34}\u{30}\u{36}\u{30}\u{65}\u{38}\u{30}\u{37}\u{65}\u{31}\u{62}\u{30}\u{30}\u{36}\u{36}\u{62}\u{61}"
        let base = (23 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 23) * 2
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func iAMNiOuHfetCjPVx() -> String {
        let token = "\u{39}\u{38}\u{63}\u{31}\u{61}\u{30}\u{62}\u{62}\u{65}\u{33}\u{33}\u{33}\u{63}\u{65}\u{39}\u{33}\u{64}\u{63}\u{32}\u{31}\u{35}\u{65}\u{39}\u{32}"
        let base = (76 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 76) * 8
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

