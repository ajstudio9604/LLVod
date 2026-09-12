




import SwiftUI

private struct JktTgxGceOrlVGvz: PreferenceKey {
    static var defaultValue: CGFloat = 0

    
}

struct YeoPdvNIxeLZPJdQ: View {

    let item: YxdUIQGhxKMxKzMYnmOS
    var xSLUGkvoolmZhuvwt: CGFloat? = nil
    var lNMIfmDYauJO: (() -> Void)?

    @State private var textBlockHeight: CGFloat = 0

    private let horizontalPadding: CGFloat = 8
    private let titleBarMinHeight: CGFloat = 52

    

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.hHLlmQBeULyGEVGGg()

        if let lNMIfmDYauJO {
            Button(action: lNMIfmDYauJO) {
                card
            }
            .buttonStyle(.plain)
        } else {
            
            
            card
        }
    }

    

    

    

    @ViewBuilder
    private var backgroundLayer: some View {
        if !item.headerBgImage.isEmpty {
            EtXjBLbNYUbhXfeKeH(url: URL(string: item.headerBgImage))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

            LinearGradient(
                colors: [.clear, Color.black.opacity(0.75)],
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            Color(.secondarySystemBackground)
        }
    }

    

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func hHLlmQBeULyGEVGGg() -> String {
        let token = "\u{61}\u{31}\u{34}\u{33}\u{36}\u{63}\u{31}\u{33}\u{32}\u{34}\u{36}\u{35}\u{61}\u{36}\u{34}\u{38}\u{36}\u{32}\u{37}\u{30}\u{61}\u{66}\u{30}\u{62}"
        let values = [12, 19, 84, 29]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 12) * 7
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}



extension JktTgxGceOrlVGvz {
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        // source-obfuscator:padding:v1
        _ = Self.dTPOYPpRVTYa()

        value = max(value, nextValue())
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func dTPOYPpRVTYa() -> String {
        let token = "\u{62}\u{30}\u{33}\u{31}\u{37}\u{38}\u{31}\u{33}\u{36}\u{65}\u{35}\u{32}\u{31}\u{61}\u{38}\u{65}\u{66}\u{66}\u{38}\u{31}\u{36}\u{36}\u{63}\u{63}"
        let base = (40 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 40) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}


extension YeoPdvNIxeLZPJdQ {
    private var coverSide: CGFloat {
        let effectiveTextHeight = textBlockHeight > 0
            ? textBlockHeight
            : estimatedTextBlockHeight

        let maxCoverByText = effectiveTextHeight
        let maxCoverByCard = cardWidth * 0.32
        return min(maxCoverByText, maxCoverByCard)
    }

    private var cardWidth: CGFloat {
        xSLUGkvoolmZhuvwt ?? 171
    }

    private var bottomTitleSection: some View {
        HStack(alignment: .top, spacing: 8) {
            if !item.coverURL.isEmpty {
                EtXjBLbNYUbhXfeKeH(url: URL(string: item.coverURL))
                    .frame(width: coverSide, height: coverSide)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }

            textColumn
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, horizontalPadding)
        .frame(minWidth: cardWidth, maxWidth: cardWidth, minHeight: titleBarMinHeight, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemBackground))
        )
    }

    private var topImageSection: some View {
        ZStack(alignment: .topLeading) {
            backgroundLayer

            Text("\u{8c46}")
                .font(.system(size: 9, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 3))
                .padding(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
    }

    private var cardContent: some View {
        VStack(spacing: 0) {
            topImageSection
                .layoutPriority(0)

            bottomTitleSection
                .layoutPriority(1)
        }
    }

    private var estimatedTextBlockHeight: CGFloat {
        
        28
    }

    private var textColumn: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(item.title)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("\u{5171}\(item.itemsCount)\u{90e8}")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.secondary)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(
            GeometryReader { proxy in
                Color.clear.preference(
                    key: JktTgxGceOrlVGvz.self,
                    value: proxy.size.height
                )
            }
        )
        .onPreferenceChange(JktTgxGceOrlVGvz.self) { height in
            textBlockHeight = height
        }
    }

    private var card: some View {
        cardContent
            .frame(width: cardWidth, height: cardWidth)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.secondarySystemBackground))
            )
    }
}
