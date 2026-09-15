//
//  AHPortraitFullscreenPlayerView.swift
//  LLVod
//

import SwiftUI
import AVKit

struct AHPortraitFullscreenPlayerView: View {
    @ObservedObject var vm: AHVodDetailViewModel
    @ObservedObject var viewModel: AHVideoPlayerViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showSpeedSelector = false
    @State private var showSourceSelector = false
    @State private var showEpisodeSelector = false

    var vodSources: [AHVodSourceLine]?
    var selectedSourceIndex: Int
    var selectedEpisodeIndex: Int
    var onSourceChanged: ((Int) -> Void)?
    var onEpisodeChanged: ((Int) -> Void)?
    var onNextEpisode: (() -> Void)?

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            AHAVPlayerContainerView(player: viewModel.player, isFillScreen: viewModel.isVideoFillScreen)

            AHDanmakuOverlayView(playerViewModel: viewModel)

            AHPlayerGestureView(playerViewModel: viewModel)

            if viewModel.isLongPressing {
                VStack {
                    Text("2.0x")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(12)
                    Spacer()
                }
                .padding(.top, 32)
            }

            if viewModel.isBuffering && !viewModel.isLoading {
                ProgressView()
            }

            if viewModel.isLoading {
                ProgressView()
            }

            if viewModel.showControls {
                if viewModel.isControlsLocked {
                    AHPlayerLockButton(viewModel: viewModel)
                } else {
                    AHPortraitFullscreenControlsView(
                        viewModel: viewModel,
                        showSpeedSelector: $showSpeedSelector,
                        showSourceSelector: $showSourceSelector,
                        showEpisodeSelector: $showEpisodeSelector,
                        hasMultipleSources: (vodSources?.count ?? 0) > 1,
                        hasMultipleEpisodes: true,
                        onNextEpisode: onNextEpisode,
                        onBack: {
                            viewModel.clearControlsLock()
                            dismiss()
                        }
                    )
                    AHPlayerLockButton(viewModel: viewModel)
                }
            }

            if showSpeedSelector {
                AHPortraitSpeedSelectorOverlay(
                    viewModel: viewModel,
                    isPresented: $showSpeedSelector
                )
            }

            if showSourceSelector, let sources = vodSources {
                AHPortraitSourceSelectorOverlay(
                    sources: sources,
                    selectedIndex: selectedSourceIndex,
                    isPresented: $showSourceSelector,
                    onSelect: { index in
                        onSourceChanged?(index)
                        showSourceSelector = false
                    }
                )
            }

            if showEpisodeSelector,
               let sources = vodSources,
               selectedSourceIndex < sources.count {
                AHPortraitEpisodeSelectorOverlay(
                    episodes: sources[selectedSourceIndex].episodes,
                    selectedIndex: selectedEpisodeIndex,
                    isPresented: $showEpisodeSelector,
                    onSelect: { index in
                        onEpisodeChanged?(index)
                        showEpisodeSelector = false
                    }
                )
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.toggleControls()
            }
        }
        .statusBar(hidden: true)
        .ignoresSafeArea()
        .onDisappear {
            viewModel.clearControlsLock()
        }
    }
}

// MARK: - 竖屏全屏控制层
struct AHPortraitFullscreenControlsView: View {
    @ObservedObject var viewModel: AHVideoPlayerViewModel
    @ObservedObject private var appConfig = AHAppConfig.shared
    @Binding var showSpeedSelector: Bool
    @Binding var showSourceSelector: Bool
    @Binding var showEpisodeSelector: Bool
    var hasMultipleSources: Bool
    var hasMultipleEpisodes: Bool
    var onNextEpisode: (() -> Void)?
    var onBack: () -> Void

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Top Bar
                HStack(spacing: 12) {
                    Button(action: onBack) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)

                            Text(viewModel.vodName ?? "")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .lineLimit(1)
                            Text(viewModel.currentEpisodeName ?? "")
                                .font(.system(size: 12))
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }

                    Spacer()

                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.toggleVideoFillMode()
                        }
                    }) {
                        Image(systemName: viewModel.isVideoFillScreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.15))
                            .cornerRadius(8)
                    }

                    AHCastButton(viewModel: viewModel, square: true)
                }
                .padding(.horizontal, 16)
                .padding(.top, topSafeArea == 0 ? 48 : topSafeArea)
                .padding(.bottom, 8)
                .background(LinearGradient(colors: [Color.black.opacity(0.7), Color.clear], startPoint: .top, endPoint: .bottom))

                Spacer()

                // Bottom Bar
                VStack(spacing: 15) {
                    HStack(spacing: 12) {
                        Text(AHVideoPlayerViewModel.formatTime(viewModel.currentTime))
                            .font(.system(size: 13, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                            .frame(minWidth: 38, alignment: .trailing)
                        AHPortraitFullscreenProgressBar(viewModel: viewModel)
                            .frame(height: 30)
                        Text(AHVideoPlayerViewModel.formatTime(viewModel.duration))
                            .font(.system(size: 13, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                            .frame(minWidth: 38, alignment: .leading)
                    }

                    HStack {
                        HStack(spacing: 20) {
                            AHPortraitFullscreenButton(icon: viewModel.isPlaying ? "pause" : "play", action: { viewModel.togglePlayPause() })
                            if onNextEpisode != nil {
                                AHPortraitFullscreenButton(icon: "forward.end", action: { onNextEpisode?() })
                            }
                        }
                        Spacer()
                        HStack(spacing: 20) {
                            if appConfig.isDanmakuAvailable {
                                VStack(spacing: 4) {
                                    Image(systemName: "text.bubble")
                                    Text("弹幕")
                                }
                                .font(.system(size: 12))
                                .foregroundColor(viewModel.showDanmaku ? .green : .white)
                                .onTapGesture { viewModel.toggleDanmaku() }
                            }

                            VStack(spacing: 4) {
                                Text("\(String(format: "%.1f", viewModel.playbackSpeed))x")
                                Text("倍速")
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .onTapGesture { showSpeedSelector.toggle() }

                            if hasMultipleSources {
                                VStack(spacing: 4) {
                                    Image(systemName: "play.square.stack")
                                    Text("源")
                                }
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .onTapGesture { showSourceSelector = true }
                            }

                            if hasMultipleEpisodes {
                                VStack(spacing: 4) {
                                    Image(systemName: "list.bullet")
                                    Text("选集")
                                }
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .onTapGesture { showEpisodeSelector = true }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, geometry.safeAreaInsets.bottom == 0 ? 12 : geometry.safeAreaInsets.bottom)
                .background(LinearGradient(colors: [Color.clear, Color.black.opacity(0.8)], startPoint: .top, endPoint: .bottom))
            }
        }
    }

    private var topSafeArea: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .safeAreaInsets.top ?? 0
    }
}

// MARK: - 竖屏全屏进度条
struct AHPortraitFullscreenProgressBar: View {
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
                    .frame(height: 4)
                    .position(x: width / 2, y: midY)

                // 已播放进度
                Capsule()
                    .fill(Color.green)
                    .frame(width: progressX, height: 4)
                    .position(x: progressX / 2, y: midY)

                // 拖动圆点
                Circle()
                    .fill(Color.white)
                    .frame(
                        width: isDragging ? 16 : 12,
                        height: isDragging ? 16 : 12
                    )
                    .shadow(color: .black.opacity(0.3), radius: 2)
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
        .frame(height: 28)
    }
}

// MARK: - 竖屏全屏按钮
struct AHPortraitFullscreenButton: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
        }
    }
}

// MARK: - 竖屏倍速选择器
struct AHPortraitSpeedSelectorOverlay: View {
    @ObservedObject var viewModel: AHVideoPlayerViewModel
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea().onTapGesture { withAnimation { isPresented = false } }

            VStack {
                Spacer()
                VStack(spacing: 0) {
                    HStack {
                        Text("播放速度").font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                        Spacer()
                        Button(action: { withAnimation { isPresented = false } }) {
                            Image(systemName: "xmark").font(.system(size: 16, weight: .semibold)).foregroundColor(.white.opacity(0.7))
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))

                    Divider().background(Color.white.opacity(0.2))

                    VStack(spacing: 0) {
                        ForEach(viewModel.speedOptions, id: \.self) { speed in
                            Button(action: {
                                viewModel.setSpeed(speed)
                                withAnimation { isPresented = false }
                            }) {
                                HStack {
                                    Text(String(format: "%.2fx", speed)).font(.system(size: 16, weight: viewModel.playbackSpeed == speed ? .semibold : .regular)).foregroundColor(.white)
                                    Spacer()
                                    if viewModel.playbackSpeed == speed {
                                        Image(systemName: "checkmark").font(.system(size: 16, weight: .bold)).foregroundColor(.green)
                                    }
                                }
                                .padding()
                                .background(viewModel.playbackSpeed == speed ? Color.white.opacity(0.15) : Color.clear)
                            }

                            if speed != viewModel.speedOptions.last {
                                Divider().background(Color.white.opacity(0.1))
                            }
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .padding()
            }
        }
    }
}
