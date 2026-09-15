//
//  AHVideoPlayerSharedView.swift
//  LLVod
//

import SwiftUI
import AVKit

struct AHVideoPlayerSharedView: View {
    @ObservedObject var viewModel: AHVodDetailViewModel
    @ObservedObject var playerViewModel: AHVideoPlayerViewModel
    @State private var showFullscreen = false
    @State private var showPortraitFullscreen = false

    var onNextEpisode: (() -> Void)? = nil
    var onSelectSource: (() -> Void)? = nil
    var onSelectEpisode: (() -> Void)? = nil

    // 传递视频详情数据用于横屏选择
    var vodSources: [AHVodSourceLine]? = nil
    var selectedSourceIndex: Int = 0
    var selectedEpisodeIndex: Int = 0
    var onSourceChanged: ((Int) -> Void)? = nil
    var onEpisodeChanged: ((Int) -> Void)? = nil

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()

                // 视频层
                AHAVPlayerContainerView(player: playerViewModel.player, isFillScreen: playerViewModel.isVideoFillScreen)

                // 弹幕层
                AHDanmakuOverlayView(playerViewModel: playerViewModel)

                // 缓冲指示器
                if playerViewModel.isBuffering && !playerViewModel.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        Text("缓冲中...")
                            .foregroundColor(.white)
                            .font(.system(size: 14))

                        if playerViewModel.bufferProgress > 0 {
                            Text("已缓冲 \(Int(playerViewModel.bufferProgress * 100))%")
                                .foregroundColor(.white.opacity(0.7))
                                .font(.system(size: 12))
                        }
                    }
                }

                // 加载指示器
                if playerViewModel.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        Text("加载中...")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                }

                // 长按加速提示
                if playerViewModel.isLongPressing {
                    VStack {
                        Spacer()
                        HStack(spacing: 8) {
                            Image(systemName: "hare.fill")
                                .font(.system(size: 20))
                            Text("2倍速播放中")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.green.opacity(0.9))
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.3), radius: 8)
                        Spacer().frame(height: 100)
                    }
                }

                // 错误提示
                if let error = playerViewModel.errorMessage {
                    ZStack {
                        Color.black.opacity(0.85)

                        VStack(spacing: 20) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.orange)

                            Text(error)
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .medium))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                                .lineSpacing(4)
                        }
                    }
                }

                // 控制层
                if playerViewModel.showControls {
                    AHPortraitControlsView(
                        viewModel: playerViewModel,
                        onNextEpisode: onNextEpisode,
                        onFullscreen: {
                            if playerViewModel.isVerticalVideo {
                                showPortraitFullscreen = true
                            } else {
                                showFullscreen = true
                            }
                        }
                    )
                }
            }
            .contentShape(Rectangle())
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            playerViewModel.toggleControls()
                        }
                    }
            )
        }
        .background(Color.black)
        .onAppear {
            // 将回调传递给 playerViewModel
            playerViewModel.onNextEpisode = onNextEpisode
            playerViewModel.onSelectSource = onSelectSource
            playerViewModel.onSelectEpisode = onSelectEpisode
        }
        .ahFullscreen(isPresented: $showFullscreen) {
            AHFullscreenPlayerView(
                vm: viewModel,
                viewModel: playerViewModel,
                vodSources: vodSources,
                selectedSourceIndex: selectedSourceIndex,
                selectedEpisodeIndex: selectedEpisodeIndex,
                onSourceChanged: onSourceChanged,
                onEpisodeChanged: onEpisodeChanged,
                onNextEpisode: onNextEpisode
            )
            .transition(.opacity.combined(with: .scale(scale: 0.95)))
        }
        .fullScreenCover(isPresented: $showPortraitFullscreen) {
            AHPortraitFullscreenPlayerView(
                vm: viewModel,
                viewModel: playerViewModel,
                vodSources: vodSources,
                selectedSourceIndex: selectedSourceIndex,
                selectedEpisodeIndex: selectedEpisodeIndex,
                onSourceChanged: onSourceChanged,
                onEpisodeChanged: onEpisodeChanged,
                onNextEpisode: onNextEpisode
            )
            .transition(.opacity.combined(with: .scale(scale: 0.95)))
        }
    }
}

// MARK: - AVPlayer容器视图
struct AHAVPlayerContainerView: UIViewControllerRepresentable {
    let player: AVPlayer
    let isFillScreen: Bool

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = isFillScreen ? .resizeAspectFill : .resizeAspect
        controller.view.backgroundColor = .black
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
        uiViewController.videoGravity = isFillScreen ? .resizeAspectFill : .resizeAspect
    }
}

// MARK: - 竖屏控制层
struct AHPortraitControlsView: View {
    @ObservedObject var viewModel: AHVideoPlayerViewModel
    var onNextEpisode: (() -> Void)?
    var onFullscreen: (() -> Void)?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            // 顶部信息栏
            HStack(spacing: 12) {
                // 视频标题和集数（避开安全区域）
                if let vodName = viewModel.vodName {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                            HStack {
                                Text(vodName)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                if let episodeName = viewModel.currentEpisodeName {
                                    Text(episodeName)
                                        .font(.system(size: 11))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                        }
                        .padding(.leading, 12)
                    }
                }

                Spacer()

                // AirPlay / DLNA 投屏
                AHCastButton(viewModel: viewModel)
                    .padding(.trailing, 16)
            }
            .padding(.top, 8)
            .padding(.bottom, 4)
            .background(
                LinearGradient(
                    colors: [Color.black.opacity(0.7), Color.clear],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )

            Spacer()

            // 中间播放按钮
            if !viewModel.isPlaying {
                Button(action: { viewModel.play() }) {
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.5))
                            .frame(width: 60, height: 60)
                        Image(systemName: "play.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                }
            }

            Spacer()

            // 底部控制栏
            VStack(spacing: 5) {
                HStack(spacing: 0) {
                    // 左侧按钮组
                    HStack(spacing: 0) {
                        // 播放/暂停
                        Button(action: { viewModel.togglePlayPause() }) {
                            Image(systemName: viewModel.isPlaying ? "pause" : "play")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .frame(width: 32, height: 35)
                        }

                        // 下一集
                        if onNextEpisode != nil {
                            Button(action: { onNextEpisode?() }) {
                                Image(systemName: "forward.end")
                                    .font(.system(size: 17))
                                    .foregroundColor(.white)
                                    .frame(width: 32, height: 35)
                            }
                        }
                    }

                    HStack(spacing: 4) {
                        Text(AHVideoPlayerViewModel.formatTime(viewModel.currentTime))
                            .font(.system(size: 11, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                            .frame(minWidth: 38, alignment: .trailing)
                            .padding(.trailing, 4)

                        AHProgressSlider(viewModel: viewModel)
                            .frame(maxWidth: .infinity, maxHeight: 20)

                        Text(AHVideoPlayerViewModel.formatTime(viewModel.duration))
                            .font(.system(size: 11, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                            .frame(minWidth: 38, alignment: .leading)
                    }
                    .padding(.horizontal, 2)

                    // 右侧全屏按钮
                    Button(action: { onFullscreen?() }) {
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .font(.system(size: 17))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 35)
                    }
                }
                .padding(.bottom, 10)
            }
            .background(
                LinearGradient(
                    colors: [.clear, .black.opacity(0.8)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
}

struct AHProgressSlider: View {
    @ObservedObject var viewModel: AHVideoPlayerViewModel
    @State private var isDragging = false
    @State private var dragProgress: Double = 0

    private var progress: Double {
        guard viewModel.duration > 0 else { return 0 }
        return isDragging
            ? dragProgress
            : viewModel.currentTime / viewModel.duration
    }

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let midY = geo.size.height / 2
            let progressX = width * progress

            ZStack {
                // 背景轨道
                Capsule()
                    .fill(Color.white.opacity(0.3))
                    .frame(height: 3)
                    .position(x: width / 2, y: midY)

                // 已播放进度
                Capsule()
                    .fill(Color.green)
                    .frame(width: progressX, height: 3)
                    .position(x: progressX / 2, y: midY)

                // 拖动指示器
                Circle()
                    .fill(Color.white)
                    .frame(width: isDragging ? 12 : 8,
                           height: isDragging ? 12 : 8)
                    .position(x: progressX, y: midY)
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        isDragging = true
                        let p = min(max(0, value.location.x / width), 1)
                        dragProgress = p
                        viewModel.currentTime = p * viewModel.duration
                    }
                    .onEnded { value in
                        let p = min(max(0, value.location.x / width), 1)
                        viewModel.seek(to: p * viewModel.duration)
                        isDragging = false
                    }
            )
        }
        .frame(height: 20)
    }
}

// MARK: - 倍速选择器
struct AHSpeedSelectorView: View {
    @ObservedObject var viewModel: AHVideoPlayerViewModel
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 0) {
                HStack {
                    Text("播放速度")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
                .padding()

                Divider().background(Color.white.opacity(0.2))

                ForEach(viewModel.speedOptions, id: \.self) { speed in
                    Button(action: {
                        viewModel.setSpeed(speed)
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        HStack {
                            Text("\(String(format: "%.2f", speed))x")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            Spacer()
                            if viewModel.playbackSpeed == speed {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.green)
                            }
                        }
                        .padding()
                        .background(viewModel.playbackSpeed == speed ? Color.white.opacity(0.1) : Color.clear)
                    }

                    if speed != viewModel.speedOptions.last {
                        Divider().background(Color.white.opacity(0.1))
                    }
                }
            }
            .background(Color.black.opacity(0.95))
            .cornerRadius(12)
            .padding()
        }
        .background(
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
        )
    }
}
