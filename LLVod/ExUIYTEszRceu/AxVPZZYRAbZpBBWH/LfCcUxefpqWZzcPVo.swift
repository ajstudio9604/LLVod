




import SwiftUI

struct XtVkZKQgfcKfvaO: View {

    let items: [KdBwtNklTiaktZDpxT]
    var onSelect: (String) -> Void

    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]

    var body: some View {
        
        eTuruENRbSEvuOQuA()
    }

    

    
    @ViewBuilder
    @inline(never)
    private func eTuruENRbSEvuOQuA() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.yPNMdVyjgFIt()

        bVoImOMprSXrwOcmdpPv
    }

    @ViewBuilder
    private var bVoImOMprSXrwOcmdpPv: some View {
        VStack(alignment: .leading, spacing: 8) {
            aPAHfDYLhFXC

            cUwVFfAlAOPhT
           
        }
    }


    @ViewBuilder
    private var aPAHfDYLhFXC: some View {
        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{72}\u{46}\u{71}\u{71}\u{4d}\u{4d}\u{4e}\u{4d}"))
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.red)
                .padding(.leading, 15)
                .padding(.top, 10)
    }

    @ViewBuilder
    private var cUwVFfAlAOPhT: some View {
        LazyVGrid(columns: columns, spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    Button {
                        onSelect(item.title)
                    } label: {
                        HStack(spacing: 8) {
                            Text("\(index + 1)")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(vCijwdVoLFrbivK(for: index))
                                .frame(width: 20, alignment: .leading)
                                .padding(.leading, 7)

                            Text(item.title)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.primary)
                                .lineLimit(1)

                            Spacer(minLength: 0)
                        }
                        .frame(height: 40)
                        .padding(.horizontal, 8)
                    }
                    .buttonStyle(.plain)
                }
            }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func yPNMdVyjgFIt() -> String {
        let values = [15, 21, 90, 32]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 15) * 6
        let token = "\u{34}\u{62}\u{30}\u{30}\u{30}\u{34}\u{36}\u{64}\u{64}\u{38}\u{34}\u{33}\u{36}\u{38}\u{38}\u{61}\u{61}\u{61}\u{35}\u{64}\u{66}\u{64}\u{37}\u{63}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}



extension XtVkZKQgfcKfvaO {
    private func vCijwdVoLFrbivK(for index: Int) -> Color {
        switch index {
        case 0:
            return Color(red: 0xF7 / 255, green: 0x39 / 255, blue: 0x3B / 255)
        case 1:
            return Color(red: 0xEF / 255, green: 0x99 / 255, blue: 0x2A / 255)
        case 2:
            return Color(red: 0x52 / 255, green: 0x91 / 255, blue: 0xFF / 255)
        default:
            return .primary
        }
    }
}
