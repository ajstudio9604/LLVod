//
//  AHRankView.swift
//  LLVod
//
//  豆瓣榜单一级 Tab：头图标题 + 左侧周榜侧栏 + 右侧明细
//  不含返回键 / 关注数 / +关注 / 条目标签
//

import SwiftUI

struct AHRankView: View {

    @StateObject private var viewModel = AHRankViewModel()
    @State private var showFilterSheet = false
    @State private var bottomInset: CGFloat = 0

    private let sidebarWidth: CGFloat = 76
    private let headerHeight: CGFloat = 132
    private let accent = Color(red: 0.93, green: 0.55, blue: 0.18)

    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                let safeTop = proxy.safeAreaInsets.top

                VStack(spacing: 0) {
                    header(safeTop: safeTop)

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
                await viewModel.loadIfNeeded()
            }
            .alert(
                "提示",
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil },
                    set: { if !$0 { viewModel.errorMessage = nil } }
                )
            ) {
                Button("确定") { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .sheet(isPresented: $showFilterSheet) {
                filterSheet
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ahTabRootBottomInsetProbe($bottomInset)
        .ahFixLayoutAfterRotation()
    }

    private var contentBottomInset: CGFloat {
        AHTabRootBottomLayout.contentBottomInset(measuredSafeAreaBottom: bottomInset)
    }

    // MARK: - Header（无返回 / 无关注）

    private func header(safeTop: CGFloat) -> some View {
        let height = headerHeight + safeTop
        let title = viewModel.selectedCollection?.displayTitle ?? "豆瓣榜单"
        let imageURL = viewModel.selectedCollection?.headerImageURL ?? ""

        return ZStack(alignment: .bottom) {
            Group {
                if let url = URL(string: imageURL), !imageURL.isEmpty {
                    CachedAsyncImageView(url: url)
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
                    Image(systemName: "laurel.leading")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(red: 0.95, green: 0.78, blue: 0.35))
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    Image(systemName: "laurel.trailing")
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

    // MARK: - Sidebar

    private var sidebar: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 4) {
                ForEach(viewModel.sidebar) { collection in
                    let selected = viewModel.selectedCollection?.id == collection.id
                    Button {
                        Task { await viewModel.selectCollection(collection) }
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
            .padding(.bottom, contentBottomInset)
        }
    }

    // MARK: - Content

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
                    Text("暂无榜单内容")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, item in
                                AHRankItemCard(rank: index + 1, item: item)
                                    .padding(.horizontal, 12)

                                if index < viewModel.items.count - 1 {
                                    Divider()
                                        .padding(.leading, 12)
                                }
                            }
                        }
                        .padding(.bottom, contentBottomInset + 24)
                    }
                }
            }
        }
    }

    private var toolbarRow: some View {
        HStack(spacing: 8) {
            Spacer()

            Menu {
                Button("本周榜单") {
                    Task { await viewModel.selectWeekly() }
                }
                ForEach(viewModel.yearTabs) { tab in
                    Button(tab.title + "年度") {
                        Task { await viewModel.selectYear(tab.key) }
                    }
                }
            } label: {
                HStack(spacing: 3) {
                    Text(dateMenuTitle)
                        .font(.system(size: 12, weight: .medium))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 9, weight: .semibold))
                }
                .foregroundColor(.secondary)
            }

            Button {
                showFilterSheet = true
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
                    .frame(width: 28, height: 28)
            }
            .buttonStyle(.plain)
        }
    }

    private var dateMenuTitle: String {
        switch viewModel.mode {
        case .weekly:
            return viewModel.selectedCollection?.updatedDisplay ?? "更新"
        case .year(let year):
            return "\(year) 年度"
        case .category:
            return viewModel.selectedCollection?.updatedDisplay ?? "分类榜"
        }
    }

    // MARK: - Filter sheet

    private var filterSheet: some View {
        NavigationView {
            List {
                Section("电影类型榜单") {
                    ForEach(viewModel.movieCategoryTabs) { tab in
                        Button(tab.title) {
                            showFilterSheet = false
                            Task {
                                await viewModel.selectCategory(kind: .movie, key: tab.key)
                            }
                        }
                    }
                }

                Section("电视地区榜单") {
                    ForEach(viewModel.tvCategoryTabs) { tab in
                        Button(tab.title) {
                            showFilterSheet = false
                            Task {
                                await viewModel.selectCategory(kind: .tv, key: tab.key)
                            }
                        }
                    }
                }

                Section {
                    Button("回到本周榜单") {
                        showFilterSheet = false
                        Task { await viewModel.selectWeekly() }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("筛选榜单")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("关闭") { showFilterSheet = false }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
