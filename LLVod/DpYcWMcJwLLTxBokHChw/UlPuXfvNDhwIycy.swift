






import SwiftUI

struct YcXNMyaFWaZfUY: View {
    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.nCWfwNKwliFYPMW()

        RaMNtCONlhEwDycUH()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func nCWfwNKwliFYPMW() -> String {
        let token = "\u{34}\u{31}\u{33}\u{37}\u{62}\u{61}\u{38}\u{63}\u{37}\u{62}\u{38}\u{38}\u{66}\u{66}\u{31}\u{61}\u{66}\u{38}\u{39}\u{34}\u{35}\u{34}\u{63}\u{39}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{34}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 4) * 8
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

#Preview {
    YcXNMyaFWaZfUY()
}

