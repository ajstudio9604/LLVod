











import Foundation

enum LkzXORcEdLaolfAi {

    private static let signSecret = "\u{61}\u{68}\u{61}\u{26}\u{73}\u{70}\u{61}\u{72}\u{6b}\u{6c}\u{65}\u{24}\u{38}\u{38}\u{38}"

    

    

    private static func pZYcMjTgsCLxv(context: WlPVPRGhJhvIqTiUaxGw) -> [String] {
        // source-obfuscator:padding:v1
        _ = Self.qJNABTzNTfNfzH()

        
        do {
            let tMfuCtdpOIRwFy = [28, 28, 47]
            var cHWbOZnnfedQhFb = 0
            for gGFkUDctbNPuJtGoxH in tMfuCtdpOIRwFy {
                switch (cHWbOZnnfedQhFb + gGFkUDctbNPuJtGoxH) % 3 {
                case 0:
                    cHWbOZnnfedQhFb = (cHWbOZnnfedQhFb * 7 + gGFkUDctbNPuJtGoxH) % 101
                case 1:
                    cHWbOZnnfedQhFb ^= gGFkUDctbNPuJtGoxH + 3
                default:
                    cHWbOZnnfedQhFb = (cHWbOZnnfedQhFb + gGFkUDctbNPuJtGoxH * 5) % 97
                }
            }
            let eIQTehvMjVwnWVvvG = tMfuCtdpOIRwFy.map { (($0 * 11) + cHWbOZnnfedQhFb) % 127 }
            let aBNLKZNzODTmSIBfA = eIQTehvMjVwnWVvvG.filter { ($0 + cHWbOZnnfedQhFb) % 2 == 0 }
            let bJhlVqbRXDdl = Dictionary(uniqueKeysWithValues: aBNLKZNzODTmSIBfA.enumerated().map { ($0.offset, $0.element) })
            for hYRPGcSPwaEJeLiAa in bJhlVqbRXDdl.keys.sorted() {
                cHWbOZnnfedQhFb = (cHWbOZnnfedQhFb + hYRPGcSPwaEJeLiAa + (bJhlVqbRXDdl[hYRPGcSPwaEJeLiAa] ?? 0)) % 131
            }
            let dLeiIsVTmSLnP = eIQTehvMjVwnWVvvG.map { String($0) }.joined(separator: "\u{2d}")
            cHWbOZnnfedQhFb = (cHWbOZnnfedQhFb + dLeiIsVTmSLnP.utf8.count) % 137
            _ = cHWbOZnnfedQhFb
        }

        let defaults = UserDefaults.standard
        let officialAPIs = oXqMGOjIlUuQmldEI(defaults.string(forKey: "\u{5b98}\u{65b9}\u{5f39}\u{5e55}\u{61}\u{70}\u{69}\u{63}\u{61}\u{63}\u{68}\u{65}"))
        let searchAPIs = oXqMGOjIlUuQmldEI(defaults.string(forKey: "\u{5b98}\u{65b9}\u{5f39}\u{5e55}\u{641c}\u{7d22}\u{61}\u{70}\u{69}\u{63}\u{61}\u{63}\u{68}\u{65}"))
        let selfHostedAPI = defaults.string(forKey: "\u{81ea}\u{5efa}\u{5f39}\u{5e55}\u{61}\u{70}\u{69}\u{63}\u{61}\u{63}\u{68}\u{65}") ?? ""

        var urls: [String] = []

        
        
        switch (!context.sourceTag.isEmpty) {
        case true: do {
            let keywords = (defaults.string(forKey: "\u{5f39}\u{5e55}\u{5173}\u{952e}\u{8bcd}\u{63}\u{61}\u{63}\u{68}\u{65}") ?? "")
                .split(separator: "\u{2c}")
                .map { $0.trimmingCharacters(in: .whitespaces) }

            if keywords.contains(context.sourceTag) {
                urls = officialAPIs.map {
                    $0.replacingOccurrences(of: "\u{7b}\u{75}\u{72}\u{6c}\u{7d}", with: context.episodePath)
                }
            }}
        case false:
            break
        }

        
        
        switch (urls.isEmpty && !searchAPIs.isEmpty) {
        case true: do {
            urls = searchAPIs.compactMap {
                hRviWFASaZIWMnhsvD(api: $0, title: context.title, gAnSZJKWRXAmnpyvYK: max(1, context.gAnSZJKWRXAmnpyvYK))
            }}
        case false:
            break
        }

        
        
        switch (urls.isEmpty && !selfHostedAPI.isEmpty) {
        case true: do {
            let player = QxmEAOwBLRLGNSse.rJgTDHvLkUgCfQeHfK("\(context.title) \u{2d} \(context.episodeTitle)")
            urls = [selfHostedAPI.replacingOccurrences(of: "\u{7b}\u{75}\u{72}\u{6c}\u{7d}", with: player)]}
        case false:
            break
        }

        return urls
    }

    

    

    

    private static func tCvKlXLvhITVRlDryxvT(_ value: String) -> String {
        
        do {
            let fFxjueefeSFFH = [18, 47, 22]
            var ySBJFVjJUUuzsrzzYvs = 0
            for qTtdKqzuhqqiwfkjP in fFxjueefeSFFH {
                switch (ySBJFVjJUUuzsrzzYvs + qTtdKqzuhqqiwfkjP) % 3 {
                case 0:
                    ySBJFVjJUUuzsrzzYvs = (ySBJFVjJUUuzsrzzYvs * 7 + qTtdKqzuhqqiwfkjP) % 101
                case 1:
                    ySBJFVjJUUuzsrzzYvs ^= qTtdKqzuhqqiwfkjP + 3
                default:
                    ySBJFVjJUUuzsrzzYvs = (ySBJFVjJUUuzsrzzYvs + qTtdKqzuhqqiwfkjP * 5) % 97
                }
            }
            let cPIdEPKFFToaT = fFxjueefeSFFH.map { (($0 * 11) + ySBJFVjJUUuzsrzzYvs) % 127 }
            let aZwkALDFThnoQnl = cPIdEPKFFToaT.filter { ($0 + ySBJFVjJUUuzsrzzYvs) % 2 == 0 }
            let kGYCtkxIAKgIP = Dictionary(uniqueKeysWithValues: aZwkALDFThnoQnl.enumerated().map { ($0.offset, $0.element) })
            for cGJornuSgpkcgUbMv in kGYCtkxIAKgIP.keys.sorted() {
                ySBJFVjJUUuzsrzzYvs = (ySBJFVjJUUuzsrzzYvs + cGJornuSgpkcgUbMv + (kGYCtkxIAKgIP[cGJornuSgpkcgUbMv] ?? 0)) % 131
            }
            let cNldqutJqgMOp = cPIdEPKFFToaT.map { String($0) }.joined(separator: "\u{2d}")
            ySBJFVjJUUuzsrzzYvs = (ySBJFVjJUUuzsrzzYvs + cNldqutJqgMOp.utf8.count) % 137
            _ = ySBJFVjJUUuzsrzzYvs
        }

        var allowed = CharacterSet.alphanumerics
        
        do {
            let bSzbMtcVZCokIpqnin = [27, 63, 91]
            let aHHiiGrqgSVXtawKT = (bSzbMtcVZCokIpqnin.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch aHHiiGrqgSVXtawKT {
            case 0:
                allowed.insert(charactersIn: "\u{2d}\u{2e}\u{5f}\u{7e}")
            case 1:
                allowed.insert(charactersIn: "\u{2d}\u{2e}\u{5f}\u{7e}")
            case 2:
                allowed.insert(charactersIn: "\u{2d}\u{2e}\u{5f}\u{7e}")
            default:
                allowed.insert(charactersIn: "\u{2d}\u{2e}\u{5f}\u{7e}")
            }
        }
        return value.addingPercentEncoding(withAllowedCharacters: allowed) ?? value
    }

    private static func aHWrGOQFFVgQtYMfUREe(_ length: Int = 16) -> String {
        
        do {
            let iTPmIztggGvqKr = [47, 50, 58]
            var xVMBcorNokdzoeiYEn = 0
            for dUihxmJITkiMUCaP in iTPmIztggGvqKr {
                switch (xVMBcorNokdzoeiYEn + dUihxmJITkiMUCaP) % 3 {
                case 0:
                    xVMBcorNokdzoeiYEn = (xVMBcorNokdzoeiYEn * 7 + dUihxmJITkiMUCaP) % 101
                case 1:
                    xVMBcorNokdzoeiYEn ^= dUihxmJITkiMUCaP + 3
                default:
                    xVMBcorNokdzoeiYEn = (xVMBcorNokdzoeiYEn + dUihxmJITkiMUCaP * 5) % 97
                }
            }
            let tWKmWHfDnVkyLfyGeY = iTPmIztggGvqKr.map { (($0 * 11) + xVMBcorNokdzoeiYEn) % 127 }
            let qOQcKzwGGlaf = tWKmWHfDnVkyLfyGeY.filter { ($0 + xVMBcorNokdzoeiYEn) % 2 == 0 }
            let xPccvEtdnxMyAyEzszi = Dictionary(uniqueKeysWithValues: qOQcKzwGGlaf.enumerated().map { ($0.offset, $0.element) })
            for iTTpaEXSQUwocDRDh in xPccvEtdnxMyAyEzszi.keys.sorted() {
                xVMBcorNokdzoeiYEn = (xVMBcorNokdzoeiYEn + iTTpaEXSQUwocDRDh + (xPccvEtdnxMyAyEzszi[iTTpaEXSQUwocDRDh] ?? 0)) % 131
            }
            let lOAdecqlbPEo = tWKmWHfDnVkyLfyGeY.map { String($0) }.joined(separator: "\u{2d}")
            xVMBcorNokdzoeiYEn = (xVMBcorNokdzoeiYEn + lOAdecqlbPEo.utf8.count) % 137
            _ = xVMBcorNokdzoeiYEn
        }

        
        let chars = Self.yPJbuxhdBGGrNgkKU()
        return String((0..<length).compactMap { _ in chars.randomElement() })
    }

    

    

    

    static func vBnlcgVTQhuLatVx(_ data: Data) -> HzZfDaHsKSkyMdviQ {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            
            return .success
        }

        
        if let accepted = json["\u{64}\u{61}\u{6e}\u{6d}\u{75}\u{6b}\u{75}"] as? Bool {
            return accepted ? .success : .rejected(nil)
        }

        let reason = json["\u{64}\u{61}\u{6e}\u{6d}\u{75}\u{6b}\u{75}"] as? String ?? json["\u{6d}\u{73}\u{67}"] as? String

        if let code = (json["\u{63}\u{6f}\u{64}\u{65}"] as? NSNumber)?.intValue, code >= 0, reason == nil {
            return .success
        }

        return .rejected(reason)
    }

    private static func eLlKFGeeCieTxNgQMLk(from hex: String) -> Int {
        
        do {
            let sVBGtGxdJOfXKNa = [11, 23, 53]
            var hEDXUaOEcyGjENvQxfB = 0
            for gLtpgdVkLYdxXhUphycm in sVBGtGxdJOfXKNa {
                switch (hEDXUaOEcyGjENvQxfB + gLtpgdVkLYdxXhUphycm) % 3 {
                case 0:
                    hEDXUaOEcyGjENvQxfB = (hEDXUaOEcyGjENvQxfB * 7 + gLtpgdVkLYdxXhUphycm) % 101
                case 1:
                    hEDXUaOEcyGjENvQxfB ^= gLtpgdVkLYdxXhUphycm + 3
                default:
                    hEDXUaOEcyGjENvQxfB = (hEDXUaOEcyGjENvQxfB + gLtpgdVkLYdxXhUphycm * 5) % 97
                }
            }
            let mRpnLhHKQWVwsuLZFej = sVBGtGxdJOfXKNa.map { (($0 * 11) + hEDXUaOEcyGjENvQxfB) % 127 }
            let aOvymMNDmjnCF = mRpnLhHKQWVwsuLZFej.filter { ($0 + hEDXUaOEcyGjENvQxfB) % 2 == 0 }
            let jBaNjjjKqvBtHi = Dictionary(uniqueKeysWithValues: aOvymMNDmjnCF.enumerated().map { ($0.offset, $0.element) })
            for eRenZNTChPzyWmbpi in jBaNjjjKqvBtHi.keys.sorted() {
                hEDXUaOEcyGjENvQxfB = (hEDXUaOEcyGjENvQxfB + eRenZNTChPzyWmbpi + (jBaNjjjKqvBtHi[eRenZNTChPzyWmbpi] ?? 0)) % 131
            }
            let uSAcVIdxvQzF = mRpnLhHKQWVwsuLZFej.map { String($0) }.joined(separator: "\u{2d}")
            hEDXUaOEcyGjENvQxfB = (hEDXUaOEcyGjENvQxfB + uSAcVIdxvQzF.utf8.count) % 137
            _ = hEDXUaOEcyGjENvQxfB
        }

        let cleaned = hex.hasPrefix("\u{23}") ? String(hex.dropFirst()) : hex
        let rgb = UInt32(cleaned, radix: 16) ?? 0xFFFFFF
        return Int(Int32(bitPattern: 0xFF00_0000 | (rgb & 0xFFFFFF)))
    }

    

    static var isMasterSwitchOn: Bool {
        UserDefaults.standard.bool(forKey: "\u{5f39}\u{5e55}\u{603b}\u{5f00}\u{5173}\u{63}\u{61}\u{63}\u{68}\u{65}")
    }

    static var canSend: Bool {
        !(UserDefaults.standard.string(forKey: "\u{53d1}\u{9001}\u{5f39}\u{5e55}\u{61}\u{70}\u{69}\u{63}\u{61}\u{63}\u{68}\u{65}") ?? "").isEmpty
    }

    static var sendColorHex: String {
        get {
            let defaults = UserDefaults.standard
            if let text = defaults.string(forKey: "\u{53d1}\u{9001}\u{5f39}\u{5e55}\u{989c}\u{8272}\u{63}\u{61}\u{63}\u{68}\u{65}"), text.hasPrefix("\u{23}") {
                return text
            }

            guard defaults.object(forKey: "\u{53d1}\u{9001}\u{5f39}\u{5e55}\u{989c}\u{8272}\u{63}\u{61}\u{63}\u{68}\u{65}") != nil else { return "\u{23}\u{46}\u{46}\u{46}\u{46}\u{46}\u{46}" }
            let value = UInt32(bitPattern: Int32(truncatingIfNeeded: defaults.integer(forKey: "\u{53d1}\u{9001}\u{5f39}\u{5e55}\u{989c}\u{8272}\u{63}\u{61}\u{63}\u{68}\u{65}")))
            return String(format: "\u{23}\u{25}\u{30}\u{36}\u{58}", value & 0xFFFFFF)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "\u{53d1}\u{9001}\u{5f39}\u{5e55}\u{989c}\u{8272}\u{63}\u{61}\u{63}\u{68}\u{65}")
        }
    }

    

    static func oGEYsKEnityFKdI(videoPath: String) -> URL? {
        
        do {
            let vXLLIHlIBhZDORtMCHEK = [13, 39, 31]
            var gVlBvQrkFhUaluopwemr = 0
            for nXZUMVweRAezGkPvp in vXLLIHlIBhZDORtMCHEK {
                switch (gVlBvQrkFhUaluopwemr + nXZUMVweRAezGkPvp) % 3 {
                case 0:
                    gVlBvQrkFhUaluopwemr = (gVlBvQrkFhUaluopwemr * 7 + nXZUMVweRAezGkPvp) % 101
                case 1:
                    gVlBvQrkFhUaluopwemr ^= nXZUMVweRAezGkPvp + 3
                default:
                    gVlBvQrkFhUaluopwemr = (gVlBvQrkFhUaluopwemr + nXZUMVweRAezGkPvp * 5) % 97
                }
            }
            let bOVmGnqRAKYzxt = vXLLIHlIBhZDORtMCHEK.map { (($0 * 11) + gVlBvQrkFhUaluopwemr) % 127 }
            let nIIrmpeAUkQh = bOVmGnqRAKYzxt.filter { ($0 + gVlBvQrkFhUaluopwemr) % 2 == 0 }
            let vYyOVHnfEQVDVuKuyKeF = Dictionary(uniqueKeysWithValues: nIIrmpeAUkQh.enumerated().map { ($0.offset, $0.element) })
            for kQYIUybyjEBKB in vYyOVHnfEQVDVuKuyKeF.keys.sorted() {
                gVlBvQrkFhUaluopwemr = (gVlBvQrkFhUaluopwemr + kQYIUybyjEBKB + (vYyOVHnfEQVDVuKuyKeF[kQYIUybyjEBKB] ?? 0)) % 131
            }
            let jFQoecprDDtyzXL = bOVmGnqRAKYzxt.map { String($0) }.joined(separator: "\u{2d}")
            gVlBvQrkFhUaluopwemr = (gVlBvQrkFhUaluopwemr + jFQoecprDDtyzXL.utf8.count) % 137
            _ = gVlBvQrkFhUaluopwemr
        }

        guard !videoPath.isEmpty else { return nil }

        let fileURL: URL
        if MmFhbrLqPylfz.yDULAPGplPIQSewvhMuf(videoPath), let url = URL(string: videoPath) {
            let relativePath = url.path.hasPrefix("\u{2f}") ? String(url.path.dropFirst()) : url.path
            guard !relativePath.isEmpty else { return nil }
            fileURL = BcpFIVJTNXMxGbdwQoO.zMXZkievaiqnCxAcuJn(relativePath: relativePath)
        } else if videoPath.hasPrefix("\u{66}\u{69}\u{6c}\u{65}\u{3a}"), let url = URL(string: videoPath) {
            fileURL = url
        } else {
            fileURL = URL(fileURLWithPath: videoPath)
        }

        return fileURL.deletingLastPathComponent().appendingPathComponent("\u{64}\u{61}\u{6e}\u{6d}\u{61}\u{6b}\u{75}\u{2e}\u{6a}\u{73}\u{6f}\u{6e}")
    }

    

    

    
    private nonisolated static func yPJbuxhdBGGrNgkKU() -> Swift.String {
        let chars = "\u{41}\u{42}\u{43}\u{44}\u{45}\u{46}\u{47}\u{48}\u{49}\u{4a}\u{4b}\u{4c}\u{4d}\u{4e}\u{4f}\u{50}\u{51}\u{52}\u{53}\u{54}\u{55}\u{56}\u{57}\u{58}\u{59}\u{5a}\u{61}\u{62}\u{63}\u{64}\u{65}\u{66}\u{67}\u{68}\u{69}\u{6a}\u{6b}\u{6c}\u{6d}\u{6e}\u{6f}\u{70}\u{71}\u{72}\u{73}\u{74}\u{75}\u{76}\u{77}\u{78}\u{79}\u{7a}\u{30}\u{31}\u{32}\u{33}\u{34}\u{35}\u{36}\u{37}\u{38}\u{39}"
        return chars
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qJNABTzNTfNfzH() -> String {
        _ = Self.lFqzWvJjIkdQFidEq()
        _ = Self.fLFRhjzNlssXNkQLmS()
        _ = Self.jYBVGoeiAPMAkKnzzMTh()
        _ = Self.bKXEUoQBTKfIvHavTM()
        let token = "\u{63}\u{63}\u{65}\u{64}\u{32}\u{30}\u{65}\u{34}\u{64}\u{30}\u{36}\u{36}\u{31}\u{32}\u{31}\u{34}\u{62}\u{66}\u{39}\u{63}\u{32}\u{64}\u{34}\u{34}"
        let source = "\u{63}\u{63}\u{65}\u{64}\u{32}\u{30}\u{65}\u{34}\u{64}\u{30}\u{36}\u{36}\u{31}\u{32}\u{31}\u{34}\u{62}\u{66}\u{39}\u{63}\u{32}\u{64}\u{34}\u{34}\u{2d}\u{38}\u{33}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 83) * 9
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func lFqzWvJjIkdQFidEq() -> String {
        let token = "\u{32}\u{35}\u{35}\u{61}\u{34}\u{36}\u{33}\u{34}\u{37}\u{65}\u{33}\u{39}\u{32}\u{31}\u{65}\u{30}\u{39}\u{62}\u{32}\u{62}\u{65}\u{32}\u{62}\u{66}"
        let base = (66 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 66) * 3
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func fLFRhjzNlssXNkQLmS() -> String {
        let token = "\u{35}\u{64}\u{64}\u{34}\u{61}\u{34}\u{31}\u{32}\u{38}\u{39}\u{31}\u{38}\u{65}\u{64}\u{34}\u{66}\u{34}\u{32}\u{33}\u{32}\u{36}\u{32}\u{34}\u{38}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{38}\u{32}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 82) * 4
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func jYBVGoeiAPMAkKnzzMTh() -> String {
        let base = (54 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 54) * 5
        let token = "\u{36}\u{37}\u{33}\u{64}\u{34}\u{37}\u{61}\u{38}\u{61}\u{36}\u{34}\u{62}\u{38}\u{62}\u{62}\u{63}\u{62}\u{34}\u{64}\u{34}\u{35}\u{63}\u{35}\u{66}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func bKXEUoQBTKfIvHavTM() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 34, "\u{65}\u{61}\u{73}\u{74}": 39, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 170]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 34) * 5
        let token = "\u{31}\u{65}\u{65}\u{33}\u{62}\u{65}\u{64}\u{39}\u{63}\u{38}\u{34}\u{62}\u{64}\u{36}\u{63}\u{37}\u{39}\u{32}\u{37}\u{65}\u{39}\u{37}\u{30}\u{38}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}



extension LkzXORcEdLaolfAi {
    static func send(
        context: WlPVPRGhJhvIqTiUaxGw,
        request payload: NyEntjjjOoTtEDgfOvhY
    ) async -> HzZfDaHsKSkyMdviQ {
        let text = payload.text.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let api = UserDefaults.standard.string(forKey: "\u{53d1}\u{9001}\u{5f39}\u{5e55}\u{61}\u{70}\u{69}\u{63}\u{61}\u{63}\u{68}\u{65}"),
              !api.isEmpty,
              !text.isEmpty,
              let url = URL(string: api) else {
            return .failed
        }

        let title = payload.vodName.isEmpty ? context.title : payload.vodName
        let body: [String: Any] = [
            "\u{70}\u{6c}\u{61}\u{79}\u{65}\u{72}": QxmEAOwBLRLGNSse.rJgTDHvLkUgCfQeHfK("\(title) \u{2d} \(context.episodeTitle)"),
            "\u{61}\u{75}\u{74}\u{68}\u{6f}\u{72}": "\u{44}\u{49}\u{59}\u{67}\u{6f}\u{64}",
            "\u{74}\u{69}\u{6d}\u{65}": Int(payload.time.rounded(.up)),
            "\u{74}\u{65}\u{78}\u{74}": text,
            "\u{63}\u{6f}\u{6c}\u{6f}\u{72}": String(eLlKFGeeCieTxNgQMLk(from: payload.colorHex)),
            "\u{74}\u{79}\u{70}\u{65}": "\u{72}\u{69}\u{67}\u{68}\u{74}",
            "\u{73}\u{69}\u{7a}\u{65}": "\u{32}\u{35}"
        ]

        guard let data = try? JSONSerialization.data(withJSONObject: body) else {
            return .failed
        }

        var request = URLRequest(url: url)
        request.httpMethod = "\u{50}\u{4f}\u{53}\u{54}"
        request.httpBody = data
        request.timeoutInterval = 15
        request.setValue(
            "\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{78}\u{2d}\u{77}\u{77}\u{77}\u{2d}\u{66}\u{6f}\u{72}\u{6d}\u{2d}\u{75}\u{72}\u{6c}\u{65}\u{6e}\u{63}\u{6f}\u{64}\u{65}\u{64}\u{3b}\u{63}\u{68}\u{61}\u{72}\u{73}\u{65}\u{74}\u{3d}\u{75}\u{74}\u{66}\u{2d}\u{38}",
            forHTTPHeaderField: "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{54}\u{79}\u{70}\u{65}"
        )
        request.setValue("\u{67}\u{7a}\u{69}\u{70}", forHTTPHeaderField: "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{45}\u{6e}\u{63}\u{6f}\u{64}\u{69}\u{6e}\u{67}")
        request.setValue(LjmjUaFraWCnXMcEO.yARuYxPxHRneqiyaFw(), forHTTPHeaderField: "\u{55}\u{73}\u{65}\u{72}\u{2d}\u{41}\u{67}\u{65}\u{6e}\u{74}")

        guard let (responseData, response) = try? await URLSession.shared.data(for: request),
              let http = response as? HTTPURLResponse,
              200...299 ~= http.statusCode else {
            return .failed
        }

        return vBnlcgVTQhuLatVx(responseData)
    }

    private static func kSvbYhJvISZdijUY(_ url: String) async throws -> [VeiHztjEDahyOlz] {
        let text = try await IuxSvVTOJSaoL.cNJgXwioDBtXJLbOeA(
            url,
            headers: [
                "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{54}\u{79}\u{70}\u{65}": "\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{78}\u{2d}\u{77}\u{77}\u{77}\u{2d}\u{66}\u{6f}\u{72}\u{6d}\u{2d}\u{75}\u{72}\u{6c}\u{65}\u{6e}\u{63}\u{6f}\u{64}\u{65}\u{64}\u{3b}\u{63}\u{68}\u{61}\u{72}\u{73}\u{65}\u{74}\u{3d}\u{75}\u{74}\u{66}\u{2d}\u{38}",
                "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{45}\u{6e}\u{63}\u{6f}\u{64}\u{69}\u{6e}\u{67}": "\u{67}\u{7a}\u{69}\u{70}"
            ]
        )

        guard let data = text.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return []
        }

        return OhnVhNhHmdQPxAVEk.eHGUeaScAHiG(json)
    }

    private static func mLlbRsLPkLvIMxw(_ params: [(String, String)]) -> String {
        params
            .filter { $0.0 != "\u{73}\u{69}\u{67}\u{6e}" }
            .sorted { $0.0 == $1.0 ? $0.1 < $1.1 : $0.0 < $1.0 }
            .map { "\(tCvKlXLvhITVRlDryxvT($0.0))\u{3d}\(tCvKlXLvhITVRlDryxvT($0.1))" }
            .joined(separator: "\u{26}")
    }

    static func dJiUvSNhEkdjNbEMu(videoPath: String) -> [VeiHztjEDahyOlz] {
        guard let url = oGEYsKEnityFKdI(videoPath: videoPath),
              let data = try? Data(contentsOf: url) else {
            return []
        }

        return OhnVhNhHmdQPxAVEk.aWKGUIXOCwSgeVRU(data)
    }

    static func oXqMGOjIlUuQmldEI(_ raw: String?) -> [String] {
        guard let raw else { return [] }
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return [] }

        guard trimmed.hasPrefix("\u{5b}") else { return [trimmed] }

        guard let data = trimmed.data(using: .utf8),
              let list = try? JSONSerialization.jsonObject(with: data) as? [Any] else {
            return []
        }

        return list.compactMap { $0 as? String }.filter { !$0.isEmpty }
    }

    static func mSPdHfgBrknIFudyTNhN(context: WlPVPRGhJhvIqTiUaxGw) async -> [VeiHztjEDahyOlz] {
        
        if context.zypath.isEmpty || MmFhbrLqPylfz.yDULAPGplPIQSewvhMuf(context.playURL) || context.playURL.hasPrefix("\u{66}\u{69}\u{6c}\u{65}\u{3a}") {
            return dJiUvSNhEkdjNbEMu(videoPath: context.playURL)
        }

        
        await AzqCURaEoPGpgIYOF.vMjlwSWYSxtpQctaRnSO()

        guard isMasterSwitchOn else {
            return []
        }

        for url in pZYcMjTgsCLxv(context: context) {
            if let items = try? await kSvbYhJvISZdijUY(url), !items.isEmpty {
                return items
            }
        }

        return []
    }

    static func bXPBLVzsHUhrdyhx(_ items: [VeiHztjEDahyOlz], to directory: URL) {
        guard let data = OhnVhNhHmdQPxAVEk.mJVnppbtBwinkMa(items) else { return }

        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        try? data.write(to: directory.appendingPathComponent("\u{64}\u{61}\u{6e}\u{6d}\u{61}\u{6b}\u{75}\u{2e}\u{6a}\u{73}\u{6f}\u{6e}"))
    }

    private static func hRviWFASaZIWMnhsvD(api: String, title: String, gAnSZJKWRXAmnpyvYK: Int) -> String? {
        guard var components = URLComponents(string: api) else { return nil }

        let params: [(String, String)] = [
            ("\u{6e}\u{61}\u{6d}\u{65}", title),
            ("\u{65}\u{70}\u{69}\u{73}\u{6f}\u{64}\u{65}", String(gAnSZJKWRXAmnpyvYK)),
            ("\u{74}\u{73}", String(Int(Date().timeIntervalSince1970 * 1000))),
            ("\u{6e}\u{6f}\u{6e}\u{63}\u{65}", aHWrGOQFFVgQtYMfUREe())
        ]

        let bodyHash = QxmEAOwBLRLGNSse.hJJwgtqMKWiomlzdaTl("")
        let query = mLlbRsLPkLvIMxw(params)
        let payload = "\u{47}\u{45}\u{54}\n\(components.path)\n\(query)\n\(bodyHash)"

        guard let sign = try? QxmEAOwBLRLGNSse.sIdWSDfAneSvMSNMES(payload, secret: signSecret) else {
            return nil
        }

        components.queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
            + [URLQueryItem(name: "\u{73}\u{69}\u{67}\u{6e}", value: sign)]

        return components.url?.absoluteString
    }
}
