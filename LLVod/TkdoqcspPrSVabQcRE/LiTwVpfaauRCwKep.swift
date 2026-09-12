







import SwiftUI

struct RfadHHbYkHmQHUVgeNU: View {

    let info: JtekaluVnEPfuBNeJE
    var jSLorqXgbbAiOQV: () -> Void
    var sTSemucQBxbCBqjMdNBi: (() -> Void)?

    @EnvironmentObject private var themeManager: CbyiPVoRONUJO

    var body: some View {
        
        xTcRuvXrbFbHzfvTej()
    }

    
    @ViewBuilder
    @inline(never)
    private func xTcRuvXrbFbHzfvTej() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.gIQXuzgbMLydaMIPZwD()

        aQvyieIjMzBzMnRnhxV
    }

    @ViewBuilder
    private var aQvyieIjMzBzMnRnhxV: some View {
        ZStack {
            gWtAayYAiSGkSdOqn

            jLxRhpSphLJdou
        }
    }


    @ViewBuilder
    private var gWtAayYAiSGkSdOqn: some View {
        Color.black.opacity(0.5)
                .ignoresSafeArea()
                
                .allowsHitTesting(true)
    }

    @ViewBuilder
    private var jLxRhpSphLJdou: some View {
        VStack(spacing: 0) {
                
                LinearGradient(
                    colors: [
                        themeManager.mainTheme.primary,
                        themeManager.mainTheme.primary.opacity(0.75)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 72)
                .overlay(
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{51}\u{71}\u{71}\u{6f}\u{4c}\u{37}\u{52}\u{50}"))
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                )

                VStack(alignment: .leading, spacing: 12) {
                    Text(info.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)

                    ScrollView {
                        Text(info.bodyText.isEmpty ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{59}\u{39}\u{76}\u{37}\u{47}\u{32}\u{4b}\u{72}") : info.bodyText)
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxHeight: 180)

                    Button(action: jSLorqXgbbAiOQV) {
                        Text(info.updateButtonTitle)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(themeManager.mainTheme.primary)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)

                    if !info.isForce {
                        Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{5a}\u{64}\u{70}\u{43}\u{50}\u{37}\u{70}\u{63}")) {
                            sTSemucQBxbCBqjMdNBi?()
                        }
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 2)
                        .padding(.bottom, 4)
                    }
                }
                .padding(18)
            }
            .frame(width: 290)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(.systemBackground))
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: .black.opacity(0.2), radius: 16, y: 8)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func gIQXuzgbMLydaMIPZwD() -> String {
        let base = (18 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 18) * 9
        let token = "\u{65}\u{64}\u{30}\u{35}\u{36}\u{35}\u{62}\u{62}\u{64}\u{34}\u{36}\u{33}\u{62}\u{64}\u{36}\u{32}\u{65}\u{36}\u{64}\u{61}\u{34}\u{31}\u{34}\u{64}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}

