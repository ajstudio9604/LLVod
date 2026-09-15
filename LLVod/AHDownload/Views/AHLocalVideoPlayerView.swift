//
//  AHLocalVideoPlayerView.swift
//  LLVod
//
//  离线播放，直接进详情页那套横屏播放器
//

import SwiftUI

struct AHLocalFullscreenPlayerView: View {

    let url: URL
    let title: String
    let episodeTitle: String

    @StateObject private var playerViewModel = AHVideoPlayerViewModel(url: "")
    @StateObject private var detailViewModel: AHVodDetailViewModel

    init(url: URL, title: String = "", episodeTitle: String = "") {
        self.url = url
        self.title = title
        self.episodeTitle = episodeTitle

        // 播放器组件要靠详情 VM 取片名做弹幕，本地播放给一个不联网的空壳
        _detailViewModel = StateObject(
            wrappedValue: AHVodDetailViewModel(
                route: AHVodDetailRoute(
                    name: title,
                    path: url.absoluteString,
                    sourceName: "本地缓存",
                    videoLinkId: "",
                    pic: "",
                    zypath: ""
                )
            )
        )
    }

    var body: some View {
        AHFullscreenPlayerView(
            vm: detailViewModel,
            viewModel: playerViewModel
        )
        .onAppear {
            TADHalfInterstitialScheduler.shared.enterPlayPage()
            // 离线播放可能没进过详情页，弹幕数据源要自己接一次
            AHVodDanmakuBridge.install()
            playerViewModel.setVideoInfo(
                vodId: "",
                vodName: title.isEmpty ? "本地缓存" : title,
                vodPic: nil,
                sourceIndex: 0,
                episodeIndex: 0,
                episodeName: episodeTitle
            )
            playerViewModel.updatePlayURL(url.absoluteString)
        }
        .onDisappear {
            TADHalfInterstitialScheduler.shared.leavePlayPage()
            playerViewModel.pause()
        }
    }
}
