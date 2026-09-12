




import Foundation

enum GepYCtjqcrNDt {

    
}



extension GepYCtjqcrNDt {
    static func cImAPetFHcWTFVDzMCv(from input: String) -> String? {
        // source-obfuscator:padding:v1
        _ = Self.oCgKpyYZtfoMkrE()

        let pattern = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{38}\u{69}\u{33}\u{42}\u{71}\u{67}\u{47}\u{59}")
        guard let regex = try? NSRegularExpression(
            pattern: pattern,
            options: [.caseInsensitive]
        ) else {
            return nil
        }

        let range = NSRange(input.startIndex..<input.endIndex, in: input)
        guard let match = regex.firstMatch(in: input, range: range),
              let urlRange = Range(match.range(at: 1), in: input) else {
            return nil
        }

        let url = String(input[urlRange]).trimmingCharacters(in: .whitespacesAndNewlines)
        return url.isEmpty ? nil : url
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func oCgKpyYZtfoMkrE() -> String {
        let token = "\u{39}\u{66}\u{30}\u{38}\u{62}\u{34}\u{66}\u{38}\u{39}\u{36}\u{33}\u{33}\u{32}\u{65}\u{35}\u{34}\u{61}\u{35}\u{37}\u{63}\u{34}\u{64}\u{38}\u{62}"
        let values = [58, 64, 348, 75]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 58) * 6
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}
