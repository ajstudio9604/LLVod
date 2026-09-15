//
//  AHVodDetailView.swift
//  LLVod
//
//  对应 Flutter VideoDetailPage / bfqxj.dart
//

import SwiftUI
import AVKit
import SwiftUIPager

struct AHVodDetailView: View {

    @StateObject private var viewModel: AHVodDetailViewModel
    @StateObject private var playerViewModel = AHVideoPlayerViewModel(url: "")
    @State private var updateWorkItem: DispatchWorkItem?
    @Environment(\.dismiss) private var dismiss

    @State private var selectedIndex: Int = 0
    @State private var page = Page.withIndex(0)
    @State private var tabTitles: [AHVodDetailTab] = [
        AHVodDetailTab(text: "剧集", index: 0),
        AHVodDetailTab(text: "评论", index: 1)
    ]

    init(route: AHVodDetailRoute, resumeRecord: AHVodPlayRecord? = nil) {
        _viewModel = StateObject(
            wrappedValue: AHVodDetailViewModel(route: route, resumeRecord: resumeRecord)
        )
    }

    var tabHeader: some View {
        AHVodDetailTabHeaderView(
            tabs: tabTitles,
            selectedIndex: $selectedIndex
        ) { index in
            page.update(.new(index: index))
        }
    }

    @ViewBuilder
    func pageView(_ tab: AHVodDetailTab) -> some View {
        if tab.index == 0 {
            if let payload = viewModel.payload {
                AHVodDetailInfoTabView(viewModel: viewModel, payload: payload)
            } else {
                errorPlaceholder
            }
        } else {
            AHVodDetailCommentTabView(
                // target_id 直接用影片名，跨源同一部片评论才能汇到一起
                targetId: viewModel.payload?.title ?? viewModel.route.name,
                title: viewModel.payload?.title ?? viewModel.route.name,
                pic: viewModel.route.pic,
                sourceName: viewModel.route.sourceName
            )
        }
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)

                    Spacer()
                }
            } else {

                // 播放器
                AHVodDetailPlayerView(
                    viewModel: viewModel,
                    playerViewModel: playerViewModel
                )
                .frame(height: 220)
                .onAppear {
                    if !viewModel.isLoading {
                        self.updatePlayerWithCurrentVideo()
                    }
                }
                .onChange(of: viewModel.selectedLineIndex) { _ in
                    // 切换播放源时更新
                    self.updatePlayerWithCurrentVideo()
                }
                .onChange(of: viewModel.selectedEpisodeIndex) { _ in
                    // 切换集数时更新
                    self.updatePlayerWithCurrentVideo()
                }

                HStack {
                    tabHeader
//                    AHVodDetailSearchBarView {
//                        tabTitles[1] = AHVodDetailTab(text: "评论(56)", index: 1)
//                    }
                }
                .frame(height: 32)

                Divider()
                    .background(Color(red: 254 / 255, green: 254 / 255, blue: 254 / 255))

                GeometryReader { proxy in
                    Pager(
                        page: page,
                        data: tabTitles,
                        id: \.id
                    ) { tab in
                        pageView(tab)
                    }
                    .onPageChanged { index in
                        selectedIndex = index
                    }
                    .frame(width: proxy.size.width,
                           height: proxy.size.height)
                }
            }
        }
        .background(Color(.systemBackground))
        .onAppear {
            TADHalfInterstitialScheduler.shared.enterPlayPage()
            AHVodDanmakuBridge.install()
            playerViewModel.onProgressUpdate = { position, duration in
                viewModel.savePlayProgress(position: position, duration: duration)
            }
            viewModel.loadDetail()
        }
        .onDisappear {
            TADHalfInterstitialScheduler.shared.leavePlayPage()
            // 退出时补记一次，不然最后不满一个上报周期的进度会丢
            viewModel.savePlayProgress(
                position: playerViewModel.currentTime,
                duration: playerViewModel.duration,
                syncRemoteImmediately: true
            )
            // 先掐解析再停播：只 pause 挡不住解析完成后的起播，
            // 表现就是页面已经 pop 掉了，后台还在出声
            viewModel.deactivate()
            updateWorkItem?.cancel()
            playerViewModel.stop()
        }
        .onChange(of: viewModel.resolvedPlayURL) { url in
            // 页面已经离开就别再喂给播放器
            guard viewModel.isActive else { return }
            // AH 详情页解析完成后再交给播放器，file:// 是已下载的本地缓存
            guard url.hasPrefix("http") || url.hasPrefix("file://") else { return }
            AHVodDanmakuBridge.updatePlayURL(url)
            playerViewModel.updatePlayURL(
                url,
                headers: viewModel.resolvedPlayHeaders,
                startAt: viewModel.takeResumePosition()
            )
        }
        .ahHideNavigationBar()
        .ahHideTabBar()
        .ahFixLayoutAfterRotation()
    }

    private var errorPlaceholder: some View {
        VStack(spacing: 12) {
            Text(viewModel.errorMessage ?? "加载失败")
                .foregroundColor(.secondary)
            Button("返回") { dismiss() }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func updatePlayerWithCurrentVideo() {
        // 取消之前的待执行任务
        updateWorkItem?.cancel()

        // 创建新的延迟任务
        let workItem = DispatchWorkItem {
            guard let payload = viewModel.payload else { return }

            let episodeName = viewModel.currentEpisode?.title
                ?? "第\(viewModel.selectedEpisodeIndex + 1)集"

            // 弹幕接口需要源标识名和集地址，换源换集时同步过去
            AHVodDanmakuBridge.update(
                AHVodDanmakuContext(
                    title: payload.title,
                    sourceTag: viewModel.currentLine?.sourceTag ?? "",
                    zypath: viewModel.route.zypath,
                    episodeTitle: episodeName,
                    episodePath: viewModel.currentEpisode?.path ?? "",
                    playURL: viewModel.resolvedPlayURL,
                    episodeIndex: viewModel.selectedEpisodeIndex + 1
                )
            )

            playerViewModel.setVideoInfo(
                vodId: viewModel.route.videoLinkId,
                vodName: payload.title,
                vodPic: payload.pic,
                sourceIndex: viewModel.selectedLineIndex,
                episodeIndex: viewModel.selectedEpisodeIndex,
                episodeName: episodeName
            )

            // 播放地址由 AHVodDetailViewModel 异步解析，这里只重置播放器状态
            playerViewModel.errorMessage = nil
            playerViewModel.isLoading = true
        }

        updateWorkItem = workItem
        // 延迟100ms执行，如果在这期间再次调用，则会取消之前的任务
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: workItem)
    }
}

#Preview {
    NavigationView {
        AHVodDetailView(
            route: AHVodDetailRoute(
                name: "测试影片",
                path: "https://example.com",
                sourceName: "测试源",
                videoLinkId: "1",
                pic: "",
                zypath: "dyy壹影视订阅"
            )
        )
    }
}
