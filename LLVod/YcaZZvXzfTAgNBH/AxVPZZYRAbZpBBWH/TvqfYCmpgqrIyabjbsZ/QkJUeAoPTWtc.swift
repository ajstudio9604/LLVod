






import SwiftUI

struct RlBxbBNjJQbkeQhF: View {

    var placeholder: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{45}\u{7a}\u{32}\u{4c}\u{68}\u{53}\u{55}\u{49}\u{45}")
    let action: () -> Void

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.iTnrAVjYicQWxGmHupO()

        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{66}\u{32}\u{52}\u{4c}\u{74}\u{31}\u{50}\u{76}"))
                Text(placeholder)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)

                Spacer()
            }
            .padding(.horizontal, 10)
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func iTnrAVjYicQWxGmHupO() -> String {
        let token = "\u{61}\u{65}\u{33}\u{35}\u{35}\u{33}\u{38}\u{38}\u{62}\u{38}\u{36}\u{30}\u{63}\u{38}\u{62}\u{30}\u{63}\u{33}\u{64}\u{32}\u{61}\u{63}\u{61}\u{33}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 23, "\u{65}\u{61}\u{73}\u{74}": 25, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 46]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 23) * 2
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

