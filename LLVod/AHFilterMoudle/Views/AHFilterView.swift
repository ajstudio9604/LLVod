//
//  AHFilterView.swift
//  LLVod
//
//  对应 Flutter pagev3.dart：分类筛选 + 推荐列表
//

import SwiftUI

private struct FilterScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct AHFilterView: View {

    @StateObject private var viewModel = AHFilterViewModel()
    @State private var isFilterCollapsed = false
    @State private var bottomInset: CGFloat = 0

    private let filterExpandedHeight: CGFloat = 190
    private let filterCollapseThreshold: CGFloat = 120

    var body: some View {
        NavigationView {
            GeometryReader { containerProxy in
                ScrollViewReader { scrollProxy in
                    VStack(spacing: 0) {
                        if isFilterCollapsed {
                            AHFilterCollapsedBarView(
                                summaryText: viewModel.selectedFilterSummary
                            ) {
                                expandFilterPanel(scrollProxy: scrollProxy)
                            }

                            Divider()
                        }

                        ScrollView {
                            VStack(spacing: 0) {
                                scrollOffsetReader

                                if !isFilterCollapsed {
                                    expandedFilterPanel
                                        .id("filterPanelTop")
                                }

                                listContent(
                                    containerWidth: containerProxy.size.width,
                                    containerHeight: containerProxy.size.height
                                )
                            }
                        }
                        .coordinateSpace(name: "filterScroll")
                        .onPreferenceChange(FilterScrollOffsetKey.self) { minY in
                            guard !viewModel.items.isEmpty else { return }

                            let scrolledDistance = max(0, -minY)
                            let shouldCollapse = scrolledDistance > filterCollapseThreshold
                            guard shouldCollapse != isFilterCollapsed else { return }

                            withAnimation(.easeInOut(duration: 0.2)) {
                                isFilterCollapsed = shouldCollapse
                            }
                        }
                    }
                }
            }
            .ahTabRootIgnoreBottomSafeAreaIfNeeded()
            .navigationTitle("分类")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ahTabRootBottomInsetProbe($bottomInset)
        .task {
            await viewModel.loadIfNeeded()
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
    }

    private var scrollOffsetReader: some View {
        GeometryReader { geometry in
            Color.clear.preference(
                key: FilterScrollOffsetKey.self,
                value: geometry.frame(in: .named("filterScroll")).minY
            )
        }
        .frame(height: 0)
    }

    private func expandFilterPanel(scrollProxy: ScrollViewProxy) {
        withAnimation(.easeInOut(duration: 0.2)) {
            isFilterCollapsed = false
        }

        DispatchQueue.main.async {
            scrollProxy.scrollTo("filterPanelTop", anchor: .top)
        }
    }

    private var expandedFilterPanel: some View {
        VStack(spacing: 0) {
            AHFilterBarView(
                options: AHFilterOptions.mediaTypes,
                selectedIndex: viewModel.selectedMediaTypeIndex
            ) { index in
                Task { await viewModel.selectMediaType(at: index) }
            }

            AHFilterBarView(
                options: AHFilterOptions.genres,
                selectedIndex: viewModel.selectedGenreIndex
            ) { index in
                Task { await viewModel.selectGenre(at: index) }
            }

            AHFilterBarView(
                options: AHFilterOptions.regions,
                selectedIndex: viewModel.selectedRegionIndex
            ) { index in
                Task { await viewModel.selectRegion(at: index) }
            }

            AHFilterBarView(
                options: viewModel.yearOptions,
                selectedIndex: viewModel.selectedYearIndex
            ) { index in
                Task { await viewModel.selectYear(at: index) }
            }

            AHFilterBarView(
                options: AHFilterOptions.sortOptions,
                selectedIndex: viewModel.selectedSortIndex
            ) { index in
                Task { await viewModel.selectSort(at: index) }
            }
        }
        .frame(height: filterExpandedHeight)
        .background(Color(.systemBackground))
    }

    @ViewBuilder
    private func listContent(containerWidth: CGFloat, containerHeight: CGFloat) -> some View {
        if viewModel.isLoading && viewModel.items.isEmpty {
            ProgressView("正在加载")
                .frame(maxWidth: .infinity)
                .frame(minHeight: 320)
        } else if viewModel.items.isEmpty {
            VStack(spacing: 12) {
                Image(systemName: "square.grid.3x3")
                    .font(.system(size: 36))
                    .foregroundColor(.secondary)
                Text("暂无内容")
                    .font(.headline)
                Text("试试调整筛选条件")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 320)
        } else {
            mediaGridContent(
                containerWidth: containerWidth,
                isLandscape: containerWidth > containerHeight
            )
        }
    }

    private func mediaGridContent(
        containerWidth: CGFloat,
        isLandscape: Bool
    ) -> some View {
        let layout = AHPosterGridLayout.metrics(
            containerWidth: containerWidth,
            isLandscape: isLandscape
        )

        return Group {
            LazyVGrid(columns: layout.columns, spacing: layout.rowSpacing) {
                ForEach(viewModel.items) { item in
                    AHFilterMediaCardView(
                        item: item,
                        itemWidth: layout.itemWidth
                    )
                    .task {
                        await viewModel.loadMoreIfNeeded(currentItem: item)
                    }
                }
            }
            .padding(.leading, layout.leadingPadding)
            .padding(.trailing, layout.trailingPadding)
            .padding(.top, 10)
            .padding(.bottom, contentBottomInset + 16)

            if viewModel.isLoadingMore {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
            }
        }
    }

    private var contentBottomInset: CGFloat {
        AHTabRootBottomLayout.contentBottomInset(measuredSafeAreaBottom: bottomInset)
    }

}

#Preview {
    AHFilterView()
}
