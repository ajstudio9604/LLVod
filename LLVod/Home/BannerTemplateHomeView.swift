//
//  BannerTemplateHomeView.swift
//  LLVod
//
//  Created by minusapple on 2026/7/13.
//

import SwiftUI

struct BannerTemplateHomeView: View {

    @ObservedObject var viewModel: BannerViewModel

    let requestURL: String
    let containerWidth: CGFloat
    var refreshToken: Int = 0

    var body: some View {
        content
            .task(id: refreshToken) {
                if refreshToken == 0 {
                    await viewModel.loadIfNeeded(requestURL)
                } else {
                    await viewModel.getBanner(requestURL)
                }
            }
            .alert(
                "提示",
                isPresented: errorBinding
            ) {
                Button("确定", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(
                    viewModel.errorMessage ??
                    "服务器连接失败"
                )
            }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading &&
            viewModel.bannerData.isEmpty &&
            viewModel.listData.isEmpty {

            ProgressView("正在加载")
                .frame(maxWidth: .infinity)
                .frame(height: 320)

        } else {
            // 外层 HomeTemplateView 已经是 ScrollView，这里不能再套一层：
            // 套了之后本段的高度会被它自己框住，超出的内容被裁掉，
            // 外层 LazyVStack 里后面的分区也不再布局，页面下半截就是空白
            VStack(
                alignment: .leading,
                spacing: 24
            ) {
                if !viewModel.bannerData.isEmpty {
                    AHBannerSectionView(
                        items: viewModel.bannerData
                    )
                    .padding(.top, 12)
                }

                VideoListSectionView(
                    items: viewModel.listData,
                    containerWidth: containerWidth
                )
            }
        }
    }

    private var errorBinding: Binding<Bool> {
        Binding(
            get: {
                viewModel.errorMessage != nil
            },
            set: { isPresented in
                if !isPresented {
                    viewModel.errorMessage = nil
                }
            }
        )
    }
}

struct AHBannerSectionView: View {
    
    let items: [VideoItem]
    
    var body: some View {
        if !items.isEmpty {
            AHBannerCarouselView(banners: items)
                .frame(height: 180)
        }
    }
}

struct AHBannerCarouselView: View {
    
    let banners: [VideoItem]
    @State private var currentIndex = 0
    @State private var timer: Timer?

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<banners.count, id: \.self) { index in
                let vod = banners[index]
                AHSearchByTitleLink(title: vod.name) {
                    CachedAsyncImageView(url: URL(string: vod.pictureURL), contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                }
                .tag(index)
            }
        }
        .cornerRadius(16)
        .padding(.horizontal, 16)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onAppear {
            startAutoScroll()
        }
        .onDisappear {
            stopAutoScroll()
        }
    }
    
    private func startAutoScroll() {
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                currentIndex = (currentIndex + 1) % banners.count
            }
        }
    }
    
    private func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
}

struct VideoListSectionView: View {

    let items: [VideoItem]
    let containerWidth: CGFloat

    private var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    private let horizontalPadding: CGFloat = 16
    private let itemSpacing: CGFloat = 16
    private let rowSpacing: CGFloat = 16

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            Text("热播推荐")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal, horizontalPadding)

            if items.isEmpty {
                Text("暂无数据")
                    .foregroundColor(.secondary)
                    .padding(.horizontal, horizontalPadding)
            } else if isPad {
                iPadContent
            } else {
                iPhoneContent
            }
        }
    }

    // MARK: - iPad：单行横向滑动

    private var iPadContent: some View {
        let itemWidth = calculatePadItemWidth(
            containerWidth: containerWidth
        )

        return ScrollView(
            .horizontal,
            showsIndicators: false
        ) {
            LazyHStack(
                alignment: .top,
                spacing: itemSpacing
            ) {
                ForEach(items.indices, id: \.self) { index in
                    VideoGridCard(
                        item: items[index],
                        itemWidth: itemWidth
                    )
                }
            }
            .padding(.horizontal, horizontalPadding)
        }
        .frame(height: 250)
    }

    // MARK: - iPhone：两列，高度由卡片自己撑

    private var iPhoneContent: some View {
        let itemWidth = (containerWidth - horizontalPadding * 3) / 2

        let columns = [
            GridItem(.fixed(itemWidth), spacing: itemSpacing),
            GridItem(.fixed(itemWidth))
        ]

        return LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: rowSpacing
        ) {
            let displayItems = Array(items.prefix(4))

            ForEach(displayItems.indices, id: \.self) { index in
                VideoGridCard(
                    item: displayItems[index],
                    itemWidth: itemWidth
                )
            }
        }
        .padding(.horizontal, horizontalPadding)
    }

    private func calculatePadItemWidth(
        containerWidth: CGFloat
    ) -> CGFloat {
        let visibleCount: CGFloat = 4

        let availableWidth =
            containerWidth
            - horizontalPadding * 2
            - itemSpacing * (visibleCount - 1)

        return availableWidth / visibleCount
    }
}

struct VideoGridCard: View {

    let item: VideoItem
    var itemWidth: CGFloat? = nil

    var body: some View {
        AHSearchByTitleLink(title: item.name) {
            VStack(
                alignment: .leading,
            ) {
                imageView

                Text(item.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)

                if !item.remarks.isEmpty {
                    Text(item.remarks)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(width: itemWidth)
        }
    }

    private var imageView: some View {
        AsyncImage(
            url: URL(string: item.pictureURL)
        ) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Color.gray.opacity(0.15)
                    ProgressView()
                }

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()

            case .failure:
                ZStack {
                    Color.gray.opacity(0.15)

                    Image(systemName: "photo")
                        .foregroundColor(.secondary)
                }

            @unknown default:
                Color.gray.opacity(0.15)
            }
        }
        .frame(width: itemWidth)
        .aspectRatio(5 / 3, contentMode: .fill)
        .clipped()
        .clipShape(
            RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            )
        )
    }
}
