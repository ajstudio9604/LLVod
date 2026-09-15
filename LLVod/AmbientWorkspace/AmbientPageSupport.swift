import Combine
import UIKit

/// 次级页面共用留白、主题与错误提示，具体业务仍由共享服务持有。
class AmbientFormViewController: UIViewController {
    let content = UIStackView()
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AmbientStyle.background
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll)
        content.axis = .vertical
        content.spacing = 18
        content.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(content)
        let width = content.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor, constant: -40)
        width.priority = .defaultHigh
        NSLayoutConstraint.activate([
            scroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor), scroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scroll.contentLayoutGuide.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
            content.centerXAnchor.constraint(equalTo: scroll.frameLayoutGuide.centerXAnchor), width,
            content.widthAnchor.constraint(lessThanOrEqualToConstant: 620),
            content.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor, constant: 24),
            content.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -28)
        ])
    }

    func heading(_ title: String, detail: String? = nil) {
        content.addArrangedSubview(AmbientStyle.label(title, size: 26, weight: .medium))
        if let detail {
            let caption = AmbientStyle.label(detail, size: 13)
            caption.textColor = AmbientStyle.secondary
            content.addArrangedSubview(caption)
        }
    }

    func perform(_ operation: @escaping () async throws -> Void) {
        Task { [weak self] in
            do { try await operation() }
            catch { if let self { AmbientStyle.message(on: self, title: "暂时无法完成", text: error.localizedDescription) } }
        }
    }
}

@MainActor
enum AmbientPageUI {
    /// 通透页的导航栏只覆盖当前导航项，推入详情后仍使用常规导航外观。
    static func useTransparentNavigation(on page: UIViewController) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: AmbientStyle.text]
        page.navigationItem.standardAppearance = appearance
        page.navigationItem.scrollEdgeAppearance = appearance
        page.navigationItem.compactAppearance = appearance
    }

    /// 表格页眉按真实宽度与字号重算高度，避免长标题被固定高度裁切。
    static func sizeHeader(_ header: UIView, in table: UITableView) {
        let width = table.bounds.width
        guard width > 0 else { return }
        let height = header.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
        guard table.tableHeaderView !== header || header.frame.width != width || abs(header.frame.height - height) > 0.5 else { return }
        header.frame = CGRect(x: 0, y: 0, width: width, height: height)
        table.tableHeaderView = header
    }

    /// 分组说明保持可读字号和透明底，深浅主题下都透出页面自身的底色。
    static func styleCaption(_ view: UIView, footer: Bool) {
        guard let caption = view as? UITableViewHeaderFooterView else { return }
        caption.backgroundConfiguration = .clear()
        caption.textLabel?.textColor = AmbientStyle.pageSecondary
        caption.textLabel?.font = UIFontMetrics(forTextStyle: .caption1).scaledFont(
            for: .systemFont(ofSize: footer ? 12 : 13, weight: footer ? .regular : .medium))
        caption.textLabel?.adjustsFontForContentSizeCategory = true
        caption.textLabel?.numberOfLines = 0
    }

    static func button(_ title: String, symbol: String? = nil, action: @escaping () -> Void) -> UIButton {
        let button = AmbientStyle.button(title)
        button.configuration?.image = symbol.flatMap { UIImage(systemName: $0) }
        button.configuration?.imagePadding = 10
        button.contentHorizontalAlignment = .leading
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
        button.addAction(UIAction { _ in action() }, for: .touchUpInside)
        return button
    }

    static func toggle(_ title: String, isOn: Bool, change: @escaping (Bool) -> Void) -> UIView {
        let label = AmbientStyle.label(title, size: 15)
        let control = UISwitch()
        control.isOn = isOn
        control.onTintColor = AmbientStyle.accent
        control.accessibilityLabel = title
        label.isAccessibilityElement = false
        control.addAction(UIAction { [weak control] _ in if let control { change(control.isOn) } }, for: .valueChanged)
        let row = UIStackView(arrangedSubviews: [label, control])
        row.alignment = .center
        row.spacing = 12
        row.heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
        control.setContentHuggingPriority(.required, for: .horizontal)
        return row
    }

    static func present(_ page: UIViewController, from presenter: UIViewController) {
        let nav = AmbientNavigationController(rootViewController: page)
        nav.overrideUserInterfaceStyle = AmbientPreferences.shared.values.theme.style
        page.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", primaryAction: UIAction { [weak nav] _ in nav?.dismiss(animated: true) })
        nav.modalPresentationStyle = .pageSheet
        nav.sheetPresentationController?.detents = [.medium(), .large()]
        nav.sheetPresentationController?.prefersGrabberVisible = true
        presenter.present(nav, animated: true)
    }
}

/// 习惯与空间页的内容区标题；限制易读宽度，同时允许辅助字号自然增高。
final class AmbientTableTitleView: UIView {
    private let label: UILabel
    // 标题上下各留 16 点，测量与布局共用同一数值，紧凑展示时仍保留完整文字高度。
    private let verticalPadding: CGFloat = 16

    /// display 为 true 时使用更大的苹方细体展示标题，用于习惯页这类需要强调氛围的页面。
    init(title: String, display: Bool = false) {
        label = AmbientStyle.label(title, size: display ? 30 : 27, weight: .medium)
        super.init(frame: .zero)
        if display {
            label.font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: AmbientStyle.pingFang(size: 30, weight: .light))
        }
        label.accessibilityTraits = .header
        addSubview(label)
    }

    required init?(coder: NSCoder) { nil }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width = min(620, max(0, size.width - 40))
        return CGSize(width: size.width, height: ceil(label.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height) + verticalPadding * 2)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = min(620, max(0, bounds.width - 40))
        label.frame = CGRect(x: (bounds.width - width) / 2, y: verticalPadding, width: width, height: max(0, bounds.height - verticalPadding * 2))
    }
}

/// 修改目标不会修改已开始的轮次，关联习惯只在完成后请求用户确认。
final class AmbientGoalViewController: UITableViewController {
    private let services: AmbientServices
    private let input = UITextField()
    private var selectedHabit: UUID?
    private var habits: [AmbientHabit] { services.progress.habits.filter { $0.archivedDay == nil }.sorted { $0.order < $1.order } }

    init(services: AmbientServices) { self.services = services; super.init(style: .insetGrouped) }
    required init?(coder: NSCoder) { nil }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "本次专注目标"
        tableView.backgroundColor = AmbientStyle.background
        // 占位提示与页面保存按钮共用主题强调色。
        input.attributedPlaceholder = NSAttributedString(string: "这一轮，想完成什么？", attributes: [.foregroundColor: AmbientStyle.accent])
        input.text = services.clock.goal
        input.textColor = AmbientStyle.text
        input.font = .preferredFont(forTextStyle: .body)
        input.clearButtonMode = .whileEditing
        // 关联的习惯已删除或归档时按未关联显示，避免列表中没有任何一项被勾选。
        let linked = services.clock.backupArchive().habitID
        selectedHabit = habits.contains { $0.id == linked } ? linked : nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", primaryAction: UIAction { [weak self] _ in self?.save() })
    }
    override func numberOfSections(in tableView: UITableView) -> Int { 2 }
    // 没有习惯时保留一行占位提示，引导用户先去习惯页添加。
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { section == 0 ? 1 : max(habits.count, 1) }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { section == 0 ? "一句话目标，可不填写" : "关联每日习惯（必选）" }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? { section == 0 ? "最多八十字，开始后本轮目标固定。" : "开始专注前必须关联一个习惯，倒计时按习惯设定的时长进行；专注结束后仍由你确认是否完成习惯。" }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = AmbientStyle.surface
        if indexPath.section == 0 {
            input.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(input)
            NSLayoutConstraint.activate([input.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16), input.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16), input.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 14), input.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -14)])
        } else if habits.isEmpty {
            var config = cell.defaultContentConfiguration()
            config.text = "还没有习惯，请先到习惯页添加"
            config.textProperties.color = AmbientStyle.secondary
            cell.contentConfiguration = config
            cell.selectionStyle = .none
        } else {
            let habit = habits[indexPath.row]
            var config = cell.defaultContentConfiguration()
            config.text = habit.title
            // 列出每个习惯设定的时长，选中后倒计时按此进行。
            config.secondaryText = "专注 \(habit.focusMinutes) 分钟"
            config.secondaryTextProperties.color = AmbientStyle.secondary
            cell.contentConfiguration = config
            cell.accessoryType = habit.id == selectedHabit ? .checkmark : .none
            cell.tintColor = AmbientStyle.accent
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1, !habits.isEmpty else { return }
        let habit = habits[indexPath.row]
        selectedHabit = habit.id
        input.text = habit.title
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
    }
    private func save() {
        guard (input.text?.count ?? 0) <= 80 else { AmbientStyle.message(on: self, title: "目标稍长", text: "请将目标控制在八十字以内。"); return }
        // 未选中习惯时只更新目标文字，时长沿用当前值；能否开始由沉浸页按关联状态判断。
        services.clock.setGoal(input.text ?? "", habit: habits.first { $0.id == selectedHabit })
        dismiss(animated: true)
    }
}

/// 四轨调节面板；音轨开关记住上一次非零比例，总开关保持独立。
final class AmbientMixerViewController: AmbientFormViewController {
    private let services: AmbientServices
    private var levels: [String: UISlider] = [:]
    private var switches: [String: UISwitch] = [:]
    private var lastLevels: [String: Float] = [:]
    init(services: AmbientServices) { self.services = services; super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { nil }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "自然声混音"
        heading("调一份自己的宁静", detail: "各轨只调整配比；手机音量键与首页滑杆控制总音量。")
        for track in AmbientAudioMixer.tracks {
            let title = AmbientStyle.label(track.title, size: 16)
            let slider = UISlider()
            slider.minimumValue = 0
            slider.maximumValue = 1
            slider.minimumTrackTintColor = AmbientStyle.accent
            slider.accessibilityLabel = track.title + "配比"
            slider.addAction(UIAction { [weak self, weak slider] _ in
                guard let self, let slider else { return }
                self.services.setMixLevel(track.id, value: slider.value)
                self.switches[track.id]?.setOn(slider.value > 0, animated: false)
                slider.accessibilityValue = "百分之\(Int(slider.value * 100))"
            }, for: .valueChanged)
            let control = UISwitch()
            control.onTintColor = AmbientStyle.accent
            control.accessibilityLabel = track.title
            control.addAction(UIAction { [weak self, weak control, weak slider] _ in
                guard let self, let control, let slider else { return }
                if !control.isOn { self.lastLevels[track.id] = slider.value }
                let value: Float = control.isOn ? max(0.1, self.lastLevels[track.id] ?? 0.5) : 0
                slider.value = value
                self.services.setMixLevel(track.id, value: value)
            }, for: .valueChanged)
            let row = UIStackView(arrangedSubviews: [title, control])
            row.alignment = .center
            row.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
            content.addArrangedSubview(row)
            content.addArrangedSubview(slider)
            levels[track.id] = slider
            switches[track.id] = control
        }
        content.addArrangedSubview(AmbientPageUI.button("恢复场景声音", symbol: "arrow.counterclockwise") { [weak self] in self?.services.followSceneSound(); self?.render() })
        services.clock.$stage.receive(on: RunLoop.main).sink { [weak self] _ in self?.render() }.store(in: &subscriptions)
        render()
    }
    private func render() {
        let current = services.mixer.levels(for: services.selectedScene)
        for (id, slider) in levels where !slider.isTracking {
            slider.value = current[id] ?? 0
            slider.accessibilityValue = "百分之\(Int(slider.value * 100))"
            switches[id]?.setOn(slider.value > 0, animated: false)
        }
    }
}
