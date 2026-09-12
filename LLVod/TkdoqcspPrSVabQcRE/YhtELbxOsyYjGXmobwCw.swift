




import SwiftUI

extension View {
    @ViewBuilder
    func ahDismissKeyboardOnScroll() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.xIwaYCiuxssiiZTABz()

        if #available(iOS 16.0, *) {
            scrollDismissesKeyboard(.immediately)
        } else {
            self
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func xIwaYCiuxssiiZTABz() -> String {
        let values = [30, 33, 90, 47]
        let folded = values.map { ($0 * 3 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 30) * 3
        let token = "\u{36}\u{34}\u{32}\u{63}\u{63}\u{31}\u{35}\u{64}\u{33}\u{34}\u{62}\u{36}\u{38}\u{61}\u{65}\u{35}\u{62}\u{35}\u{65}\u{63}\u{64}\u{34}\u{35}\u{32}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}

