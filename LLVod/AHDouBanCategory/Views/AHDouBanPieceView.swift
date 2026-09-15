//
//  AHDouBanPieceView.swift
//  LLVod
//

import SwiftUI

struct AHDouBanPieceView: View {

    @ObservedObject var viewModel: AHDouBanPieceViewModel
    var bottomInset: CGFloat = 0

    private let leadingPadding: CGFloat = 16
    private let trailingPadding: CGFloat = 16
    private let itemSpacing: CGFloat = 16
    private let rowSpacing: CGFloat = 16
    private let padLandscapeColumns = 6
    private let padPortraitColumns = 5
    private let padItemSpacing: CGFloat = 12
    private let padRowSpacing: CGFloat = 16

    private var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    var body: some View {
        Group {
            if viewModel.isRefreshing && viewModel.items.isEmpty {
                ProgressView("正在加载")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.items.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "film.stack")
                        .font(.system(size: 36))
                        .foregroundColor(.secondary)
                    Text("暂无片单")
                        .font(.headline)
                    Text("下拉刷新试试")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                contentGrid
            }
        }
        .task {
            await viewModel.loadIfNeeded()
        }
        .refreshable {
            await viewModel.refresh()
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

    private var contentGrid: some View {
        GeometryReader { proxy in
            let isLandscape = proxy.size.width > proxy.size.height
            let columnsCount = padColumnsCount(isLandscape: isLandscape)
            let itemWidth = itemWidth(
                for: proxy.size.width,
                columnsCount: columnsCount
            )
            let columns = gridColumns(
                itemWidth: itemWidth,
                columnsCount: columnsCount
            )

            ScrollView {
                LazyVGrid(
                    columns: columns,
                    spacing: isPad ? padRowSpacing : rowSpacing
                ) {
                    ForEach(viewModel.items) { item in
                        NavigationLink {
                            AHDouBanFilmListView(playlist: item)
                        } label: {
                            AHDouBanPlaylistCardView(
                                item: item,
                                itemWidth: itemWidth
                            )
                        }
                        .buttonStyle(.plain)
                        .task {
                            await viewModel.loadMoreIfNeeded(currentItem: item)
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

    private func padColumnsCount(isLandscape: Bool) -> Int {
        guard isPad else { return 2 }
        return isLandscape ? padLandscapeColumns : padPortraitColumns
    }

    private func itemWidth(for containerWidth: CGFloat, columnsCount: Int) -> CGFloat {
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

    private func gridColumns(itemWidth: CGFloat, columnsCount: Int) -> [GridItem] {
        if isPad {
            return Array(
                repeating: GridItem(.fixed(itemWidth), spacing: padItemSpacing),
                count: columnsCount
            )
        }

        return [
            GridItem(.fixed(itemWidth), spacing: itemSpacing),
            GridItem(.fixed(itemWidth))
        ]
    }
}
