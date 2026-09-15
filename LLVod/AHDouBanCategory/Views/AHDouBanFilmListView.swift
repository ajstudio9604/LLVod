//
//  AHDouBanFilmListView.swift
//  LLVod
//
//  片单专辑页（对应 Flutter hometab/Film.dart）：
//  顶部是片单封面模糊后的大图，标题压在图上，下面是三列海报网格。
//  item 布局和点击行为都跟分类页一致：点一下用片名进搜索页
//

import SwiftUI

private struct FilmListHeaderBottomKey: PreferenceKey {
    static var defaultValue: CGFloat = .greatestFiniteMagnitude

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = min(value, nextValue())
    }
}

struct AHDouBanFilmListView: View {

    let playlist: AHDouBanPlaylistItem

    @StateObject private var viewModel: AHDouBanFilmListViewModel
    @Environment(\.presentationMode) private var presentationMode
    @State private var isBarCollapsed = false
    @State private var hasMeasuredHeader = false

    private let headerHeight: CGFloat = 180
    private let barHeight: CGFloat = 44

    init(playlist: AHDouBanPlaylistItem) {
        self.playlist = playlist
        _viewModel = StateObject(
            wrappedValue: AHDouBanFilmListViewModel(
                playlistID: playlist.id,
                expectedCount: playlist.itemsCount
            )
        )
    }

    var body: some View {
        GeometryReader { proxy in
            // 安全区要在忽略之前量：头图铺到状态栏底下，顶栏自己让出这段高度
            let safeTop = proxy.safeAreaInsets.top

            ZStack(alignment: .top) {
                scrollContent(
                    containerWidth: proxy.size.width,
                    containerHeight: proxy.size.height,
                    safeTop: safeTop
                )

                topBar(safeTop: safeTop)
            }
            .ignoresSafeArea(.container, edges: .top)
        }
        .background(Color(.systemBackground))
        .ahHideNavigationBar()
        .ahHideTabBar()
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

    private func scrollContent(
        containerWidth: CGFloat,
        containerHeight: CGFloat,
        safeTop: CGFloat
    ) -> some View {
        ScrollView {
            VStack(spacing: 0) {
                header(width: containerWidth, safeTop: safeTop)

                listContent(
                    containerWidth: containerWidth,
                    isLandscape: containerWidth > containerHeight
                )
            }
        }
        .onPreferenceChange(FilmListHeaderBottomKey.self) { headerBottom in
            // 头图快滚完了就把顶栏换成实底，压在图上的白字才不会糊在内容上
            let collapsed = headerBottom <= safeTop + barHeight

            // push 转场途中会先量到一个页面还没就位的值，那时别急着折叠，
            // 否则顶栏会在进场动画里闪一下实底
            if !collapsed {
                hasMeasuredHeader = true
            }

            guard hasMeasuredHeader, collapsed != isBarCollapsed else { return }

            withAnimation(.easeInOut(duration: 0.2)) {
                isBarCollapsed = collapsed
            }
        }
    }

    private func header(width: CGFloat, safeTop: CGFloat) -> some View {
        let height = headerHeight + safeTop

        return ZStack {
            CachedAsyncImageView(url: URL(string: headerImageURL))
                .frame(width: width, height: height)
                // opaque 让模糊不吃掉边缘，不然四周会透出底色
                .blur(radius: 6, opaque: true)

            // 标题是白色，加一层压暗保证亮底封面也看得清
            LinearGradient(
                colors: [
                    Color.black.opacity(0.28),
                    Color.black.opacity(0.12),
                    Color.black.opacity(0.3)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .frame(width: width, height: height)
        .clipped()
        .background(headerBottomReader)
    }

    private var headerBottomReader: some View {
        GeometryReader { geometry in
            Color.clear.preference(
                key: FilmListHeaderBottomKey.self,
                value: geometry.frame(in: .global).maxY
            )
        }
    }

    private var headerImageURL: String {
        playlist.headerBgImage.isEmpty ? playlist.coverURL : playlist.headerBgImage
    }

    private func topBar(safeTop: CGFloat) -> some View {
        HStack(spacing: 0) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: barHeight, height: barHeight)
            }

            Spacer(minLength: 4)

            Text(playlist.title)
                .font(.system(size: 15, weight: .bold))
                .lineLimit(1)

            Spacer(minLength: 4)

            // 占位撑出和返回按钮等宽的右侧，标题才是真居中
            Color.clear
                .frame(width: barHeight, height: barHeight)
        }
        .foregroundColor(isBarCollapsed ? .primary : .white)
        .frame(height: barHeight)
        .padding(.top, safeTop)
        .background(barBackground)
    }

    @ViewBuilder
    private var barBackground: some View {
        if isBarCollapsed {
            VStack(spacing: 0) {
                Color(.systemBackground)
                Divider()
            }
        } else {
            Color.clear
        }
    }

    @ViewBuilder
    private func listContent(
        containerWidth: CGFloat,
        isLandscape: Bool
    ) -> some View {
        if viewModel.isLoading && viewModel.items.isEmpty {
            ProgressView("正在加载")
                .frame(maxWidth: .infinity)
                .frame(minHeight: 320)
        } else if viewModel.items.isEmpty {
            emptyState
        } else {
            mediaGrid(containerWidth: containerWidth, isLandscape: isLandscape)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "film.stack")
                .font(.system(size: 36))
                .foregroundColor(.secondary)

            Text("暂无内容")
                .font(.headline)

            Button("重新加载") {
                Task { await viewModel.reload() }
            }
            .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 320)
    }

    private func mediaGrid(
        containerWidth: CGFloat,
        isLandscape: Bool
    ) -> some View {
        // 网格尺寸和分类页共用一套
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
            .padding(.bottom, 16)

            if viewModel.isLoadingMore {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
            }
        }
    }
}

#Preview {
    NavigationView {
        AHDouBanFilmListView(
            playlist: AHDouBanPlaylistItem(
                id: "EC65ACL5Y",
                title: "2026年08月定档热门电影推荐",
                coverURL: "",
                headerBgImage: "",
                itemsCount: 40
            )
        )
    }
}
