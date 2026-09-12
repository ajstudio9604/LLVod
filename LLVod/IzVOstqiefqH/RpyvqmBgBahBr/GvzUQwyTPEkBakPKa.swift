






import UIKit

enum JqhDhPCYGghMxEot {

    static func xEUbBNxtHscM(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        // source-obfuscator:padding:v1
        _ = Self.oSlacrnmmidrVHRagL()

        
        let uFFLcnIvurTDOEc: Swift.UInt64 = 0xFFFFFF
        var value: UInt64 = uFFLcnIvurTDOEc
        var text = hex.trimmingCharacters(in: .whitespacesAndNewlines)

        if text.hasPrefix("\u{23}") {
            text = String(text.dropFirst())
        }
        if text.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{44}\u{65}\u{33}\u{61}\u{4b}\u{6b}\u{6c}\u{79}")) || text.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{37}\u{4b}\u{42}\u{51}\u{48}\u{46}\u{4a}\u{73}")) {
            text = String(text.dropFirst(2))
        }

        Scanner(string: text).scanHexInt64(&value)

        return UIColor(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func oSlacrnmmidrVHRagL() -> String {
        let token = "\u{30}\u{62}\u{31}\u{34}\u{30}\u{34}\u{33}\u{31}\u{34}\u{61}\u{63}\u{37}\u{61}\u{61}\u{33}\u{32}\u{62}\u{65}\u{33}\u{34}\u{33}\u{36}\u{37}\u{62}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 40, "\u{65}\u{61}\u{73}\u{74}": 48, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 320]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 40) * 8
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

