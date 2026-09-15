//
//  HomeView.swift
//  LLVod
//
//  Created by minusapple on 2026/7/13.
//

import SwiftUI

struct HomeTemplateView: View {

    @ObservedObject var viewModel: HomeApiViewModel
    @ObservedObject var bannerViewModel: BannerViewModel
    var bottomInset: CGFloat = 0
    @State private var refreshToken = 0

    // 外层 AHHomeView 已经提供 NavigationView，这里不能再套一层，
    // 否则卡片里的 NavigationLink 会 push 到内层栈上，出现双导航栏
    var body: some View {
        Group {
            if viewModel.isLoading &&
                viewModel.hotMovieList.isEmpty &&
                bannerViewModel.bannerData.isEmpty &&
                bannerViewModel.listData.isEmpty {

                ProgressView("正在加载")

            } else {
                contentView
            }
        }
        .task {
            // 只在还没数据时拉；ViewModel 挂在 AHHomeView 上，切 tab 不会丢
            await viewModel.loadIfNeeded()
        }
        .refreshable {
            // 轮播那段通过 refreshToken 自己再拉一次
            refreshToken += 1
            await viewModel.getHttp()
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

    // 整页只有这一个 ScrollView：轮播那一段以前自己又套了一层，
    // 内容超出它写死的高度就会被裁掉，后面的热门分区也跟着不布局，
    // 表现就是页面下半截空白。宽度在这里量一次往下传，分类页也是这么做的
    private var contentView: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    BannerTemplateHomeView(
                        viewModel: bannerViewModel,
                        requestURL: "https://login.yiys07.com/zy.json",
                        containerWidth: proxy.size.width,
                        refreshToken: refreshToken
                    )

                    MediaSectionView(
                        title: "热门电影",
                        items: viewModel.hotMovieList
                    )

                    MediaSectionView(
                        title: "热门电视剧",
                        items: viewModel.hotTVList
                    )

                    MediaSectionView(
                        title: "热门动漫",
                        items: viewModel.hotAnimeList
                    )

                    MediaSectionView(
                        title: "热门综艺",
                        items: viewModel.hotVarietyList
                    )
                }
                .padding(.bottom, bottomInset + 16)
            }
        }
    }
}

struct MediaSectionView: View {

    let title: String
    let items: [HotMediaItem]

    private var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)

            if items.isEmpty {
                Text("暂无数据")
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            } else if isPad {
                iPadContent
            } else {
                iPhoneContent
            }
        }
    }

    // MARK: - iPad：单行横向滑动

    private var iPadContent: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(items) { item in
                    MediaCardView(item: item)
                }
            }
            .padding(.horizontal)
        }
    }

    // MARK: - iPhone：固定两行，每行三个，不滑动

    private var iPhoneContent: some View {
        LazyVGrid(
            columns: phoneColumns,
            alignment: .center,
            spacing: 16
        ) {
            ForEach(Array(items.prefix(6))) { item in
                MediaCardView(item: item)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var phoneColumns: [GridItem] {
        Array(
            repeating: GridItem(
                .fixed(120),
                spacing: 12,
                alignment: .top
            ),
            count: 3
        )
    }
}

struct MediaCardView: View {

    let item: HotMediaItem

    var body: some View {
        AHSearchByTitleLink(title: item.title) {
            VStack(alignment: .leading, spacing: 8) {
                CachedAsyncImageView(url: URL(string: item.imageURL))
                    .frame(width: 120, height: 168)
                    .background(Color.gray.opacity(0.08))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .clipped()

                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)

                Text(item.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .frame(width: 120, alignment: .leading)
        }
    }
}
