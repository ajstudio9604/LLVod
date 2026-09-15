import AVFoundation
import Combine
import UIKit

/// 统一持有专注空间的音频、计时和播放资源，退出时先释放再创建新空间。
@MainActor
final class AmbientServices: ObservableObject {
    let clock = AmbientFocusClock()
    let sleepTimer = AmbientSleepTimer()
    // 场景、声音与全屏播放的变化都会影响陪伴计时，统一在赋值后重新判断。
    // 默认展示夜雨，按资源标识选择，避免依赖缩略图排列顺序。
    @Published private(set) var selectedScene = AmbientScene.collection.first(where: { $0.identifier == "ambient_night" }) ?? AmbientScene.collection[0] {
        didSet { updateCompanionTracking() }
    }
    @Published private(set) var isSoundEnabled = false {
        didSet { updateCompanionTracking() }
    }
    @Published private(set) var playback: AmbientPlaybackViewController? {
        didSet { updateCompanionTracking() }
    }
    @Published private(set) var notice: String?

    let mixer = AmbientAudioMixer()
    private let phaseCue = AmbientPhaseCue()
    private var isAudioSessionActive = false
    let spatialMotion = AmbientSpatialMotion()
    @Published private(set) var progress = AmbientProgressPayload() {
        // 关联的习惯被删除或归档后解除关联并保留目标文字；进行中的一轮目标已固定，留到之后的刷新再处理。
        didSet {
            guard isReady, clock.canEditGoal, let habitID = clock.backupArchive().habitID else { return }
            if let habit = progress.habits.first(where: { $0.id == habitID && $0.archivedDay == nil }) {
                // 就绪状态下习惯时长被修改，倒计时同步为新时长。
                if habit.focusSeconds != clock.backupArchive().focusDuration { clock.setGoal(clock.goal, habit: habit) }
            } else {
                clock.setGoal(clock.goal, habit: nil)
            }
        }
    }
    @Published private(set) var isReady = false
    @Published private(set) var loadError: String?
    private var progressSubscription: AnyCancellable?
    private var preferencesSubscription: AnyCancellable?
    private var loadTask: Task<Void, Never>?
    private var progressGeneration = 0
    @Published private(set) var isMaintainingData = false
    /// 场景陪伴计时：环境音或全屏视频正在播放时按场景累计时长，供足迹页的偏好占比使用。
    private let companion = AmbientCompanionTracker()
    private var observers: [NSObjectProtocol] = []
    private var clockSubscription: AnyCancellable?
    private var isStopped = false
    private weak var backdrop: AmbientBackdropView?
    private var isHomeVisible = false
    private var hasAppliedDefaultSound = false
    private var isInterrupted = false
    private var resumeSoundAfterInterruption = false
    private let originalIdleSetting = UIApplication.shared.isIdleTimerDisabled
    private var sessionSnapshot: (AVAudioSession.Category, AVAudioSession.Mode, AVAudioSession.CategoryOptions)?

    init() {
        // 启动时预热全屏文案缓存，进入全屏时可以先展示已缓存的一句。
        AmbientQuoteProvider.shared.prefetch()
        sleepTimer.onGainChange = { [weak self] gain in self?.applySleepGain(gain) }
        sleepTimer.onExpiration = { [weak self] expiredAt in self?.enterSleep(at: expiredAt) }
        clockSubscription = clock.$state.sink { [weak self] state in
            self?.updateIdleSetting(clockRunning: state == .running)
        }
        observe(AVAudioSession.interruptionNotification) { [weak self] note in self?.handleInterruption(note) }
        observe(AVAudioSession.routeChangeNotification) { [weak self] note in
            guard let reason = note.userInfo?[AVAudioSessionRouteChangeReasonKey] as? UInt,
                  reason == AVAudioSession.RouteChangeReason.oldDeviceUnavailable.rawValue else { return }
            self?.pauseMedia()
        }
        observe(AVAudioSession.mediaServicesWereResetNotification) { [weak self] _ in
            guard let self else { return }
            self.isAudioSessionActive = false
            let visiblePlayback = self.playback
            self.pauseMedia()
            self.backdrop?.setPlaybackAllowed(false)
            self.phaseCue.stop()
            self.mixer.stop()
            self.finishPlayback()
            self.notice = "音频环境已更新，请重新开始播放。"
            if let visiblePlayback, visiblePlayback.viewIfLoaded?.window != nil {
                AmbientStyle.message(on: visiblePlayback, title: "播放已暂停", text: "音频环境已更新，请返回主页后重新选择场景。")
                self.notice = nil
            }
        }
        observe(UIApplication.willResignActiveNotification) { [weak self] _ in
            self?.backdrop?.setPlaybackAllowed(false)
        }
        observe(UIApplication.didEnterBackgroundNotification) { [weak self] _ in
            guard let self else { return }
            self.updateIdleSetting()
            // 进入后台先结算一次陪伴时长，进程随后被挂起也不会丢失当前片段。
            self.companion.checkpoint()
            // 给系统画中画切换留出回调时间，普通后台退出不继续解码视频。
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
                guard let self, !self.isStopped,
                      UIApplication.shared.applicationState == .background,
                      self.playback?.isPictureInPictureActive != true,
                      self.playback?.isStartingPictureInPicture != true else { return }
                self.playback?.pauseForBackground()
                // 暂停后立即重新判断陪伴计时，不等待异步的速率回调，避免挂起期间仍在计时。
                self.updateCompanionTracking()
            }
        }
        observe(UIApplication.didBecomeActiveNotification) { [weak self] _ in
            guard let self else { return }
            self.sleepTimer.refresh()
            self.clock.refreshAfterActivation()
            if !self.sleepTimer.isSleeping && !self.isInterrupted { self.playback?.resumeFromBackground() }
            self.updateIdleSetting()
            self.updateBackdrop()
            self.applyDefaultSoundIfNeeded()
            self.updateCompanionTracking()
        }
        observe(UIApplication.significantTimeChangeNotification) { [weak self] _ in self?.sleepTimer.refresh() }
        phaseCue.onFinish = { [weak self] in self?.releaseAudioSessionIfUnused() }
        clock.onPhaseChange = { [weak self] stage, audible in
            guard let self, !self.isStopped else { return }
            self.mixer.setRest(stage == .rest)
            if audible && AmbientPreferences.shared.values.phaseSound && !self.sleepTimer.isSleeping {
                // 应用内短音只在到期附近播放，恢复前台不补播过期提示。
                do { try self.prepareAudioSession(); try self.phaseCue.play() }
                catch { self.releaseAudioSessionIfUnused() }
            }
            if self.isSoundEnabled && !self.sleepTimer.isSleeping { self.setSoundEnabled(true, userInitiated: false) }
        }
        progressSubscription = NotificationCenter.default.publisher(for: AmbientProgressStore.didChange)
            .receive(on: RunLoop.main).sink { [weak self] _ in self?.reloadProgress() }
        preferencesSubscription = NotificationCenter.default.publisher(for: AmbientPreferences.didChange)
            .receive(on: RunLoop.main).sink { [weak self] _ in self?.objectWillChange.send() }
        observe(Notification.Name("com.workspace.storage.failed")) { [weak self] _ in
            self?.notice = "记录暂时无法保存，请稍后重试。"
        }
        prepareProgress()
    }

    /// 数据迁移完成后才启动计时和自动环境音，避免先结算后迁移覆盖奖励。
    func prepareProgress() {
        guard loadTask == nil, !isStopped else { return }
        loadTask = Task { [weak self] in
            guard let self else { return }
            defer { self.loadTask = nil }
            do {
                // 已启动时只重试保存与读取，不重复执行恢复事务或自动开启声音。
                if self.isReady {
                    try await self.clock.retryPersistence()
                    await self.refreshProgressNow()
                    self.loadError = nil
                    return
                }
                try await AmbientProgressStore.shared.prepare()
                try await AmbientBackupManager.recoverIfNeeded(clock: self.clock)
                self.publish(try await AmbientProgressStore.shared.snapshot())
                guard !self.isStopped else { return }
                self.loadError = nil
                self.isReady = true
                self.sleepTimer.refresh()
                if self.sleepTimer.isSleeping { self.enterSleep() }
                self.clock.activate()
                self.clock.sceneIdentifierProvider = { [weak self] in self?.selectedScene.identifier }
                self.mixer.setRest(self.clock.stage == .rest)
                self.applyDefaultSoundIfNeeded()
            } catch { self.loadError = "本地记录暂时无法读取，轻点重试。" }
        }
    }

    /// 所有进度快照统一经此发布。DEBUG 构建把全部场景视为已解锁，方便本地验证；
    /// 只改内存快照，不写盘，账目与备份校验仍按真实数据执行。
    private func publish(_ snapshot: AmbientProgressPayload) {
        var payload = snapshot
        #if DEBUG
        payload.unlocks.formUnion(AmbientScene.collection.map(\.identifier))
        #endif
        progress = payload
    }

    /// 只应用最新一次读取，避免导入前的慢回调覆盖已经替换的数据。
    func refreshProgressNow() async {
        progressGeneration += 1
        let generation = progressGeneration
        do {
            let latest = try await AmbientProgressStore.shared.snapshot()
            guard generation == progressGeneration, !isStopped else { return }
            publish(latest)
        } catch { notice = error.localizedDescription }
    }

    func reloadProgress() {
        Task { [weak self] in await self?.refreshProgressNow() }
    }

    func setMixLevel(_ id: String, value: Float) {
        guard value.isFinite else { return }
        var levels = mixer.levels(for: selectedScene)
        levels[id] = min(1, max(0, value))
        mixer.changedByUser()
        AmbientPreferences.shared.update { $0.followsScene = false; $0.levels = levels }
        if isSoundEnabled { setSoundEnabled(true, userInitiated: false) }
    }

    func followSceneSound() {
        mixer.changedByUser()
        AmbientPreferences.shared.update { $0.followsScene = true }
        if isSoundEnabled { setSoundEnabled(true, userInitiated: false) }
    }

    /// 数据操作期间先停声并结算，恢复后保持暂停，避免导入期间出现迟到写入。
    func pauseForDataOperation() async throws {
        isMaintainingData = true
        clock.pauseForDataOperation()
        hasAppliedDefaultSound = true
        phaseCue.stop()
        mixer.stop()
        isSoundEnabled = false
        let previous = playback
        finishPlayback(resumeBackdrop: false)
        previous?.dismissForSleep()
        companion.update(scene: nil)
        try await clock.finishPersistence()
        try await companion.finishPersistence()
        restoreAudioSession()
    }

    func finishDataOperation() {
        guard isMaintainingData else { return }
        isMaintainingData = false
        if !progress.unlocks.contains(selectedScene.identifier) { selectedScene = AmbientScene.collection[0] }
        backdrop?.display(selectedScene)
        mixer.setRest(clock.stage == .rest)
        updateBackdrop()
        updateIdleSetting()
    }


    func clearNotice() { notice = nil }

    /// 首页持有视图，服务只弱引用它，以便与全屏、画中画和空间切换统一互斥。
    func connectBackdrop(_ backdrop: AmbientBackdropView) {
        self.backdrop = backdrop
        backdrop.display(selectedScene)
        updateBackdrop()
    }

    func setHomeVisible(_ visible: Bool) {
        sleepTimer.refresh()
        isHomeVisible = visible
        updateBackdrop()
        updateIdleSetting()
        applyDefaultSoundIfNeeded()
    }

    /// 每次进入专注空间仅自动开启一次，返回首页时保留用户手动关闭的状态。
    private func applyDefaultSoundIfNeeded() {
        guard isReady, !isMaintainingData, !isStopped, !sleepTimer.isSleeping, !hasAppliedDefaultSound, isHomeVisible, !isInterrupted,
              UIApplication.shared.applicationState == .active else { return }
        hasAppliedDefaultSound = true
        setSoundEnabled(AmbientPreferences.shared.values.soundEnabled, userInitiated: false)
    }

    @discardableResult
    func select(_ scene: AmbientScene) -> Bool {
        guard isReady, !isMaintainingData, !isStopped, progress.unlocks.contains(scene.identifier) else { return false }
        resumeFromSleep()
        guard scene.identifier != selectedScene.identifier else { return true }
        guard playback == nil else {
            notice = "请先结束当前播放，再切换场景。"
            return false
        }
        selectedScene = scene
        backdrop?.display(scene)
        if isSoundEnabled { setSoundEnabled(true, userInitiated: false) }
        return true
    }

    private func updateBackdrop() {
        backdrop?.setPlaybackAllowed(!isMaintainingData && !isStopped && !sleepTimer.isSleeping && isHomeVisible && !isInterrupted && playback == nil &&
                                    UIApplication.shared.applicationState == .active)
    }

    func setSoundEnabled(_ enabled: Bool, userInitiated: Bool = true) {
        guard isReady, !isStopped, !isMaintainingData else { return }
        if userInitiated { AmbientPreferences.shared.update { $0.soundEnabled = enabled } }
        if enabled {
            if userInitiated { resumeFromSleep() } else { sleepTimer.refresh() }
            guard !sleepTimer.isSleeping else { return }
        }
        resumeSoundAfterInterruption = false
        if !enabled {
            mixer.stop()
            isSoundEnabled = false
            releaseAudioSessionIfUnused()
            return
        }
        do {
            try prepareAudioSession()
            try mixer.play(scene: selectedScene, gain: sleepTimer.gain)
            isSoundEnabled = true
        } catch {
            self.phaseCue.stop()
            self.mixer.stop()
            isSoundEnabled = false
            releaseAudioSessionIfUnused()
            notice = "环境音暂时无法播放，请稍后重试。"
        }
    }

    func open(_ scene: AmbientScene, from presenter: UIViewController) {
        guard isReady, !isMaintainingData, !isStopped, progress.unlocks.contains(scene.identifier), presenter.presentedViewController == nil else { return }
        resumeFromSleep()
        if let playback, playback.scene.identifier == scene.identifier {
            if playback.isPictureInPictureActive || playback.isStartingPictureInPicture {
                // 系统控制器没有公开的主动恢复接口，由画中画窗口的还原按钮恢复。
                notice = "请点击画中画窗口中的还原按钮，返回完整播放画面。"
                return
            }
            if playback.presentingViewController == nil {
                presenter.present(playback, animated: true)
            }
            return
        }
        // 先释放首页解码资源，再创建全屏队列，避免同时加载同一段素材。
        backdrop?.setPlaybackAllowed(false)
        finishPlayback(resumeBackdrop: false)
        select(scene)
        do {
            guard let url = scene.resource("mp4") else { throw AmbientMediaError.missingResource }
            try prepareAudioSession()
            let controller = AmbientPlaybackViewController(scene: scene, url: url, services: self)
            playback = controller
            AppWorkspaceCoordinator.shared.setPlayerPresented(true, from: presenter)
            presenter.present(controller, animated: true)
        } catch {
            releaseAudioSessionIfUnused()
            updateBackdrop()
            notice = "场景资源暂时无法播放，请重新打开应用后重试。"
        }
    }

    func finishPlayback(resumeBackdrop: Bool = true) {
        let previous = playback
        playback = nil
        previous?.stop()
        if resumeBackdrop { updateBackdrop() }
        updateIdleSetting()
        releaseAudioSessionIfUnused()
    }

    func playbackVisibilityChanged() { updateIdleSetting() }

    /// 全屏播放页的实际播放状态变化时调用，重新判断陪伴计时。
    func playbackActivityChanged() { updateCompanionTracking() }

    /// 打开足迹页前结算进行中的专注与陪伴片段，页面数据与此刻一致。
    func flushRecords() {
        guard !isStopped else { return }
        clock.flushProgress()
        companion.checkpoint()
    }

    /// 环境音或全屏视频正在播放时按当前场景计入陪伴时长；停止、休眠或退出空间时结算并停止。
    /// 按场景标识而不是音频文件统计，炉火与余烬共用音频也会分开计算。
    private func updateCompanionTracking() {
        let videoScene = playback?.isPlayingVideo == true ? playback?.scene.identifier : nil
        let soundScene = isSoundEnabled && mixer.isPlaying ? selectedScene.identifier : nil
        companion.update(scene: (isStopped || sleepTimer.isSleeping) ? nil : (videoScene ?? soundScene))
    }

    /// 当前关联且未归档的习惯；找不到时视为未关联。
    var linkedHabit: AmbientHabit? {
        guard let habitID = clock.backupArchive().habitID else { return nil }
        return progress.habits.first { $0.id == habitID && $0.archivedDay == nil }
    }

    /// 即将开启一轮专注却没有关联习惯时禁止开始，倒计时时长只能来自习惯设置。
    var isFocusStartBlocked: Bool { clock.isAwaitingFocusStart && linkedHabit == nil }

    /// 计时与媒体的重新开始均属于明确的用户唤醒动作。
    func performFocusAction() {
        guard isReady, !isMaintainingData, !isStopped, !isFocusStartBlocked else { return }
        resumeFromSleep()
        clock.primaryAction()
    }

    /// 睡眠定时只按固定时长关停，任何时候都可以设置，与番茄钟状态无关。
    func setSleepPreset(_ preset: AmbientSleepTimer.Preset) {
        guard isReady, !isMaintainingData, !isStopped else { return }
        sleepTimer.schedule(preset)
        updateBackdrop()
        updateIdleSetting()
    }

    private func applySleepGain(_ gain: Float) {
        // 睡眠渐弱只影响当前环境音，不改写手机系统音量或滑杆位置。
        mixer.updateGain(gain, scene: selectedScene)
    }

    private func resumeFromSleep() {
        guard !isStopped else { return }
        sleepTimer.refresh()
        guard sleepTimer.isSleeping else { return }
        sleepTimer.wake()
        updateBackdrop()
        updateIdleSetting()
    }

    /// expiredAt 为睡眠实际到期时刻；启动时补判休眠状态使用默认值此刻。
    private func enterSleep(at expiredAt: Date = Date()) {
        guard !isStopped else { return }
        hasAppliedDefaultSound = true
        resumeSoundAfterInterruption = false
        backdrop?.setPlaybackAllowed(false)
        clock.pauseForSleep(at: expiredAt)
        let previous = playback
        phaseCue.stop()
        mixer.stop()
        isSoundEnabled = false
        finishPlayback(resumeBackdrop: false)
        previous?.dismissForSleep()
        restoreAudioSession()
        // 恢复系统自动锁定，而不是依赖仍可能存活的播放页面或专注状态。
        UIApplication.shared.isIdleTimerDisabled = false
    }

    /// 显式清理使迟到的系统回调无法再影响新的音频会话。
    func shutdown() async throws {
        guard !isStopped else { return }
        try await pauseForDataOperation()
        try await clock.shutdown()
        spatialMotion.setPageVisible(false)
        isStopped = true
        // 先结算最后一段陪伴时长并停止计时，再拆除播放资源。
        updateCompanionTracking()
        progressSubscription?.cancel()
        preferencesSubscription?.cancel()
        sleepTimer.shutdown()
        backdrop?.shutdown()
        backdrop = nil
        observers.forEach(NotificationCenter.default.removeObserver)
        observers.removeAll()
        clockSubscription?.cancel()
        clockSubscription = nil
        phaseCue.stop()
        mixer.stop()
        isSoundEnabled = false
        finishPlayback()
        restoreAudioSession()
        UIApplication.shared.isIdleTimerDisabled = originalIdleSetting
    }

    private func prepareAudioSession() throws {
        guard !isStopped, !sleepTimer.isSleeping else { throw AmbientMediaError.unavailable }
        let session = AVAudioSession.sharedInstance()
        if sessionSnapshot == nil {
            sessionSnapshot = (session.category, session.mode, session.categoryOptions)
        }
        if !isAudioSessionActive {
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
            isAudioSessionActive = true
        }
    }

    private func releaseAudioSessionIfUnused() {
        if !mixer.hasPlayers && !phaseCue.isPlaying && playback == nil { restoreAudioSession() }
    }

    private func restoreAudioSession() {
        guard let snapshot = sessionSnapshot else { return }
        sessionSnapshot = nil
        isAudioSessionActive = false
        let session = AVAudioSession.sharedInstance()
        try? session.setActive(false, options: .notifyOthersOnDeactivation)
        try? session.setCategory(snapshot.0, mode: snapshot.1, options: snapshot.2)
    }

    private func updateIdleSetting(clockRunning: Bool? = nil) {
        guard !isStopped else { return }
        if sleepTimer.isSleeping {
            UIApplication.shared.isIdleTimerDisabled = false
            return
        }
        let active = UIApplication.shared.applicationState == .active
        let playingVisible = playback?.viewIfLoaded?.window != nil
        UIApplication.shared.isIdleTimerDisabled = originalIdleSetting ||
            (active && ((clockRunning ?? (clock.state == .running)) || playingVisible))
    }

    private func pauseMedia() {
        resumeSoundAfterInterruption = false
        phaseCue.stop()
        mixer.stop()
        isSoundEnabled = false
        playback?.pause()
        releaseAudioSessionIfUnused()
    }

    private func handleInterruption(_ notification: Notification) {
        guard let raw = notification.userInfo?[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: raw) else { return }
        // 即使已经休眠也记录中断结束，避免用户唤醒后仍被旧中断状态拦住。
        isInterrupted = type == .began
        sleepTimer.refresh()
        guard !isStopped, !sleepTimer.isSleeping else { return }
        if type == .began {
            isAudioSessionActive = false
            phaseCue.stop()
            isInterrupted = true
            updateBackdrop()
            let shouldResume = isSoundEnabled
            // 先保存播放意图，再暂停，避免中断开始时丢失恢复依据。
            playback?.beginInterruption()
            mixer.pause()
            isSoundEnabled = false
            resumeSoundAfterInterruption = shouldResume
        } else {
            isInterrupted = false
            let options = (notification.userInfo?[AVAudioSessionInterruptionOptionKey] as? UInt) ?? 0
            let canResume = AVAudioSession.InterruptionOptions(rawValue: options).contains(.shouldResume)
            if canResume {
                do {
                    try prepareAudioSession()
                    if resumeSoundAfterInterruption { setSoundEnabled(true, userInitiated: false) }
                    playback?.endInterruption(canResume: true)
                } catch {
                    playback?.endInterruption(canResume: false)
                    notice = "音频暂时无法恢复，请手动重新开始。"
                }
            } else {
                playback?.endInterruption(canResume: false)
            }
            resumeSoundAfterInterruption = false
            updateBackdrop()
        }
    }

    private func observe(_ name: Notification.Name, handler: @escaping (Notification) -> Void) {
        observers.append(NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { note in
            // 通知限定在主队列，回调同步完成，避免切换后排队修改全局状态。
            MainActor.assumeIsolated { handler(note) }
        })
    }

    deinit { observers.forEach(NotificationCenter.default.removeObserver) }
}

private enum AmbientMediaError: Error {
    case missingResource, unavailable
}
