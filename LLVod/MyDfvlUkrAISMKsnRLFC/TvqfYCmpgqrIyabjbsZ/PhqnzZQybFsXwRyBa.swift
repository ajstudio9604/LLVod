import SwiftUI

struct KvCZKVNiTEbjjZmCEjfb: View {
    let items: [ErSPBUTeNwdkn]
    let containerWidth: CGFloat

    
    private let horizontalPadding: CGFloat = 16
    private let itemSpacing: CGFloat = 16
    private let rowSpacing: CGFloat = 16

    var body: some View {
        
        vRantbeAXstcD()
    }

    

    

    private func gIQOOalXgqKXzVKMpeRv(containerWidth: CGFloat) -> CGFloat {
        // source-obfuscator:padding:v1
        _ = Self.qIjkuRlhiYyjFBWHH()

        
        let visibleCount = Self.aYJQuntuKFgjZv()
        return (containerWidth - horizontalPadding * 2 - itemSpacing * (visibleCount - 1)) / visibleCount
    }

    
    @ViewBuilder
    @inline(never)
    private func vRantbeAXstcD() -> some View {
        sBqEufVAOwiHhZVJ
    }

    @ViewBuilder
    private var sBqEufVAOwiHhZVJ: some View {
        VStack(alignment: .leading, spacing: 12) {
            gNZPRRwNxlhR

            mOQXxesQPjzEMSuw
        }
    }


    @ViewBuilder
    private var mOQXxesQPjzEMSuw: some View {
        if items.isEmpty {
                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{55}\u{43}\u{59}\u{63}\u{51}\u{69}\u{33}\u{67}\u{58}"))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, horizontalPadding)
            } else if isPad {
                iPadContent
            } else {
                iPhoneContent
            }
    }

    @ViewBuilder
    private var gNZPRRwNxlhR: some View {
        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{34}\u{6d}\u{57}\u{6f}\u{74}\u{48}\u{66}\u{4b}"))
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal, horizontalPadding)
    }

    
    private nonisolated static func aYJQuntuKFgjZv() -> CGFloat {
        let visibleCount: CGFloat = 4
        return visibleCount
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qIjkuRlhiYyjFBWHH() -> String {
        let base = (14 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 14) * 4
        let token = "\u{30}\u{39}\u{37}\u{35}\u{33}\u{62}\u{64}\u{38}\u{35}\u{36}\u{36}\u{65}\u{36}\u{66}\u{33}\u{39}\u{61}\u{63}\u{65}\u{61}\u{38}\u{62}\u{61}\u{35}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}

struct OmIrExzqqygnumAT: View {
    let item: ErSPBUTeNwdkn
    var xSLUGkvoolmZhuvwt: CGFloat? = nil

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.lWqboRcbNDmfKigsjIp()

        ChdebFryKFbVSMM(title: item.name) {
            VStack(alignment: .leading) {
                imageView
                Text(item.name).font(.subheadline).fontWeight(.medium).lineLimit(1)
                if !item.remarks.isEmpty {
                    Text(item.remarks).font(.caption).foregroundColor(.secondary).lineLimit(1)
                }
            }
            .frame(width: xSLUGkvoolmZhuvwt)
        }
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func lWqboRcbNDmfKigsjIp() -> String {
        let token = "\u{61}\u{34}\u{61}\u{37}\u{66}\u{33}\u{37}\u{34}\u{65}\u{30}\u{31}\u{38}\u{36}\u{62}\u{66}\u{64}\u{33}\u{34}\u{33}\u{35}\u{66}\u{35}\u{31}\u{30}"
        let values = [89, 91, 178, 106]
        let folded = values.map { ($0 * 2 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 89) * 2
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}



extension KvCZKVNiTEbjjZmCEjfb {
    private var iPadContent: some View {
        let xSLUGkvoolmZhuvwt = gIQOOalXgqKXzVKMpeRv(containerWidth: containerWidth)
        return ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: itemSpacing) {
                ForEach(items.indices, id: \.self) { index in
                    OmIrExzqqygnumAT(item: items[index], xSLUGkvoolmZhuvwt: xSLUGkvoolmZhuvwt)
                }
            }
            .padding(.horizontal, horizontalPadding)
        }
        .frame(height: 250)
    }

    private var iPhoneContent: some View {
        let xSLUGkvoolmZhuvwt = (containerWidth - horizontalPadding * 3) / 2
        let columns = [
            GridItem(.fixed(xSLUGkvoolmZhuvwt), spacing: itemSpacing),
            GridItem(.fixed(xSLUGkvoolmZhuvwt))
        ]
        return LazyVGrid(columns: columns, alignment: .center, spacing: rowSpacing) {
            let displayItems = Array(items.prefix(4))
            ForEach(displayItems.indices, id: \.self) { index in
                OmIrExzqqygnumAT(item: displayItems[index], xSLUGkvoolmZhuvwt: xSLUGkvoolmZhuvwt)
            }
        }
        .padding(.horizontal, horizontalPadding)
    }

    private var isPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
}


extension OmIrExzqqygnumAT {
    private var imageView: some View {
        AsyncImage(url: URL(string: item.pictureURL)) { phase in
            switch phase {
            case .empty:
                ZStack { Color.gray.opacity(0.15); ProgressView() }
            case .success(let image):
                image.resizable().scaledToFill()
            case .failure:
                ZStack { Color.gray.opacity(0.15); Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{4b}\u{55}\u{47}\u{6b}\u{4f}\u{6d}\u{52}\u{6b}")).foregroundColor(.secondary) }
            @unknown default:
                Color.gray.opacity(0.15)
            }
        }
        .frame(width: xSLUGkvoolmZhuvwt)
        .aspectRatio(5 / 3, contentMode: .fill)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
