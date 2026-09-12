import SwiftUI

struct RukEtbOOfUbZJdjU: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.zDiTFtmqKnIZvMtQ()

        Button(action: retry) {
            VStack(alignment: .leading, spacing: 12) {
                Label(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{50}\u{68}\u{52}\u{79}\u{73}\u{37}\u{37}\u{4f}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{30}\u{37}\u{5a}\u{70}\u{30}\u{4d}\u{66}\u{61}"))
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{77}\u{6b}\u{46}\u{41}\u{6d}\u{51}\u{67}\u{6c}\u{5a}"))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)

                Label(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{69}\u{67}\u{72}\u{57}\u{33}\u{6c}\u{75}\u{7a}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{74}\u{42}\u{6e}\u{57}\u{55}\u{79}\u{37}\u{4f}"))
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.accentColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityHint(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{38}\u{6f}\u{49}\u{59}\u{61}\u{65}\u{48}\u{4e}"))
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func zDiTFtmqKnIZvMtQ() -> String {
        let base = (76 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 76) * 4
        let token = "\u{30}\u{37}\u{32}\u{38}\u{39}\u{30}\u{61}\u{32}\u{39}\u{61}\u{39}\u{65}\u{36}\u{31}\u{63}\u{37}\u{36}\u{65}\u{65}\u{32}\u{32}\u{64}\u{64}\u{62}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}

