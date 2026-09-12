import SwiftUI

struct IloJXzhjSQiLYLgJ: View {
    let message: String
    let retry: () -> Void
    var pVxecARtNUxMkDEGrpuL: (() -> Void)?

    var body: some View {
        
        wPkuXMFhpCuBCObxXa()
    }

    
    @ViewBuilder
    @inline(never)
    private func wPkuXMFhpCuBCObxXa() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.tLFiDWRODgMBdNLsLE()

        cHdWCrgRfkzn
    }

    @ViewBuilder
    private var cHdWCrgRfkzn: some View {
        ZStack {
            fIzWiJfbinchVo

            hSNPLXOWlvxkQEdtsjC
        }
        .contentShape(Rectangle())
    }


    @ViewBuilder
    private var hSNPLXOWlvxkQEdtsjC: some View {
        VStack(spacing: 20) {
                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4c}\u{4a}\u{42}\u{59}\u{72}\u{70}\u{70}\u{4d}\u{6b}"))
                    .font(.system(size: 60))
                    .foregroundColor(.orange)

                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{32}\u{49}\u{46}\u{6e}\u{57}\u{38}\u{43}\u{39}"))
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .lineSpacing(4)

                Button(action: retry) {
                    Label(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{69}\u{67}\u{72}\u{57}\u{33}\u{6c}\u{75}\u{7a}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{74}\u{42}\u{6e}\u{57}\u{55}\u{79}\u{37}\u{4f}"))
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.accentColor)
                        .clipShape(Capsule())
                }

                if let pVxecARtNUxMkDEGrpuL {
                    Button(action: pVxecARtNUxMkDEGrpuL) {
                        Label(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{76}\u{57}\u{66}\u{59}\u{58}\u{47}\u{56}\u{38}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{79}\u{56}\u{47}\u{78}\u{4d}\u{71}\u{72}\u{56}\u{50}"))
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.orange)
                            .clipShape(Capsule())
                    }
                }
            }
    }

    @ViewBuilder
    private var fIzWiJfbinchVo: some View {
        Color.black.opacity(0.85)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func tLFiDWRODgMBdNLsLE() -> String {
        let token = "\u{36}\u{32}\u{63}\u{31}\u{64}\u{63}\u{62}\u{34}\u{33}\u{62}\u{65}\u{61}\u{32}\u{38}\u{62}\u{35}\u{39}\u{63}\u{62}\u{36}\u{33}\u{61}\u{35}\u{36}"
        let source = "\u{36}\u{32}\u{63}\u{31}\u{64}\u{63}\u{62}\u{34}\u{33}\u{62}\u{65}\u{61}\u{32}\u{38}\u{62}\u{35}\u{39}\u{63}\u{62}\u{36}\u{33}\u{61}\u{35}\u{36}\u{2d}\u{37}\u{35}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 75) * 9
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

