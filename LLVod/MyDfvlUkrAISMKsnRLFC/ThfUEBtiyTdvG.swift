






import SwiftUI
import SwiftUIPager

struct LchYNbZOgLJYfuX: View {

    @StateObject private var vm = XxWGmhsLQqtxodExpQgU()
    @StateObject private var bannerViewModel = CxxgcGvyONdjCPTIxO()
    @State private var selectedIndex: Int = 0
    @State private var page = Page.withIndex(0)
    @State private var hasLoaded: Bool = false
    @State private var bottomInset: CGFloat = 0
    @State private var showSearch = false
    @State private var showDownload = false
    @State private var showHistory = false

    var tabHeader: some View {
        FooTcfcqAdzSMaSBddG(
            items: vm.homeTypes,
            selectedIndex: $selectedIndex,
            title: \.name,
            selectedFont: .system(size: 18, weight: .bold),
            normalFont: .system(size: 16, weight: .regular)
        ) { index in
            page.update(.new(index: index))
        }
    }
    
    @ViewBuilder
    func kDavZBPVGrNo(_ tab: OvbYNtlJVsci) -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.tPJiQwudnLyrIr()

        Group {
            if tab.mode == 0 {
                EkWgUnTXAyJOIZ(
                    viewModel: vm,
                    bannerViewModel: bannerViewModel,
                    bottomInset: gLYARkqVpIreHVTq
                )
            } else {
                QknafeNSECwyvic(
                    viewModel: vm,
                    mode: tab.mode,
                    bottomInset: gLYARkqVpIreHVTq
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                
                homeTopBar

                tabHeader

                
                
                
                Pager(
                    page: page,
                    data: Array(vm.homeTypes),
                    id: \.id
                ) { tab in
                    kDavZBPVGrNo(tab)
                }
                .onPageChanged { index in
                    selectedIndex = index
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .ahTabRootIgnoreBottomSafeAreaIfNeeded()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .ahHideNavigationBar()
            .background(homeNavigationLinks)
        }
        .onAppear() {
            guard !hasLoaded else { return }
            hasLoaded = true

            
            Task { await AzqCURaEoPGpgIYOF.vMjlwSWYSxtpQctaRnSO() }

            
            Task { await GhVslybsHHKxrrPJhv.xMsiAefpkcPbG() }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ahTabRootBottomInsetProbe($bottomInset)
        .ahFixLayoutAfterRotation()
        
    }

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func tPJiQwudnLyrIr() -> String {
        let base = (4 * 6 + 19) % 997
        let width = (base) % 17
        let score = (width + 4) * 6
        let token = "\u{33}\u{36}\u{31}\u{61}\u{33}\u{37}\u{33}\u{33}\u{63}\u{39}\u{32}\u{63}\u{61}\u{63}\u{65}\u{38}\u{39}\u{34}\u{30}\u{39}\u{31}\u{37}\u{31}\u{32}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}



extension LchYNbZOgLJYfuX {
    private var homeNavigationLinks: some View {
        ZStack {
            NavigationLink(
                destination: FfchOnYfkMvhyzb(autoFocusSearchField: true),
                isActive: $showSearch
            ) { EmptyView() }

            NavigationLink(
                destination: LlGgqVbCItHWtVdKDJJ(),
                isActive: $showDownload
            ) { EmptyView() }

            NavigationLink(
                destination: AlGGPacYEqCQramum(),
                isActive: $showHistory
            ) { EmptyView() }
        }
        .frame(width: 0, height: 0)
        .hidden()
        .allowsHitTesting(false)
    }

    private var homeTopBar: some View {
        HStack(spacing: 4) {
            Button {
                showSearch = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{66}\u{32}\u{52}\u{4c}\u{74}\u{31}\u{50}\u{76}"))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)

                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{45}\u{7a}\u{32}\u{4c}\u{68}\u{53}\u{55}\u{49}\u{45}"))
                        .font(.system(size: 14))
                        .foregroundColor(.gray)

                    Spacer(minLength: 0)
                }
                .padding(.horizontal, 12)
                .frame(height: 34)
                .frame(maxWidth: .infinity)
                .background(
                    Capsule().fill(Color(.tertiarySystemFill))
                )
                .contentShape(Capsule())
            }
            .buttonStyle(.plain)

            Button {
                showDownload = true
            } label: {
                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{48}\u{66}\u{51}\u{48}\u{36}\u{44}\u{66}\u{4a}\u{68}"))
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
                    .frame(width: 32, height: 34)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Button {
                showHistory = true
            } label: {
                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{36}\u{51}\u{34}\u{65}\u{4d}\u{37}\u{31}\u{7a}"))
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
                    .frame(width: 32, height: 34)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.top, 6)
        .padding(.bottom, 4)
        .zIndex(10)
    }

    private var gLYARkqVpIreHVTq: CGFloat {
        YcpXYLtySGuJT.gLYARkqVpIreHVTq(measuredSafeAreaBottom: bottomInset)
    }
}
