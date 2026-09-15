//
//  AHVideoPlayerViewModel.swift
//  LLVod
//

import Foundation
import AVKit
import Combine
import SwiftUI

class AHVideoPlayerViewModel: ObservableObject {
    // MARK: - Published属性

    let player: AVPlayer

    @Published var isPlaying = false

    @Published var currentTime: Double = 0

    @Published var duration: Double = 0

    @Published var playbackSpeed: Float = 1.0

    @Published var isLoading = true

    @Published var showControls = true

    @Published var isControlsLocked = false

    @Published var errorMessage: String?

    @Published var isSeeking = false

    @Published var isFullscreen = false

    @Published var showDanmaku = true
    @Published var danmuFontSize: Double = 18.0
    @Published var danmakuOpacity: Double = 0.8
    @Published var danmakuArea: Double = 0.3
    @Published var danmakuSpeed: Double = 0

    @Published var vodJumpLeading: Double = 0
    @Published var isJumpLeading: Bool = false
    @Published var jumpLeadingMessage: String = "已为您跳过片头"
    private var jumpLeadingWorkItem: DispatchWorkItem?
    private var jumpTrailWorkItem: DispatchWorkItem?
    @Published var isJumpTail: Bool = false
    @Published var vodJumpTrail: Double = 0

    @Published var bufferProgress: Double = 0

    @Published var isBuffering = false

    @Published var videoSize: CGSize = .zero

    @Published var isVerticalVideo = false

    @Published var isVideoFillScreen = false

    @Published var isLongPressing = false

    private var speedBeforeLongPress: Float = 1.0

    private var retryCount = 0
    private let maxRetryCount = 3

    private var loadingTimeoutTimer: Timer?
    private let loadingTimeout: TimeInterval = 15.0

    private var playbackGeneration = 0

    // MARK: - 私有属性

    private var timeObserver: Any?
    private var cancellables = Set<AnyCancellable>()
    private var hideControlsTask: Task<Void, Never>?

    private var playHeaders: [String: String] = [:]

    private var resumePosition: Double = 0

    private var hasAppliedStartPosition = false

    private var lastProgressReportTime: TimeInterval = 0

    var onProgressUpdate: ((Double, Double) -> Void)?

    let danmaku = AHDanmakuManager()

    let speedOptions: [Float] = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]

    let fontSizeOptions: [Double] = [18.0, 19.0, 20.0, 21.0, 22.0, 23.0]

    var onNextEpisode: (() -> Void)?
    var onSelectSource: (() -> Void)?
    var onSelectEpisode: (() -> Void)?

    var vodId: String?
    var vodName: String?
    var vodPic: String?
    var sourceIndex: Int = 0
    var episodeIndex: Int = 0

    @Published var currentEpisodeName: String?

    @Published var currentPlayURL = ""

    @Published var currentVideoTitle: String = ""
    @Published var currentEpisodeInfo: String = ""

    @Published var showDanmuInput = false
    @Published var requestFocusDanmuInput = false
    @Published var danmuText = ""

    @Published var danmuColor = AHDanmakuService.sendColorHex {
        didSet { AHDanmakuService.sendColorHex = danmuColor }
    }

    // MARK: - 初始化

    init(url: String) {
        self.player = AVPlayer()

        setupPlayer()
        setupObservers()

        let settings = AHVodJumpLeadTrailStore.shared.load()

        self.vodJumpLeading = settings.leading
        self.vodJumpTrail = settings.trail

        Publishers.CombineLatest(
            $vodJumpLeading,
            $vodJumpTrail
        )
        .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
        .sink { [weak self] leading, trail in
            guard let self else { return }

            self.vodJumpLeading = leading
            self.vodJumpTrail = trail

            let newSettings = AHVodJumpLeadTrail(
                leading: leading,
                trail: trail
            )

            AHVodJumpLeadTrailStore.shared.save(newSettings)
        }
        .store(in: &cancellables)
    }

    deinit {
        if let observer = timeObserver {
            player.removeTimeObserver(observer)
        }
        NotificationCenter.default.removeObserver(self)
        loadingTimeoutTimer?.invalidate()
        loadingTimeoutTimer = nil
    }

    // MARK: - 播放器设置

    private func setupPlayer() {
        // 允许后台播放
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [.allowAirPlay])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch { }

        // 设置倍速时保持音调
        player.currentItem?.audioTimePitchAlgorithm = .timeDomain

        // 允许AirPlay投屏
        player.allowsExternalPlayback = true
        player.usesExternalPlaybackWhileExternalScreenIsActive = true
    }

    // MARK: - 观察者设置

    private func setupObservers() {
        // 监听播放进度
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self, !self.isSeeking else { return }
            self.currentTime = time.seconds
            self.danmaku.update(currentTime: time.seconds)
            self.reportProgressIfNeeded()

            // 是否跳过片尾
            if Int(self.duration - self.currentTime - (self.vodJumpTrail * 300)) == 5 && !self.isJumpTail {
                self.isJumpTail = true
                // 取消之前的延时任务（防止叠加）
                self.jumpTrailWorkItem?.cancel()
                let workItem = DispatchWorkItem { [weak self] in
                    self?.isJumpTail = false
                }
                self.jumpTrailWorkItem = workItem
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: workItem)
            }

            // 跳过片尾
            if ((self.duration - self.currentTime - (self.vodJumpTrail * 300)) <= 0) && self.duration > 0 {
                self.currentTime = 0
                self.onNextEpisode?()
            }
        }

        // 监听播放状态
        player.publisher(for: \.timeControlStatus)
            .sink { [weak self] status in
                DispatchQueue.main.async {
                    guard let self else { return }
                    self.isPlaying = (status == .playing)
                    self.isLoading = (status == .waitingToPlayAtSpecifiedRate)
                    self.isBuffering = (status == .waitingToPlayAtSpecifiedRate)

                    // 画面停住了弹幕也得停住，不然暂停时弹幕还在飘
                    if self.isPlaying {
                        self.danmaku.play()
                    } else {
                        self.danmaku.pause()
                    }
                }
            }
            .store(in: &cancellables)

        // 监听总时长
        player.publisher(for: \.currentItem?.duration)
            .compactMap { $0 }
            .sink { [weak self] duration in
                if duration.isNumeric {
                    DispatchQueue.main.async {
                        self?.duration = duration.seconds
                        self?.isLoading = false
                    }
                }
            }
            .store(in: &cancellables)

        // 监听缓冲进度
        player.publisher(for: \.currentItem?.loadedTimeRanges)
            .compactMap { $0 }
            .sink { [weak self] timeRanges in
                guard let self = self,
                      let timeRange = timeRanges.first?.timeRangeValue else { return }

                let bufferedTime = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration)
                let totalTime = self.duration

                DispatchQueue.main.async {
                    if totalTime > 0 {
                        self.bufferProgress = bufferedTime / totalTime
                    }
                }
            }
            .store(in: &cancellables)

        // 监听是否可以播放
        player.publisher(for: \.currentItem?.isPlaybackLikelyToKeepUp)
            .sink { [weak self] isLikelyToKeepUp in
                DispatchQueue.main.async {
                    if isLikelyToKeepUp == true {
                        self?.isBuffering = false
                        self?.errorMessage = nil
                        self?.retryCount = 0
                        self?.stopLoadingTimeout()
                    }
                }
            }
            .store(in: &cancellables)

        // 监听AVPlayerItem的状态（关键：检测加载失败）
        player.publisher(for: \.currentItem?.status)
            .sink { [weak self] status in
                guard let self = self, let status = status else { return }

                DispatchQueue.main.async { [self] in
                    switch status {
                    case .readyToPlay:
                        self.stopLoadingTimeout()

                        if let item = self.player.currentItem {
                            let size = item.presentationSize

                            if size != .zero {
                                self.videoSize = size
                                self.isVerticalVideo = size.height > size.width
                            } else if let track = item.asset.tracks(withMediaType: .video).first {
                                let realSize = track.naturalSize.applying(track.preferredTransform)
                                self.videoSize = CGSize(width: abs(realSize.width),
                                                        height: abs(realSize.height))
                                self.isVerticalVideo = self.videoSize.height > self.videoSize.width
                            }
                        }

                        // 起播定位：续播位置与片头时长取较大值
                        self.applyStartPositionIfNeeded()

                    case .failed:
                        self.stopLoadingTimeout()

                        if let error = self.player.currentItem?.error {
                            self.errorMessage = "播放失败: \(error.localizedDescription)"
                        } else {
                            self.errorMessage = "播放失败，未知错误"
                        }

                        self.handlePlaybackError()

                    case .unknown:
                        break

                    @unknown default:
                        break
                    }
                }
            }
            .store(in: &cancellables)

        // 监听AVPlayerItem的错误
        player.publisher(for: \.currentItem?.error)
            .compactMap { $0 }
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.stopLoadingTimeout()
                    self?.handlePlaybackError()
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - 播放控制

    func play() {
        player.play()
        player.rate = playbackSpeed
        autoHideControls()
    }

    func pause() {
        player.pause()
        showControls = true
        hideControlsTask?.cancel()
    }

    func stop() {
        playbackGeneration += 1
        hideControlsTask?.cancel()
        stopLoadingTimeout()
        jumpLeadingWorkItem?.cancel()
        jumpTrailWorkItem?.cancel()
        player.pause()
        player.replaceCurrentItem(with: nil)
        isPlaying = false
        isLoading = false
        isBuffering = false
        errorMessage = nil
        currentTime = 0
        duration = 0
        bufferProgress = 0
        danmaku.pause()
    }

    func togglePlayPause() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }

    func toggleVideoFillMode() {
        isVideoFillScreen.toggle()
    }

    func seek(to time: Double) {
        isSeeking = true
        danmaku.jumped(to: time)
        let cmTime = CMTime(seconds: time, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.seek(to: cmTime) { [weak self] _ in
            DispatchQueue.main.async {
                self?.isSeeking = false
            }
        }
    }

    func jumpLeading(time: Double) {
        vodJumpLeading = time
    }

    // MARK: - 起播定位（续播 / 跳过片头）

    var jumpLeadingSeconds: Double {
        vodJumpLeading * 300
    }

    private func applyStartPositionIfNeeded() {
        guard !hasAppliedStartPosition else { return }
        hasAppliedStartPosition = true

        let itemDuration = player.currentItem?.duration.seconds ?? 0
        var resume = resumePosition

        // 上次已经看到结尾，重新从头开始，不然一进来就播完了
        if itemDuration.isFinite, itemDuration > 0, resume >= itemDuration - 15 {
            resume = 0
        }

        let leading = jumpLeadingSeconds
        let target = max(resume, leading)
        guard target > 1 else { return }

        seekToStart(target)

        jumpLeadingMessage = resume > leading ? "已为您跳转到上次播放位置" : "已为您跳过片头"
        isJumpLeading = true
        // 取消之前的延时任务（防止叠加）
        jumpLeadingWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            self?.isJumpLeading = false
        }
        jumpLeadingWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: workItem)
    }

    private func seekToStart(_ time: Double) {
        danmaku.jumped(to: time)
        let cmTime = CMTime(seconds: time, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.seek(to: cmTime, toleranceBefore: .zero, toleranceAfter: .zero) { [weak self] finished in
            guard finished else { return }
            DispatchQueue.main.async {
                self?.currentTime = time
                self?.play()
            }
        }
    }

    private func reportProgressIfNeeded() {
        guard onProgressUpdate != nil, isPlaying, currentTime > 0 else { return }

        let now = Date().timeIntervalSince1970
        guard now - lastProgressReportTime >= 5 else { return }
        lastProgressReportTime = now

        onProgressUpdate?(currentTime, duration)
    }

    func jumpTrail(time: Double) {
        vodJumpTrail = time
    }

    func forward(_ seconds: Double = 15) {
        let newTime = min(currentTime + seconds, duration)
        seek(to: newTime)
    }

    func backward(_ seconds: Double = 15) {
        let newTime = max(currentTime - seconds, 0)
        seek(to: newTime)
    }

    func setSpeed(_ speed: Float) {
        playbackSpeed = speed
        if isPlaying {
            player.rate = speed
        }
    }

    func showSendDanmuUI() {
        showDanmuInput = true
        requestFocusDanmuInput = true
    }

    func toggleFullscreen() {
        isFullscreen.toggle()
        if isFullscreen {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        } else {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
    }

    func toggleDanmaku() {
        showDanmaku.toggle()
    }

    // MARK: - 长按加速

    func startLongPressSpeed() {
        guard !isControlsLocked else { return }
        guard !isLongPressing else { return }

        isLongPressing = true
        speedBeforeLongPress = playbackSpeed

        playbackSpeed = 2.0
        if isPlaying {
            player.rate = 2.0
        }
    }

    func endLongPressSpeed() {
        guard isLongPressing else { return }

        isLongPressing = false

        playbackSpeed = speedBeforeLongPress
        if isPlaying {
            player.rate = speedBeforeLongPress
        }
    }

    // MARK: - 控制层显示

    func showControlsTemporarily() {
        showControls = true
        autoHideControls()
    }

    func toggleControls() {
        showControls.toggle()
        // 锁屏时只用来露出/收起解锁钮，不自动隐藏
        if isControlsLocked { return }
        if showControls && isPlaying {
            autoHideControls()
        }
    }

    func toggleControlsLock() {
        isControlsLocked.toggle()
        if isControlsLocked {
            // 锁上后先露出解锁钮，再按自动隐藏节奏收起
            showControls = true
            autoHideControls()
        } else {
            showControlsTemporarily()
        }
    }

    func clearControlsLock() {
        guard isControlsLocked else { return }
        isControlsLocked = false
        showControlsTemporarily()
    }

    private func autoHideControls() {
        hideControlsTask?.cancel()
        hideControlsTask = Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000) // 3秒
            if !Task.isCancelled {
                await MainActor.run {
                    // 锁屏时也可以收起，点一下再出现解锁钮
                    if self.isPlaying || self.isControlsLocked {
                        self.showControls = false
                    }
                }
            }
        }
    }

    // MARK: - 通知处理

    @objc private func playerDidFinishPlaying() {
        DispatchQueue.main.async {
            self.isPlaying = false
            self.showControls = true

            // 自动播放下一集
            self.onNextEpisode?()
        }
    }

    @objc private func playerDidFail(_ notification: Notification) {
        DispatchQueue.main.async {
            self.handlePlaybackError()
        }
    }

    @objc private func playerStalled(_ notification: Notification) {
        DispatchQueue.main.async {
            self.isBuffering = true
            let generation = self.playbackGeneration

            // 尝试恢复播放
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
                guard let self, self.playbackGeneration == generation else { return }
                if self.isBuffering && !self.isPlaying {
                    self.play()
                }
            }
        }
    }

    private func handlePlaybackError() {
        stopLoadingTimeout()

        guard retryCount < maxRetryCount else {
            errorMessage = "当前播放源无法播放\n请尝试切换其他播放源"
            isLoading = false
            isBuffering = false
            return
        }

        retryCount += 1

        // 重试会换掉 item，把当前位置记下来，重新 ready 后接着播
        resumePosition = max(resumePosition, currentTime)
        hasAppliedStartPosition = false
        let generation = playbackGeneration

        // 延迟重试
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self, self.playbackGeneration == generation else { return }
            if let currentItem = self.player.currentItem,
               let asset = currentItem.asset as? AVURLAsset {
                // 重建 asset 时要把请求头带上，否则重试会因缺 Referer 直接失败
                let newItem = AVPlayerItem(asset: self.makeAsset(url: asset.url))
                self.player.replaceCurrentItem(with: newItem)
                self.startLoadingTimeout()
                self.play()
            }
        }
    }

    private func startLoadingTimeout() {
        stopLoadingTimeout()

        loadingTimeoutTimer = Timer.scheduledTimer(withTimeInterval: loadingTimeout, repeats: false) { [weak self] _ in
            guard let self = self else { return }

            DispatchQueue.main.async {
                if self.isLoading && self.errorMessage == nil {
                    self.errorMessage = "加载超时\n请检查网络或切换播放源"
                    self.isLoading = false
                    self.isBuffering = false
                }
            }
        }
    }

    private func stopLoadingTimeout() {
        loadingTimeoutTimer?.invalidate()
        loadingTimeoutTimer = nil
    }

    // MARK: - 工具方法

    static func formatTime(_ seconds: Double) -> String {
        guard seconds.isFinite && !seconds.isNaN else { return "00:00" }

        let totalSeconds = Int(seconds)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let secs = totalSeconds % 60

        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, secs)
        } else {
            return String(format: "%02d:%02d", minutes, secs)
        }
    }

    func updatePlayURL(_ url: String, headers: [String: String] = [:], startAt: Double = 0) {
        // 新的起播会话，作废上一次留下的延迟 play / 重试
        playbackGeneration += 1
        let generation = playbackGeneration

        // 清除之前的错误信息和重试次数
        errorMessage = nil
        retryCount = 0
        stopLoadingTimeout()
        playHeaders = headers
        currentPlayURL = url
        resumePosition = max(0, startAt)
        hasAppliedStartPosition = false
        lastProgressReportTime = 0

        // 对齐 Flutter：播放地址就绪后再拉这一集的弹幕
        danmaku.loadDanmaku(
            request: AHDanmakuRequest(
                vodName: vodName ?? "",
                episode: episodeIndex + 1,
                playURL: url
            ),
            startAt: resumePosition
        )

        if let videoURL = URL(string: url) {
            let playerItem = AVPlayerItem(asset: makeAsset(url: videoURL))
            player.replaceCurrentItem(with: playerItem)

            // 重新注册通知观察者（针对新的 playerItem）
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemFailedToPlayToEndTime, object: nil)
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemPlaybackStalled, object: nil)

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(playerDidFinishPlaying),
                name: .AVPlayerItemDidPlayToEndTime,
                object: playerItem
            )

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(playerDidFail),
                name: .AVPlayerItemFailedToPlayToEndTime,
                object: playerItem
            )

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(playerStalled),
                name: .AVPlayerItemPlaybackStalled,
                object: playerItem
            )

            currentTime = 0
            isLoading = true

            // 开始加载超时检测
            startLoadingTimeout()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self, self.playbackGeneration == generation else { return }
                self.play()
            }
        } else {
            errorMessage = "无效的视频地址"
            isLoading = false
        }
    }

    private func makeAsset(url: URL) -> AVURLAsset {
        guard !playHeaders.isEmpty else {
            return AVURLAsset(url: url)
        }

        return AVURLAsset(
            url: url,
            options: ["AVURLAssetHTTPHeaderFieldsKey": playHeaders]
        )
    }

    func setVideoInfo(vodId: String, vodName: String, vodPic: String?, sourceIndex: Int, episodeIndex: Int, episodeName: String? = nil) {
        self.vodId = vodId
        self.vodName = vodName
        self.vodPic = vodPic
        self.sourceIndex = sourceIndex
        self.episodeIndex = episodeIndex

        if let episodeName = episodeName {
            self.currentEpisodeName = episodeName
        } else {
            self.currentEpisodeName = "第\(episodeIndex + 1)集"
        }
    }
}
