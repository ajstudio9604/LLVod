




import SwiftUI

struct LnioIHqvGaJGB: View {

    @ObservedObject var viewModel: EizFlwEHoMPRnxjsSfB
    var bottomInset: CGFloat = 0

    private let leadingPadding: CGFloat = 16
    private let trailingPadding: CGFloat = 16
    private let itemSpacing: CGFloat = 16
    private let rowSpacing: CGFloat = 16
    private let padLandscapeColumns = 6
    private let padPortraitColumns = 5
    private let padItemSpacing: CGFloat = 12
    private let padRowSpacing: CGFloat = 16

    

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.tEMjNAfMmOaiijD()

        Group {
            if viewModel.isRefreshing && viewModel.items.isEmpty {
                ProgressView(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{49}\u{65}\u{6c}\u{63}\u{57}\u{4a}\u{54}\u{31}"))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.items.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{51}\u{4d}\u{79}\u{41}\u{6f}\u{35}\u{52}\u{63}"))
                        .font(.system(size: 36))
                        .foregroundColor(.secondary)
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{4d}\u{46}\u{38}\u{44}\u{43}\u{69}\u{41}\u{33}"))
                        .font(.headline)
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{42}\u{65}\u{4e}\u{76}\u{50}\u{76}\u{4e}\u{42}"))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                contentGrid
            }
        }
        .task {
            await viewModel.zGFkkXBnrgUq()
        }
        .refreshable {
            await viewModel.bLCjkRqVgoxA()
        }
        .ahInlineError(message: viewModel.errorMessage, isLoading: viewModel.isRefreshing || viewModel.isLoadingMore) {
            await viewModel.kXEBrljsQlYp()
        }
    }

    

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func tEMjNAfMmOaiijD() -> String {
        let token = "\u{62}\u{63}\u{31}\u{37}\u{37}\u{37}\u{64}\u{38}\u{32}\u{32}\u{66}\u{61}\u{36}\u{30}\u{38}\u{34}\u{65}\u{66}\u{33}\u{32}\u{62}\u{39}\u{32}\u{31}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 60, "\u{65}\u{61}\u{73}\u{74}": 67, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 420]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 60) * 7
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}



extension LnioIHqvGaJGB {
    private func jVdMEXdNvUkSUb(isLandscape: Bool) -> Int {
        guard isPad else { return 2 }
        return isLandscape ? padLandscapeColumns : padPortraitColumns
    }

    private var contentGrid: some View {
        GeometryReader { proxy in
            let isLandscape = proxy.size.width > proxy.size.height
            let columnsCount = jVdMEXdNvUkSUb(isLandscape: isLandscape)
            let xSLUGkvoolmZhuvwt = xSLUGkvoolmZhuvwt(
                for: proxy.size.width,
                columnsCount: columnsCount
            )
            let columns = oZANHxlMiscx(
                xSLUGkvoolmZhuvwt: xSLUGkvoolmZhuvwt,
                columnsCount: columnsCount
            )

            ScrollView {
                LazyVGrid(
                    columns: columns,
                    spacing: isPad ? padRowSpacing : rowSpacing
                ) {
                    ForEach(viewModel.items) { item in
                        NavigationLink {
                            NfWpekezXewNpoHEBIt(playlist: item)
                        } label: {
                            YeoPdvNIxeLZPJdQ(
                                item: item,
                                xSLUGkvoolmZhuvwt: xSLUGkvoolmZhuvwt
                            )
                        }
                        .buttonStyle(.plain)
                        .task {
                            await viewModel.qEfkyEQMmVhijBWNiW(currentItem: item)
                        }
                    }
                }
                .padding(.leading, leadingPadding)
                .padding(.trailing, trailingPadding)
                .padding(.vertical, 15)

                if viewModel.isLoadingMore {
                    ProgressView()
                        .padding(.bottom, 16)
                }

                Color.clear
                    .frame(height: bottomInset)
            }
        }
    }

    private var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    private func oZANHxlMiscx(xSLUGkvoolmZhuvwt: CGFloat, columnsCount: Int) -> [GridItem] {
        if isPad {
            return Array(
                repeating: GridItem(.fixed(xSLUGkvoolmZhuvwt), spacing: padItemSpacing),
                count: columnsCount
            )
        }

        return [
            GridItem(.fixed(xSLUGkvoolmZhuvwt), spacing: itemSpacing),
            GridItem(.fixed(xSLUGkvoolmZhuvwt))
        ]
    }

    private func xSLUGkvoolmZhuvwt(for containerWidth: CGFloat, columnsCount: Int) -> CGFloat {
        if isPad {
            return (
                containerWidth
                - leadingPadding
                - trailingPadding
                - padItemSpacing * CGFloat(columnsCount - 1)
            ) / CGFloat(columnsCount)
        }

        return (
            containerWidth
            - leadingPadding
            - trailingPadding
            - itemSpacing
        ) / 2
    }
}
