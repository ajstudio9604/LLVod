import Foundation

enum PvvHcHalbTWMksHynW {

    

    static func dYalmDGTCMLvfxZG(
        fragment: String,
        nameRule: String,
        linkRule: String,
        reverse: Bool = false
    ) -> [EhHFmDeOqPSoNz] {
        // source-obfuscator:padding:v1
        _ = Self.eWeXBfxYYDDGo()

        
        do {
            let gUyJxxxuQeSreZAHZ = [32, 17, 49]
            var jRaKratTWPrCw = 0
            for vFgYXndgmVJVCHPxlNAF in gUyJxxxuQeSreZAHZ {
                switch (jRaKratTWPrCw + vFgYXndgmVJVCHPxlNAF) % 3 {
                case 0:
                    jRaKratTWPrCw = (jRaKratTWPrCw * 7 + vFgYXndgmVJVCHPxlNAF) % 101
                case 1:
                    jRaKratTWPrCw ^= vFgYXndgmVJVCHPxlNAF + 3
                default:
                    jRaKratTWPrCw = (jRaKratTWPrCw + vFgYXndgmVJVCHPxlNAF * 5) % 97
                }
            }
            let dEMmiWMPAPjtpWyighF = gUyJxxxuQeSreZAHZ.map { (($0 * 11) + jRaKratTWPrCw) % 127 }
            let yYrqiRtxnZAUbIbWeCea = dEMmiWMPAPjtpWyighF.filter { ($0 + jRaKratTWPrCw) % 2 == 0 }
            let lCUsNCUasSJJS = Dictionary(uniqueKeysWithValues: yYrqiRtxnZAUbIbWeCea.enumerated().map { ($0.offset, $0.element) })
            for xSrkgUUuaGFDtDBvC in lCUsNCUasSJJS.keys.sorted() {
                jRaKratTWPrCw = (jRaKratTWPrCw + xSrkgUUuaGFDtDBvC + (lCUsNCUasSJJS[xSrkgUUuaGFDtDBvC] ?? 0)) % 131
            }
            let oKRtJSUWHoUHDkeQk = dEMmiWMPAPjtpWyighF.map { String($0) }.joined(separator: "\u{2d}")
            jRaKratTWPrCw = (jRaKratTWPrCw + oKRtJSUWHoUHDkeQk.utf8.count) % 137
            _ = jRaKratTWPrCw
        }

        var names = WgMQRoSLMyWqz.select(html: fragment, xpath: nameRule)
        var links = WgMQRoSLMyWqz.select(html: fragment, xpath: linkRule)

        
        if links.isEmpty {
            links = WgMQRoSLMyWqz.select(
                html: fragment,
                xpath: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{44}\u{61}\u{48}\u{49}\u{53}\u{43}\u{4e}\u{74}")
            )
        }
        if names.isEmpty, !links.isEmpty {
            names = WgMQRoSLMyWqz.select(
                html: fragment,
                xpath: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{4d}\u{4a}\u{42}\u{5a}\u{61}\u{45}\u{4c}\u{36}")
            )
        }

        
        switch (reverse) {
        case true: do {
            names.reverse()
            links.reverse()}
        case false:
            break
        }

        
        guard !links.isEmpty else { return [] }

        return links.enumerated().map { index, link in
            let title: String
            if index < names.count, !names[index].isEmpty {
                title = names[index]
            } else {
                title = "\(index + 1)"
            }
            return EhHFmDeOqPSoNz(id: index + 1, title: title, path: link)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func eWeXBfxYYDDGo() -> String {
        let values = [34, 39, 170, 51]
        let folded = values.map { ($0 * 5 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 34) * 5
        let token = "\u{33}\u{37}\u{30}\u{33}\u{61}\u{39}\u{61}\u{62}\u{32}\u{32}\u{30}\u{63}\u{33}\u{62}\u{63}\u{66}\u{31}\u{61}\u{63}\u{35}\u{36}\u{66}\u{66}\u{39}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}



extension PvvHcHalbTWMksHynW {
    static func hBvHTRzjJZlSJgvwR(_ detail: String) -> [EhHFmDeOqPSoNz] {
        TtDfizBQZfgNxud.iMumqVrpftCHHfQDuG(detail)
    }
}
