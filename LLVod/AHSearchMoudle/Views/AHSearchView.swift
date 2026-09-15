//
//  AHSearchView.swift
//  LLVod
//
//  对应 Flutter OkssPage / search/view.dart
//
//  顶部完全交给系统导航栏 + .searchable：
//  返回按钮、搜索框、取消按钮、清空按钮、键盘联动都用 Apple 的默认行为，
//  不再自绘顶栏（自绘时配合 navigationBarHidden 会在顶部留出一段空白）。
//

import SwiftUI

struct AHSearchView: View {

    @StateObject private var viewModel = AHSearchViewModel()
    @State private var selectedRoute: AHVodDetailRoute?
    @State private var showDetail = false
    @State private var didBootstrap = false

    private let initialKeyword: String?
    private let autoFocusSearchField: Bool

    init(initialKeyword: String? = nil, autoFocusSearchField: Bool = false) {
        self.initialKeyword = initialKeyword
        self.autoFocusSearchField = autoFocusSearchField
    }

    var body: some View {
        contentView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            .navigationTitle("搜索")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $viewModel.keyword,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "搜索影片名/演员/导演"
            )
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .onSubmit(of: .search) {
                viewModel.submitSearch()
            }
            .onChange(of: viewModel.keyword) { value in
                viewModel.onKeywordChanged(value)
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
                // 进详情再返回时 .task 会重跑；只引导一次，保留已有搜索结果
                guard !didBootstrap else { return }
                didBootstrap = true

                viewModel.loadInitialData()
                viewModel.configure(initialKeyword: initialKeyword)

                if autoFocusSearchField, initialKeyword == nil {
                    AHSearchFieldFocus.activate()
                }
            }
            .alert(
                "提示",
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil },
                    set: { value in
                        if !value {
                            viewModel.errorMessage = nil
                        }
                    }
                )
            ) {
                Button("确定") {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .ahHideTabBar()
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.pageState {
        case .searching:
            ProgressView("正在搜索")
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .results:
            AHSearchResultView(
                sourceNames: viewModel.sourceNames,
                selectedSource: viewModel.selectedSource,
                results: viewModel.currentResults,
                isLoadingMoreSources: viewModel.isSearching,
                onSelectSource: viewModel.selectSource,
                onSelectItem: openDetail
            )

        case .suggesting:
            AHSearchSuggestionView(
                items: viewModel.suggestionItems,
                keyword: viewModel.keyword,
                onSelect: viewModel.search
            )

        case .empty:
            AHSearchEmptyView(keyword: viewModel.keyword)

        case .idle:
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    AHSearchHotView(items: viewModel.hotItems) { keyword in
                        viewModel.search(with: keyword)
                    }

                    if viewModel.showHistorySection {
                        AHSearchHistoryView(
                            items: viewModel.historyItems,
                            onSelect: viewModel.search,
                            onDeleteAll: viewModel.clearHistory,
                            onDeleteItem: viewModel.removeHistory
                        )
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }

    @ViewBuilder
    private var detailDestination: some View {
        if let selectedRoute {
            AHVodDetailView(route: selectedRoute)
        } else {
            EmptyView()
        }
    }

    private func openDetail(_ item: AHSearchResultItem) {
        guard let route = viewModel.detailRoute(for: item) else {
            viewModel.errorMessage = "无法打开详情，请重试"
            return
        }
        selectedRoute = route
        showDetail = true
    }
}

struct AHSearchEmptyView: View {

    let keyword: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 44, weight: .light))
                .foregroundColor(.secondary)

            Text("没有找到「\(keyword)」相关内容")
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)

            Text("换个关键字试试")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

enum AHSearchFieldFocus {

    static func activate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            guard let window = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap(\.windows)
                .first(where: \.isKeyWindow),
                let searchBar = findSearchBar(in: window) else {
                return
            }
            searchBar.becomeFirstResponder()
        }
    }

    private static func findSearchBar(in view: UIView) -> UISearchBar? {
        if let searchBar = view as? UISearchBar {
            return searchBar
        }
        for subview in view.subviews {
            if let found = findSearchBar(in: subview) {
                return found
            }
        }
        return nil
    }
}

#Preview {
    NavigationView {
        AHSearchView()
    }
}
