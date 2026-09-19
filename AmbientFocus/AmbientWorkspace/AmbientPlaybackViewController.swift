import AVKit
import Combine
import UIKit

/// 可在画中画还原全屏播放时先行收起的轻量浮层，例如首页的设置面板。
protocol AmbientDismissibleSheet: AnyObject {}

/// 组合系统播放控制器；画中画运行时由专注服务保留整个播放会话。
final class AmbientPlaybackViewController: UIViewController, AVPlayerViewControllerDelegate {
    let scene: AmbientScene
    private weak var services: AmbientServices?
    private let systemPlayer = AVPlayerViewController()
    private let queue = AVQueuePlayer()
    private var looper: AVPlayerLooper?
    private var soundSubscription: AnyCancellable?
    private var sleepSubscription: AnyCancellable?
    private var statusObservation: NSKeyValueObservation?
    private var playbackObservation: NSKeyValueObservation?
    private var shouldResumeFromBackground = false
    private var shouldResumeAfterInterruption = false
    private var isInterrupted = false
    private var lastPlaybackIntent = true
    private var isStopped = false
    private var isClosing = false
    private var isRestoringInterface = false
    /// 最近一次应用的横竖屏状态；只在方向变化时改写填充方式，避免每次布局重复赋值。
    private var appliedLandscapeLayout: Bool?
    private weak var sourceWindow: UIWindow?
    private let soundButton = UIButton(type: .system)
    private let sleepButton: AmbientSleepButton
    private let sleepStatusLabel = AmbientStyle.label("", size: 12)
    /// 顶部渐变遮罩始终不拦截触摸，整体显隐时只改透明度。
    private let shadeView = AmbientPlaybackShadeView()
    private let soundImages = AmbientStyle.soundImages(pointSize: 19)
    private let controlTint = UIColor(red: 0.95, green: 0.93, blue: 0.88, alpha: 1)
    private(set) var isPictureInPictureActive = false
    private(set) var isStartingPictureInPicture = false
    /// 供服务层统计场景陪伴时长：全屏或画中画中的视频实际在播放。
    var isPlayingVideo: Bool { !isStopped && queue.rate > 0 }
    /// 场景内置副标题，网络文案拉取失败且没有缓存时展示它。
    private lazy var defaultQuote = AmbientQuote(text: scene.subtitle, attribution: nil)
    /// 当前展示的文案；进入全屏先用缓存或内置文案，再异步拉取新文案平滑替换。
    private lazy var currentQuote = AmbientQuoteProvider.shared.cached ?? defaultQuote
    /// 全屏文案控件，可拖动摆放，轻点它换一句；始终显示，不参与轻点画面的整体显隐。
    private lazy var subtitleCaption = AmbientSubtitleCaption(quote: currentQuote, tint: controlTint)
    private var quoteTask: Task<Void, Never>?
    /// 副标题中心点在画面中的相对位置（0 到 1），旋转时按比例还原；每次进入全屏都回到画面中央。
    private var subtitlePosition = AmbientSubtitleCaption.centerPosition
    /// 全屏页内所有浮层控件的整体显示状态，轻点画面时一起切换。
    private var isOverlayVisible = true
    /// 参与整体显隐的浮层：标题栏、顶部遮罩、睡眠倒计时以及画中画提示；文案控件不在其中。
    private var overlayViews: [UIView] = []
    /// 标题栏所在区域，副标题拖动时不进入这里，避免挡住返回与声音按钮。
    private weak var controlsRow: UIView?

    init(scene: AmbientScene, url: URL, services: AmbientServices) {
        self.scene = scene
        self.services = services
        sleepButton = AmbientSleepButton(services: services)
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        queue.isMuted = true
        // 常亮仅由专注服务管理，休眠后播放器不能独立阻止系统息屏。
        queue.preventsDisplaySleepDuringVideoPlayback = false
        looper = AVPlayerLooper(player: queue, templateItem: AVPlayerItem(url: url))
        systemPlayer.player = queue
        systemPlayer.delegate = self
        // 呈现前隐藏整套系统控制栏，包含进度、倍速和画中画等入口，仅保留自定义操作。
        systemPlayer.showsPlaybackControls = false
        systemPlayer.allowsPictureInPicturePlayback = AVPictureInPictureController.isPictureInPictureSupported()
        systemPlayer.canStartPictureInPictureAutomaticallyFromInline = true
        systemPlayer.videoGravity = .resizeAspectFill
        // 状态仅用于错误提示；循环播放由系统队列管理，不用结尾通知反复跳转。
        statusObservation = queue.observe(\.currentItem?.status, options: [.new]) { [weak self] _, _ in
            Task { @MainActor in
                guard let self, !self.isStopped, self.queue.currentItem?.status == .failed else { return }
                self.showPlaybackFailure()
            }
        }
        playbackObservation = queue.observe(\.rate, options: [.new]) { [weak self] _, _ in
            Task { @MainActor in
                guard let self, !self.isStopped else { return }
                if !self.isInterrupted && !self.shouldResumeFromBackground &&
                    UIApplication.shared.applicationState == .active {
                    self.lastPlaybackIntent = self.queue.rate > 0
                }
                // 播放速率变化会影响场景陪伴计时，通知服务层重新判断。
                self.services?.playbackActivityChanged()
            }
        }
    }

    required init?(coder: NSCoder) { nil }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .allButUpsideDown }
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    @available(iOS 26.0, *)
    override var prefersInterfaceOrientationLocked: Bool { false }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = .black
        addChild(systemPlayer)
        systemPlayer.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(systemPlayer.view)
        NSLayoutConstraint.activate([
            systemPlayer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            systemPlayer.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            systemPlayer.view.topAnchor.constraint(equalTo: view.topAnchor),
            systemPlayer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        systemPlayer.didMove(toParent: self)
        let close = UIButton(type: .system)
        configureLineButton(close, title: "返回", symbol: "chevron.backward")
        close.contentHorizontalAlignment = .leading
        close.accessibilityLabel = "返回"
        close.addTarget(self, action: #selector(closePlayback), for: .touchUpInside)
        configureLineButton(soundButton, title: "环境音", symbol: "speaker.wave.2")
        // 右侧采用两个独立图标，窄屏仍为场景标题保留空间，朗读名称保持完整。
        soundButton.configuration?.title = nil
        // 初始图标按当前环境音状态渲染，环境音默认关闭时显示为静音。
        renderSoundControl(enabled: services?.isSoundEnabled ?? false)
        soundButton.contentHorizontalAlignment = .trailing
        soundButton.accessibilityLabel = "环境音"
        soundButton.addTarget(self, action: #selector(toggleSound), for: .touchUpInside)
        let title = AmbientStyle.label(scene.title, size: 18)
        // 标题与副标题同用苹方细体，全屏页字体保持统一。
        title.font = UIFontMetrics.default.scaledFont(for: AmbientStyle.pingFang(size: 18, weight: .light), maximumPointSize: 28)
        title.textColor = controlTint
        title.textAlignment = .center
        title.numberOfLines = 1
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.7
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        let controls = UIView()
        controls.translatesAutoresizingMaskIntoConstraints = false
        // 渐变只改善亮色场景的对比度，不拦截系统播放器的手势。
        let shade = shadeView
        shade.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shade)
        view.addSubview(controls)
        sleepButton.tintColor = controlTint
        let trailingControls = UIStackView(arrangedSubviews: [sleepButton, soundButton])
        trailingControls.alignment = .center
        trailingControls.spacing = 8
        for item in [close, title, trailingControls] {
            item.translatesAutoresizingMaskIntoConstraints = false
            controls.addSubview(item)
        }
        // 场景副标题默认位于画面中央，由布局回调按记录的相对位置摆放；拖动只作用在副标题本身。
        controlsRow = controls
        view.addSubview(subtitleCaption)
        let subtitlePan = UIPanGestureRecognizer(target: self, action: #selector(dragSubtitle(_:)))
        subtitleCaption.addGestureRecognizer(subtitlePan)
        // 轻点文案本身换一句；拖动一开始轻点即失败，小幅挪动后松手不会顺带换句。
        let subtitleTap = UITapGestureRecognizer(target: self, action: #selector(switchQuote))
        subtitleTap.require(toFail: subtitlePan)
        subtitleCaption.addGestureRecognizer(subtitleTap)
        subtitleCaption.accessibilityCustomActions = [
            UIAccessibilityCustomAction(name: "换一句") { [weak self] _ in
                self?.switchQuote()
                return true
            },
            UIAccessibilityCustomAction(name: "移回画面中央") { [weak self] _ in
                self?.resetSubtitlePosition()
                return true
            },
            // 文案始终可见，控件全部隐藏后旁白用户仍能从这里把控件找回来。
            UIAccessibilityCustomAction(name: "显示或隐藏控件") { [weak self] _ in
                self?.toggleOverlay()
                return true
            }
        ]
        // 轻点画面整体切换所有控件的显示；旁白用户可从场景标题执行同一操作，全部隐藏后由画面本身充当找回入口。
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleOverlay))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        // 拖动一开始轻点即失败，小幅挪动副标题松手后不会被顺带隐藏；只轻点副标题时仍照常切换。
        tap.require(toFail: subtitlePan)
        view.addGestureRecognizer(tap)
        title.accessibilityCustomActions = [
            UIAccessibilityCustomAction(name: "显示或隐藏控件") { [weak self] _ in
                self?.toggleOverlay()
                return true
            }
        ]
        sleepStatusLabel.textColor = controlTint.withAlphaComponent(0.8)
        sleepStatusLabel.textAlignment = .center
        sleepStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sleepStatusLabel)
        NSLayoutConstraint.activate([
            controls.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            controls.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -22),
            controls.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            close.leadingAnchor.constraint(equalTo: controls.leadingAnchor),
            close.topAnchor.constraint(equalTo: controls.topAnchor),
            close.bottomAnchor.constraint(equalTo: controls.bottomAnchor),
            trailingControls.trailingAnchor.constraint(equalTo: controls.trailingAnchor),
            trailingControls.topAnchor.constraint(equalTo: controls.topAnchor),
            trailingControls.bottomAnchor.constraint(equalTo: controls.bottomAnchor),
            // 标题始终位于画面中线，不随两侧文字宽度或声音状态偏移。
            title.centerXAnchor.constraint(equalTo: controls.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: controls.centerYAnchor),
            title.leadingAnchor.constraint(greaterThanOrEqualTo: close.trailingAnchor, constant: 12),
            title.trailingAnchor.constraint(lessThanOrEqualTo: trailingControls.leadingAnchor, constant: -8),
            title.topAnchor.constraint(greaterThanOrEqualTo: controls.topAnchor),
            title.bottomAnchor.constraint(lessThanOrEqualTo: controls.bottomAnchor),
            sleepStatusLabel.topAnchor.constraint(equalTo: controls.bottomAnchor, constant: 8),
            sleepStatusLabel.leadingAnchor.constraint(equalTo: controls.leadingAnchor),
            sleepStatusLabel.trailingAnchor.constraint(equalTo: controls.trailingAnchor),
            shade.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shade.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shade.topAnchor.constraint(equalTo: view.topAnchor),
            shade.bottomAnchor.constraint(equalTo: controls.bottomAnchor, constant: 64)
        ])
        soundSubscription = services?.$isSoundEnabled.sink { [weak self] enabled in
            self?.renderSoundControl(enabled: enabled)
        }
        sleepSubscription = services?.sleepTimer.objectWillChange.receive(on: RunLoop.main).sink { [weak self] in
            self?.renderSleepControl()
        }
        renderSleepControl()
        overlayViews = [shade, controls, sleepStatusLabel]
        if !AVPictureInPictureController.isPictureInPictureSupported() {
            let note = AmbientStyle.label("当前设备暂不支持画中画", size: 12)
            note.textAlignment = .center
            note.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(note)
            NSLayoutConstraint.activate([
                note.topAnchor.constraint(equalTo: sleepStatusLabel.bottomAnchor, constant: 12),
                note.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            overlayViews.append(note)
        }
    }

    /// 按钮保持透明，仅用细线图标和文字表达操作，触控区域不随视觉样式缩小。
    private func configureLineButton(_ button: UIButton, title: String, symbol: String) {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.image = UIImage(systemName: symbol)
        configuration.imagePadding = 6
        configuration.baseForegroundColor = controlTint
        configuration.background.backgroundColor = .clear
        configuration.background.strokeWidth = 0
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 19, weight: .light)
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var result = attributes
            result.font = UIFontMetrics(forTextStyle: .body).scaledFont(
                for: .systemFont(ofSize: 14, weight: .regular), maximumPointSize: 22)
            return result
        }
        button.configuration = configuration
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.75
        button.configurationUpdateHandler = { button in
            // 按下时仅降低透明度，避免系统状态更新重新绘制按钮底板。
            button.alpha = button.isHighlighted ? 0.55 : 1
        }
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 44),
            button.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
    }

    private func renderSoundControl(enabled: Bool) {
        // 文案和颜色不随声音状态变化，等尺寸图标保证文字位置保持稳定。
        soundButton.configuration?.image = enabled ? soundImages.enabled : soundImages.disabled
        soundButton.accessibilityValue = enabled ? "已开启" : "已关闭"
        soundButton.accessibilityHint = enabled ? "轻点关闭环境音" : "轻点开启环境音"
    }

    private func renderSleepControl() {
        guard let timer = services?.sleepTimer else { return }
        sleepStatusLabel.text = timer.preset == nil ? nil : timer.status
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppWorkspaceCoordinator.shared.setPlayerPresented(true, from: presentingViewController ?? self)
        // 每次进入全屏（含画中画还原后重新呈现）都回到初始状态：所有控件可见，副标题位于画面中央。
        subtitlePosition = AmbientSubtitleCaption.centerPosition
        view.setNeedsLayout()
        setOverlayVisible(true, animated: false)
        refreshQuote(manual: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubtitle()
        // 以布局后的真实尺寸为准，覆盖首次呈现、旋转和画中画还原后的重新呈现。
        // 场景视频为竖屏构图：竖屏铺满，横屏完整显示并在两侧留黑边，避免放大裁切后发虚。
        let size = view.bounds.size
        guard size.width > 0, size.height > 0 else { return }
        let isLandscape = size.width > size.height
        guard isLandscape != appliedLandscapeLayout else { return }
        appliedLandscapeLayout = isLandscape
        systemPlayer.videoGravity = isLandscape ? .resizeAspect : .resizeAspectFill
    }

    // MARK: - 场景副标题

    /// 按记录的相对位置摆放副标题，并限制在安全区内、标题栏下方。
    private func layoutSubtitle() {
        let bounds = view.bounds
        guard bounds.width > 0, bounds.height > 0 else { return }
        let area = subtitleArea()
        let fitted = subtitleCaption.sizeThatFits(CGSize(width: min(area.width, 520), height: .greatestFiniteMagnitude))
        subtitleCaption.bounds = CGRect(x: 0, y: 0, width: min(fitted.width, area.width), height: fitted.height)
        let target = CGPoint(x: subtitlePosition.x * bounds.width, y: subtitlePosition.y * bounds.height)
        subtitleCaption.center = clampedSubtitleCenter(target)
    }

    /// 副标题可以停放的区域：安全区左右与底部留出边距，顶部从标题栏下方开始。
    private func subtitleArea() -> CGRect {
        let safe = view.bounds.inset(by: view.safeAreaInsets).insetBy(dx: 12, dy: 0)
        let controlsBottom = controlsRow.map { $0.convert($0.bounds, to: view).maxY } ?? safe.minY
        // 睡眠倒计时显示时顶部再下移到它下方，副标题拖到最上方也不会与倒计时文字重叠；没有文字时该标签高度为零，不影响原位置。
        let top = max(safe.minY, controlsBottom + 8, sleepStatusLabel.frame.maxY)
        return CGRect(x: safe.minX, y: top, width: max(0, safe.width), height: max(0, safe.maxY - 12 - top))
    }

    /// 让副标题整体保持在可停放区域内，区域比副标题还小时停在区域起点。
    private func clampedSubtitleCenter(_ point: CGPoint) -> CGPoint {
        let area = subtitleArea()
        let halfWidth = subtitleCaption.bounds.width / 2
        let halfHeight = subtitleCaption.bounds.height / 2
        let minX = area.minX + halfWidth
        let minY = area.minY + halfHeight
        let maxX = max(minX, area.maxX - halfWidth)
        let maxY = max(minY, area.maxY - halfHeight)
        return CGPoint(x: min(max(point.x, minX), maxX), y: min(max(point.y, minY), maxY))
    }

    @objc private func dragSubtitle(_ pan: UIPanGestureRecognizer) {
        let bounds = view.bounds
        guard bounds.width > 0, bounds.height > 0 else { return }
        let translation = pan.translation(in: view)
        let moved = CGPoint(x: subtitleCaption.center.x + translation.x, y: subtitleCaption.center.y + translation.y)
        let clamped = clampedSubtitleCenter(moved)
        subtitleCaption.center = clamped
        // 只扣除实际移动的部分，越过边界的位移留在手势里：手指回到边界前副标题保持贴边，之后仍停在手指下方。
        pan.setTranslation(CGPoint(x: moved.x - clamped.x, y: moved.y - clamped.y), in: view)
        // 拖动过程中同步更新相对位置，期间的布局刷新（例如睡眠倒计时变化）不会把副标题拉回原处。
        subtitlePosition = CGPoint(x: subtitleCaption.center.x / bounds.width, y: subtitleCaption.center.y / bounds.height)
    }

    /// 轻点画面时所有浮层控件在显示与隐藏之间一起切换。
    @objc private func toggleOverlay() {
        setOverlayVisible(!isOverlayVisible, animated: true)
    }

    /// 统一设置浮层显隐；隐藏期间按钮不再响应触摸，也不被旁白读到。文案控件始终显示并可拖动、换句。
    private func setOverlayVisible(_ visible: Bool, animated: Bool) {
        isOverlayVisible = visible
        for item in overlayViews where item !== shadeView { item.isUserInteractionEnabled = visible }
        let duration = animated && !UIAccessibility.isReduceMotionEnabled ? 0.2 : 0
        UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) {
            for item in self.overlayViews { item.alpha = visible ? 1 : 0 }
        }
        UIAccessibility.post(notification: .layoutChanged, argument: nil)
    }

    private func resetSubtitlePosition() {
        subtitlePosition = AmbientSubtitleCaption.centerPosition
        view.setNeedsLayout()
    }

    // MARK: - 动态文案

    /// 轻点文案换一句：拉取期间文案略微变淡作为反馈，重复轻点不会叠加请求。
    @objc private func switchQuote() {
        guard quoteTask == nil else { return }
        refreshQuote(manual: true)
    }

    /// 异步拉取新文案。自动刷新失败时保留当前内容（缓存或内置文案）；手动换句失败时回到内置文案，让用户看到响应。
    private func refreshQuote(manual: Bool) {
        quoteTask?.cancel()
        subtitleCaption.setLoading(manual)
        quoteTask = Task { [weak self] in
            guard let self else { return }
            let quote = await AmbientQuoteProvider.shared.fetch(avoiding: currentQuote)
            guard !Task.isCancelled else { return }
            quoteTask = nil
            subtitleCaption.setLoading(false)
            guard !isStopped else { return }
            if let quote {
                apply(quote)
            } else if manual, currentQuote != defaultQuote {
                apply(defaultQuote)
            }
        }
    }

    private func apply(_ quote: AmbientQuote) {
        guard quote != currentQuote else { return }
        currentQuote = quote
        // 只有页面在窗口上才做淡入淡出，画中画期间直接替换，回到全屏时已是新文案。
        subtitleCaption.update(quote, animated: viewIfLoaded?.window != nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !isStopped else { dismissForSleep(); return }
        sourceWindow = view.window
        services?.playbackVisibilityChanged()
        AppWorkspaceCoordinator.shared.refreshOrientation(from: self)
        if lastPlaybackIntent { queue.play() }
        if queue.currentItem?.status == .failed { showPlaybackFailure() }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard !isStopped else { return }
        services?.playbackVisibilityChanged()
        if presentingViewController == nil && !isPictureInPictureActive && !isStartingPictureInPicture {
            services?.finishPlayback()
        }
    }

    func pause() {
        lastPlaybackIntent = false
        shouldResumeFromBackground = false
        shouldResumeAfterInterruption = false
        queue.pause()
    }

    func pauseForBackground() {
        shouldResumeFromBackground = queue.rate > 0
        queue.pause()
    }

    func resumeFromBackground() {
        guard !isStopped, shouldResumeFromBackground, viewIfLoaded?.window != nil else { return }
        shouldResumeFromBackground = false
        queue.play()
    }

    func beginInterruption() {
        isInterrupted = true
        shouldResumeAfterInterruption = lastPlaybackIntent
        queue.pause()
    }

    func endInterruption(canResume: Bool) {
        isInterrupted = false
        defer { shouldResumeAfterInterruption = false }
        if !canResume { lastPlaybackIntent = false }
        guard !isStopped, canResume, shouldResumeAfterInterruption,
              viewIfLoaded?.window != nil || isPictureInPictureActive else { return }
        queue.play()
    }

    func stop() {
        guard !isStopped else { return }
        isStopped = true
        statusObservation?.invalidate()
        statusObservation = nil
        playbackObservation?.invalidate()
        playbackObservation = nil
        soundSubscription?.cancel()
        soundSubscription = nil
        sleepSubscription?.cancel()
        sleepSubscription = nil
        systemPlayer.delegate = nil
        // 解除系统播放关联，关闭当前画中画内容，迟到的回调不再持有业务资源。
        systemPlayer.player = nil
        queue.pause()
        looper?.disableLooping()
        looper = nil
        queue.removeAllItems()
        isPictureInPictureActive = false
        isStartingPictureInPicture = false
        isRestoringInterface = false
    }

    /// 资源由服务先行释放，再退出全屏；后台不等待转场动画完成才能休眠。
    func dismissForSleep() {
        isClosing = true
        // 到期可能恰逢全屏或画中画还原动画，待呈现完成后再退出，避免留下空白页面。
        if isBeingPresented, let transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: nil) { [weak self] _ in
                self?.dismissForSleep()
            }
            return
        }
        guard !isBeingDismissed else { return }
        guard let presenter = presentingViewController else { return }
        presenter.dismiss(animated: UIApplication.shared.applicationState == .active) {
            AppWorkspaceCoordinator.shared.setPlayerPresented(false, from: presenter)
        }
    }

    @objc private func closePlayback() {
        guard !isClosing else { return }
        isClosing = true
        let presenter = presentingViewController
        let services = services
        dismiss(animated: true) {
            services?.finishPlayback()
            if let presenter { AppWorkspaceCoordinator.shared.setPlayerPresented(false, from: presenter) }
        }
    }

    @objc private func toggleSound() {
        guard let services else { return }
        services.setSoundEnabled(!services.isSoundEnabled)
        if let notice = services.notice {
            services.clearNotice()
            AmbientStyle.message(on: self, title: "温馨提示", text: notice)
        }
    }

    private func showPlaybackFailure() {
        guard viewIfLoaded?.window != nil, presentedViewController == nil else { return }
        pause()
        AmbientStyle.message(on: self, title: "暂时无法播放", text: "请返回主页后重新选择场景。")
    }

    func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        isStartingPictureInPicture = true
    }

    func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        guard !isStopped else { return }
        isStartingPictureInPicture = false
        isPictureInPictureActive = true
        let presenter = presentingViewController
        dismiss(animated: true) {
            if let presenter { AppWorkspaceCoordinator.shared.setPlayerPresented(false, from: presenter) }
        }
    }

    func playerViewController(_ playerViewController: AVPlayerViewController,
                              failedToStartPictureInPictureWithError error: Error) {
        isStartingPictureInPicture = false
        if UIApplication.shared.applicationState == .background { pauseForBackground() }
        AmbientStyle.message(on: self, title: "画中画暂不可用", text: "你可以继续全屏播放，稍后再试。")
    }

    func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
        isPictureInPictureActive = false
        isStartingPictureInPicture = false
        if presentingViewController == nil && !isRestoringInterface { services?.finishPlayback() }
    }

    func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(_ playerViewController: AVPlayerViewController) -> Bool {
        // 由外层全屏容器负责退出，避免系统只移除内部播放控制器。
        false
    }

    func playerViewController(_ playerViewController: AVPlayerViewController,
                              restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        guard !isStopped, let services else { completionHandler(false); return }
        if presentingViewController != nil { completionHandler(true); return }
        guard let root = sourceWindow?.rootViewController else { completionHandler(false); return }
        isRestoringInterface = true
        attemptRestore(on: root, services: services, remainingAttempts: 3, completionHandler: completionHandler)
    }

    /// 按 root 当前的呈现状态恢复全屏：没有弹出内容时直接恢复；设置等轻量浮层让位于画中画还原，
    /// 先收起再恢复，浮层正处于弹出或收起转场时等转场结束再判断；其他弹窗（例如反馈提示）保持原判断，不覆盖。
    private func attemptRestore(on root: UIViewController, services: AmbientServices, remainingAttempts: Int,
                                completionHandler: @escaping (Bool) -> Void) {
        guard !isStopped, remainingAttempts > 0 else {
            isRestoringInterface = false
            completionHandler(false)
            return
        }
        guard let presented = root.presentedViewController else {
            presentForRestore(on: root, services: services, completionHandler: completionHandler)
            return
        }
        guard presented is AmbientDismissibleSheet else {
            isRestoringInterface = false
            completionHandler(false)
            return
        }
        let retry = { [weak self] in
            guard let self else { completionHandler(false); return }
            self.attemptRestore(on: root, services: services, remainingAttempts: remainingAttempts - 1,
                                completionHandler: completionHandler)
        }
        if presented.isBeingPresented || presented.isBeingDismissed, let coordinator = presented.transitionCoordinator {
            // 转场进行中发起呈现或收起会被系统忽略：等转场结束后立即重新判断，抢在首页延后弹出的提示之前恢复；
            // 交互式下滑被取消时浮层仍在，重新判断会走到下面的收起分支。
            let queued = coordinator.animate(alongsideTransition: nil) { _ in
                if root.presentedViewController == nil { retry() } else { DispatchQueue.main.async { retry() } }
            }
            if !queued { DispatchQueue.main.async { retry() } }
            return
        }
        presented.dismiss(animated: false, completion: retry)
    }

    private func presentForRestore(on root: UIViewController, services: AmbientServices,
                                   completionHandler: @escaping (Bool) -> Void) {
        AppWorkspaceCoordinator.shared.setPlayerPresented(true, from: root)
        root.present(self, animated: true) { [weak self] in
            self?.isRestoringInterface = false
            services.playbackVisibilityChanged()
            completionHandler(true)
        }
    }
}

extension AmbientPlaybackViewController: UIGestureRecognizerDelegate {
    /// 画面轻点只响应画面本身；返回、睡眠与声音按钮保持原有操作，文案上的轻点交给换句手势，都不会顺带切换控件显隐。
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touched = touch.view, touched.isDescendant(of: subtitleCaption) { return false }
        var current = touch.view
        while let view = current {
            if view is UIControl { return false }
            current = view.superview
        }
        return true
    }

    /// 与系统播放器视图可能存在的手势同时识别，避免轻点被播放器吞掉。
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

/// 全屏播放的文案控件：正文加可选出处，四周留出透明边距便于手指拿起拖动；位置按画面比例记录，旋转后保持相对位置。
private final class AmbientSubtitleCaption: UIView {
    /// 默认相对位置：画面正中，每次进入全屏都从这里开始。
    static let centerPosition = CGPoint(x: 0.5, y: 0.5)

    /// 正文与出处放在同一容器里，换句时只对容器做淡入淡出，不影响外层整体显隐的透明度。
    private let content = UIView()
    private let label: UILabel
    private let attributionLabel: UILabel
    private let padding: CGFloat = 14
    private let lineGap: CGFloat = 10
    private var quote: AmbientQuote

    init(quote: AmbientQuote, tint: UIColor) {
        self.quote = quote
        label = AmbientStyle.label(quote.text, size: 22)
        attributionLabel = AmbientStyle.label(quote.attribution ?? "", size: 14)
        super.init(frame: .zero)
        // 苹方细体放大字号并拉开字距，在画面上更轻盈舒展。
        label.font = UIFontMetrics.default.scaledFont(for: AmbientStyle.pingFang(size: 22, weight: .light), maximumPointSize: 32)
        label.textColor = tint.withAlphaComponent(0.92)
        label.textAlignment = .center
        // 出处用更小更淡的一行，退居正文之下。
        attributionLabel.font = UIFontMetrics.default.scaledFont(for: AmbientStyle.pingFang(size: 14, weight: .light), maximumPointSize: 20)
        attributionLabel.textColor = tint.withAlphaComponent(0.7)
        attributionLabel.textAlignment = .center
        for item in [label, attributionLabel] {
            // 离开顶部遮罩后亮色画面上也要看得清，用柔和的文字阴影代替底板。
            item.layer.shadowColor = UIColor.black.cgColor
            item.layer.shadowOpacity = 0.7
            item.layer.shadowRadius = 6
            item.layer.shadowOffset = .zero
            item.isAccessibilityElement = false
            content.addSubview(item)
        }
        content.isUserInteractionEnabled = false
        addSubview(content)
        isAccessibilityElement = true
        accessibilityHint = "轻点换一句，拖动可调整位置"
        render(quote)
    }

    required init?(coder: NSCoder) { nil }

    /// 替换文案；动画时先淡出旧内容，换好文字并让外层重新排版后再淡入。
    func update(_ quote: AmbientQuote, animated: Bool) {
        self.quote = quote
        let apply = {
            self.render(quote)
            self.superview?.setNeedsLayout()
            self.superview?.layoutIfNeeded()
        }
        guard animated, !UIAccessibility.isReduceMotionEnabled else {
            apply()
            return
        }
        UIView.animate(withDuration: 0.18, delay: 0, options: [.beginFromCurrentState, .curveEaseIn]) {
            self.content.alpha = 0
        } completion: { _ in
            apply()
            UIView.animate(withDuration: 0.32, delay: 0, options: [.beginFromCurrentState, .curveEaseOut]) {
                self.content.alpha = 1
            }
        }
    }

    /// 拉取期间略微变淡，作为轻点换句的即时反馈。
    func setLoading(_ loading: Bool) {
        UIView.animate(withDuration: UIAccessibility.isReduceMotionEnabled ? 0 : 0.15, delay: 0,
                       options: [.beginFromCurrentState, .allowUserInteraction]) {
            self.content.alpha = loading ? 0.55 : 1
        }
    }

    private func render(_ quote: AmbientQuote) {
        // 只在富文本里设置字距和行距，不带字体属性，字体仍由 label.font 提供以保留动态字体缩放。
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        paragraph.lineSpacing = 6
        label.attributedText = NSAttributedString(string: quote.text, attributes: [.kern: 2, .paragraphStyle: paragraph])
        attributionLabel.attributedText = NSAttributedString(string: quote.attribution ?? "", attributes: [.kern: 1, .paragraphStyle: paragraph])
        attributionLabel.isHidden = quote.attribution == nil
        accessibilityLabel = quote.attribution.map { "\(quote.text)，\($0)" } ?? quote.text
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width = max(0, size.width - padding * 2)
        let text = label.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
        var height = ceil(text.height)
        var contentWidth = ceil(text.width)
        if !attributionLabel.isHidden {
            let attribution = attributionLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
            height += lineGap + ceil(attribution.height)
            contentWidth = max(contentWidth, ceil(attribution.width))
        }
        return CGSize(width: contentWidth + padding * 2, height: height + padding * 2)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        content.frame = bounds.insetBy(dx: padding, dy: padding)
        let width = content.bounds.width
        let textHeight = ceil(label.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height)
        label.frame = CGRect(x: 0, y: 0, width: width, height: textHeight)
        guard !attributionLabel.isHidden else { return }
        let top = textHeight + lineGap
        attributionLabel.frame = CGRect(x: 0, y: top, width: width, height: max(0, content.bounds.height - top))
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // 字号变化后由播放页重新计算尺寸与位置。
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            superview?.setNeedsLayout()
        }
    }
}

/// 顶部轻遮罩随布局自动伸缩，末端透明，避免形成独立的工具栏底板。
private final class AmbientPlaybackShadeView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        isAccessibilityElement = false
        guard let gradient = layer as? CAGradientLayer else { return }
        gradient.colors = [UIColor.black.withAlphaComponent(0.46).cgColor,
                           UIColor.black.withAlphaComponent(0.26).cgColor,
                           UIColor.clear.cgColor]
        gradient.locations = [0, 0.55, 1]
    }

    required init?(coder: NSCoder) { nil }
}
