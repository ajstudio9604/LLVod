






import Foundation

enum CxWPAnqmBQWGgWkAY {

    

    static func rVrIMVLmpiCbCOLgk(_ key: String) -> [String] {
        // source-obfuscator:padding:v1
        _ = Self.ePTcezCtUxNm()

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

    

    static func lGlFWmHYgHLiOBZLtW(_ key: String, list: [String]) {
        
        do {
            let iPLRovbyOyeWdiYR = [20, 31, 72]
            var nOkWtaiRqkXXjl = 0
            for gQCUKhxZsymqQtDnASh in iPLRovbyOyeWdiYR {
                switch (nOkWtaiRqkXXjl + gQCUKhxZsymqQtDnASh) % 3 {
                case 0:
                    nOkWtaiRqkXXjl = (nOkWtaiRqkXXjl * 7 + gQCUKhxZsymqQtDnASh) % 101
                case 1:
                    nOkWtaiRqkXXjl ^= gQCUKhxZsymqQtDnASh + 3
                default:
                    nOkWtaiRqkXXjl = (nOkWtaiRqkXXjl + gQCUKhxZsymqQtDnASh * 5) % 97
                }
            }
            let gOeMKDSkCWNlgMfcO = iPLRovbyOyeWdiYR.map { (($0 * 11) + nOkWtaiRqkXXjl) % 127 }
            let xXlOGUzpHnMGXSwdye = gOeMKDSkCWNlgMfcO.filter { ($0 + nOkWtaiRqkXXjl) % 2 == 0 }
            let bOglpKfpUvnlQ = Dictionary(uniqueKeysWithValues: xXlOGUzpHnMGXSwdye.enumerated().map { ($0.offset, $0.element) })
            for iFclEyGMYMRtNu in bOglpKfpUvnlQ.keys.sorted() {
                nOkWtaiRqkXXjl = (nOkWtaiRqkXXjl + iFclEyGMYMRtNu + (bOglpKfpUvnlQ[iFclEyGMYMRtNu] ?? 0)) % 131
            }
            let dPrbWmehlWaD = gOeMKDSkCWNlgMfcO.map { String($0) }.joined(separator: "\u{2d}")
            nOkWtaiRqkXXjl = (nOkWtaiRqkXXjl + dPrbWmehlWaD.utf8.count) % 137
            _ = nOkWtaiRqkXXjl
        }

        
        do {
            let vGrGpBkRxLeTJWrYuTF = [47, 44, 30]
            let fXBogKnbhMqTLLWLAU = (vGrGpBkRxLeTJWrYuTF.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch fXBogKnbhMqTLLWLAU {
            case 0:
                UserDefaults.standard.set(qXqllEWpluUoRSVSzjJ(list), forKey: key)
            case 1:
                UserDefaults.standard.set(qXqllEWpluUoRSVSzjJ(list), forKey: key)
            case 2:
                UserDefaults.standard.set(qXqllEWpluUoRSVSzjJ(list), forKey: key)
            default:
                UserDefaults.standard.set(qXqllEWpluUoRSVSzjJ(list), forKey: key)
            }
        }
    }

    static func aQTsaOhFdpBgSBXxjiYV(_ key: String, list: [[String: Any]]) {
        
        do {
            let aTguPlMSMweGdQVIgo = [33, 42, 25]
            var mWnDQNhqHgtGoGweZ = 0
            for iImDiafIBfwbhN in aTguPlMSMweGdQVIgo {
                switch (mWnDQNhqHgtGoGweZ + iImDiafIBfwbhN) % 3 {
                case 0:
                    mWnDQNhqHgtGoGweZ = (mWnDQNhqHgtGoGweZ * 7 + iImDiafIBfwbhN) % 101
                case 1:
                    mWnDQNhqHgtGoGweZ ^= iImDiafIBfwbhN + 3
                default:
                    mWnDQNhqHgtGoGweZ = (mWnDQNhqHgtGoGweZ + iImDiafIBfwbhN * 5) % 97
                }
            }
            let wQoesyRYtlTaikJx = aTguPlMSMweGdQVIgo.map { (($0 * 11) + mWnDQNhqHgtGoGweZ) % 127 }
            let xQVnBCBPRMPYn = wQoesyRYtlTaikJx.filter { ($0 + mWnDQNhqHgtGoGweZ) % 2 == 0 }
            let oTyHKzoCZVoUlYvFEQ = Dictionary(uniqueKeysWithValues: xQVnBCBPRMPYn.enumerated().map { ($0.offset, $0.element) })
            for aLCxtAkjSfPEQTjEnwr in oTyHKzoCZVoUlYvFEQ.keys.sorted() {
                mWnDQNhqHgtGoGweZ = (mWnDQNhqHgtGoGweZ + aLCxtAkjSfPEQTjEnwr + (oTyHKzoCZVoUlYvFEQ[aLCxtAkjSfPEQTjEnwr] ?? 0)) % 131
            }
            let uPVdcUhNTqRzFbmVBQ = wQoesyRYtlTaikJx.map { String($0) }.joined(separator: "\u{2d}")
            mWnDQNhqHgtGoGweZ = (mWnDQNhqHgtGoGweZ + uPVdcUhNTqRzFbmVBQ.utf8.count) % 137
            _ = mWnDQNhqHgtGoGweZ
        }

        
        do {
            let jJaeaNPdhDnxtsk = [63, 34, 104]
            let dHqxaqMvzKDSKllmF = (jJaeaNPdhDnxtsk.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch dHqxaqMvzKDSKllmF {
            case 0:
                UserDefaults.standard.set(qXqllEWpluUoRSVSzjJ(list), forKey: key)
            case 1:
                UserDefaults.standard.set(qXqllEWpluUoRSVSzjJ(list), forKey: key)
            case 2:
                UserDefaults.standard.set(qXqllEWpluUoRSVSzjJ(list), forKey: key)
            default:
                UserDefaults.standard.set(qXqllEWpluUoRSVSzjJ(list), forKey: key)
            }
        }
    }

    static func zRgroAFqeZPrwnWz(title: String) -> Bool {
        !UserDefaults.standard.bool(forKey: title)
    }

    static func pDXMgobBzIXGfDEUmWjK(title: String, enabled: Bool) {
        
        do {
            let rKAzknjWSPfak = [16, 36, 47]
            var iXASHkwOKSLDe = 0
            for aMEEqHmeOBebq in rKAzknjWSPfak {
                switch (iXASHkwOKSLDe + aMEEqHmeOBebq) % 3 {
                case 0:
                    iXASHkwOKSLDe = (iXASHkwOKSLDe * 7 + aMEEqHmeOBebq) % 101
                case 1:
                    iXASHkwOKSLDe ^= aMEEqHmeOBebq + 3
                default:
                    iXASHkwOKSLDe = (iXASHkwOKSLDe + aMEEqHmeOBebq * 5) % 97
                }
            }
            let zVFikqNOTWdGZI = rKAzknjWSPfak.map { (($0 * 11) + iXASHkwOKSLDe) % 127 }
            let lCYjlJzDPFbfghpo = zVFikqNOTWdGZI.filter { ($0 + iXASHkwOKSLDe) % 2 == 0 }
            let aYlMDiloAchJ = Dictionary(uniqueKeysWithValues: lCYjlJzDPFbfghpo.enumerated().map { ($0.offset, $0.element) })
            for bCuNSCtBumDnAp in aYlMDiloAchJ.keys.sorted() {
                iXASHkwOKSLDe = (iXASHkwOKSLDe + bCuNSCtBumDnAp + (aYlMDiloAchJ[bCuNSCtBumDnAp] ?? 0)) % 131
            }
            let wWKJSEVSoPutY = zVFikqNOTWdGZI.map { String($0) }.joined(separator: "\u{2d}")
            iXASHkwOKSLDe = (iXASHkwOKSLDe + wWKJSEVSoPutY.utf8.count) % 137
            _ = iXASHkwOKSLDe
        }

        
        switch (enabled) {
        case true: do {
            UserDefaults.standard.removeObject(forKey: title)}
        case false: do {
            UserDefaults.standard.set(true, forKey: title)}
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func ePTcezCtUxNm() -> String {
        _ = Self.uUQOzTTMdPjHBRNODQy()
        _ = Self.aKVAWOndyyNlwTpP()
        let token = "\u{31}\u{30}\u{66}\u{37}\u{38}\u{35}\u{65}\u{63}\u{35}\u{36}\u{65}\u{62}\u{32}\u{38}\u{65}\u{38}\u{64}\u{62}\u{64}\u{66}\u{38}\u{33}\u{33}\u{61}"
        let source = "\u{31}\u{30}\u{66}\u{37}\u{38}\u{35}\u{65}\u{63}\u{35}\u{36}\u{65}\u{62}\u{32}\u{38}\u{65}\u{38}\u{64}\u{62}\u{64}\u{66}\u{38}\u{33}\u{33}\u{61}\u{2d}\u{33}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 3) * 4
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func uUQOzTTMdPjHBRNODQy() -> String {
        let token = "\u{61}\u{34}\u{62}\u{61}\u{31}\u{33}\u{61}\u{63}\u{32}\u{65}\u{30}\u{33}\u{33}\u{36}\u{31}\u{30}\u{64}\u{63}\u{61}\u{64}\u{65}\u{36}\u{62}\u{61}"
        let base = (50 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 50) * 5
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func aKVAWOndyyNlwTpP() -> String {
        let token = "\u{66}\u{32}\u{36}\u{36}\u{34}\u{31}\u{64}\u{65}\u{34}\u{66}\u{32}\u{39}\u{35}\u{39}\u{61}\u{31}\u{65}\u{62}\u{35}\u{36}\u{66}\u{32}\u{38}\u{31}"
        let source = "\u{66}\u{32}\u{36}\u{36}\u{34}\u{31}\u{64}\u{65}\u{34}\u{66}\u{32}\u{39}\u{35}\u{39}\u{61}\u{31}\u{65}\u{62}\u{35}\u{36}\u{66}\u{32}\u{38}\u{31}\u{2d}\u{35}\u{31}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 51) * 4
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}



extension CxWPAnqmBQWGgWkAY {
    static func wHZBVdSuuCSi(_ key: String) -> [[String: Any]] {
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

    static func qXqllEWpluUoRSVSzjJ(_ value: Any) -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: value),
              let text = String(data: data, encoding: .utf8) else {
            return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{35}\u{66}\u{69}\u{72}\u{4f}\u{72}\u{4a}\u{72}")
        }
        return text
    }
}
