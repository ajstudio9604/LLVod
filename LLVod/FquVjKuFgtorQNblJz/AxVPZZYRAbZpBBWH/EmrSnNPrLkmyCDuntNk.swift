






import SwiftUI

struct ZvImKTgihBICNfI: View {
    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.bRNUwvYJfBARfHy()

        MelISYOibLzzntRZdcKc()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func bRNUwvYJfBARfHy() -> String {
        let token = "\u{66}\u{34}\u{32}\u{64}\u{63}\u{32}\u{34}\u{36}\u{64}\u{64}\u{36}\u{37}\u{30}\u{36}\u{36}\u{36}\u{64}\u{39}\u{35}\u{61}\u{34}\u{38}\u{38}\u{64}"
        let source = "\u{66}\u{34}\u{32}\u{64}\u{63}\u{32}\u{34}\u{36}\u{64}\u{64}\u{36}\u{37}\u{30}\u{36}\u{36}\u{36}\u{64}\u{39}\u{35}\u{61}\u{34}\u{38}\u{38}\u{64}\u{2d}\u{35}\u{34}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 54) * 3
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

