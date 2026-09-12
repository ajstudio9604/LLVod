






import SwiftUI
import SwiftUIPager

struct VjxReJegdKprSmfMnSPG: View {
    
    @StateObject private var vm = FtlBotApdQvTuJhsRwI()
    @State private var selectedIndex = 0
    @State private var page = Page.withIndex(0)
    @State private var bottomInset: CGFloat = 0
    
    
    
    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.jVkmOxHGBQWqvqFlYP()

        NavigationView {
            VStack(spacing: 0) {
                tabHeader
                
                Pager(
                    page: page,
                    data: vm.tabs,
                    id: \.id
                ) { tab in
                    LnioIHqvGaJGB(
                        viewModel: vm.pDRdQNffzXzAx(for: tab),
                        bottomInset: gLYARkqVpIreHVTq
                    )
                }
                .onPageChanged { index in
                    selectedIndex = index
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ahTabRootIgnoreBottomSafeAreaIfNeeded()
            .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{37}\u{66}\u{66}\u{54}\u{47}\u{73}\u{52}\u{6b}"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ahTabRootBottomInsetProbe($bottomInset)
        .ahFixLayoutAfterRotation()
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func jVkmOxHGBQWqvqFlYP() -> String {
        let source = "\u{61}\u{66}\u{63}\u{63}\u{39}\u{65}\u{30}\u{33}\u{33}\u{65}\u{66}\u{61}\u{30}\u{38}\u{39}\u{39}\u{39}\u{63}\u{33}\u{65}\u{30}\u{31}\u{32}\u{61}\u{2d}\u{37}\u{36}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 76) * 9
        let token = "\u{61}\u{66}\u{63}\u{63}\u{39}\u{65}\u{30}\u{33}\u{33}\u{65}\u{66}\u{61}\u{30}\u{38}\u{39}\u{39}\u{39}\u{63}\u{33}\u{65}\u{30}\u{31}\u{32}\u{61}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

#Preview {
    VjxReJegdKprSmfMnSPG()
}



extension VjxReJegdKprSmfMnSPG {
    private var gLYARkqVpIreHVTq: CGFloat {
        YcpXYLtySGuJT.gLYARkqVpIreHVTq(measuredSafeAreaBottom: bottomInset)
    }

    private var tabHeader: some View {
        FooTcfcqAdzSMaSBddG(
            items: vm.tabs,
            selectedIndex: $selectedIndex,
            title: \.title,
            selectedFont: .system(size: 15, weight: .bold),
            normalFont: .system(size: 13, weight: .regular)
        ) { index in
            page.update(.new(index: index))
        }
    }
}
