






import SwiftUI

struct QknafeNSECwyvic: View {

    @ObservedObject var viewModel: XxWGmhsLQqtxodExpQgU

    let mode: Int
    var bottomInset: CGFloat = 0

    
    
    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.pDCZGLRWOqoI()

        Group {
            if viewModel.isLoading && displayItems.isEmpty {
                ProgressView(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{49}\u{65}\u{6c}\u{63}\u{57}\u{4a}\u{54}\u{31}"))
            } else {
                contentView
            }
        }
        .task {
            await viewModel.zGFkkXBnrgUq()
        }
        .refreshable {
            await viewModel.tJCJwklUboPVmktkER()
        }
        .ahInlineError(message: viewModel.errorMessage, isLoading: viewModel.isLoading) {
            await viewModel.tJCJwklUboPVmktkER()
        }
    }

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func pDCZGLRWOqoI() -> String {
        let values = [10, 17, 70, 27]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 10) * 7
        let token = "\u{61}\u{32}\u{61}\u{63}\u{61}\u{63}\u{39}\u{35}\u{36}\u{62}\u{62}\u{61}\u{63}\u{39}\u{30}\u{31}\u{35}\u{35}\u{31}\u{39}\u{30}\u{39}\u{61}\u{37}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}



extension QknafeNSECwyvic {
    private var phoneColumns: [GridItem] {
        Array(
            repeating: GridItem(
                .fixed(120),
                spacing: 12,
                alignment: .top
            ),
            count: 3
        )
    }

    private var contentView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                LazyVGrid(
                    columns: phoneColumns,
                    alignment: .center,
                    spacing: 16
                ) {
                    ForEach(Array(displayItems)) { item in
                        BtTTBMEUAauCRAiAU(item: item)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, bottomInset + 16)
            .padding(.top, 12)
        }
    }

    private var displayItems: [DcLpvWsALmUOoRftmSn] {
        viewModel.items(for: mode)
    }
}
