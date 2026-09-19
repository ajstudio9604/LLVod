import Combine
import UIKit

/// 四个独立导航栈共享服务；底部浮层不参与页面高度变化。
final class AmbientWorkspaceViewController: UIViewController {
    private let services: AmbientServices
    private var pages: [Int: AmbientNavigationController] = [:]
    private var selected = 0
    private var active: AmbientNavigationController?
    private let secondaryBackdrop = AmbientSecondaryBackdropView()
    private let bar = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    private var buttons: [UIButton] = []
    private var subscriptions = Set<AnyCancellable>()

    init(services: AmbientServices) {
        self.services = services
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    override var childForStatusBarStyle: UIViewController? { active }
    override var childForStatusBarHidden: UIViewController? { active }
    override var childForHomeIndicatorAutoHidden: UIViewController? { active }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
    override var shouldAutomaticallyForwardAppearanceMethods: Bool { false }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AmbientStyle.background
        // 次级页共用一个静态画布；只有沉浸页保留原有视频播放器。
        secondaryBackdrop.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondaryBackdrop)
        NSLayoutConstraint.activate([
            secondaryBackdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondaryBackdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondaryBackdrop.topAnchor.constraint(equalTo: view.topAnchor),
            secondaryBackdrop.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        buildBar()
        applyAppearance()
        selectPage(0)
        services.$selectedScene.receive(on: RunLoop.main).sink { [weak self] scene in
            guard let self, self.selected != 0 else { return }
            self.secondaryBackdrop.display(scene)
        }.store(in: &subscriptions)
        services.$isMaintainingData.receive(on: RunLoop.main).sink { [weak self] busy in
            self?.active?.view.isUserInteractionEnabled = !busy
            self?.bar.isUserInteractionEnabled = !busy
        }.store(in: &subscriptions)
        for name in [AmbientPreferences.didChange, UIAccessibility.reduceTransparencyStatusDidChangeNotification,
                     UIAccessibility.voiceOverStatusDidChangeNotification, UIAccessibility.reduceMotionStatusDidChangeNotification] {
            NotificationCenter.default.publisher(for: name).receive(on: RunLoop.main).sink { [weak self] _ in
                self?.applyAppearance()
            }.store(in: &subscriptions)
        }
    }

    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated); active?.beginAppearanceTransition(true, animated: animated) }
    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated); active?.endAppearanceTransition() }
    override func viewWillDisappear(_ animated: Bool) { super.viewWillDisappear(animated); active?.beginAppearanceTransition(false, animated: animated) }
    override func viewDidDisappear(_ animated: Bool) { super.viewDidDisappear(animated); active?.endAppearanceTransition() }

    private func page(_ index: Int) -> AmbientNavigationController {
        if let page = pages[index] { return page }
        let root: UIViewController
        switch index {
        case 1: root = AmbientHabitsViewController(services: services)
        case 2: root = AmbientAchievementsViewController(services: services)
        case 3: root = AmbientSpaceViewController(services: services)
        default: root = AmbientHomeViewController(services: services)
        }
        let nav = AmbientNavigationController(rootViewController: root)
        nav.additionalSafeAreaInsets.bottom = 76
        if index != 0 { nav.view.backgroundColor = .clear }
        pages[index] = nav
        return nav
    }

    /// 子页面切回沉浸页的入口，例如从习惯页为某个习惯开始专注。
    func showFocusPage() { selectPage(0) }

    private func selectPage(_ index: Int) {
        guard !services.isMaintainingData else { return }
        guard index != selected || active == nil else { return }
        let next = page(index)
        secondaryBackdrop.isHidden = index == 0
        if index != 0 {
            // 三个根页分别采用 H1、F3、S1，背景模式独立于各自的业务状态。
            switch index {
            case 1, 3: secondaryBackdrop.appearance = .scenic
            default: secondaryBackdrop.appearance = .editorial
            }
            secondaryBackdrop.display(services.selectedScene)
        }
        let previous = active
        let visible = view.window != nil
        if visible { previous?.beginAppearanceTransition(false, animated: false) }
        previous?.willMove(toParent: nil)
        previous?.view.removeFromSuperview()
        previous?.removeFromParent()
        if visible { previous?.endAppearanceTransition() }
        addChild(next)
        next.view.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(next.view, belowSubview: bar)
        NSLayoutConstraint.activate([
            next.view.leadingAnchor.constraint(equalTo: view.leadingAnchor), next.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            next.view.topAnchor.constraint(equalTo: view.topAnchor), next.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        if visible { next.beginAppearanceTransition(true, animated: false) }
        next.didMove(toParent: self)
        if visible { next.endAppearanceTransition() }
        selected = index
        active = next
        for (offset, button) in buttons.enumerated() {
            button.isSelected = offset == index
            button.accessibilityTraits = offset == index ? [.button, .selected] : [.button]
            button.setNeedsUpdateConfiguration()
        }
        applyAppearance()
        setNeedsStatusBarAppearanceUpdate()
        services.flushRecords()
    }

    private func buildBar() {
        // 底栏常驻；全屏播放器通过完整模态页面覆盖底栏，返回后自动恢复。
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.layer.cornerRadius = 30
        bar.clipsToBounds = true
        bar.layer.borderWidth = 0.5
        view.addSubview(bar)
        let row = UIStackView()
        row.distribution = .fillEqually
        row.translatesAutoresizingMaskIntoConstraints = false
        bar.contentView.addSubview(row)
        // 足迹使用系统数据图表符号，水滴符号仅用于余额与奖励。
        let items = [("沉浸", "leaf"), ("习惯", "checkmark.circle"), ("足迹", "chart.bar.xaxis"), ("空间", "slider.horizontal.3")]
        for (index, item) in items.enumerated() {
            let button = UIButton(type: .custom)
            var configuration = UIButton.Configuration.plain()
            configuration.title = item.0
            configuration.image = UIImage(systemName: item.1)
            configuration.imagePlacement = .top
            configuration.imagePadding = 3
            configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 19, weight: .light)
            configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { source in
                var attributes = source
                attributes.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 10), maximumPointSize: 13)
                return attributes
            }
            button.configuration = configuration
            // 选中状态只用细线和字重强调，完整控制配置以免系统自动添加底色。
            let marker = UIView()
            marker.translatesAutoresizingMaskIntoConstraints = false
            marker.backgroundColor = AmbientStyle.text
            marker.layer.cornerRadius = 1
            marker.isUserInteractionEnabled = false
            marker.isAccessibilityElement = false
            button.addSubview(marker)
            NSLayoutConstraint.activate([
                marker.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                marker.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -3),
                marker.widthAnchor.constraint(equalToConstant: 14),
                marker.heightAnchor.constraint(equalToConstant: 2)
            ])
            button.configurationUpdateHandler = { [weak marker] button in
                guard var configuration = button.configuration else { return }
                let color = button.isSelected ? AmbientStyle.text : AmbientStyle.pageSecondary
                let weight: UIFont.Weight = button.isSelected ? .medium : .regular
                configuration.background = UIBackgroundConfiguration.clear()
                configuration.background.backgroundColorTransformer = UIConfigurationColorTransformer { _ in .clear }
                configuration.baseForegroundColor = color
                configuration.imageColorTransformer = UIConfigurationColorTransformer { _ in color }
                configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { source in
                    var attributes = source
                    attributes.foregroundColor = color
                    attributes.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 10, weight: weight), maximumPointSize: 13)
                    return attributes
                }
                configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 19, weight: button.isSelected ? .regular : .light)
                button.configuration = configuration
                button.alpha = button.isHighlighted ? 0.65 : 1
                marker?.alpha = button.isSelected ? 1 : 0
            }
            button.setNeedsUpdateConfiguration()
            button.addAction(UIAction { [weak self] _ in self?.selectPage(index) }, for: .touchUpInside)
            row.addArrangedSubview(button)
            buttons.append(button)
        }
        let width = bar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -32)
        width.priority = .defaultHigh
        NSLayoutConstraint.activate([
            bar.centerXAnchor.constraint(equalTo: view.centerXAnchor), bar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            bar.heightAnchor.constraint(equalToConstant: 60), width, bar.widthAnchor.constraint(lessThanOrEqualToConstant: 420),
            row.leadingAnchor.constraint(equalTo: bar.contentView.leadingAnchor, constant: 8), row.trailingAnchor.constraint(equalTo: bar.contentView.trailingAnchor, constant: -8),
            row.topAnchor.constraint(equalTo: bar.contentView.topAnchor, constant: 2), row.bottomAnchor.constraint(equalTo: bar.contentView.bottomAnchor, constant: -2)
        ])
    }

    private func applyAppearance() {
        overrideUserInterfaceStyle = AmbientPreferences.shared.values.theme.style
        // 视频页的深色遮罩只作用于页面，底栏始终继承空间选择的主题。
        bar.overrideUserInterfaceStyle = .unspecified
        bar.effect = UIAccessibility.isReduceTransparencyEnabled ? nil : UIBlurEffect(style: .systemMaterial)
        bar.backgroundColor = .clear
        bar.contentView.backgroundColor = UIAccessibility.isReduceTransparencyEnabled ? AmbientStyle.pageBackground : AmbientStyle.pageBackground.withAlphaComponent(0.5)
        updateBarColors()
        setNeedsStatusBarAppearanceUpdate()
    }

    /// 图层颜色不会自动解析动态色，跟随系统切换时需同步刷新边框。
    private func updateBarColors() {
        bar.layer.borderColor = AmbientStyle.text.withAlphaComponent(0.12).resolvedColor(with: bar.traitCollection).cgColor
        buttons.forEach { $0.setNeedsUpdateConfiguration() }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard isViewLoaded, traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        updateBarColors()
    }
}
