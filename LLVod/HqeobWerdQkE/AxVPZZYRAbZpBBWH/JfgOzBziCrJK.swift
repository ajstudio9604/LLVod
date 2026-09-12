




import SwiftUI

struct TnVcHIxhppSL: View {

    let summaryText: String
    var lNMIfmDYauJO: () -> Void

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.qEPJcunwvZNKLDGrzgP()

        Button(action: lNMIfmDYauJO) {
            HStack(spacing: 8) {
                Text(summaryText)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Spacer(minLength: 0)

                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{71}\u{6d}\u{48}\u{49}\u{41}\u{57}\u{44}\u{51}"))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
        }
        .buttonStyle(.plain)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qEPJcunwvZNKLDGrzgP() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 93, "\u{65}\u{61}\u{73}\u{74}": 102, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 837]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 93) * 9
        let token = "\u{33}\u{30}\u{33}\u{34}\u{30}\u{66}\u{33}\u{36}\u{31}\u{36}\u{36}\u{37}\u{33}\u{65}\u{33}\u{37}\u{64}\u{62}\u{35}\u{30}\u{64}\u{64}\u{36}\u{34}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}

