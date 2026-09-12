






import SwiftUI

struct EexTZkzIPFeDGE: View {

    let notice: DiFlugBsHBcmHhv

    @Environment(\.openURL) private var openURL

    var body: some View {
        
        mRsbflFMSaSGC()
    }

    

    
    @ViewBuilder
    @inline(never)
    private func mRsbflFMSaSGC() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.tZViZAhxzurivn()

        rIcusmChjcjYokfZQ
    }

    @ViewBuilder
    private var rIcusmChjcjYokfZQ: some View {
        HStack(spacing: 12) {
            zQqjwxaDmNTH

            VStack(alignment: .leading, spacing: 4) {
                if !notice.title.isEmpty {
                    Text(notice.title)
                        .font(.system(size: 15, weight: .bold))
                }

                if !notice.content.isEmpty {
                    Text(notice.content)
                        .font(.system(size: 13))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .foregroundColor(notice.textColor)

            hRIvzINPIQNvRBrtbTx
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(notice.backgroundColor)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            guard let url = URL(string: notice.linkURL), notice.linkURL.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{4d}\u{41}\u{67}\u{61}\u{64}\u{6f}\u{72}\u{30}")) else {
                return
            }
            openURL(url)
        }
    }


    @ViewBuilder
    private var zQqjwxaDmNTH: some View {
        Image(systemName: iconName)
                .font(.system(size: 17))
                .foregroundColor(UhQdrGVmfViYYgQaF.accent)
                .frame(width: 38, height: 38)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.12))
                )
    }

    @ViewBuilder
    private var hRIvzINPIQNvRBrtbTx: some View {
        Spacer(minLength: 0)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func tZViZAhxzurivn() -> String {
        let token = "\u{38}\u{66}\u{38}\u{35}\u{31}\u{38}\u{63}\u{35}\u{63}\u{37}\u{62}\u{65}\u{30}\u{64}\u{30}\u{39}\u{32}\u{39}\u{65}\u{33}\u{33}\u{35}\u{63}\u{36}"
        let values = [37, 39, 74, 54]
        let folded = values.map { ($0 * 2 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 37) * 2
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}



extension EexTZkzIPFeDGE {
    private var iconName: String {
        guard !notice.icon.isEmpty, UIImage(systemName: notice.icon) != nil else {
            return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{45}\u{62}\u{33}\u{4e}\u{6a}\u{4e}\u{79}\u{56}")
        }
        return notice.icon
    }
}
