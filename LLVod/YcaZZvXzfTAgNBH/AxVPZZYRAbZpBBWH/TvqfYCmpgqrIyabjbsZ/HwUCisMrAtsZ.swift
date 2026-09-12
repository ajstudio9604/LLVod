






import SwiftUI

enum UhQdrGVmfViYYgQaF {
    static let accent = Color(red: 18 / 255, green: 183 / 255, blue: 106 / 255)
    static let accentSoft = Color(red: 18 / 255, green: 183 / 255, blue: 106 / 255).opacity(0.14)
    static let divider = Color(.separator).opacity(0.5)
}

struct GlMabcCxtASnmbkI: View {

    let url: String
    var size: CGFloat = 30

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.qMGuALrojEvcqZck()

        Group {
            if let imageURL = URL(string: url), !url.isEmpty {
                EtXjBLbNYUbhXfeKeH(url: imageURL)
            } else {
                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{57}\u{44}\u{32}\u{51}\u{63}\u{65}\u{69}\u{4f}\u{37}"))
                    .resizable()
                    .foregroundColor(Color(.tertiaryLabel))
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qMGuALrojEvcqZck() -> String {
        let token = "\u{37}\u{64}\u{64}\u{33}\u{36}\u{65}\u{63}\u{37}\u{38}\u{37}\u{36}\u{30}\u{64}\u{62}\u{62}\u{35}\u{37}\u{62}\u{31}\u{32}\u{30}\u{39}\u{33}\u{38}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 95, "\u{65}\u{61}\u{73}\u{74}": 102, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 665]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 95) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

