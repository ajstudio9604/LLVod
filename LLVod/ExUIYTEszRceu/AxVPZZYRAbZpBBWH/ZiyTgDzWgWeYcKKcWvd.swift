










import SwiftUI

struct FfchOnYfkMvhyzb: View {

    @StateObject private var viewModel = RbFDtoadGDZRunIvj()
    @State private var selectedRoute: RawJGVnXMRwEec?
    @State private var showDetail = false
    @State private var didBootstrap = false

    private let initialKeyword: String?
    private let autoFocusSearchField: Bool

    init(initialKeyword: String? = nil, autoFocusSearchField: Bool = false) {
        // source-obfuscator:padding:v1
        _ = Self.tHYGiNJmzLriOVooRs()

        self.initialKeyword = initialKeyword
        self.autoFocusSearchField = autoFocusSearchField
    }

    var body: some View {
        contentView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{6e}\u{56}\u{31}\u{6b}\u{5a}\u{37}\u{33}\u{75}"))
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $viewModel.keyword,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{67}\u{30}\u{71}\u{53}\u{6a}\u{62}\u{64}\u{39}")
            )
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .onSubmit(of: .search) {
                viewModel.oXTrXRKiDHeFtBJoD()
            }
            .onChange(of: viewModel.keyword) { value in
                viewModel.gMPqgGjSUplwuG(value)
            }
            .background(
                NavigationLink(
                    destination: detailDestination,
                    isActive: $showDetail
                ) {
                    EmptyView()
                }
                .hidden()
            )
            .task {
                
                guard !didBootstrap else { return }
                didBootstrap = true

                viewModel.cCZAUelMXgijQkvqacM()
                viewModel.hVAwKWwHhvrHyHxaY(initialKeyword: initialKeyword)

                if autoFocusSearchField, initialKeyword == nil {
                    ScpsUgjkQtYQNRMGsRM.lSWvKjPMcjDUZJNWgC()
                }
            }
            .ahInlineError(message: viewModel.errorMessage, isLoading: viewModel.isSearching) {
                viewModel.oXTrXRKiDHeFtBJoD()
            }
            .ahHideTabBar()
    }

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func tHYGiNJmzLriOVooRs() -> String {
        let token = "\u{34}\u{65}\u{65}\u{33}\u{30}\u{34}\u{61}\u{36}\u{64}\u{63}\u{39}\u{35}\u{33}\u{66}\u{35}\u{30}\u{37}\u{31}\u{36}\u{34}\u{34}\u{37}\u{39}\u{38}"
        let base = (63 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 63) * 9
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

struct GovtqgkzhTZiUhdS: View {

    let keyword: String

    var body: some View {
        
        cUvuNCIWwKIaoWORi()
    }

    
    @ViewBuilder
    @inline(never)
    private func cUvuNCIWwKIaoWORi() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.wFBoBDmhmqqFkesT()

        lWYeCejuHNuUXlbzuMdR
    }

    @ViewBuilder
    private var lWYeCejuHNuUXlbzuMdR: some View {
        VStack(spacing: 12) {
            nSxpFmBKykOkvQmWJn

            rHfFjYUIpklYqmq

            pPavptKjrcDP
        }
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }


    @ViewBuilder
    private var rHfFjYUIpklYqmq: some View {
        Text("\u{6ca1}\u{6709}\u{627e}\u{5230}\u{300c}\(keyword)\u{300d}\u{76f8}\u{5173}\u{5185}\u{5bb9}")
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
    }

    @ViewBuilder
    private var nSxpFmBKykOkvQmWJn: some View {
        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{66}\u{32}\u{52}\u{4c}\u{74}\u{31}\u{50}\u{76}"))
                .font(.system(size: 44, weight: .light))
                .foregroundColor(.secondary)
    }

    @ViewBuilder
    private var pPavptKjrcDP: some View {
        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{78}\u{36}\u{47}\u{69}\u{57}\u{36}\u{76}\u{4b}\u{64}"))
                .font(.subheadline)
                .foregroundColor(.secondary)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func wFBoBDmhmqqFkesT() -> String {
        let base = (47 * 6 + 19) % 997
        let width = (base) % 17
        let score = (width + 47) * 6
        let token = "\u{34}\u{37}\u{34}\u{61}\u{30}\u{34}\u{36}\u{34}\u{34}\u{61}\u{35}\u{61}\u{34}\u{33}\u{35}\u{35}\u{38}\u{39}\u{36}\u{62}\u{66}\u{39}\u{30}\u{31}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}

enum ScpsUgjkQtYQNRMGsRM {

    

    
}

#Preview {
    NavigationView {
        FfchOnYfkMvhyzb()
    }
}



extension ScpsUgjkQtYQNRMGsRM {
    private static func fBrRkpTPCKNylHkx(in view: UIView) -> UISearchBar? {
        // source-obfuscator:padding:v1
        _ = Self.yLVCWNwhiRFEElIUR()

        if let searchBar = view as? UISearchBar {
            return searchBar
        }
        for subview in view.subviews {
            if let found = fBrRkpTPCKNylHkx(in: subview) {
                return found
            }
        }
        return nil
    }

    static func lSWvKjPMcjDUZJNWgC() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            guard let window = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap(\.windows)
                .first(where: \.isKeyWindow),
                let searchBar = fBrRkpTPCKNylHkx(in: window) else {
                return
            }
            searchBar.becomeFirstResponder()
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func yLVCWNwhiRFEElIUR() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 61, "\u{65}\u{61}\u{73}\u{74}": 64, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 183]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 61) * 3
        let token = "\u{38}\u{38}\u{34}\u{37}\u{38}\u{37}\u{39}\u{34}\u{61}\u{36}\u{33}\u{65}\u{66}\u{64}\u{32}\u{35}\u{38}\u{39}\u{33}\u{36}\u{38}\u{37}\u{32}\u{32}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}


extension FfchOnYfkMvhyzb {
    @ViewBuilder
    private var detailDestination: some View {
        if let selectedRoute {
            GsJOCBdoNInHfKqMeUj(route: selectedRoute)
        } else {
            EmptyView()
        }
    }

    private func iDmquLBzJYaKYVr(_ item: PzPGBfDtzkHPSRROQs) {
        guard let route = viewModel.iSYrcFyyaBYaHkBzNcqL(for: item) else {
            viewModel.errorMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{54}\u{70}\u{59}\u{4c}\u{71}\u{77}\u{6d}\u{41}")
            return
        }
        selectedRoute = route
        showDetail = true
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.pageState {
        case .searching:
            ProgressView(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{6e}\u{34}\u{66}\u{75}\u{49}\u{41}\u{6f}\u{32}"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .results:
            VueBqSzEmitezfpnfEjd(
                sourceNames: viewModel.sourceNames,
                selectedSource: viewModel.selectedSource,
                results: viewModel.currentResults,
                isLoadingMoreSources: viewModel.isSearching,
                jToOJNXOUoFxpphRV: viewModel.sJibEqdaGoGmzajkJte,
                iBIIhStwTQlQUkVLH: iDmquLBzJYaKYVr
            )

        case .suggesting:
            DxFuXEXLZARkWtNVnB(
                items: viewModel.suggestionItems,
                keyword: viewModel.keyword,
                onSelect: viewModel.iEHLCtVaPmgavrry
            )

        case .empty:
            GovtqgkzhTZiUhdS(keyword: viewModel.keyword)

        case .idle:
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    XtVkZKQgfcKfvaO(items: viewModel.hotItems) { keyword in
                        viewModel.iEHLCtVaPmgavrry(with: keyword)
                    }

                    if viewModel.showHistorySection {
                        QhiteiepZsGWuPztiMId(
                            items: viewModel.historyItems,
                            onSelect: viewModel.iEHLCtVaPmgavrry,
                            hAvmsFvrezwVTXOcpZub: viewModel.xTHgBehzYTaSdhGqO,
                            vExzLFhciepUhSPH: viewModel.iKkhSwgToEzfHlEtWoEL
                        )
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}
