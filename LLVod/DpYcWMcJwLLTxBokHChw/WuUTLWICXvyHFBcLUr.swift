







import SwiftUI

struct RaMNtCONlhEwDycUH: View {

    @StateObject private var viewModel = VujfALJeghHgtgCh()
    @State private var showFilterSheet = false
    @State private var bottomInset: CGFloat = 0

    private let sidebarWidth: CGFloat = 76
    private let headerHeight: CGFloat = 132
    private let accent = Color(red: 0.93, green: 0.55, blue: 0.18)

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.dJLnNBKjfIBmSLETrt()

        NavigationView {
            GeometryReader { proxy in
                let safeTop = proxy.safeAreaInsets.top

                VStack(spacing: 0) {
                    uQXxFooGwofExe(safeTop: safeTop)

                    HStack(alignment: .top, spacing: 0) {
                        sidebar
                            .frame(width: sidebarWidth)
                            .background(Color(.secondarySystemBackground))

                        contentColumn
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(.systemBackground))
                    }
                }
                .ignoresSafeArea(.container, edges: .top)
            }
            .background(Color(.systemBackground))
            .ahTabRootIgnoreBottomSafeAreaIfNeeded()
            .ahHideNavigationBar()
            .task {
                await viewModel.zGFkkXBnrgUq()
            }
            .ahInlineError(message: viewModel.errorMessage, isLoading: viewModel.isLoadingShell || viewModel.isLoadingItems) {
                await viewModel.kXEBrljsQlYp()
            }
            .sheet(isPresented: $showFilterSheet) {
                filterSheet
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ahTabRootBottomInsetProbe($bottomInset)
        .ahFixLayoutAfterRotation()
    }

    

    

    

    

    

    

    

    

    

    

    private var filterSheet: some View {
        NavigationView {
            List {
                Section(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{77}\u{77}\u{67}\u{70}\u{6d}\u{52}\u{45}\u{33}")) {
                    ForEach(viewModel.movieCategoryTabs) { tab in
                        Button(tab.title) {
                            showFilterSheet = false
                            Task {
                                await viewModel.mLNhkQNcPwqbapfWeKEA(kind: .movie, key: tab.key)
                            }
                        }
                    }
                }

                Section(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{48}\u{49}\u{63}\u{45}\u{6d}\u{61}\u{73}\u{4e}\u{4b}")) {
                    ForEach(viewModel.tvCategoryTabs) { tab in
                        Button(tab.title) {
                            showFilterSheet = false
                            Task {
                                await viewModel.mLNhkQNcPwqbapfWeKEA(kind: .tv, key: tab.key)
                            }
                        }
                    }
                }

                Section {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{55}\u{77}\u{4a}\u{65}\u{37}\u{71}\u{48}\u{4d}\u{65}")) {
                        showFilterSheet = false
                        Task { await viewModel.mTiOnYCBigjztgggBbf() }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{43}\u{46}\u{4a}\u{34}\u{64}\u{4b}\u{58}\u{73}"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{6a}\u{77}\u{42}\u{70}\u{64}\u{77}\u{6c}\u{70}")) { showFilterSheet = false }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func dJLnNBKjfIBmSLETrt() -> String {
        let token = "\u{31}\u{31}\u{37}\u{30}\u{65}\u{37}\u{34}\u{36}\u{63}\u{36}\u{37}\u{34}\u{39}\u{35}\u{66}\u{33}\u{62}\u{63}\u{30}\u{61}\u{39}\u{61}\u{61}\u{66}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{34}\u{32}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 42) * 2
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension RaMNtCONlhEwDycUH {
    private var dateMenuTitle: String {
        switch viewModel.mode {
        case .weekly:
            return viewModel.selectedCollection?.updatedDisplay ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{72}\u{56}\u{65}\u{31}\u{6c}\u{41}\u{6d}\u{4a}")
        case .year(let year):
            return "\(year) \u{5e74}\u{5ea6}"
        case .category:
            return viewModel.selectedCollection?.updatedDisplay ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{37}\u{36}\u{31}\u{41}\u{67}\u{41}\u{59}\u{6e}\u{47}")
        }
    }

    private var toolbarRow: some View {
        HStack(spacing: 8) {
            Spacer()

            Menu {
                Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{73}\u{70}\u{4f}\u{6b}\u{6c}\u{52}\u{53}\u{6c}")) {
                    Task { await viewModel.mTiOnYCBigjztgggBbf() }
                }
                ForEach(viewModel.yearTabs) { tab in
                    Button(tab.title + AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{78}\u{4f}\u{38}\u{7a}\u{6b}\u{61}\u{68}\u{39}")) {
                        Task { await viewModel.iJofPpmSSGFN(tab.key) }
                    }
                }
            } label: {
                HStack(spacing: 3) {
                    Text(dateMenuTitle)
                        .font(.system(size: 12, weight: .medium))
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{71}\u{6d}\u{48}\u{49}\u{41}\u{57}\u{44}\u{51}"))
                        .font(.system(size: 9, weight: .semibold))
                }
                .foregroundColor(.secondary)
            }

            Button {
                showFilterSheet = true
            } label: {
                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{78}\u{54}\u{4f}\u{4e}\u{75}\u{38}\u{75}\u{36}\u{6f}"))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
                    .frame(width: 28, height: 28)
            }
            .buttonStyle(.plain)
        }
    }

    private var sidebar: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 4) {
                ForEach(viewModel.sidebar) { collection in
                    let selected = viewModel.selectedCollection?.id == collection.id
                    Button {
                        Task { await viewModel.tLkvxqWZgACLwT(collection) }
                    } label: {
                        Text(collection.sidebarLabel)
                            .font(.system(size: 13, weight: selected ? .semibold : .regular))
                            .foregroundColor(selected ? accent : Color.secondary)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(selected ? Color(.systemBackground) : Color.clear)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 10)
            .padding(.bottom, gLYARkqVpIreHVTq)
        }
    }

    private var gLYARkqVpIreHVTq: CGFloat {
        YcpXYLtySGuJT.gLYARkqVpIreHVTq(measuredSafeAreaBottom: bottomInset)
    }

    private var contentColumn: some View {
        VStack(spacing: 0) {
            toolbarRow
                .padding(.horizontal, 12)
                .padding(.vertical, 10)

            Divider()

            ZStack {
                if viewModel.isLoadingShell || viewModel.isLoadingItems {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.items.isEmpty {
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4f}\u{64}\u{44}\u{63}\u{51}\u{6a}\u{64}\u{39}\u{77}"))
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, item in
                                HlqcujHgGlgafnjIq(rank: index + 1, item: item)
                                    .padding(.horizontal, 12)

                                if index < viewModel.items.count - 1 {
                                    Divider()
                                        .padding(.leading, 12)
                                }
                            }
                        }
                        .padding(.bottom, gLYARkqVpIreHVTq + 24)
                    }
                }
            }
        }
    }

    private func uQXxFooGwofExe(safeTop: CGFloat) -> some View {
        let height = headerHeight + safeTop
        let title = viewModel.selectedCollection?.displayTitle ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{35}\u{76}\u{53}\u{4c}\u{67}\u{5a}\u{33}\u{5a}")
        let imageURL = viewModel.selectedCollection?.headerImageURL ?? ""

        return ZStack(alignment: .bottom) {
            Group {
                if let url = URL(string: imageURL), !imageURL.isEmpty {
                    EtXjBLbNYUbhXfeKeH(url: url)
                } else {
                    LinearGradient(
                        colors: [Color(white: 0.25), Color(white: 0.12)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            }
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .clipped()

            LinearGradient(
                colors: [.black.opacity(0.15), .black.opacity(0.62)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: height)

            VStack(spacing: 0) {
                Spacer(minLength: 0)

                HStack(spacing: 10) {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{78}\u{50}\u{4d}\u{70}\u{4d}\u{45}\u{56}\u{61}"))
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(red: 0.95, green: 0.78, blue: 0.35))
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{75}\u{65}\u{69}\u{42}\u{37}\u{42}\u{72}\u{58}"))
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(red: 0.95, green: 0.78, blue: 0.35))
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 18)
                .padding(.top, safeTop)
            }
            .frame(height: height)
        }
        .frame(height: height)
    }
}
