import Combine
import UIKit

/// 足迹和图鉴共享水滴摘要；原有统计页面继续负责自己的列表与聚合。
final class AmbientAchievementsViewController: UIViewController {
    private let services: AmbientServices
    /// 内容标题右侧的水滴余额，图表图标与水滴数量各自保持明确的含义。
    private let balanceLabel = UILabel()
    private let balanceView = UIStackView()
    private let segment = UISegmentedControl(items: ["足迹", "图鉴"])
    private let host = UIView()
    private var active: UIViewController?
    private var pages: [Int: UIViewController] = [:]
    private var subscriptions = Set<AnyCancellable>()
    init(services: AmbientServices) { self.services = services; super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { nil }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "足迹与成就"
        view.backgroundColor = .clear
        AmbientStyle.styleSegment(segment)
        segment.selectedSegmentIndex = 0
        segment.addAction(UIAction { [weak self] _ in self?.selectPage() }, for: .valueChanged)
        let heading = AmbientStyle.label("足迹与成就", size: 27, weight: .medium)
        heading.accessibilityTraits = .header
        let balance = configureBalance()
        balance.setContentCompressionResistancePriority(.required, for: .horizontal)
        balance.setContentHuggingPriority(.required, for: .horizontal)
        let titleRow = UIStackView(arrangedSubviews: [heading, balance])
        titleRow.alignment = .center
        titleRow.spacing = 16
        let header = UIStackView(arrangedSubviews: [titleRow, segment])
        header.axis = .vertical
        header.spacing = 22
        header.translatesAutoresizingMaskIntoConstraints = false
        host.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        view.addSubview(host)
        let width = header.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -40)
        width.priority = .defaultHigh
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 34),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor), width,
            header.widthAnchor.constraint(lessThanOrEqualToConstant: 620),
            host.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 12), host.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            host.trailingAnchor.constraint(equalTo: view.trailingAnchor), host.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        services.$progress.receive(on: RunLoop.main).sink { [weak self] payload in
            self?.balanceLabel.text = "\(payload.balance)"
            self?.balanceView.accessibilityValue = "\(payload.balance) 滴"
        }.store(in: &subscriptions)
        selectPage()
    }
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated); navigationController?.setNavigationBarHidden(true, animated: false); services.flushRecords() }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            AmbientStyle.styleSegment(segment)
        }
    }

    private func configureBalance() -> UIView {
        let icon = UIImageView(image: UIImage(systemName: "drop.fill"))
        icon.tintColor = AmbientStyle.text
        icon.preferredSymbolConfiguration = UIImage.SymbolConfiguration(textStyle: .subheadline)
        icon.setContentHuggingPriority(.required, for: .horizontal)
        // 等宽数字让余额变化时宽度不跳动。
        balanceLabel.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: .monospacedDigitSystemFont(ofSize: 15, weight: .medium), maximumPointSize: 20)
        balanceLabel.adjustsFontForContentSizeCategory = true
        balanceLabel.textColor = AmbientStyle.text
        // 数字在前、图标在后，中间留一个空格的宽度，例如"9 [水滴]"。
        balanceView.addArrangedSubview(balanceLabel)
        balanceView.addArrangedSubview(icon)
        balanceView.spacing = (" " as NSString).size(withAttributes: [.font: balanceLabel.font as Any]).width
        balanceView.alignment = .center
        // 图标与数字合并为一个旁白元素，读作"水滴，N 滴"。
        balanceView.isAccessibilityElement = true
        balanceView.accessibilityLabel = "水滴"
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        // F3 余额用中性细边胶囊，与页面标题保持同一文字色。
        let capsule = BalanceCapsuleView()
        capsule.backgroundColor = AmbientStyle.text.withAlphaComponent(0.06)
        capsule.layer.borderWidth = 0.5
        capsule.addSubview(balanceView)
        NSLayoutConstraint.activate([
            balanceView.leadingAnchor.constraint(equalTo: capsule.leadingAnchor, constant: 12),
            balanceView.trailingAnchor.constraint(equalTo: capsule.trailingAnchor, constant: -12),
            balanceView.topAnchor.constraint(equalTo: capsule.topAnchor, constant: 5),
            balanceView.bottomAnchor.constraint(equalTo: capsule.bottomAnchor, constant: -5)
        ])
        return capsule
    }

    /// 圆角随实际高度计算，大字号下仍保持胶囊形。
    private final class BalanceCapsuleView: UIView {
        override func layoutSubviews() {
            super.layoutSubviews()
            layer.cornerCurve = .circular
            layer.cornerRadius = bounds.height / 2
            layer.borderColor = AmbientStyle.hairline.resolvedColor(with: traitCollection).cgColor
        }

        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            layer.borderColor = AmbientStyle.hairline.resolvedColor(with: traitCollection).cgColor
        }
    }
    private func selectPage() {
        let index = segment.selectedSegmentIndex
        let next = pages[index] ?? (index == 0 ? AmbientFootprintViewController(services: services) : AmbientSceneGalleryViewController(services: services))
        guard active !== next else { return }
        pages[index] = next
        let previous = active
        let visible = view.window != nil
        if visible { previous?.beginAppearanceTransition(false, animated: false) }
        previous?.willMove(toParent: nil)
        previous?.view.removeFromSuperview()
        previous?.removeFromParent()
        if visible { previous?.endAppearanceTransition() }
        addChild(next)
        next.view.translatesAutoresizingMaskIntoConstraints = false
        host.addSubview(next.view)
        NSLayoutConstraint.activate([next.view.leadingAnchor.constraint(equalTo: host.leadingAnchor), next.view.trailingAnchor.constraint(equalTo: host.trailingAnchor), next.view.topAnchor.constraint(equalTo: host.topAnchor), next.view.bottomAnchor.constraint(equalTo: host.bottomAnchor)])
        if visible { next.beginAppearanceTransition(true, animated: false) }
        next.didMove(toParent: self)
        if visible { next.endAppearanceTransition() }
        active = next
    }
}

/// 图鉴只加载封面，锁定场景不创建视频解码器。
final class AmbientSceneGalleryViewController: UITableViewController {
    private let services: AmbientServices
    private var subscription: AnyCancellable?
    init(services: AmbientServices) { self.services = services; super.init(style: .insetGrouped) }
    required init?(coder: NSCoder) { nil }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .clear
        tableView.separatorColor = AmbientStyle.hairline
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88
        subscription = services.$progress.receive(on: RunLoop.main).sink { [weak self] _ in self?.tableView.reloadData() }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { AmbientScene.collection.count }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? { "完整走完一轮专注，每 5 分钟得 1 滴，解锁后永久拥有。所有自然声音均可免费混音。" }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let scene = AmbientScene.collection[indexPath.row]
        let unlocked = services.progress.unlocks.contains(scene.identifier)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = .clear
        cell.backgroundConfiguration = .clear()
        var config = cell.defaultContentConfiguration()
        config.text = scene.title
        config.secondaryText = unlocked ? "已收集 · " + scene.subtitle : "\(AmbientScene.prices[scene.identifier] ?? 0) 滴水滴 · 待解锁"
        config.textProperties.color = AmbientStyle.text
        config.secondaryTextProperties.color = AmbientStyle.secondary
        config.imageProperties.maximumSize = CGSize(width: 72, height: 72)
        config.imageProperties.cornerRadius = 12
        config.directionalLayoutMargins.top = 14
        config.directionalLayoutMargins.bottom = 14
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        AmbientSceneArtwork.thumbnail(for: scene) { [weak cell] image in
            guard let cell else { return }
            var updated = config
            updated.image = image
            cell.contentConfiguration = updated
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        AmbientPageUI.present(AmbientSceneDetailViewController(scene: AmbientScene.collection[indexPath.row], services: services), from: self)
    }
}

/// 兑换按钮等待事务完成才显示成功，余额变化或重复点击不会重复扣款。
final class AmbientSceneDetailViewController: AmbientFormViewController {
    private let scene: AmbientScene
    private let services: AmbientServices
    private let actionButton = AmbientStyle.button("", primary: true)
    private let status = AmbientStyle.label("", size: 14)
    private var isWorking = false
    init(scene: AmbientScene, services: AmbientServices) { self.scene = scene; self.services = services; super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { nil }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = scene.title
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.heightAnchor.constraint(equalToConstant: 220).isActive = true
        content.addArrangedSubview(image)
        AmbientSceneArtwork.thumbnail(for: scene) { [weak image] artwork in image?.image = artwork }
        heading(scene.title, detail: scene.subtitle)
        content.addArrangedSubview(status)
        content.addArrangedSubview(actionButton)
        actionButton.addAction(UIAction { [weak self] _ in self?.activateScene() }, for: .touchUpInside)
        services.$progress.receive(on: RunLoop.main).sink { [weak self] _ in self?.render() }.store(in: &subscriptions)
        render()
    }
    private func render() {
        let unlocked = services.progress.unlocks.contains(scene.identifier)
        status.text = unlocked ? "已解锁，随时回到这片宁静。" : "解锁需要 \(AmbientScene.prices[scene.identifier] ?? 0) 滴 · 当前拥有 \(services.progress.balance) 滴"
        actionButton.configuration?.title = unlocked ? "使用这个场景" : "兑换场景"
        actionButton.isEnabled = !isWorking && services.isReady
    }
    private func activateScene() {
        guard !isWorking else { return }
        if services.progress.unlocks.contains(scene.identifier) {
            if services.select(scene) { dismiss(animated: true) }
            else { AmbientStyle.message(on: self, title: "暂时无法切换", text: services.notice ?? "请先结束当前播放。"); services.clearNotice() }
            return
        }
        let alert = UIAlertController(title: "兑换“\(scene.title)”？", message: "将使用 \(AmbientScene.prices[scene.identifier] ?? 0) 滴水滴，解锁后永久拥有。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "确认兑换", style: .default) { [weak self] _ in self?.redeem() })
        present(alert, animated: true)
    }
    private func redeem() {
        isWorking = true
        render()
        perform { [weak self] in
            guard let self else { return }
            defer { self.isWorking = false; self.render() }
            try await AmbientProgressStore.shared.redeemScene(self.scene)
            await self.services.refreshProgressNow()
        }
    }
}
