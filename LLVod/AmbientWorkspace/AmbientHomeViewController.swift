import Combine
// 音量条继承自系统 MPVolumeView；工程开启了成员导入可见性，创建它需要在使用处显式导入。
import MediaPlayer
import UIKit

/// 圆环与机械翻页共用计时状态，切换时持续播放当前自然场景。
final class AmbientHomeViewController: UIViewController {
    private enum DisplayStyle: CaseIterable {
        case ring, flip
    }

    private let services: AmbientServices
    private var subscriptions = Set<AnyCancellable>()
    private let backdrop = AmbientBackdropView()
    /// 空间微动只作用于首页背景；页面可见性与睡眠状态由本控制器告知，其余启停条件由其自行观察。
    private var spatialMotion: AmbientSpatialMotion { services.spatialMotion }
    private let shade = AmbientHomeShadeView()
    private let controls = UIStackView()
    private let focusRing = AmbientFocusRingView()
    private let clockStage = UIView()
    private let contentScroll = UIScrollView()
    private let flipClock = AmbientFlipClockView()
    private let flipGroup = UIStackView()
    private let flipStageLabel = AmbientStyle.label("专注时刻", size: 13)
    private let flipResetButton = UIButton(type: .system)
    private var displayStyle: DisplayStyle = .ring
    private var ringWidthConstraint: NSLayoutConstraint?
    private var isHomeVisible = false
    private let stageLabel = AmbientStyle.label("专注时刻", size: 13)
    private let timeLabel = AmbientStyle.label("25:00", size: 64, weight: .light)
    private let timerHint = AmbientStyle.label("", size: 12)
    private let sleepStatusLabel = AmbientStyle.label("", size: 12)
    private let goalButton = UIButton(type: .system)
    private let pendingHabitRow = UIStackView()
    private var displayedPromptID: UUID?
    private let retryButton = UIButton(type: .system)
    private let primaryButton = UIButton(type: .system)
    private let resetButton = UIButton(type: .system)
    private let playbackButton = UIButton(type: .system)
    private let soundButton = UIButton(type: .system)
    private let soundImages = AmbientStyle.soundImages(pointSize: 15)
    private let volumeSlider = AmbientVolumeSlider()
    private let soundRow = UIStackView()
    private var sceneButtons: [AmbientSceneThumbnail] = []
    private var displayedSceneIdentifier: String?
    private let cream = UIColor(red: 0.95, green: 0.93, blue: 0.88, alpha: 1)

    init(services: AmbientServices) {
        self.services = services
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "沉浸视界"
        navigationItem.backButtonTitle = "返回"
        view.backgroundColor = AmbientStyle.background
        overrideUserInterfaceStyle = .dark
        buildLayout()
        configureStyleSwitching()
        services.connectBackdrop(backdrop)
        spatialMotion.attach(to: backdrop)
        // 睡眠渐隐期间视差随声音一起缓慢归零，避免声音越来越轻、画面却仍随手抖移动。
        spatialMotion.intensitySource = { [weak self] in
            1 - (self?.services.sleepTimer.fadeProgress ?? 1)
        }
        bindState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isHomeVisible = true
        renderClock()
        services.setHomeVisible(true)
        volumeSlider.beginSynchronizing()
        spatialMotion.setPageVisible(true)
        AppWorkspaceCoordinator.shared.setPlayerPresented(false, from: self)
        services.playbackVisibilityChanged()
        showPendingNotice()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isHomeVisible = false
        focusRing.stopAnimation()
        flipClock.stopAnimation()
        services.setHomeVisible(false)
        volumeSlider.endSynchronizing()
        spatialMotion.setPageVisible(false)
        // 足迹页与反馈页使用原有导航栏；首页和全屏播放不占用导航栏空间。
        if navigationController?.topViewController !== self {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 渐变跟随实际控制区位置，大字号或短窗口滚动时仍保持文字对比度。
        shade.controlTop = controls.convert(controls.bounds, to: shade).minY
    }

    private func buildLayout() {
        for item in [backdrop, shade] {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                item.topAnchor.constraint(equalTo: view.topAnchor),
                item.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        let scroll = contentScroll
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.delegate = self
        view.addSubview(scroll)
        NSLayoutConstraint.activate([
            scroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        let content = UIStackView()
        content.axis = .vertical
        content.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(content)
        let width = content.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor, constant: -44)
        width.priority = .defaultHigh
        NSLayoutConstraint.activate([
            scroll.contentLayoutGuide.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
            content.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor, constant: 4),
            content.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -8),
            content.centerXAnchor.constraint(equalTo: scroll.frameLayoutGuide.centerXAnchor),
            content.heightAnchor.constraint(greaterThanOrEqualTo: scroll.frameLayoutGuide.heightAnchor, constant: -12),
            width, content.widthAnchor.constraint(lessThanOrEqualToConstant: 620)
        ])
        let upperSpace = makeBreathingSpace()
        content.addArrangedSubview(upperSpace)
        let focus = UIStackView()
        focus.axis = .vertical
        focus.alignment = .center
        focus.spacing = 16
        configureQuietButton(goalButton, title: "这一轮，想完成什么？", symbol: "pencil.line", size: 20)
        // 目标入口与开始专注按钮共用暖白色并加粗，左右各留 12 点热区，轻点文字边缘也落在按钮内。
        goalButton.configuration?.baseForegroundColor = cream
        goalButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        goalButton.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        // 字号与加粗在任何状态下都保持不变，禁用只通过颜色变淡表达，不再叠加整体透明度。
        goalButton.configurationUpdateHandler = { [cream] button in
            button.configuration?.baseForegroundColor = button.isEnabled ? cream : cream.withAlphaComponent(0.5)
            button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
                var result = attributes
                result.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 20, weight: .bold))
                return result
            }
        }
        goalButton.addAction(UIAction { [weak self] _ in
            guard let self, self.services.clock.canEditGoal else { return }
            AmbientPageUI.present(AmbientGoalViewController(services: self.services), from: self)
        }, for: .touchUpInside)
        focus.addArrangedSubview(goalButton)
        goalButton.widthAnchor.constraint(lessThanOrEqualTo: focus.widthAnchor).isActive = true
        // 目标入口、时钟、开始按钮之间同样使用弹性留白，与顶部及缩略图上方的留白等高，
        // 多余高度由所有主行平均分摊，不再全部堆在顶部和缩略图上方。
        let goalSpace = makeBreathingSpace()
        focus.addArrangedSubview(goalSpace)
        focus.setCustomSpacing(0, after: goalButton)
        focus.setCustomSpacing(0, after: goalSpace)
        focus.addArrangedSubview(makeClock())
        let clockSpace = makeBreathingSpace()
        focus.addArrangedSubview(clockSpace)
        focus.setCustomSpacing(0, after: clockStage)
        focus.setCustomSpacing(0, after: clockSpace)
        configurePrimaryButton()
        focus.addArrangedSubview(primaryButton)
        // 开始按钮与全屏播放之间留 16 点，避免两个按钮贴得太近。
        focus.setCustomSpacing(16, after: primaryButton)
        configureQuietButton(playbackButton, title: "全屏播放", symbol: "arrow.up.left.and.arrow.down.right", size: 12)
        playbackButton.addTarget(self, action: #selector(openPlayback), for: .touchUpInside)
        focus.addArrangedSubview(playbackButton)
        timerHint.textColor = cream.withAlphaComponent(0.75)
        timerHint.textAlignment = .center
        focus.addArrangedSubview(timerHint)
        sleepStatusLabel.textColor = cream.withAlphaComponent(0.8)
        sleepStatusLabel.textAlignment = .center
        focus.addArrangedSubview(sleepStatusLabel)
        pendingHabitRow.isHidden = true
        pendingHabitRow.axis = .vertical
        pendingHabitRow.alignment = .center
        pendingHabitRow.spacing = 6
        focus.addArrangedSubview(pendingHabitRow)
        pendingHabitRow.widthAnchor.constraint(equalTo: focus.widthAnchor).isActive = true
        configureQuietButton(retryButton, title: "", symbol: "arrow.clockwise", size: 12)
        retryButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            if self.services.isReady {
                Task {
                    do { try await self.services.clock.retryPersistence() }
                    catch { self.renderClock() }
                }
            } else { self.services.prepareProgress() }
        }, for: .touchUpInside)
        focus.addArrangedSubview(retryButton)
        content.addArrangedSubview(focus)
        updateRingWidth()
        NSLayoutConstraint.activate([
            clockStage.widthAnchor.constraint(equalTo: focus.widthAnchor),
            clockStage.heightAnchor.constraint(equalTo: focusRing.heightAnchor),
            focusRing.widthAnchor.constraint(lessThanOrEqualToConstant: 360),
            focusRing.heightAnchor.constraint(equalTo: focusRing.widthAnchor),
            primaryButton.widthAnchor.constraint(equalTo: focusRing.widthAnchor, multiplier: 0.90),
            timerHint.widthAnchor.constraint(equalTo: focus.widthAnchor),
            sleepStatusLabel.widthAnchor.constraint(equalTo: focus.widthAnchor),
            playbackButton.widthAnchor.constraint(lessThanOrEqualTo: focus.widthAnchor)
        ])
        let lowerSpace = makeBreathingSpace()
        content.addArrangedSubview(lowerSpace)
        // 目标入口之后、时钟之后、缩略图之前三处留白等高，顶部留白只取它们的一半，让目标入口更贴近顶部。
        for space in [goalSpace, clockSpace, lowerSpace] {
            space.heightAnchor.constraint(equalTo: upperSpace.heightAnchor, multiplier: 2).isActive = true
        }
        controls.axis = .vertical
        controls.alignment = .center
        // 滑杆内部已预留数值标签高度，外层仅保留八点间距，避免重复留白。
        controls.spacing = 8
        let scenes = makeSceneSelector()
        let sound = makeSoundControl()
        controls.addArrangedSubview(scenes)
        controls.addArrangedSubview(sound)
        for (item, maximumWidth) in [(scenes, CGFloat(410)), (sound, CGFloat(440))] {
            let width = item.widthAnchor.constraint(equalTo: controls.widthAnchor)
            width.priority = .defaultHigh
            NSLayoutConstraint.activate([width, item.widthAnchor.constraint(lessThanOrEqualToConstant: maximumWidth)])
        }
        content.addArrangedSubview(controls)
    }

    /// 弹性留白：最小 8 点，屏幕有富余时按比例约束拉伸；中间三处为顶部的两倍，因此中间最小 16 点。
    private func makeBreathingSpace() -> UIView {
        let space = UIView()
        // 宽度只给低优先级提示：在居中对齐的栈里消除歧义，在拉满对齐的栈里让位给栈自身的约束，避免冲突。
        let width = space.widthAnchor.constraint(equalToConstant: 1)
        width.priority = .defaultLow
        width.isActive = true
        space.heightAnchor.constraint(greaterThanOrEqualToConstant: 8).isActive = true
        let restingHeight = space.heightAnchor.constraint(equalToConstant: 8)
        restingHeight.priority = .fittingSizeLevel
        restingHeight.isActive = true
        return space
    }

    private func updateRingWidth() {
        guard let container = focusRing.superview else { return }
        ringWidthConstraint?.isActive = false
        // 辅助字号使用更大的圆环承托读数，所需高度由页面滚动提供。
        let ratio: CGFloat = traitCollection.preferredContentSizeCategory.isAccessibilityCategory ? 0.94 : 0.74
        let width = focusRing.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: ratio)
        width.priority = .defaultHigh
        width.isActive = true
        ringWidthConstraint = width
    }

    private func makeClock() -> UIView {
        timeLabel.font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(
            for: UIFont(descriptor: UIFont.systemFont(ofSize: 64, weight: .light).fontDescriptor.withDesign(.serif)
                        ?? UIFont.systemFont(ofSize: 64, weight: .light).fontDescriptor, size: 64), maximumPointSize: 82)
        timeLabel.textColor = cream
        timeLabel.numberOfLines = 1
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.minimumScaleFactor = 0.5
        timeLabel.accessibilityLabel = "剩余时间"
        timeLabel.textAlignment = .center
        stageLabel.textColor = cream.withAlphaComponent(0.85)
        stageLabel.textAlignment = .center
        stageLabel.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 13), maximumPointSize: 20)
        configureQuietButton(resetButton, title: "重置", symbol: "arrow.counterclockwise", size: 12)
        resetButton.addTarget(self, action: #selector(resetClock), for: .touchUpInside)
        resetButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        resetButton.setContentHuggingPriority(.required, for: .horizontal)
        let reading = UIStackView(arrangedSubviews: [stageLabel, timeLabel])
        reading.axis = .vertical
        reading.spacing = 10
        reading.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        focusRing.addSubview(reading)
        focusRing.addSubview(resetButton)
        let center = reading.centerYAnchor.constraint(equalTo: focusRing.centerYAnchor, constant: -8)
        center.priority = .defaultHigh
        NSLayoutConstraint.activate([
            reading.centerXAnchor.constraint(equalTo: focusRing.centerXAnchor),
            center,
            reading.widthAnchor.constraint(equalTo: focusRing.widthAnchor, multiplier: 0.76),
            reading.topAnchor.constraint(greaterThanOrEqualTo: focusRing.topAnchor, constant: 20),
            reading.bottomAnchor.constraint(lessThanOrEqualTo: resetButton.topAnchor, constant: -4),
            resetButton.centerXAnchor.constraint(equalTo: focusRing.centerXAnchor),
            resetButton.bottomAnchor.constraint(equalTo: focusRing.bottomAnchor, constant: -20),
            resetButton.widthAnchor.constraint(lessThanOrEqualTo: focusRing.widthAnchor, multiplier: 0.7)
        ])
        // 两套时钟共用固定展示区域，切换时下方按钮与场景选择器不重新排位。
        focusRing.translatesAutoresizingMaskIntoConstraints = false
        clockStage.addSubview(focusRing)
        flipGroup.axis = .vertical
        flipGroup.alignment = .center
        flipGroup.spacing = 10
        flipGroup.translatesAutoresizingMaskIntoConstraints = false
        flipStageLabel.font = stageLabel.font
        flipStageLabel.textColor = stageLabel.textColor
        flipStageLabel.textAlignment = .center
        configureQuietButton(flipResetButton, title: "重置", symbol: "arrow.counterclockwise", size: 12)
        flipResetButton.addTarget(self, action: #selector(resetClock), for: .touchUpInside)
        for item in [flipStageLabel, flipClock, flipResetButton] { flipGroup.addArrangedSubview(item) }
        clockStage.addSubview(flipGroup)
        let flipWidth = flipGroup.widthAnchor.constraint(equalTo: clockStage.widthAnchor, multiplier: 0.94)
        flipWidth.priority = .defaultHigh
        NSLayoutConstraint.activate([
            focusRing.centerXAnchor.constraint(equalTo: clockStage.centerXAnchor),
            focusRing.centerYAnchor.constraint(equalTo: clockStage.centerYAnchor),
            flipGroup.centerXAnchor.constraint(equalTo: clockStage.centerXAnchor),
            flipGroup.centerYAnchor.constraint(equalTo: clockStage.centerYAnchor),
            flipWidth, flipGroup.widthAnchor.constraint(lessThanOrEqualToConstant: 440),
            flipClock.widthAnchor.constraint(equalTo: flipGroup.widthAnchor),
            flipClock.heightAnchor.constraint(equalTo: flipClock.widthAnchor, multiplier: 0.36),
            flipStageLabel.widthAnchor.constraint(equalTo: flipGroup.widthAnchor),
            flipResetButton.widthAnchor.constraint(lessThanOrEqualTo: flipGroup.widthAnchor)
        ])
        flipGroup.isHidden = true
        return clockStage
    }

    private func configureStyleSwitching() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(cycleDisplayStyle))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        // 旁白用户可从两套时间读数执行同一切换操作。
        for target in [timeLabel, flipClock] as [UIView] {
            target.accessibilityCustomActions = [
                UIAccessibilityCustomAction(name: "切换显示风格", target: self,
                                            selector: #selector(switchAccessibleStyle))
            ]
        }
    }

    @objc private func switchAccessibleStyle() -> Bool {
        guard isHomeVisible, presentedViewController == nil else { return false }
        cycleDisplayStyle()
        return true
    }

    @objc private func cycleDisplayStyle() {
        guard isHomeVisible, presentedViewController == nil else { return }
        let styles = DisplayStyle.allCases
        let index = styles.firstIndex(of: displayStyle) ?? 0
        displayStyle = styles[(index + 1) % styles.count]
        focusRing.stopAnimation()
        flipClock.stopAnimation()
        focusRing.isHidden = displayStyle != .ring
        flipGroup.isHidden = displayStyle != .flip
        renderClock()
        if UIAccessibility.isVoiceOverRunning {
            UIAccessibility.post(notification: .screenChanged,
                                 argument: displayStyle == .flip ? flipClock : timeLabel)
        }
    }

    private func configurePrimaryButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "开始专注"
        configuration.baseForegroundColor = cream
        configuration.image = UIImage(systemName: "play.fill")
        configuration.imagePadding = 10
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 14, weight: .medium)
        configuration.cornerStyle = .capsule
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 20, bottom: 13, trailing: 20)
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var result = attributes
            result.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: .systemFont(ofSize: 17, weight: .medium))
            return result
        }
        primaryButton.configuration = configuration
        // 透明玻璃底由按钮配置承载，胶囊圆角随按钮实际高度调整。
        primaryButton.configurationUpdateHandler = { [cream] button in
            guard var configuration = button.configuration else { return }
            let usesOpaqueBackground = UIAccessibility.isReduceTransparencyEnabled
            var background = UIBackgroundConfiguration.clear()
            // 白色细边搭配轻薄底色，明确按钮区域，同时保留透出的场景细节。
            background.visualEffect = nil
            background.backgroundColor = usesOpaqueBackground
                ? UIColor(white: button.isHighlighted ? 0.28 : 0.20, alpha: 1)
                : UIColor.white.withAlphaComponent(button.isHighlighted ? 0.16 : 0.10)
            background.strokeColor = UIColor.white.withAlphaComponent(button.isHighlighted ? 0.85 : 0.65)
            background.strokeWidth = 1
            configuration.background = background
            configuration.baseForegroundColor = cream
            button.configuration = configuration
        }
        primaryButton.titleLabel?.adjustsFontForContentSizeCategory = true
        primaryButton.titleLabel?.numberOfLines = 0
        primaryButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        primaryButton.addTarget(self, action: #selector(changeClock), for: .touchUpInside)
    }

    private func makeSceneSelector() -> UIView {
        sceneButtons = AmbientScene.collection.map { scene in
            let button = AmbientSceneThumbnail(scene: scene, tint: cream)
            button.addAction(UIAction { [weak self] _ in
                guard let self, self.services.isReady else { return }
                if self.services.progress.unlocks.contains(scene.identifier) {
                    self.services.select(scene)
                    self.renderMedia()
                } else {
                    AmbientPageUI.present(AmbientSceneDetailViewController(scene: scene, services: self.services), from: self)
                }
            }, for: .touchUpInside)
            return button
        }
        return AmbientSceneSelectorView(buttons: sceneButtons)
    }

    private func makeSoundControl() -> UIView {
        configureQuietButton(soundButton, title: "环境音", symbol: "speaker.slash", size: 13)
        soundButton.configuration?.image = soundImages.disabled
        soundButton.contentHorizontalAlignment = .leading
        soundButton.accessibilityHint = "轻点开启或关闭当前场景的环境音"
        soundButton.addTarget(self, action: #selector(changeSound), for: .touchUpInside)
        soundButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        soundRow.addArrangedSubview(soundButton)
        soundRow.addArrangedSubview(volumeSlider)
        let mix = UIButton(type: .system)
        mix.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        mix.tintColor = cream
        mix.accessibilityLabel = "自然声混音"
        mix.widthAnchor.constraint(equalToConstant: 44).isActive = true
        mix.heightAnchor.constraint(equalToConstant: 44).isActive = true
        mix.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            AmbientPageUI.present(AmbientMixerViewController(services: self.services), from: self)
        }, for: .touchUpInside)
        soundRow.addArrangedSubview(mix)
        soundRow.spacing = 14
        // 辅助字号下音量单独占一行，避免将滑杆压缩成不可操作的长度。
        updateSoundRowLayout()
        return soundRow
    }

    private func updateSoundRowLayout() {
        let usesSeparateRow = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        soundRow.axis = usesSeparateRow ? .vertical : .horizontal
        // 普通字号把环境音入口与下方滑轨对齐，上方空间留给随动标签。
        soundRow.alignment = usesSeparateRow ? .fill : .bottom
    }

    private func configureQuietButton(_ button: UIButton, title: String, symbol: String, size: CGFloat) {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.image = UIImage(systemName: symbol)
        configuration.imagePadding = 8
        configuration.baseForegroundColor = cream.withAlphaComponent(0.85)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: size + 2, weight: .light)
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var result = attributes
            result.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: size))
            return result
        }
        button.configuration = configuration
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateSoundRowLayout()
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            updateRingWidth()
        }
    }

    private func bindState() {
        // 辅助功能设置改变后立即恢复可读底色，同时保留当前计时文案和图标。
        NotificationCenter.default.publisher(for: UIAccessibility.reduceTransparencyStatusDidChangeNotification)
            .receive(on: RunLoop.main).sink { [weak self] _ in
                self?.primaryButton.setNeedsUpdateConfiguration()
            }.store(in: &subscriptions)
        services.clock.objectWillChange.receive(on: RunLoop.main).sink { [weak self] in
            self?.renderClock()
        }.store(in: &subscriptions)
        services.sleepTimer.objectWillChange.receive(on: RunLoop.main).sink { [weak self] in
            self?.renderSleep()
        }.store(in: &subscriptions)
        services.objectWillChange.receive(on: RunLoop.main).sink { [weak self] in
            self?.renderMedia()
        }.store(in: &subscriptions)
        NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification).sink { [weak self] _ in
            self?.focusRing.stopAnimation()
            self?.flipClock.stopAnimation()
        }.store(in: &subscriptions)
        for name in [UIApplication.didBecomeActiveNotification, UIAccessibility.reduceMotionStatusDidChangeNotification] {
            NotificationCenter.default.publisher(for: name).receive(on: RunLoop.main).sink { [weak self] _ in
                self?.flipClock.stopAnimation()
                self?.renderClock()
            }.store(in: &subscriptions)
        }
        renderClock()
        renderMedia()
    }

    private func renderClock() {
        let clock = services.clock
        goalButton.configuration?.title = clock.goal.isEmpty ? "这一轮，想完成什么？" : clock.goal
        goalButton.isEnabled = clock.canEditGoal && services.isReady
        // 未关联习惯时不能开启新一轮，倒计时时长只能来自习惯设置。
        let blocked = services.isFocusStartBlocked
        primaryButton.isEnabled = services.isReady && clock.storageMessage == nil && !blocked
        retryButton.isHidden = services.loadError == nil && clock.storageMessage == nil
        retryButton.configuration?.title = services.loadError ?? clock.storageMessage
        timeLabel.text = clock.display
        timeLabel.accessibilityValue = clock.display
        focusRing.update(remaining: clock.remaining, duration: clock.duration,
                         isRunning: displayStyle == .ring && clock.state == .running && isHomeVisible &&
                            !services.sleepTimer.isSleeping)
        if displayStyle == .flip {
            flipClock.update(remaining: clock.remaining,
                             animated: clock.state == .running && isHomeVisible && !services.sleepTimer.isSleeping)
        }
        stageLabel.text = clock.stage == .focus ? "专注时刻" : "片刻休息"
        flipStageLabel.text = stageLabel.text
        resetButton.isHidden = clock.state == .ready
        // 用透明度保留重置入口占位，开始或暂停时翻页钟不会上下跳动。
        flipResetButton.alpha = clock.state == .ready ? 0 : 1
        flipResetButton.isUserInteractionEnabled = clock.state != .ready
        flipResetButton.accessibilityElementsHidden = clock.state == .ready
        timerHint.isHidden = clock.state == .running || (clock.state == .ready && !blocked)
        // 图标表达下一步操作，暂停后恢复为播放符号，与按钮文案保持一致。
        primaryButton.configuration?.image = UIImage(systemName: clock.state == .running ? "pause.fill" : "play.fill")
        switch clock.state {
        case .ready:
            primaryButton.configuration?.title = clock.stage == .focus ? "开始专注" : "开始休息"
            if blocked { timerHint.text = "先在上方目标里关联一个习惯，再开始专注。" }
        case .running:
            primaryButton.configuration?.title = "暂停专注"
            if clock.stage == .rest { primaryButton.configuration?.title = "暂停休息" }
        case .paused:
            primaryButton.configuration?.title = "继续"
            // 被睡眠定时关停时写明原因，第二天打开也知道专注为何停下；手动暂停仍显示普通提示。
            timerHint.text = clock.isPausedBySleep ? "已随定时关停暂停，准备好时再继续。" : "已暂停，准备好时再继续。"
        case .completed:
            primaryButton.configuration?.title = clock.stage == .focus ? "休息五分钟" : "开始新一轮"
            timerHint.text = clock.stage == .focus ? "本轮专注已完成，给自己一点休息。" : "休息已完成，可以开始新的专注。"
            if blocked { timerHint.text = "休息已完成，先在上方目标里关联一个习惯，再开始新一轮。" }
        }
        // 未关联习惯的阻断提示用红色突出，其余状态提示沿用暖白色。
        timerHint.textColor = blocked ? UIColor(red: 0.96, green: 0.42, blue: 0.40, alpha: 1) : cream.withAlphaComponent(0.75)
        primaryButton.accessibilityHint = clock.stage == .focus ? "本轮专注 \(Int(clock.duration / 60)) 分钟" : "本轮休息五分钟"
        renderSleep()
    }

    private func renderSleep() {
        let timer = services.sleepTimer
        sleepStatusLabel.isHidden = timer.preset == nil && !timer.isSleeping
        sleepStatusLabel.text = timer.isSleeping ? "已休眠，播放已停止" : timer.status
        // 睡眠到期停止运动采样，唤醒后重新以当下持姿取基准。
        spatialMotion.isSleeping = timer.isSleeping
    }

    private func renderMedia() {
        let scene = services.selectedScene
        if displayedSceneIdentifier != scene.identifier {
            displayedSceneIdentifier = scene.identifier
            for button in sceneButtons { button.isSelected = button.scene.identifier == scene.identifier }
        }
        // 文案保持固定，仅切换等尺寸图标，避免挤动右侧音量控件。
        soundButton.configuration?.image = services.isSoundEnabled ? soundImages.enabled : soundImages.disabled
        soundButton.accessibilityValue = services.isSoundEnabled ? "已开启" : "已关闭"
        playbackButton.configuration?.title = services.playback == nil ? "全屏播放" : "返回播放"
        playbackButton.accessibilityHint = "播放当前场景：" + scene.title
        for button in sceneButtons { button.isLocked = !services.progress.unlocks.contains(button.scene.identifier) }
        renderHabitPrompt()
        renderClock()
        showPendingNotice()
    }

    /// 关联确认不使用阻塞弹窗，休息计时始终继续。
    private func renderHabitPrompt() {
        let oldest = AmbientDayKey.key(AmbientDayKey.calendar.date(byAdding: .day, value: -6, to: Date()) ?? Date())
        // 同一习惯当天已经打卡（例如在习惯页勾选）时不再追问，也兼容升级前已保存的旧提示。
        let prompt = services.progress.prompts.first { prompt in
            prompt.day >= oldest && services.progress.habits.contains { $0.id == prompt.habitID && $0.archivedDay == nil }
                && services.progress.entries[prompt.habitID.uuidString]?.contains(prompt.day) != true
        }
        guard displayedPromptID != prompt?.id else { return }
        displayedPromptID = prompt?.id
        pendingHabitRow.arrangedSubviews.forEach { $0.removeFromSuperview() }
        pendingHabitRow.isHidden = prompt == nil
        guard let prompt else { return }
        let label = AmbientStyle.label("已完成“\(prompt.title)”吗？", size: 13)
        label.textColor = cream
        label.textAlignment = .center
        pendingHabitRow.addArrangedSubview(label)
        let confirm = AmbientPageUI.button("已完成") { [weak self] in self?.resolvePrompt(prompt, completed: true) }
        let skip = AmbientPageUI.button("暂不打卡") { [weak self] in self?.resolvePrompt(prompt, completed: false) }
        let row = UIStackView(arrangedSubviews: [confirm, skip])
        row.spacing = 12
        pendingHabitRow.addArrangedSubview(row)
    }

    private func resolvePrompt(_ prompt: AmbientHabitPrompt, completed: Bool) {
        pendingHabitRow.isUserInteractionEnabled = false
        Task { [weak self] in
            guard let self else { return }
            defer { self.pendingHabitRow.isUserInteractionEnabled = true }
            do {
                if completed { try await AmbientProgressStore.shared.setHabitCompletion(prompt.habitID, day: prompt.day, completed: true) }
                try await AmbientProgressStore.shared.dismissPrompt(prompt.id)
                await self.services.refreshProgressNow()
            } catch { AmbientStyle.message(on: self, title: "暂时无法保存", text: error.localizedDescription) }
        }
    }

    private func showPendingNotice() {
        guard viewIfLoaded?.window != nil, presentedViewController == nil,
              navigationController?.topViewController === self, let notice = services.notice else { return }
        services.clearNotice()
        AmbientStyle.message(on: self, title: "温馨提示", text: notice)
    }

    @objc private func changeClock() { services.performFocusAction(); renderClock() }
    @objc private func resetClock() {
        services.clock.reset()
        renderClock()
    }
    @objc private func changeSound() { services.setSoundEnabled(!services.isSoundEnabled); renderMedia() }
    @objc private func openPlayback() { services.open(services.selectedScene, from: self) }

}

extension AmbientHomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        shade.controlTop = controls.convert(controls.bounds, to: shade).minY
    }
}

extension AmbientHomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard isHomeVisible, presentedViewController == nil,
              navigationController?.topViewController === self else { return false }
        // 目标入口按区域排除：一轮进行中它处于禁用态，触摸不再被按钮消费，若不排除会落到这里误切换时钟。
        if goalButton.bounds.contains(touch.location(in: goalButton)) { return false }
        // 排除控件及其内部图标、标签；场景选择、滑杆拖动和睡眠菜单不会误切换。
        var target = touch.view
        while let current = target {
            if current is UIControl { return false }
            target = current.superview
        }
        return true
    }
}

/// 轻遮罩保障圆环和数字对比度，底部渐变只承托场景与音量控制。
private final class AmbientHomeShadeView: UIView {
    private let upper = CAGradientLayer()
    private let lower = CAGradientLayer()
    var controlTop: CGFloat = 0 { didSet { setNeedsLayout() } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        backgroundColor = UIColor.black.withAlphaComponent(0.24)
        upper.colors = [UIColor.black.withAlphaComponent(0.22).cgColor, UIColor.black.withAlphaComponent(0.06).cgColor,
                        UIColor.clear.cgColor]
        upper.locations = [0, 0.65, 1]
        lower.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.4).cgColor,
                        UIColor(white: 0.04, alpha: 0.7).cgColor, UIColor(white: 0.04, alpha: 0.84).cgColor]
        lower.locations = [0, 0.36, 0.72, 1]
        layer.addSublayer(upper)
        layer.addSublayer(lower)
    }

    required init?(coder: NSCoder) { nil }

    override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        upper.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height * 0.55)
        let start = max(0, min(controlTop - 100, bounds.height * 0.78))
        lower.frame = CGRect(x: 0, y: start, width: bounds.width, height: bounds.height - start)
        CATransaction.commit()
    }
}

/// 固定展示全部场景，不持有滚动手势；窄窗口换行，保留每个场景的可点击宽度。
private final class AmbientSceneSelectorView: UIView {
    private let buttons: [AmbientSceneThumbnail]
    private let rows = UIStackView()
    private var columns = 0

    init(buttons: [AmbientSceneThumbnail]) {
        self.buttons = buttons
        super.init(frame: .zero)
        rows.axis = .vertical
        rows.alignment = .center
        rows.spacing = 12
        rows.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rows)
        NSLayoutConstraint.activate([
            rows.leadingAnchor.constraint(equalTo: leadingAnchor),
            rows.trailingAnchor.constraint(equalTo: trailingAnchor),
            rows.topAnchor.constraint(equalTo: topAnchor),
            rows.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        arrange(columns: 6)
    }

    required init?(coder: NSCoder) { nil }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard bounds.width > 0 else { return }
        // 六列至少需要三百一十四点；宽度不足时采用完整行，不隐藏末尾场景。
        // 候选列数与所需宽度显式标注类型，避免整数字面量与 CGFloat 重载组合导致编译器类型检查超时。
        let candidates: [Int] = [6, 3, 2, 1]
        let available = bounds.width
        let count = candidates.first { (candidate: Int) -> Bool in
            let required = CGFloat(candidate * 44 + (candidate - 1) * 10)
            return required <= available
        } ?? 1
        if columns != count { arrange(columns: count) }
    }

    private func arrange(columns count: Int) {
        columns = count
        // 先移除旧行中的按钮，再建立新层级，避免遗留跨行约束。
        buttons.forEach { $0.removeFromSuperview() }
        rows.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for start in stride(from: 0, to: buttons.count, by: count) {
            let row = UIStackView()
            row.spacing = 10
            row.distribution = .fillEqually
            row.alignment = .fill
            for index in start..<min(start + count, buttons.count) {
                row.addArrangedSubview(buttons[index])
            }
            rows.addArrangedSubview(row)
            let width = row.widthAnchor.constraint(equalTo: rows.widthAnchor)
            width.priority = .defaultHigh
            NSLayoutConstraint.activate([
                width,
                row.widthAnchor.constraint(lessThanOrEqualToConstant: CGFloat(count * 60 + (count - 1) * 10))
            ])
        }
    }
}

/// 圆形缩略图只加载封面，细描边与辅助功能状态共同标明当前场景。
private final class AmbientSceneThumbnail: UIControl {
    let scene: AmbientScene
    private let preview: AmbientScenePreviewView
    private let titleLabel: UILabel
    private let lockMark = UIImageView(image: UIImage(systemName: "lock.fill"))
    var isLocked = false {
        didSet {
            lockMark.isHidden = !isLocked
            accessibilityHint = isLocked ? "查看场景与兑换价格" : "切换场景"
            accessibilityValue = isLocked ? "未解锁" : "已解锁"
        }
    }

    init(scene: AmbientScene, tint: UIColor) {
        self.scene = scene
        preview = AmbientScenePreviewView(scene: scene, tint: tint)
        titleLabel = AmbientStyle.label(scene.title, size: 12)
        super.init(frame: .zero)
        isAccessibilityElement = true
        accessibilityLabel = scene.title
        accessibilityHint = "切换首页场景与环境音素材"
        titleLabel.textAlignment = .center
        titleLabel.textColor = tint
        let stack = UIStackView(arrangedSubviews: [preview, titleLabel])
        stack.axis = .vertical
        stack.spacing = 7
        stack.alignment = .center
        stack.isUserInteractionEnabled = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            preview.widthAnchor.constraint(equalTo: widthAnchor),
            preview.heightAnchor.constraint(equalTo: preview.widthAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        lockMark.translatesAutoresizingMaskIntoConstraints = false
        lockMark.tintColor = tint
        lockMark.backgroundColor = UIColor.black.withAlphaComponent(0.55)
        lockMark.layer.cornerRadius = 9
        lockMark.clipsToBounds = true
        lockMark.contentMode = .center
        lockMark.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 10, weight: .light)
        lockMark.isUserInteractionEnabled = false
        addSubview(lockMark)
        NSLayoutConstraint.activate([lockMark.trailingAnchor.constraint(equalTo: preview.trailingAnchor), lockMark.bottomAnchor.constraint(equalTo: preview.bottomAnchor), lockMark.widthAnchor.constraint(equalToConstant: 20), lockMark.heightAnchor.constraint(equalToConstant: 20)])
        updateSelection()
    }

    required init?(coder: NSCoder) { nil }
    override var isSelected: Bool { didSet { updateSelection() } }
    override var isHighlighted: Bool { didSet { alpha = isHighlighted ? 0.65 : 1 } }

    private func updateSelection() {
        preview.setSelected(isSelected)
        titleLabel.alpha = isSelected ? 1 : 0.7
        accessibilityTraits = isSelected ? [.button, .selected] : [.button]
    }
}

/// 由封面视图自身的实际尺寸驱动圆形裁剪，避免读取尚未完成布局的后代视图尺寸。
private final class AmbientScenePreviewView: UIView {
    private let imageView = UIImageView()

    init(scene: AmbientScene, tint: UIColor) {
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        clipsToBounds = true
        layer.cornerCurve = .circular
        layer.borderColor = tint.cgColor
        imageView.image = scene.resource("jpg").flatMap { UIImage(contentsOfFile: $0.path) }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerCurve = .circular
        addSubview(imageView)
    }

    required init?(coder: NSCoder) { nil }

    override func layoutSubviews() {
        super.layoutSubviews()
        let diameter = min(bounds.width, bounds.height)
        let imageDiameter = max(0, diameter - 8)
        // 先设置图片尺寸，再同步更新内外圆角，首次显示和宽度变化都使用同一套几何值。
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        layer.cornerRadius = diameter / 2
        imageView.frame = CGRect(x: bounds.midX - imageDiameter / 2, y: bounds.midY - imageDiameter / 2,
                                 width: imageDiameter, height: imageDiameter)
        imageView.layer.cornerRadius = imageDiameter / 2
        CATransaction.commit()
    }

    func setSelected(_ selected: Bool) {
        layer.borderWidth = selected ? 1.5 : 0
        imageView.alpha = selected ? 1 : 0.72
    }
}
