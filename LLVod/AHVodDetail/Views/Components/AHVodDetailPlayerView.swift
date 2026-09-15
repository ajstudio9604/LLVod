//
//  AHVodDetailPlayerView.swift
//  LLVod
//
//  详情页顶部播放器，内部使用 AHVideoPlayerSharedView
//

import SwiftUI

struct AHVodDetailPlayerView: View {

    @ObservedObject var viewModel: AHVodDetailViewModel
    @ObservedObject var playerViewModel: AHVideoPlayerViewModel

    var body: some View {
        ZStack {
            AHVideoPlayerSharedView(
                viewModel: viewModel,
                playerViewModel: playerViewModel,
                onNextEpisode: {
                    viewModel.playNextEpisode()
                },
                vodSources: viewModel.payload?.sourceLines,
                selectedSourceIndex: viewModel.selectedLineIndex,
                selectedEpisodeIndex: viewModel.selectedEpisodeIndex,
                onSourceChanged: { newSourceIndex in
                    viewModel.selectLine(at: newSourceIndex)
                },
                onEpisodeChanged: { newEpisodeIndex in
                    viewModel.selectEpisode(at: newEpisodeIndex)
                }
            )

            // 播放地址解析状态（AH 详情页独有）
            if viewModel.isResolvingPlayURL {
                ZStack {
                    Color.black.opacity(0.6)
                    ProgressView("正在解析...")
                        .tint(.white)
                        .foregroundColor(.white)
                }
            } else if viewModel.resolvedPlayURL.isEmpty && !viewModel.playStatusMessage.isEmpty {
                ZStack {
                    Color.black.opacity(0.6)

                    VStack(spacing: 8) {
                        Image(systemName: "play.rectangle")
                            .font(.system(size: 36))
                            .foregroundColor(.white.opacity(0.8))

                        Text(viewModel.playStatusMessage)
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)

                        if viewModel.playStatusMessage != "请选择集数" {
                            Button("重试解析") {
                                viewModel.retryResolve()
                            }
                            .font(.footnote)
                            .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}
