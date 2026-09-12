






import SwiftUI

struct HqGCEpcvYsev: View {

    @ObservedObject var viewModel: CxxgcGvyONdjCPTIxO

    let requestURL: String
    let containerWidth: CGFloat
    var refreshToken: Int = 0

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.hHLHjysdfOkQmYAqS()

        content
            .task(id: refreshToken) {
                if refreshToken == 0 {
                    await viewModel.zGFkkXBnrgUq(requestURL)
                } else {
                    await viewModel.mSvTwoHzTQHjZFborUoz(requestURL)
                }
            }
    }

    


    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func hHLHjysdfOkQmYAqS() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 7, "\u{65}\u{61}\u{73}\u{74}": 13, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 42]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 7) * 6
        let token = "\u{32}\u{61}\u{32}\u{39}\u{62}\u{61}\u{37}\u{65}\u{63}\u{62}\u{63}\u{62}\u{35}\u{36}\u{66}\u{63}\u{32}\u{66}\u{61}\u{36}\u{38}\u{63}\u{36}\u{37}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}



extension HqGCEpcvYsev {
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading &&
            viewModel.bannerData.isEmpty &&
            viewModel.listData.isEmpty {

            ProgressView(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{49}\u{65}\u{6c}\u{63}\u{57}\u{4a}\u{54}\u{31}"))
                .frame(maxWidth: .infinity)
                .frame(height: 320)

        } else {
            
            
            
            VStack(
                alignment: .leading,
                spacing: 24
            ) {
                if let message = viewModel.errorMessage {
                    RukEtbOOfUbZJdjU(message: message) {
                        Task {
                            await viewModel.mSvTwoHzTQHjZFborUoz(requestURL)
                        }
                    }
                    .disabled(viewModel.isLoading)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                }

                if !viewModel.bannerData.isEmpty {
                    PlFOgfGSuGIzL(
                        items: viewModel.bannerData
                    )
                    .padding(.top, 12)
                }

                if viewModel.errorMessage == nil || !viewModel.listData.isEmpty {
                    KvCZKVNiTEbjjZmCEjfb(
                        items: viewModel.listData,
                        containerWidth: containerWidth
                    )
                }
            }
        }
    }
}
