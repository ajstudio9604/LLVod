//
//  AHFullscreenPlayerView.swift
//  LLVod
//

import SwiftUI
import AVKit

struct AHFullscreenPlayerView: View {

    @ObservedObject var vm: AHVodDetailViewModel
    @ObservedObject var viewModel: AHVideoPlayerViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showSpeedSelector = false
    @State private var showSourceSelector = false
    @State private var showEpisodeSelector = false
    @State private var showDanmukuSettingSelector = false
    @State private var showJumpLeadTraliSelector = false
    @State private var danmuHint: String?

    @FocusState private var inputFocused: Bool

    var vodSources: [AHVodSourceLine]?
    var selectedSourceIndex: Int
    var selectedEpisodeIndex: Int
    var onSourceChanged: ((Int) -> Void)?
    var onEpisodeChanged: ((Int) -> Void)?
    var onNextEpisode: (() -> Void)?

    init(vm: AHVodDetailViewModel,
         viewModel: AHVideoPlayerViewModel,
         vodSources: [AHVodSourceLine]? = nil,
         selectedSourceIndex: Int = 0,
         selectedEpisodeIndex: Int = 0,
         onSourceChanged: ((Int) -> Void)? = nil,
         onEpisodeChanged: ((Int) -> Void)? = nil,
         onNextEpisode: (() -> Void)? = nil) {
        self._vm = ObservedObject(wrappedValue: vm)
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.vodSources = vodSources
        self.selectedSourceIndex = selectedSourceIndex
        self.selectedEpisodeIndex = selectedEpisodeIndex
        self.onSourceChanged = onSourceChanged
        self.onEpisodeChanged = onEpisodeChanged
        self.onNextEpisode = onNextEpisode
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()

                // 视频层
                AHAVPlayerContainerView(player: viewModel.player, isFillScreen: viewModel.isVideoFillScreen)
                    .frame(width: geometry.size.width, height: geometry.size.height)

                // 弹幕层
                AHDanmakuOverlayView(playerViewModel: viewModel)

                // 手势控制层
                AHPlayerGestureView(playerViewModel: viewModel)

                // 长按加速提示
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

                // 起播定位提示（续播 / 跳过片头）
                if viewModel.isJumpLeading {
                    VStack {
                        Text(viewModel.jumpLeadingMessage)
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

                // 即将跳过片尾提示
                if viewModel.isJumpTail {
                    VStack {
                        Text("即将为您跳过片尾")
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

                // 发送弹幕
                if viewModel.showDanmuInput {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            dismissInput()
                        }
                }

                // 缓冲指示器
                if viewModel.isBuffering && !viewModel.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        Text("缓冲中...")
                            .foregroundColor(.white)
                            .font(.system(size: 14))

                        if viewModel.bufferProgress > 0 {
                            Text("已缓冲 \(Int(viewModel.bufferProgress * 100))%")
                                .foregroundColor(.white.opacity(0.7))
                                .font(.system(size: 12))
                        }
                    }
                }

                // 加载指示器
                if viewModel.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        Text("加载中...")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                }

                // 错误提示
                if let error = viewModel.errorMessage {
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

                            // 切换播放源按钮
                            if (vodSources?.count ?? 0) > 1 {
                                Button(action: {
                                    showSourceSelector = true
                                    viewModel.errorMessage = nil
                                }) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "arrow.triangle.2.circlepath")
                                        Text("切换源")
                                    }
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .semibold))
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 12)
                                    .background(Color.orange)
                                    .cornerRadius(25)
                                }
                            }
                        }
                    }
                }

                // 控制层 / 锁屏
                if viewModel.showControls {
                    if viewModel.isControlsLocked {
                        AHPlayerLockButton(viewModel: viewModel)
                    } else {
                        AHFullscreenControlsView(
                            viewModel: viewModel,
                            showSpeedSelector: $showSpeedSelector,
                            showSourceSelector: $showSourceSelector,
                            showEpisodeSelector: $showEpisodeSelector,
                            showDanmukuSettingSelector: $showDanmukuSettingSelector,
                            showJumpLeadTrailSelector: $showJumpLeadTraliSelector,
                            hasMultipleSources: (vodSources?.count ?? 0) > 1,
                            hasMultipleEpisodes: true,
                            canSendDanmaku: !vm.route.zypath.isEmpty,
                            onNextEpisode: onNextEpisode,
                            onBack: {
                                viewModel.clearControlsLock()
                                dismiss()
                            }
                        )

                        AHPlayerLockButton(viewModel: viewModel)
                    }
                }

                // 弹幕设置
                if showDanmukuSettingSelector {
                    AHDanmukuSettingSelectorOverlay(
                        viewModel: viewModel,
                        isPresented: $showDanmukuSettingSelector
                    )
                }

                // 跳过片头片尾
                if showJumpLeadTraliSelector {
                    AHVodJumpLeadingTrailView(
                        viewModel: viewModel,
                        isPresented: $showJumpLeadTraliSelector
                    )
                }

                // 倍速选择器
                if showSpeedSelector {
                    AHSpeedSelectorOverlay(
                        viewModel: viewModel,
                        isPresented: $showSpeedSelector
                    )
                }

                // 播放源选择器
                if showSourceSelector, let sources = vodSources {
                    AHSourceSelectorOverlay(
                        sources: sources,
                        selectedIndex: selectedSourceIndex,
                        isPresented: $showSourceSelector,
                        onSelect: { index in
                            onSourceChanged?(index)
                            showSourceSelector = false
                        }
                    )
                }

                if let danmuHint {
                    Text(danmuHint)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(8)
                        .transition(.opacity)
                }

                // 集数选择器
                if showEpisodeSelector,
                   let sources = vodSources,
                   selectedSourceIndex < sources.count {
                    AHEpisodeSelectorOverlay(
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
            .onChange(of: viewModel.requestFocusDanmuInput) { value in
                inputFocused = value
            }
            .onChange(of: inputFocused) { focused in
                if !focused {
                    viewModel.requestFocusDanmuInput = false
                }
            }
            .contentShape(Rectangle())
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.toggleControls()
                        }
                    }
            )
        }
        .navigationBarHidden(true)
        .statusBar(hidden: true)
        .ignoresSafeArea()
        .onDisappear {
            viewModel.clearControlsLock()
        }
        .safeAreaInset(edge: .bottom) {
            if viewModel.showDanmuInput, !viewModel.isControlsLocked {
                AHDanmuInputBar(
                    viewModel: viewModel,
                    text: $viewModel.danmuText,
                    onSend: sendDanmu
                )
                .focused($inputFocused)
                .transition(.move(edge: .bottom))
            }
        }
    }

    private func dismissInput() {
        withAnimation {
            viewModel.showDanmuInput = false
        }
    }

    private func sendDanmu() {
        let text = viewModel.danmuText.trimmingCharacters(in: .whitespacesAndNewlines)
        let colorHex = viewModel.danmuColor
        viewModel.danmuText = ""
        dismissInput()

        guard !text.isEmpty else { return }

        guard AHDanmakuService.canSend, let sender = AHDanmakuSource.sender else {
            showDanmuHint("弹幕发送接口未配置")
            return
        }

        let request = AHDanmakuSendRequest(
            vodName: vm.payload?.title ?? vm.route.name,
            episode: vm.selectedEpisodeIndex + 1,
            text: text,
            colorHex: colorHex,
            time: viewModel.currentTime
        )

        sender(request) { result in
            switch result {
            case .success:
                // 自己发的先上屏，这个接口读不回自己刚发的那条
                viewModel.danmaku.shootLocal(text: text, colorHex: colorHex)
                showDanmuHint("发送成功")

            case .rejected(let reason):
                 
                // 服务端给的说明不适合直接展示，统一给个提示
                restore(text: text)
                showDanmuHint("发送失败，请稍后重试")

            case .failed:
                restore(text: text)
                showDanmuHint("发送失败，请检查网络")
            }
        }
    }

    private func restore(text: String) {
        guard viewModel.danmuText.isEmpty else { return }
        viewModel.danmuText = text
    }

    private func showDanmuHint(_ message: String) {
        withAnimation { danmuHint = message }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                guard danmuHint == message else { return }
                danmuHint = nil
            }
        }
    }
}

struct AHPlayerLockButton: View {
    @ObservedObject var viewModel: AHVideoPlayerViewModel

    var body: some View {
        HStack {
            Button {
                viewModel.toggleControlsLock()
            } label: {
                Image(systemName: viewModel.isControlsLocked ? "lock.fill" : "lock.open.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.black.opacity(0.45))
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)

            Spacer()
        }
        .padding(.leading, 28)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .allowsHitTesting(true)
    }
}

struct AHDanmuInputBar: View {
    @ObservedObject var viewModel: AHVideoPlayerViewModel
    @Binding var text: String
    var onSend: () -> Void

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                TextField("发个弹幕吧～", text: $text)
                    .textFieldStyle(.roundedBorder)

                Button("发送") {
                    onSend()
                }
                .disabled(text.trimmingCharacters(in: .whitespaces).isEmpty)
            }

            AHDanmuColorPaletteView(viewModel: viewModel)
        }
        .padding()
        .background(.ultraThinMaterial)
    }
}

struct AHDanmuColorPaletteView: View {
    @ObservedObject var viewModel: AHVideoPlayerViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(AHDanmakuPalette.colors, id: \.self) { hex in
                    let isSelected = viewModel.danmuColor == hex

                    Button {
                        viewModel.danmuColor = hex
                    } label: {
                        Circle()
                            .fill(Color(AHPlayerColorHex.uiColor(hex)))
                            .frame(width: 28, height: 28)
                            .overlay(
                                Circle().stroke(
                                    Color.white.opacity(isSelected ? 1 : 0.25),
                                    lineWidth: isSelected ? 2 : 1
                                )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
        }
    }
}

// MARK: - 全屏控制层
struct AHFullscreenControlsView: View {
    @ObservedObject var viewModel: AHVideoPlayerViewModel
    @ObservedObject private var appConfig = AHAppConfig.shared
    @Binding var showSpeedSelector: Bool
    @Binding var showSourceSelector: Bool
    @Binding var showEpisodeSelector: Bool
    @Binding var showDanmukuSettingSelector: Bool
    @Binding var showJumpLeadTrailSelector: Bool
    var hasMultipleSources: Bool
    var hasMultipleEpisodes: Bool
    var canSendDanmaku: Bool = true
    var onNextEpisode: (() -> Void)?
    var onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // 顶部栏
            HStack(spacing: 12) {
                // 返回按钮
                Button(action: onBack) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))

                        // 视频标题和集数
                        if let vodName = viewModel.vodName {
                            Text(vodName)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .lineLimit(1)

                            if let episodeName = viewModel.currentEpisodeName {
                                Text(episodeName)
                                    .font(.system(size: 12))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .cornerRadius(8)
                }

                Spacer()

                // 视频填充模式切换按钮
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.toggleVideoFillMode()
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.white.opacity(0.15))
                            .frame(width: 40, height: 40)

                        Image(systemName: viewModel.isVideoFillScreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
                .padding(.trailing, 12)

                // AirPlay / DLNA 投屏
                AHCastButton(viewModel: viewModel, square: true)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .background(
                LinearGradient(
                    colors: [Color.black.opacity(0.7), Color.clear],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )

            Spacer()

            // 中间播放按钮
            if !viewModel.isPlaying && !viewModel.isLoading {
                Button(action: { viewModel.play() }) {
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.4))
                            .frame(width: 80, height: 80)

                        Image(systemName: "play.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                }
            }

            Spacer()

            // 底部控制栏
            VStack(spacing: 12) {
                // 进度条
                HStack(spacing: 12) {
                    Text(AHVideoPlayerViewModel.formatTime(viewModel.currentTime))
                        .font(.system(size: 13, weight: .medium, design: .monospaced))
                        .foregroundColor(.white)
                        .frame(minWidth: 38, alignment: .trailing)

                    AHFullscreenProgressBar(viewModel: viewModel)
                        .frame(height: 30)

                    Text(AHVideoPlayerViewModel.formatTime(viewModel.duration))
                        .font(.system(size: 13, weight: .medium, design: .monospaced))
                        .foregroundColor(.white)
                        .frame(minWidth: 38, alignment: .leading)
                }
                .padding(.horizontal, 16)

                // 按钮栏
                HStack {
                    // 播放/暂停
                    AHFullscreenButton(
                        icon: viewModel.isPlaying ? "pause" : "play",
                        action: { viewModel.togglePlayPause() }
                    )

                    // 下一集
                    if onNextEpisode != nil {
                        AHFullscreenButton(
                            icon: "forward.end",
                            action: {
                                onNextEpisode?()
                            }
                        )
                    }

                    // 弹幕总开关关掉时，这几个入口一律不给（对齐 Flutter）
                    if appConfig.isDanmakuAvailable {
                        // 关闭弹幕 / 弹幕开启
                        AHFullscreenButton(icon: viewModel.showDanmaku ? "slash.circle" : "checkmark.circle.fill") {
                            viewModel.toggleDanmaku()
                        }

                        // 弹幕设置，关掉弹幕后不给设置（对齐 Flutter）
                        if viewModel.showDanmaku {
                            AHFullscreenButton(icon: "gearshape") {
                                withAnimation {
                                    showDanmukuSettingSelector.toggle()
                                }
                            }
                        }

                        // 编辑弹幕
                        if viewModel.showDanmaku, canSendDanmaku, appConfig.canSendDanmaku {
                            AHFullscreenButton(icon: "pencil") {
                                viewModel.showSendDanmuUI()
                            }
                        }
                    }

                    Spacer()

                    // 片头片尾
                    Button(action: {
                        withAnimation {
                            showJumpLeadTrailSelector.toggle()
                        }
                    }) {
                        Text("片头/尾")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                    }

                    // 倍速
                    Button(action: {
                        withAnimation {
                            showSpeedSelector.toggle()
                        }
                    }) {
                        HStack(spacing: 4) {
                            Text("倍速")
                                .font(.system(size: 14, weight: .medium))
                            Text("\(String(format: "%.1f", viewModel.playbackSpeed))x")
                                .font(.system(size: 13, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                    }

                    // 播放源
                    if hasMultipleSources {
                        Button(action: {
                            showSourceSelector = true
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "play.square.stack")
                                    .font(.system(size: 14))
                                Text("播放源")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                        }
                    }

                    // 选集
                    if hasMultipleEpisodes {
                        Button(action: {
                            showEpisodeSelector = true
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "list.bullet")
                                    .font(.system(size: 14))
                                Text("选集")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
            .background(
                LinearGradient(
                    colors: [Color.clear, Color.black.opacity(0.8)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
}

// MARK: - 全屏进度条
struct AHFullscreenProgressBar: View {
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

                // 圆点
                Circle()
                    .fill(Color.white)
                    .frame(width: isDragging ? 16 : 12,
                           height: isDragging ? 16 : 12)
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
        .frame(height: 24)
    }
}

// MARK: - 全屏按钮
struct AHFullscreenButton: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 38, height: 38)
        }
    }
}

// MARK: - 倍速选择器（横屏优化版）
struct AHSpeedSelectorOverlay: View {
    @ObservedObject var viewModel: AHVideoPlayerViewModel
    @Binding var isPresented: Bool

    var body: some View {
        HStack {
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
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding()
                .background(Color.white.opacity(0.1))

                Divider().background(Color.white.opacity(0.2))

                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.speedOptions, id: \.self) { speed in
                            Button(action: {
                                viewModel.setSpeed(speed)
                                withAnimation {
                                    isPresented = false
                                }
                            }) {
                                HStack {
                                    Text(String(format: "%.2fx", speed))
                                        .font(.system(size: 16, weight: viewModel.playbackSpeed == speed ? .semibold : .regular))
                                        .foregroundColor(.white)
                                    Spacer()
                                    if viewModel.playbackSpeed == speed {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.green)
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
            }
            .frame(width: 250)
            .background(Color.black.opacity(0.95))
            .cornerRadius(12)
            .padding(.trailing, 16)
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

// MARK: - 跳过片头片尾设置
struct AHVodJumpLeadingTrailView: View {
    @ObservedObject var viewModel: AHVideoPlayerViewModel
    @Binding var isPresented: Bool

    var body: some View {
        HStack {
            Spacer()

            VStack(spacing: 0) {
                HStack {
                    Text("跳过片头片尾设置")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)

                    Spacer()
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding()
                .background(Color.white.opacity(0.1))

                Divider().background(Color.white.opacity(0.2))

                VStack {
                    ScrollView {
                        HStack {
                            Text("配置将在下次观看时生效")
                                .font(.system(size: 14))
                                .foregroundColor(Color(uiColor: UIColor.lightGray))
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16))

                        // 片头时长
                        HStack {
                            Text("片头时长")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                            Text(String(format: "%ds", Int(viewModel.vodJumpLeading * 300)))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                        }
                        .padding(.trailing, 16)

                        AHFullScreenSettingProgressBar(onChanged: { value in
                            viewModel.jumpLeading(time: value)
                        }, defaultValue: $viewModel.vodJumpLeading)

                        // 片尾时长
                        HStack {
                            Text("片尾时长")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                            Text(String(format: "%ds", Int(viewModel.vodJumpTrail * 300)))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                        }
                        .padding(.trailing, 16)

                        AHFullScreenSettingProgressBar(onChanged: { value in
                            viewModel.jumpTrail(time: value)
                        }, defaultValue: $viewModel.vodJumpTrail)

                        Spacer()
                    }
                }

                Spacer()
            }
            .frame(width: 300)
            .background(Color.black.opacity(0.95))
            .cornerRadius(12)
            .padding(.trailing, 16)
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

// MARK: - 弹幕设置
struct AHDanmukuSettingSelectorOverlay: View {
    @ObservedObject var viewModel: AHVideoPlayerViewModel
    @Binding var isPresented: Bool

    var body: some View {
        HStack {
            Spacer()

            VStack(spacing: 0) {
                HStack {
                    Text("弹幕设置")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding()
                .background(Color.white.opacity(0.1))

                Divider().background(Color.white.opacity(0.2))

                VStack {
                    ScrollView {
                        // 发送弹幕颜色
                        HStack {
                            Text("发送弹幕颜色")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                        }

                        AHDanmuColorPaletteView(viewModel: viewModel)

                        // 字号
                        HStack {
                            Text("字号")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                        }

                        AHDanmukuFontSizeView(vm: viewModel)

                        // 显示区域
                        HStack {
                            Text("显示区域")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                        }

                        AHFullScreenSettingProgressBar(onChanged: { value in
                            viewModel.danmakuArea = value
                        }, defaultValue: $viewModel.danmakuArea)

                        // 速度
                        HStack {
                            Text("速度")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                        }

                        AHFullScreenSettingProgressBar(onChanged: { value in
                            viewModel.danmakuSpeed = value
                        }, defaultValue: $viewModel.danmakuSpeed)

                        // 透明度
                        HStack {
                            Text("透明度")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                        }

                        AHFullScreenSettingProgressBar(onChanged: { value in
                            viewModel.danmakuOpacity = value
                        }, defaultValue: $viewModel.danmakuOpacity)

                        Spacer()
                    }
                }

                Spacer()
            }
            .frame(width: 300)
            .background(Color.black.opacity(0.95))
            .cornerRadius(12)
            .padding(.trailing, 16)
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

struct AHFullScreenSettingProgressBar: View {
    @State private var isDragging = false
    @State var dragProgress: Double = 0
    let onChanged: (Double) -> Void
    @Binding var defaultValue: Double

    private var progress: Double {
        return dragProgress
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

                // 已选进度
                Capsule()
                    .fill(Color.green)
                    .frame(width: progressX, height: 4)
                    .position(x: progressX / 2, y: midY)

                // 圆点
                Circle()
                    .fill(Color.white)
                    .frame(width: isDragging ? 16 : 12,
                           height: isDragging ? 16 : 12)
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
                    }
                    .onEnded { _ in
                        isDragging = false
                        onChanged(dragProgress)
                    }
            )
        }
        .frame(height: 24)
        .padding(.horizontal, 16)
        .onAppear {
            dragProgress = defaultValue
        }
        .onChange(of: defaultValue) { newValue in
            // 只有不在拖拽时才同步
            if !isDragging {
                dragProgress = newValue
            }
        }
    }
}

struct AHDanmukuFontSizeView: View {
    @ObservedObject var vm: AHVideoPlayerViewModel

    var body: some View {
        HStack {
            ForEach(vm.fontSizeOptions, id: \.self) { fontSize in
                AHDanmakuFontSizeItem(
                    fontSize: CGFloat(fontSize),
                    isSelected: vm.danmuFontSize == fontSize
                ) {
                    vm.danmuFontSize = fontSize
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

struct AHDanmakuFontSizeItem: View {
    let fontSize: CGFloat
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("A")
                .font(.system(size: fontSize, weight: isSelected ? .semibold : .regular))
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.white)
        }
        .background(isSelected ? Color.white.opacity(0.15) : Color.clear)
        .cornerRadius(4)
    }
}
