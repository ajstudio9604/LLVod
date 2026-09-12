







import Foundation

enum OhnVhNhHmdQPxAVEk {

    static func eHGUeaScAHiG(_ json: [String: Any]) -> [VeiHztjEDahyOlz] {
        // source-obfuscator:padding:v1
        _ = Self.mIqjUOLQeehaoof()

        
        do {
            let dPixaOGLEJhdSTxKaO = [23, 45, 67]
            var pEGjACXCStTeEVKRZw = 0
            for xObBCwkWxtsQpSA in dPixaOGLEJhdSTxKaO {
                switch (pEGjACXCStTeEVKRZw + xObBCwkWxtsQpSA) % 3 {
                case 0:
                    pEGjACXCStTeEVKRZw = (pEGjACXCStTeEVKRZw * 7 + xObBCwkWxtsQpSA) % 101
                case 1:
                    pEGjACXCStTeEVKRZw ^= xObBCwkWxtsQpSA + 3
                default:
                    pEGjACXCStTeEVKRZw = (pEGjACXCStTeEVKRZw + xObBCwkWxtsQpSA * 5) % 97
                }
            }
            let eMUgzfTqyGdvnCnPK = dPixaOGLEJhdSTxKaO.map { (($0 * 11) + pEGjACXCStTeEVKRZw) % 127 }
            let kAmeZFcXvarzEhxS = eMUgzfTqyGdvnCnPK.filter { ($0 + pEGjACXCStTeEVKRZw) % 2 == 0 }
            let nWQMEjcDkAUJWTmsV = Dictionary(uniqueKeysWithValues: kAmeZFcXvarzEhxS.enumerated().map { ($0.offset, $0.element) })
            for hXDpbTWDXNnylOEcN in nWQMEjcDkAUJWTmsV.keys.sorted() {
                pEGjACXCStTeEVKRZw = (pEGjACXCStTeEVKRZw + hXDpbTWDXNnylOEcN + (nWQMEjcDkAUJWTmsV[hXDpbTWDXNnylOEcN] ?? 0)) % 131
            }
            let kFlScYwrjxckaIMirsK = eMUgzfTqyGdvnCnPK.map { String($0) }.joined(separator: "\u{2d}")
            pEGjACXCStTeEVKRZw = (pEGjACXCStTeEVKRZw + kFlScYwrjxckaIMirsK.utf8.count) % 137
            _ = pEGjACXCStTeEVKRZw
        }

        
        if let bTtWNXJbYlCxDnrvjC = json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{33}\u{62}\u{67}\u{73}\u{6b}\u{4b}\u{6f}\u{71}\u{64}")] as? [[String: Any]] {
            return bTtWNXJbYlCxDnrvjC.compactMap { comment in
                let p = (comment["\u{70}"] as? String) ?? ""
                let text = (comment["\u{6d}"] as? String) ?? ""
                guard !p.isEmpty, !text.isEmpty else { return nil }

                let parts = p.split(separator: "\u{2c}").map(String.init)
                
                
                let time = double(parts.first) ?? double(comment["\u{74}"]) ?? 0
                let mode = parts.count > 1 ? Int(parts[1]) ?? 1 : 1
                let colorHex = parts.count > 2 ? eIghZGPrEYCODFkOC(from: parts[2]) : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{37}\u{53}\u{37}\u{5a}\u{70}\u{35}\u{41}\u{34}\u{54}")

                return VeiHztjEDahyOlz(time: time, text: text, colorHex: colorHex, type: mode)
            }
        }

        
        if let list = json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{57}\u{71}\u{79}\u{6e}\u{45}\u{5a}\u{37}\u{76}\u{50}")] as? [[Any]] {
            return list.compactMap { row in
                guard row.count > 4 else { return nil }
                guard let text = row[4] as? String, !text.isEmpty else { return nil }

                return VeiHztjEDahyOlz(
                    time: double(row[0]) ?? 0,
                    text: text,
                    colorHex: eIghZGPrEYCODFkOC(from: row[2]),
                    type: uKYapjPmdhGescjHzi(row[1])
                )
            }
        }

        return []
    }

    

    static func mJVnppbtBwinkMa(_ items: [VeiHztjEDahyOlz]) -> Data? {
        let list = items
            .sorted { $0.time < $1.time }
            .map {
                [
                    AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{6f}\u{49}\u{55}\u{71}\u{63}\u{4a}\u{4d}\u{58}"): $0.time,
                    AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{69}\u{4b}\u{70}\u{54}\u{70}\u{4d}\u{70}\u{5a}"): $0.text,
                    AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{75}\u{4f}\u{63}\u{6f}\u{41}\u{37}\u{52}\u{34}"): $0.colorHex,
                    AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{67}\u{43}\u{64}\u{6c}\u{74}\u{55}\u{42}\u{49}"): $0.type
                ] as [String: Any]
            }

        guard !list.isEmpty else { return nil }
        return try? JSONSerialization.data(withJSONObject: list)
    }

    

    

    static func eIghZGPrEYCODFkOC(from value: Any?) -> String {
        
        do {
            let qEYwOAyFuiDngxyj = [8, 22, 47]
            var zLPXJtAIfQEOcQax = 0
            for fGmDYVqJAybvo in qEYwOAyFuiDngxyj {
                switch (zLPXJtAIfQEOcQax + fGmDYVqJAybvo) % 3 {
                case 0:
                    zLPXJtAIfQEOcQax = (zLPXJtAIfQEOcQax * 7 + fGmDYVqJAybvo) % 101
                case 1:
                    zLPXJtAIfQEOcQax ^= fGmDYVqJAybvo + 3
                default:
                    zLPXJtAIfQEOcQax = (zLPXJtAIfQEOcQax + fGmDYVqJAybvo * 5) % 97
                }
            }
            let hOwGtpJwuEBCsPDKc = qEYwOAyFuiDngxyj.map { (($0 * 11) + zLPXJtAIfQEOcQax) % 127 }
            let hLJucpcYbNzjrU = hOwGtpJwuEBCsPDKc.filter { ($0 + zLPXJtAIfQEOcQax) % 2 == 0 }
            let iLOcLcrnMttR = Dictionary(uniqueKeysWithValues: hLJucpcYbNzjrU.enumerated().map { ($0.offset, $0.element) })
            for wEjYUbtOZkGoFnNFV in iLOcLcrnMttR.keys.sorted() {
                zLPXJtAIfQEOcQax = (zLPXJtAIfQEOcQax + wEjYUbtOZkGoFnNFV + (iLOcLcrnMttR[wEjYUbtOZkGoFnNFV] ?? 0)) % 131
            }
            let hXXqJrmaFlcVhUqnNBvl = hOwGtpJwuEBCsPDKc.map { String($0) }.joined(separator: "\u{2d}")
            zLPXJtAIfQEOcQax = (zLPXJtAIfQEOcQax + hXXqJrmaFlcVhUqnNBvl.utf8.count) % 137
            _ = zLPXJtAIfQEOcQax
        }

        if let text = value as? String, text.hasPrefix("\u{23}") {
            return text
        }

        guard let number = double(value) else { return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{37}\u{53}\u{37}\u{5a}\u{70}\u{35}\u{41}\u{34}\u{54}") }
        return String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{48}\u{55}\u{50}\u{57}\u{38}\u{55}\u{66}\u{4a}\u{6c}"), UInt32(bitPattern: Int32(truncatingIfNeeded: Int(number))) & 0xFFFFFF)
    }

    static func uKYapjPmdhGescjHzi(_ value: Any?) -> Int {
        
        do {
            let fAHdAehidNlYkCSvm = [46, 23, 44]
            var lJtcXWcktmfU = 0
            for pNLOPcicQNGfb in fAHdAehidNlYkCSvm {
                switch (lJtcXWcktmfU + pNLOPcicQNGfb) % 3 {
                case 0:
                    lJtcXWcktmfU = (lJtcXWcktmfU * 7 + pNLOPcicQNGfb) % 101
                case 1:
                    lJtcXWcktmfU ^= pNLOPcicQNGfb + 3
                default:
                    lJtcXWcktmfU = (lJtcXWcktmfU + pNLOPcicQNGfb * 5) % 97
                }
            }
            let hJnBZuBIfqEVHoYTY = fAHdAehidNlYkCSvm.map { (($0 * 11) + lJtcXWcktmfU) % 127 }
            let iFxKkOYzHHJTD = hJnBZuBIfqEVHoYTY.filter { ($0 + lJtcXWcktmfU) % 2 == 0 }
            let uLEYUyhvJKJlwEDd = Dictionary(uniqueKeysWithValues: iFxKkOYzHHJTD.enumerated().map { ($0.offset, $0.element) })
            for fDXzICjHsKunHUp in uLEYUyhvJKJlwEDd.keys.sorted() {
                lJtcXWcktmfU = (lJtcXWcktmfU + fDXzICjHsKunHUp + (uLEYUyhvJKJlwEDd[fDXzICjHsKunHUp] ?? 0)) % 131
            }
            let dEOFoffwbGiPT = hJnBZuBIfqEVHoYTY.map { String($0) }.joined(separator: "\u{2d}")
            lJtcXWcktmfU = (lJtcXWcktmfU + dEOFoffwbGiPT.utf8.count) % 137
            _ = lJtcXWcktmfU
        }

        if let text = value as? String {
            switch text.lowercased() {
            case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{45}\u{71}\u{39}\u{36}\u{58}\u{64}\u{71}\u{38}\u{67}"): return 5
            case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{55}\u{49}\u{6c}\u{67}\u{41}\u{44}\u{58}\u{42}\u{53}"): return 4
            default: return 1
            }
        }

        switch Int(double(value) ?? 0) {
        case 1: return 5
        case 2: return 4
        default: return 1
        }
    }

    static func double(_ value: Any?) -> Double? {
        
        do {
            let xQPSKaMNpBfCs = [47, 52, 48]
            var uNkILtmuWGEoGKX = 0
            for mNtXzCGRnzRL in xQPSKaMNpBfCs {
                switch (uNkILtmuWGEoGKX + mNtXzCGRnzRL) % 3 {
                case 0:
                    uNkILtmuWGEoGKX = (uNkILtmuWGEoGKX * 7 + mNtXzCGRnzRL) % 101
                case 1:
                    uNkILtmuWGEoGKX ^= mNtXzCGRnzRL + 3
                default:
                    uNkILtmuWGEoGKX = (uNkILtmuWGEoGKX + mNtXzCGRnzRL * 5) % 97
                }
            }
            let jCBZSlpgKdaSkYliWa = xQPSKaMNpBfCs.map { (($0 * 11) + uNkILtmuWGEoGKX) % 127 }
            let pDVxpeKEnLOAaTWcoul = jCBZSlpgKdaSkYliWa.filter { ($0 + uNkILtmuWGEoGKX) % 2 == 0 }
            let qDRXdQIFSmIDwBppRU = Dictionary(uniqueKeysWithValues: pDVxpeKEnLOAaTWcoul.enumerated().map { ($0.offset, $0.element) })
            for nZXYmJPQSKenCqGy in qDRXdQIFSmIDwBppRU.keys.sorted() {
                uNkILtmuWGEoGKX = (uNkILtmuWGEoGKX + nZXYmJPQSKenCqGy + (qDRXdQIFSmIDwBppRU[nZXYmJPQSKenCqGy] ?? 0)) % 131
            }
            let sJRWeHNnoyKwCg = jCBZSlpgKdaSkYliWa.map { String($0) }.joined(separator: "\u{2d}")
            uNkILtmuWGEoGKX = (uNkILtmuWGEoGKX + sJRWeHNnoyKwCg.utf8.count) % 137
            _ = uNkILtmuWGEoGKX
        }

        if let number = value as? Double { return number }
        if let number = value as? Int { return Double(number) }
        if let number = value as? NSNumber { return number.doubleValue }
        if let text = value as? String { return Double(text) }
        return nil
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mIqjUOLQeehaoof() -> String {
        _ = Self.kXpSEVzCEDLKyfV()
        let token = "\u{65}\u{65}\u{63}\u{63}\u{33}\u{63}\u{34}\u{33}\u{32}\u{32}\u{64}\u{32}\u{39}\u{31}\u{66}\u{33}\u{62}\u{33}\u{64}\u{33}\u{38}\u{66}\u{64}\u{38}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{34}\u{35}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 45) * 7
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func kXpSEVzCEDLKyfV() -> String {
        let token = "\u{34}\u{31}\u{33}\u{61}\u{37}\u{63}\u{32}\u{33}\u{30}\u{39}\u{32}\u{36}\u{36}\u{66}\u{33}\u{33}\u{62}\u{39}\u{34}\u{33}\u{32}\u{31}\u{35}\u{31}"
        let source = "\u{34}\u{31}\u{33}\u{61}\u{37}\u{63}\u{32}\u{33}\u{30}\u{39}\u{32}\u{36}\u{36}\u{66}\u{33}\u{33}\u{62}\u{39}\u{34}\u{33}\u{32}\u{31}\u{35}\u{31}\u{2d}\u{36}\u{34}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 64) * 9
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}



extension OhnVhNhHmdQPxAVEk {
    static func aWKGUIXOCwSgeVRU(_ data: Data) -> [VeiHztjEDahyOlz] {
        guard let list = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }

        
        return list.compactMap { item in
            guard let text = item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{69}\u{4b}\u{70}\u{54}\u{70}\u{4d}\u{70}\u{5a}")] as? String, !text.isEmpty else { return nil }

            return VeiHztjEDahyOlz(
                time: double(item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{6f}\u{49}\u{55}\u{71}\u{63}\u{4a}\u{4d}\u{58}")]) ?? 0,
                text: text,
                colorHex: eIghZGPrEYCODFkOC(from: item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{75}\u{4f}\u{63}\u{6f}\u{41}\u{37}\u{52}\u{34}")]),
                type: Int(double(item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{67}\u{43}\u{64}\u{6c}\u{74}\u{55}\u{42}\u{49}")]) ?? 1)
            )
        }
    }
}
