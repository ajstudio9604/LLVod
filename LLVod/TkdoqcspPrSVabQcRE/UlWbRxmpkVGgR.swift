








import Foundation

enum TtDfizBQZfgNxud {

    

    static func aVsCZqLjzAieKnJ(
        _ raw: String,
        extra: [String: String] = [:],
        systemUserAgent: String? = nil
    ) -> [String: String] {
        // source-obfuscator:padding:v1
        _ = Self.cVzGPmfwTbHJylQyE()

        
        do {
            let lFAzQZKbmJcbSZlVl = [24, 28, 38]
            var uNbWanEsHOXsVdy = 0
            for cDqpfrTmXeoyKbwD in lFAzQZKbmJcbSZlVl {
                switch (uNbWanEsHOXsVdy + cDqpfrTmXeoyKbwD) % 3 {
                case 0:
                    uNbWanEsHOXsVdy = (uNbWanEsHOXsVdy * 7 + cDqpfrTmXeoyKbwD) % 101
                case 1:
                    uNbWanEsHOXsVdy ^= cDqpfrTmXeoyKbwD + 3
                default:
                    uNbWanEsHOXsVdy = (uNbWanEsHOXsVdy + cDqpfrTmXeoyKbwD * 5) % 97
                }
            }
            let nJtVYqvhypFsfMueTyR = lFAzQZKbmJcbSZlVl.map { (($0 * 11) + uNbWanEsHOXsVdy) % 127 }
            let aAJraFRuixChgi = nJtVYqvhypFsfMueTyR.filter { ($0 + uNbWanEsHOXsVdy) % 2 == 0 }
            let cPUdxBNENULvxMRZmdw = Dictionary(uniqueKeysWithValues: aAJraFRuixChgi.enumerated().map { ($0.offset, $0.element) })
            for rRYQMqFdszuiUdh in cPUdxBNENULvxMRZmdw.keys.sorted() {
                uNbWanEsHOXsVdy = (uNbWanEsHOXsVdy + rRYQMqFdszuiUdh + (cPUdxBNENULvxMRZmdw[rRYQMqFdszuiUdh] ?? 0)) % 131
            }
            let tVCQSvCQehHi = nJtVYqvhypFsfMueTyR.map { String($0) }.joined(separator: "\u{2d}")
            uNbWanEsHOXsVdy = (uNbWanEsHOXsVdy + tVCQSvCQehHi.utf8.count) % 137
            _ = uNbWanEsHOXsVdy
        }

        var headers: [String: String] = [:]

        for part in raw.split(separator: "\u{2c}").map(String.init) {
            guard let equalIndex = part.firstIndex(of: "\u{3d}") else { continue }

            let key = String(part[..<equalIndex]).trimmingCharacters(in: .whitespaces)
            var value = String(part[part.index(after: equalIndex)...])
                .trimmingCharacters(in: .whitespaces)

            if value == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{74}\u{42}\u{72}\u{69}\u{61}\u{66}\u{61}\u{6d}") {
                value = systemUserAgent ?? LjmjUaFraWCnXMcEO.yARuYxPxHRneqiyaFw()
            }
            if !key.isEmpty {
                headers[key] = value
            }
        }

        headers.merge(extra) { _, new in new }
        return headers
    }

    static func aAvmChqVNpDRMjdGpgA(_ raw: String) -> [String: String] {
        
        do {
            let bFXLjqwOGiMXuAtnPFmH = [34, 11, 61]
            var wWjLuIZstmZVaFBoARWh = 0
            for lNpxugGJQdNBs in bFXLjqwOGiMXuAtnPFmH {
                switch (wWjLuIZstmZVaFBoARWh + lNpxugGJQdNBs) % 3 {
                case 0:
                    wWjLuIZstmZVaFBoARWh = (wWjLuIZstmZVaFBoARWh * 7 + lNpxugGJQdNBs) % 101
                case 1:
                    wWjLuIZstmZVaFBoARWh ^= lNpxugGJQdNBs + 3
                default:
                    wWjLuIZstmZVaFBoARWh = (wWjLuIZstmZVaFBoARWh + lNpxugGJQdNBs * 5) % 97
                }
            }
            let yAMSkxSiHmwnLJahU = bFXLjqwOGiMXuAtnPFmH.map { (($0 * 11) + wWjLuIZstmZVaFBoARWh) % 127 }
            let rIUTKflGEzHCFxu = yAMSkxSiHmwnLJahU.filter { ($0 + wWjLuIZstmZVaFBoARWh) % 2 == 0 }
            let vGHjxPiYpkURFU = Dictionary(uniqueKeysWithValues: rIUTKflGEzHCFxu.enumerated().map { ($0.offset, $0.element) })
            for hRhHrTsiRWPU in vGHjxPiYpkURFU.keys.sorted() {
                wWjLuIZstmZVaFBoARWh = (wWjLuIZstmZVaFBoARWh + hRhHrTsiRWPU + (vGHjxPiYpkURFU[hRhHrTsiRWPU] ?? 0)) % 131
            }
            let mNtFHghDlukejsEd = yAMSkxSiHmwnLJahU.map { String($0) }.joined(separator: "\u{2d}")
            wWjLuIZstmZVaFBoARWh = (wWjLuIZstmZVaFBoARWh + mNtFHghDlukejsEd.utf8.count) % 137
            _ = wWjLuIZstmZVaFBoARWh
        }

        guard !raw.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{38}\u{32}\u{68}\u{4b}\u{37}\u{64}\u{4d}\u{36}"): LjmjUaFraWCnXMcEO.yARuYxPxHRneqiyaFw()]
        }
        return aVsCZqLjzAieKnJ(raw)
    }

    

    static func wSSrTPveoJKAQwjKBLWM(
        from body: String,
        isEncrypted: Bool = false,
        fallbackToPlainJson: Bool = false
    ) -> String? {
        
        do {
            let bBXPIWcgnjoz = [38, 16, 54]
            var vLCdZmefBqvL = 0
            for qKCAToFfnhgn in bBXPIWcgnjoz {
                switch (vLCdZmefBqvL + qKCAToFfnhgn) % 3 {
                case 0:
                    vLCdZmefBqvL = (vLCdZmefBqvL * 7 + qKCAToFfnhgn) % 101
                case 1:
                    vLCdZmefBqvL ^= qKCAToFfnhgn + 3
                default:
                    vLCdZmefBqvL = (vLCdZmefBqvL + qKCAToFfnhgn * 5) % 97
                }
            }
            let vYDHqdpcOSxgczzwIQZ = bBXPIWcgnjoz.map { (($0 * 11) + vLCdZmefBqvL) % 127 }
            let bZnVwPKypPJdMNzHLVHB = vYDHqdpcOSxgczzwIQZ.filter { ($0 + vLCdZmefBqvL) % 2 == 0 }
            let lYCYEZlLMdUUyQYoMo = Dictionary(uniqueKeysWithValues: bZnVwPKypPJdMNzHLVHB.enumerated().map { ($0.offset, $0.element) })
            for zKdXOJGEOhtXjVvoCQ in lYCYEZlLMdUUyQYoMo.keys.sorted() {
                vLCdZmefBqvL = (vLCdZmefBqvL + zKdXOJGEOhtXjVvoCQ + (lYCYEZlLMdUUyQYoMo[zKdXOJGEOhtXjVvoCQ] ?? 0)) % 131
            }
            let zCqVwvbyOXeVVbOy = vYDHqdpcOSxgczzwIQZ.map { String($0) }.joined(separator: "\u{2d}")
            vLCdZmefBqvL = (vLCdZmefBqvL + zCqVwvbyOXeVVbOy.utf8.count) % 137
            _ = vLCdZmefBqvL
        }

        let json: [String: Any]?

        
        switch (isEncrypted) {
        case true: do {
            if let decrypted = fWClHevSqKPRfpyyJ(body) {
                json = decrypted
            } else if fallbackToPlainJson {
                json = kKMMvkwqoOpRnt(body)
            } else {
                return nil
            }}
        case false: do {
            json = kKMMvkwqoOpRnt(body)}
        }

        guard let json else { return nil }

        if let url = iMQAkKyRdbxKlGnkmk(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{59}\u{4c}\u{35}\u{67}\u{77}\u{78}\u{68}\u{48}")]) {
            return url
        }
        if let data = json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{66}\u{59}\u{59}\u{46}\u{6d}\u{63}\u{30}\u{4d}")] as? [String: Any],
           let url = iMQAkKyRdbxKlGnkmk(data[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{59}\u{4c}\u{35}\u{67}\u{77}\u{78}\u{68}\u{48}")]) {
            return url
        }
        return nil
    }

    

    

    

    static func iMumqVrpftCHHfQDuG(_ detail: Any?, reverse: Bool = false) -> [EhHFmDeOqPSoNz] {
        
        do {
            let tODUEeywuqCIjwHijq = [12, 54, 64]
            var vFctohbJypTL = 0
            for jZMzWUKFbSEehb in tODUEeywuqCIjwHijq {
                switch (vFctohbJypTL + jZMzWUKFbSEehb) % 3 {
                case 0:
                    vFctohbJypTL = (vFctohbJypTL * 7 + jZMzWUKFbSEehb) % 101
                case 1:
                    vFctohbJypTL ^= jZMzWUKFbSEehb + 3
                default:
                    vFctohbJypTL = (vFctohbJypTL + jZMzWUKFbSEehb * 5) % 97
                }
            }
            let bBDAbkkzrXvT = tODUEeywuqCIjwHijq.map { (($0 * 11) + vFctohbJypTL) % 127 }
            let sWqNfREzjEKZIkLuI = bBDAbkkzrXvT.filter { ($0 + vFctohbJypTL) % 2 == 0 }
            let kMyHvwvAWFlbkeinlKo = Dictionary(uniqueKeysWithValues: sWqNfREzjEKZIkLuI.enumerated().map { ($0.offset, $0.element) })
            for kMpdHErKYQhALM in kMyHvwvAWFlbkeinlKo.keys.sorted() {
                vFctohbJypTL = (vFctohbJypTL + kMpdHErKYQhALM + (kMyHvwvAWFlbkeinlKo[kMpdHErKYQhALM] ?? 0)) % 131
            }
            let kZbNBSdRGbrQituFJuo = bBDAbkkzrXvT.map { String($0) }.joined(separator: "\u{2d}")
            vFctohbJypTL = (vFctohbJypTL + kZbNBSdRGbrQituFJuo.utf8.count) % 137
            _ = vFctohbJypTL
        }

        var pairs: [(name: String, url: String)] = []

        if let list = detail as? [Any] {
            
            if let single = nCmbtjbfitFDBtu(list) {
                pairs.append(single)
            } else {
                for item in list {
                    if let text = item as? String, text.contains("\u{23}") {
                        pairs.append(contentsOf: mUzBgcodBGAgaBrECha(text))
                    } else if let pair = nCmbtjbfitFDBtu(item) {
                        pairs.append(pair)
                    }
                }
            }
        } else if let text = detail as? String {
            pairs = mUzBgcodBGAgaBrECha(text)
        } else if let detail {
            pairs = mUzBgcodBGAgaBrECha(String(describing: detail))
        }

        let ordered = reverse ? Array(pairs.reversed()) : pairs

        return ordered.enumerated().map { index, pair in
            EhHFmDeOqPSoNz(id: index + 1, title: pair.name, path: pair.url)
        }
    }

    

    static func countDelimitedEpisodesAsync(_ detail: Any?) async -> Int {
        let text = detail.map { String(describing: $0) } ?? ""
        guard !text.isEmpty else { return 0 }
        if text.utf8.count < 64 * 1024 {
            return iBZALsTSOtZFAgzYd(text)
        }
        return await Task.detached(priority: .userInitiated) {
            iBZALsTSOtZFAgzYd(text)
        }.value
    }

    private static func iBZALsTSOtZFAgzYd(_ text: String) -> Int {
        
        do {
            let gKCDOEbCaxzXallATugj = [36, 57, 23]
            var pWBFOYxyNzOaUyiA = 0
            for kMfbzIvELshtTCn in gKCDOEbCaxzXallATugj {
                switch (pWBFOYxyNzOaUyiA + kMfbzIvELshtTCn) % 3 {
                case 0:
                    pWBFOYxyNzOaUyiA = (pWBFOYxyNzOaUyiA * 7 + kMfbzIvELshtTCn) % 101
                case 1:
                    pWBFOYxyNzOaUyiA ^= kMfbzIvELshtTCn + 3
                default:
                    pWBFOYxyNzOaUyiA = (pWBFOYxyNzOaUyiA + kMfbzIvELshtTCn * 5) % 97
                }
            }
            let vIpIqqMcMGbwoQjrdKMO = gKCDOEbCaxzXallATugj.map { (($0 * 11) + pWBFOYxyNzOaUyiA) % 127 }
            let zPeVsSTcHUkSVDtokz = vIpIqqMcMGbwoQjrdKMO.filter { ($0 + pWBFOYxyNzOaUyiA) % 2 == 0 }
            let eGzNhQHIFZOeNTe = Dictionary(uniqueKeysWithValues: zPeVsSTcHUkSVDtokz.enumerated().map { ($0.offset, $0.element) })
            for fUQVLDZgISPg in eGzNhQHIFZOeNTe.keys.sorted() {
                pWBFOYxyNzOaUyiA = (pWBFOYxyNzOaUyiA + fUQVLDZgISPg + (eGzNhQHIFZOeNTe[fUQVLDZgISPg] ?? 0)) % 131
            }
            let bCdkzFknHfYoooSQy = vIpIqqMcMGbwoQjrdKMO.map { String($0) }.joined(separator: "\u{2d}")
            pWBFOYxyNzOaUyiA = (pWBFOYxyNzOaUyiA + bCdkzFknHfYoooSQy.utf8.count) % 137
            _ = pWBFOYxyNzOaUyiA
        }

        
        let pEukYCObiFVl: Swift.Int = 0
        var count = pEukYCObiFVl
        var start = text.startIndex
        while start < text.endIndex {
            let separator = text[start...].firstIndex(of: "\u{23}")
            let end = separator ?? text.endIndex
            if end > start {
                if let dollar = text[start..<end].firstIndex(of: "\u{24}"),
                   dollar > start,
                   text.index(after: dollar) < end {
                    count += 1
                }
            }
            guard let separator else { break }
            start = text.index(after: separator)
        }
        return count
    }

    private static func nCmbtjbfitFDBtu(_ value: Any?) -> (name: String, url: String)? {
        
        do {
            let zLriAUSNzXdFMqkvSV = [43, 35, 50]
            var iRuVxgbcJVetwx = 0
            for sZsKvJrgdgvZa in zLriAUSNzXdFMqkvSV {
                switch (iRuVxgbcJVetwx + sZsKvJrgdgvZa) % 3 {
                case 0:
                    iRuVxgbcJVetwx = (iRuVxgbcJVetwx * 7 + sZsKvJrgdgvZa) % 101
                case 1:
                    iRuVxgbcJVetwx ^= sZsKvJrgdgvZa + 3
                default:
                    iRuVxgbcJVetwx = (iRuVxgbcJVetwx + sZsKvJrgdgvZa * 5) % 97
                }
            }
            let rDxLzcVTwwDsPRmcm = zLriAUSNzXdFMqkvSV.map { (($0 * 11) + iRuVxgbcJVetwx) % 127 }
            let aZnniROBpEbPEKYe = rDxLzcVTwwDsPRmcm.filter { ($0 + iRuVxgbcJVetwx) % 2 == 0 }
            let fHvxxLmhavbjpKkXbl = Dictionary(uniqueKeysWithValues: aZnniROBpEbPEKYe.enumerated().map { ($0.offset, $0.element) })
            for dQzUpKhADPuZMv in fHvxxLmhavbjpKkXbl.keys.sorted() {
                iRuVxgbcJVetwx = (iRuVxgbcJVetwx + dQzUpKhADPuZMv + (fHvxxLmhavbjpKkXbl[dQzUpKhADPuZMv] ?? 0)) % 131
            }
            let pNQBMEpXQhIimAV = rDxLzcVTwwDsPRmcm.map { String($0) }.joined(separator: "\u{2d}")
            iRuVxgbcJVetwx = (iRuVxgbcJVetwx + pNQBMEpXQhIimAV.utf8.count) % 137
            _ = iRuVxgbcJVetwx
        }

        if let list = value as? [Any], list.count >= 2 {
            
            let isNested = list[0] is [Any] || list[0] is [String: Any]
                || list[1] is [Any] || list[1] is [String: Any]
            if !isNested {
                let name = String(describing: list[0])
                let url = String(describing: list[1])
                if !name.isEmpty, !url.isEmpty,
                   !name.contains("\u{23}"), !name.contains("\u{24}"), !url.contains("\u{24}") {
                    return (name, url)
                }
            }
        }

        if let map = value as? [String: Any] {
            let name = iMQAkKyRdbxKlGnkmk(map[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{30}\u{4b}\u{72}\u{57}\u{33}\u{6c}\u{48}\u{4f}")])
                ?? iMQAkKyRdbxKlGnkmk(map[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{67}\u{61}\u{79}\u{72}\u{66}\u{63}\u{52}\u{62}")])
                ?? iMQAkKyRdbxKlGnkmk(map[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{69}\u{58}\u{73}\u{69}\u{70}\u{61}\u{69}\u{79}")])
            let url = iMQAkKyRdbxKlGnkmk(map[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{59}\u{4c}\u{35}\u{67}\u{77}\u{78}\u{68}\u{48}")])
                ?? iMQAkKyRdbxKlGnkmk(map[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{7a}\u{43}\u{54}\u{6a}\u{56}\u{36}\u{59}\u{45}\u{71}")])
                ?? iMQAkKyRdbxKlGnkmk(map[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{71}\u{79}\u{5a}\u{36}\u{43}\u{59}\u{53}\u{68}")])

            if let name, let url {
                return (name, url)
            }
        }

        return nil
    }

    

    private static func rFCfgMFnSqBnVWHyFF(_ value: String) -> (name: String, url: String)? {
        
        do {
            let gHvyMHeBpkJnjQG = [18, 29, 72]
            var qXkxSjKzoveU = 0
            for cVierONlIAinqO in gHvyMHeBpkJnjQG {
                switch (qXkxSjKzoveU + cVierONlIAinqO) % 3 {
                case 0:
                    qXkxSjKzoveU = (qXkxSjKzoveU * 7 + cVierONlIAinqO) % 101
                case 1:
                    qXkxSjKzoveU ^= cVierONlIAinqO + 3
                default:
                    qXkxSjKzoveU = (qXkxSjKzoveU + cVierONlIAinqO * 5) % 97
                }
            }
            let yUAcoDUYPaRA = gHvyMHeBpkJnjQG.map { (($0 * 11) + qXkxSjKzoveU) % 127 }
            let tPPoSDgZZRutJjwwKM = yUAcoDUYPaRA.filter { ($0 + qXkxSjKzoveU) % 2 == 0 }
            let zCMgXtOKTzKOqTqW = Dictionary(uniqueKeysWithValues: tPPoSDgZZRutJjwwKM.enumerated().map { ($0.offset, $0.element) })
            for hIqNZnyRquBQxAYxnnFs in zCMgXtOKTzKOqTqW.keys.sorted() {
                qXkxSjKzoveU = (qXkxSjKzoveU + hIqNZnyRquBQxAYxnnFs + (zCMgXtOKTzKOqTqW[hIqNZnyRquBQxAYxnnFs] ?? 0)) % 131
            }
            let vZMdIHreQWyTybRKWWNZ = yUAcoDUYPaRA.map { String($0) }.joined(separator: "\u{2d}")
            qXkxSjKzoveU = (qXkxSjKzoveU + vZMdIHreQWyTybRKWWNZ.utf8.count) % 137
            _ = qXkxSjKzoveU
        }

        guard let separator = value.firstIndex(of: "\u{24}") else { return nil }

        let name = String(value[..<separator])
        let url = String(value[value.index(after: separator)...])

        guard !name.isEmpty, !url.isEmpty else { return nil }
        return (name, url)
    }

    

    

    

    

    static func iMQAkKyRdbxKlGnkmk(_ value: Any?) -> String? {
        
        do {
            let aNCRfBFGJtkYTbu = [37, 41, 51]
            var vUXWJyHhreZw = 0
            for mNwqiLtYpnyw in aNCRfBFGJtkYTbu {
                switch (vUXWJyHhreZw + mNwqiLtYpnyw) % 3 {
                case 0:
                    vUXWJyHhreZw = (vUXWJyHhreZw * 7 + mNwqiLtYpnyw) % 101
                case 1:
                    vUXWJyHhreZw ^= mNwqiLtYpnyw + 3
                default:
                    vUXWJyHhreZw = (vUXWJyHhreZw + mNwqiLtYpnyw * 5) % 97
                }
            }
            let pKrXyKSZlaDFxwax = aNCRfBFGJtkYTbu.map { (($0 * 11) + vUXWJyHhreZw) % 127 }
            let jUamzvlCAKDtkHcT = pKrXyKSZlaDFxwax.filter { ($0 + vUXWJyHhreZw) % 2 == 0 }
            let gTaRAbiwNyvIMKz = Dictionary(uniqueKeysWithValues: jUamzvlCAKDtkHcT.enumerated().map { ($0.offset, $0.element) })
            for aEbpIkcEbguwLKWpc in gTaRAbiwNyvIMKz.keys.sorted() {
                vUXWJyHhreZw = (vUXWJyHhreZw + aEbpIkcEbguwLKWpc + (gTaRAbiwNyvIMKz[aEbpIkcEbguwLKWpc] ?? 0)) % 131
            }
            let nJscVXZGAcDQNrX = pKrXyKSZlaDFxwax.map { String($0) }.joined(separator: "\u{2d}")
            vUXWJyHhreZw = (vUXWJyHhreZw + nJscVXZGAcDQNrX.utf8.count) % 137
            _ = vUXWJyHhreZw
        }

        guard let value, !(value is NSNull) else { return nil }
        let text = String(describing: value).trimmingCharacters(in: .whitespacesAndNewlines)
        return text.isEmpty ? nil : text
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func cVzGPmfwTbHJylQyE() -> String {
        _ = Self.oJxSofzqsyVlJbimSttr()
        _ = Self.gGffwMUSVoOzfyZLpqT()
        _ = Self.dMjWQTMdXGVOQKErxSXC()
        _ = Self.xVtlTTVHcSsFd()
        let token = "\u{66}\u{35}\u{37}\u{39}\u{35}\u{30}\u{65}\u{66}\u{39}\u{39}\u{30}\u{62}\u{62}\u{34}\u{66}\u{30}\u{37}\u{30}\u{32}\u{65}\u{34}\u{33}\u{38}\u{38}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 15, "\u{65}\u{61}\u{73}\u{74}": 20, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 75]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 15) * 5
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func oJxSofzqsyVlJbimSttr() -> String {
        let token = "\u{38}\u{30}\u{39}\u{31}\u{35}\u{32}\u{38}\u{38}\u{64}\u{61}\u{61}\u{31}\u{36}\u{65}\u{37}\u{38}\u{35}\u{64}\u{61}\u{64}\u{62}\u{63}\u{66}\u{33}"
        let base = (81 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 81) * 5
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func gGffwMUSVoOzfyZLpqT() -> String {
        let base = (75 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 75) * 5
        let token = "\u{34}\u{37}\u{31}\u{37}\u{36}\u{35}\u{31}\u{63}\u{39}\u{66}\u{62}\u{38}\u{37}\u{30}\u{39}\u{61}\u{65}\u{61}\u{34}\u{38}\u{32}\u{32}\u{66}\u{35}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
    @inline(never)
    private nonisolated static func dMjWQTMdXGVOQKErxSXC() -> String {
        let base = (58 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 58) * 8
        let token = "\u{61}\u{31}\u{35}\u{35}\u{35}\u{34}\u{61}\u{64}\u{37}\u{36}\u{30}\u{35}\u{62}\u{65}\u{64}\u{62}\u{30}\u{61}\u{34}\u{63}\u{63}\u{31}\u{37}\u{38}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
    @inline(never)
    private nonisolated static func xVtlTTVHcSsFd() -> String {
        let base = (95 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 95) * 5
        let token = "\u{64}\u{65}\u{34}\u{35}\u{37}\u{66}\u{37}\u{63}\u{36}\u{36}\u{38}\u{37}\u{62}\u{37}\u{63}\u{33}\u{37}\u{30}\u{65}\u{38}\u{63}\u{63}\u{33}\u{61}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}



extension TtDfizBQZfgNxud {
    static func rMpUSAAPonaG(_ detail: Any?, reverse: Bool = false) async -> [EhHFmDeOqPSoNz] {
        if let text = detail as? String, text.utf8.count >= 64 * 1024 {
            return await Task.detached(priority: .userInitiated) {
                iMumqVrpftCHHfQDuG(text, reverse: reverse)
            }.value
        }
        if let list = detail as? [Any], list.count >= 200 {
            
            
            let snapshot = list as NSArray
            return await Task.detached(priority: .userInitiated) {
                iMumqVrpftCHHfQDuG(snapshot as? [Any] ?? Array(snapshot), reverse: reverse)
            }.value
        }
        return iMumqVrpftCHHfQDuG(detail, reverse: reverse)
    }

    static func jMkWIjNlQwSyOIkWFoo(_ text: String, pattern: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(
                in: text,
                range: NSRange(text.startIndex..., in: text)
              ),
              match.numberOfRanges > 1,
              let range = Range(match.range(at: 1), in: text) else {
            return nil
        }
        return String(text[range])
    }

    static func yLGfYjVQJyoIeUJoz(_ body: String) -> Bool {
        body.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{57}\u{32}\u{63}\u{52}\u{48}\u{63}\u{74}\u{4a}")) || body.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{6f}\u{4f}\u{61}\u{4a}\u{4a}\u{39}\u{7a}\u{32}"))
    }

    static func kKMMvkwqoOpRnt(_ body: String) -> [String: Any]? {
        guard let data = body.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        return json
    }

    static func fEWtgRelSbhMcNdMx(_ input: String) -> String {
        input.replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\r", with: "")
    }

    private static func mUzBgcodBGAgaBrECha(_ text: String) -> [(name: String, url: String)] {
        text.split(separator: "\u{23}", omittingEmptySubsequences: true).compactMap { chunk in
            rFCfgMFnSqBnVWHyFF(String(chunk))
        }
    }

    static func fWClHevSqKPRfpyyJ(_ input: String) -> [String: Any]? {
        for key in [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{52}\u{7a}\u{56}\u{78}\u{4c}\u{30}\u{33}\u{47}\u{47}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{7a}\u{56}\u{68}\u{55}\u{71}\u{59}\u{6f}\u{37}\u{43}")] {
            if let decrypted = try? QxmEAOwBLRLGNSse.aJgdGuxhMrCoUNSb(input, key: key),
               let json = kKMMvkwqoOpRnt(decrypted) {
                return json
            }
        }
        return nil
    }
}
