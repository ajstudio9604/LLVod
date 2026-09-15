//
//  AHHomeView.swift
//  LLVod
//
//  Created by minusapple on 2026/7/13.
//

import SwiftUI
import SwiftUIPager

struct AHHomeView: View {

    @StateObject private var vm = HomeApiViewModel()
    @StateObject private var bannerViewModel = BannerViewModel()
    @State private var selectedIndex: Int = 0
    @State private var page = Page.withIndex(0)
    @State private var hasLoaded: Bool = false
    @State private var bottomInset: CGFloat = 0
    @State private var showSearch = false
    @State private var showDownload = false
    @State private var showHistory = false

    var tabHeader: some View {
        let tabs = Array(vm.homeTypes)
        
        return ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(Array(tabs.enumerated()), id: \.element.id) { index, tab in
                        Button {
                            withAnimation(.easeInOut) {
                                selectedIndex = index
                                page.update(.new(index: index))
                                
                                // ⭐️ 关键：选中后滚动到中间
                                proxy.scrollTo(tab.id, anchor: .center)
                            }
                        } label: {
                            VStack(spacing: 6) {
                                Text(tab.name)
                                    .font(.system(
                                        size: selectedIndex == index ? 18 : 16,
                                        weight: selectedIndex == index ? .bold : .regular
                                    ))
                                    .foregroundColor(
                                        selectedIndex == index ? .red : .gray
                                    )
                                
                                Capsule()
                                    .fill(selectedIndex == index ? .red : .clear)
                                    .frame(width: 16, height: 3)
                            }
                        }
                        .id(tab.id)          // ⭐️ 必须有
                        .padding(.top, 8)
                    }
                }
                .padding(.horizontal, 20)
            }
            .onAppear {
                // ⭐️ 首次进入时也居中当前选中项
                DispatchQueue.main.async {
                    if selectedIndex < tabs.count {
                        proxy.scrollTo(tabs[selectedIndex].id, anchor: .center)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func pageView(_ tab: AHHomeTabItem) -> some View {
        Group {
            if tab.mode == 0 {
                HomeTemplateView(
                    viewModel: vm,
                    bannerViewModel: bannerViewModel,
                    bottomInset: contentBottomInset
                )
            } else {
                AHHomeCategoryView(
                    viewModel: vm,
                    mode: tab.mode,
                    bottomInset: contentBottomInset
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // iPadOS 15 上 NavigationBar toolbar 的搜索项经常被压成空白，
                // 改成自绘顶栏，各系统版本表现一致
                homeTopBar

                tabHeader

                // 不把高度钉在量出来的值上：Pager 内部本身就是 GeometryReader，
                // 会自己撑满剩余空间。之前套一层 GeometryReader 再 .frame(height:) 钉死，
                // 从别的页面返回时那个值会停在旧的布局上，底部就空出一条白
                Pager(
                    page: page,
                    data: Array(vm.homeTypes),
                    id: \.id
                ) { tab in
                    pageView(tab)
                }
                .onPageChanged { index in
                    selectedIndex = index
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // 内容铺到透明 TabBar 底下；末尾遮挡由 bottomInset 顶开
            .ahTabRootIgnoreBottomSafeAreaIfNeeded()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .ahHideNavigationBar()
            .background(homeNavigationLinks)
        }
        .onAppear() {
            guard !hasLoaded else { return }
            hasLoaded = true

            // 弹幕接口等配置在这里拉，对应 Flutter pagev1 initState 里的 getgx
            Task { await AHAppConfigService.ensureLoaded() }

            // 订阅站源也在这里预热，对应 Flutter 的更新已有订阅
            Task { await AHSearchSubscriptionLoader.prefetch() }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ahTabRootBottomInsetProbe($bottomInset)
        .ahFixLayoutAfterRotation()
        
    }

    private var homeTopBar: some View {
        HStack(spacing: 4) {
            Button {
                showSearch = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)

                    Text("请输入关键字")
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
                Image(systemName: "arrow.down.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
                    .frame(width: 32, height: 34)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Button {
                showHistory = true
            } label: {
                Image(systemName: "clock.arrow.circlepath")
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

    private var homeNavigationLinks: some View {
        ZStack {
            NavigationLink(
                destination: AHSearchView(autoFocusSearchField: true),
                isActive: $showSearch
            ) { EmptyView() }

            NavigationLink(
                destination: AHDownloadManagerView(),
                isActive: $showDownload
            ) { EmptyView() }

            NavigationLink(
                destination: AHVodPlayHistoryView(),
                isActive: $showHistory
            ) { EmptyView() }
        }
        .frame(width: 0, height: 0)
        .hidden()
        .allowsHitTesting(false)
    }

    private var contentBottomInset: CGFloat {
        AHTabRootBottomLayout.contentBottomInset(measuredSafeAreaBottom: bottomInset)
    }
}
