






import SwiftUI

struct DwChOYcaotVZnACLRh: View {

    let info: KeQvvjmQCvsYeVNH
    var eJUpagJkvjWJwD: () -> Void
    var mPZrHsJtAgry: () -> Void

    @EnvironmentObject private var themeManager: CbyiPVoRONUJO

    var body: some View {
        
        xBMNKZxLZUUfTVFkES()
    }

    
    @ViewBuilder
    @inline(never)
    private func xBMNKZxLZUUfTVFkES() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.zYWOdcMXYWmNWd()

        xTldkYmWAxLfjwJLou
    }

    @ViewBuilder
    private var xTldkYmWAxLfjwJLou: some View {
        ZStack {
            cCeUxfvgLOSjIkOkJaEt

            lHOflHNOVIUYkZuIS
        }
    }


    @ViewBuilder
    private var cCeUxfvgLOSjIkOkJaEt: some View {
        Color.black.opacity(0.45)
                .ignoresSafeArea()
    }

    @ViewBuilder
    private var lHOflHNOVIUYkZuIS: some View {
        VStack(spacing: 0) {
                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{61}\u{30}\u{69}\u{48}\u{6d}\u{63}\u{4e}\u{4e}"))
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
                    .padding(.top, 20)
                    .padding(.bottom, 12)

                ScrollView {
                    Text(info.content)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 18)
                }
                .frame(maxHeight: 260)

                Divider().padding(.top, 14)

                HStack(spacing: 0) {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{36}\u{30}\u{43}\u{6c}\u{38}\u{6b}\u{4a}\u{31}")) {
                        mPZrHsJtAgry()
                    }
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)

                    Divider().frame(height: 44)

                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{61}\u{35}\u{43}\u{61}\u{72}\u{46}\u{6f}\u{53}")) {
                        eJUpagJkvjWJwD()
                    }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(themeManager.mainTheme.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                }
            }
            .frame(width: 300)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(.systemBackground))
            )
            .padding(.horizontal, 28)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func zYWOdcMXYWmNWd() -> String {
        let token = "\u{65}\u{30}\u{32}\u{64}\u{62}\u{37}\u{33}\u{65}\u{62}\u{34}\u{33}\u{39}\u{64}\u{66}\u{64}\u{30}\u{64}\u{63}\u{31}\u{37}\u{39}\u{62}\u{33}\u{65}"
        let values = [46, 53, 322, 63]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 46) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

