import Combine
import UIKit

/// 每日清单保持固定排序，勾选后原地更新，不因完成状态挪动行。
final class AmbientHabitsViewController: UITableViewController {
    private let services: AmbientServices
    private var subscriptions = Set<AnyCancellable>()
    private var habits: [AmbientHabit] = []
    private var pending = Set<UUID>()
    private let filter = UISegmentedControl(items: ["每日", "归档"])
    private let pageTitle = AmbientTableTitleView(title: "每天，一点点", display: true)
    // H1 的辅助文字直接覆盖场景，使用更高的不透明度保持可读。
    private let secondaryText = AmbientStyle.text.withAlphaComponent(0.80)
    /// 左上角只负责调整顺序：平时显示排序图标，排序中显示"完成"；不用系统 editButtonItem，避免显示英文 Edit。
    private lazy var sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), primaryAction: UIAction { [weak self] _ in
        guard let self else { return }
        self.setEditing(!self.isEditing, animated: true)
    })

    init(services: AmbientServices) { self.services = services; super.init(style: .insetGrouped) }
    required init?(coder: NSCoder) { nil }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "每天，一点点"
        tableView.backgroundColor = .clear
        // 开放列表只保留细分隔线，背景由工作空间的清晰场景承托。
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = AmbientStyle.hairline
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.sectionHeaderHeight = .leastNonzeroMagnitude
        tableView.sectionHeaderTopPadding = 0
        tableView.contentInset.bottom = 24
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 68
        AmbientPageUI.useTransparentNavigation(on: self)
        AmbientStyle.styleSegment(filter)
        filter.selectedSegmentIndex = 0
        filter.addAction(UIAction { [weak self] _ in self?.reload() }, for: .valueChanged)
        navigationItem.titleView = filter
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), primaryAction: UIAction { [weak self] _ in self?.editHabit(nil) })
        navigationItem.rightBarButtonItem?.accessibilityLabel = "添加习惯"
        sortButton.accessibilityLabel = "排序"
        navigationItem.leftBarButtonItem = sortButton
        services.$progress.receive(on: RunLoop.main).sink { [weak self] _ in self?.reload() }.store(in: &subscriptions)
        for name in [UIApplication.didBecomeActiveNotification, UIApplication.significantTimeChangeNotification,
                     .NSCalendarDayChanged, UIAccessibility.reduceTransparencyStatusDidChangeNotification] {
            NotificationCenter.default.publisher(for: name).receive(on: RunLoop.main).sink { [weak self] _ in self?.reload() }.store(in: &subscriptions)
        }
        reload()
    }
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated); navigationController?.setNavigationBarHidden(false, animated: false); reload() }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        AmbientPageUI.sizeHeader(pageTitle, in: tableView)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            AmbientStyle.styleSegment(filter)
            AmbientPageUI.sizeHeader(pageTitle, in: tableView)
        }
    }

    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        AmbientPageUI.styleCaption(view, footer: true)
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = secondaryText
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // 排序中改用文字"完成"，比图标更明确地提示如何退出。
        sortButton.image = editing ? nil : UIImage(systemName: "arrow.up.arrow.down")
        sortButton.title = editing ? "完成" : nil
        sortButton.style = editing ? .done : .plain
        sortButton.accessibilityLabel = editing ? "完成排序" : "排序"
    }

    private func reload() {
        habits = services.progress.habits.filter { ($0.archivedDay != nil) == (filter.selectedSegmentIndex == 1) }.sorted { $0.order < $1.order }
        tableView.reloadData()
        // 归档列表不能排序，少于两项时排序没有意义。
        let canSort = filter.selectedSegmentIndex == 0 && habits.count > 1
        if !canSort && isEditing { setEditing(false, animated: true) }
        sortButton.isEnabled = canSort
        if habits.isEmpty {
            let empty = AmbientStyle.label(filter.selectedSegmentIndex == 0 ? "留一个小约定给今天\n轻点右上角，添加第一个习惯" : "还没有归档的习惯", size: 16)
            empty.textAlignment = .center
            empty.textColor = secondaryText
            tableView.backgroundView = empty
        } else { tableView.backgroundView = nil }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { habits.count }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        filter.selectedSegmentIndex == 0 && !habits.isEmpty ? "今天首次完成每项得 2 滴，每天最多 10 滴。偶尔休息一天，也不会清空你的积累。" : nil
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let habit = habits[indexPath.row]
        let entries = services.progress.entries[habit.id.uuidString] ?? []
        let completed = entries.contains(AmbientDayKey.key(Date()))
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = .clear
        cell.backgroundConfiguration = .clear()
        cell.tintColor = AmbientStyle.text
        var config = cell.defaultContentConfiguration()
        config.text = habit.title
        config.textProperties.font = .preferredFont(forTextStyle: .body)
        config.textProperties.color = AmbientStyle.text
        config.textProperties.numberOfLines = 0
        config.secondaryText = "习惯强度  \(Int((habit.strength(completions: entries) * 100).rounded()))%  ·  专注 \(habit.focusMinutes) 分钟"
        config.secondaryTextProperties.color = secondaryText
        config.secondaryTextProperties.font = .preferredFont(forTextStyle: .caption1)
        // 缩小上下留白降低行高；继续由内容撑高，保留长标题换行和打卡按钮的点击区域。
        config.directionalLayoutMargins.top = 12
        config.directionalLayoutMargins.bottom = 12
        config.directionalLayoutMargins.leading = 0
        cell.contentConfiguration = config
        if habit.archivedDay == nil {
            let check = UIButton(type: .system)
            check.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
            check.setImage(UIImage(systemName: completed ? "checkmark.circle.fill" : "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .ultraLight)), for: .normal)
            check.tintColor = completed ? AmbientStyle.text : secondaryText
            check.accessibilityLabel = habit.title
            check.accessibilityValue = completed ? "今日已完成" : "今日未完成"
            check.isEnabled = !pending.contains(habit.id) && services.isReady
            check.addAction(UIAction { [weak self] _ in self?.toggle(habit, completed: !completed) }, for: .touchUpInside)
            cell.accessoryView = check
        } else { cell.accessoryType = .disclosureIndicator }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(AmbientHabitDetailViewController(id: habits[indexPath.row].id, services: services), animated: true)
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool { filter.selectedSegmentIndex == 0 }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moved = habits.remove(at: sourceIndexPath.row)
        habits.insert(moved, at: destinationIndexPath.row)
        let ids = habits.map(\.id)
        perform { try await AmbientProgressStore.shared.reorderHabits(ids) }
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { .none }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let habit = habits[indexPath.row]
        let rename = UIContextualAction(style: .normal, title: "编辑") { [weak self] _, _, done in self?.editHabit(habit); done(true) }
        let archive = UIContextualAction(style: .normal, title: habit.archivedDay == nil ? "归档" : "恢复") { [weak self] _, _, done in
            var edited = habit
            edited.archivedDay = habit.archivedDay == nil ? AmbientDayKey.key(Date()) : nil
            self?.perform { try await AmbientProgressStore.shared.saveHabit(edited) }
            done(true)
        }
        let delete = UIContextualAction(style: .destructive, title: "删除") { [weak self] _, _, done in
            self?.confirmDelete(habit)
            done(true)
        }
        let actions = UISwipeActionsConfiguration(actions: [delete, archive, rename])
        actions.performsFirstActionWithFullSwipe = false
        return actions
    }
    /// 右滑为习惯开始专注，与左滑的整理操作分开，避免误触删除。
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let habit = habits[indexPath.row]
        guard habit.archivedDay == nil else { return nil }
        let focus = UIContextualAction(style: .normal, title: "去专注") { [weak self] _, _, done in
            done(true)
            guard let self else { return }
            AmbientHabitFocus.start(habit, services: self.services, from: self)
        }
        focus.image = UIImage(systemName: "leaf")
        focus.backgroundColor = AmbientStyle.accent
        return UISwipeActionsConfiguration(actions: [focus])
    }

    private func toggle(_ habit: AmbientHabit, completed: Bool) {
        guard !pending.contains(habit.id) else { return }
        pending.insert(habit.id)
        reload()
        Task { [weak self] in
            guard let self else { return }
            defer { self.pending.remove(habit.id); self.reload() }
            do {
                try await AmbientProgressStore.shared.setHabitCompletion(habit.id, day: AmbientDayKey.key(Date()), completed: completed)
                await self.services.refreshProgressNow()
            } catch { AmbientStyle.message(on: self, title: "打卡尚未保存", text: error.localizedDescription) }
        }
    }
    private func editHabit(_ habit: AmbientHabit?) {
        let alert = UIAlertController(title: habit == nil ? "添加每日习惯" : "修改习惯",
                                      message: "写一个清楚、轻量的小目标（最多八十字），并设定每轮专注时长。", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "例如：阅读"; $0.text = habit?.title }
        // 时长必填：数字键盘输入分钟数，默认 25。
        alert.addTextField {
            $0.placeholder = "专注时长（5 到 99 分钟）"
            $0.keyboardType = .numberPad
            $0.text = String(habit?.focusMinutes ?? AmbientHabit.defaultFocusMinutes)
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "保存", style: .default) { [weak self, weak alert] _ in
            guard let self, let fields = alert?.textFields, fields.count == 2 else { return }
            var value = habit ?? AmbientHabit(title: "", createdDay: AmbientDayKey.key(Date()), order: (self.services.progress.habits.map(\.order).max() ?? -1) + 1)
            value.title = fields[0].text ?? ""
            guard let minutes = Int((fields[1].text ?? "").trimmingCharacters(in: .whitespaces)),
                  AmbientHabit.focusMinutesRange.contains(minutes) else {
                AmbientStyle.message(on: self, title: "专注时长无效", text: "请输入 5 到 99 之间的整数分钟。")
                return
            }
            value.focusMinutes = minutes
            self.perform { try await AmbientProgressStore.shared.saveHabit(value) }
        })
        present(alert, animated: true)
    }
    private func confirmDelete(_ habit: AmbientHabit) {
        let alert = UIAlertController(title: "删除这个习惯？", message: "将删除习惯与打卡历史，已获得的水滴保持不变。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "删除", style: .destructive) { [weak self] _ in self?.perform { try await AmbientProgressStore.shared.deleteHabit(habit.id) } })
        present(alert, animated: true)
    }
    private func perform(_ action: @escaping () async throws -> Void) {
        Task { [weak self] in
            do { try await action() }
            catch { if let self { AmbientStyle.message(on: self, title: "暂时无法保存", text: error.localizedDescription) } }
        }
    }
}

/// 从习惯页为某个习惯开始专注：设好本轮目标与关联后切回沉浸页，由用户在沉浸页按下开始。
@MainActor
private enum AmbientHabitFocus {
    static func start(_ habit: AmbientHabit, services: AmbientServices, from page: UIViewController) {
        guard services.isReady, habit.archivedDay == nil else { return }
        let clock = services.clock
        if clock.canEditGoal {
            clock.setGoal(habit.title, habit: habit)
        } else if clock.backupArchive().habitID != habit.id {
            // 进行中的一轮目标已固定，不改写，只说明原因。
            AmbientStyle.message(on: page, title: "本轮专注进行中", text: "当前这一轮结束后，再为“\(habit.title)”开始专注。")
            return
        }
        (page.navigationController?.parent as? AmbientWorkspaceViewController)?.showFocusPage()
    }
}

/// 复用现有方阵绘制，每个日期仅表示是否完成，不累加专注时长。
final class AmbientHabitDetailViewController: AmbientFormViewController {
    private let id: UUID
    private let services: AmbientServices
    private let heatmap = AmbientHeatmapView()
    private let strength = AmbientStyle.label("", size: 44, weight: .light)
    private let dateLabel = AmbientStyle.label("", size: 14)
    private let toggle = AmbientStyle.button("完成这一天")
    private let focusButton = AmbientStyle.button("为它专注一轮")
    private var selectedKey = AmbientDayKey.key(Date())
    init(id: UUID, services: AmbientServices) { self.id = id; self.services = services; super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { nil }
    override func viewDidLoad() {
        super.viewDidLoad()
        heading("让坚持慢慢生长", detail: "强度随每日积累平滑变化，偶尔中断不会归零。")
        strength.textColor = AmbientStyle.accent
        content.addArrangedSubview(strength)
        heatmap.isHabitHistory = true
        heatmap.onSelect = { [weak self] day in self?.selectedKey = day.key; self?.render() }
        content.addArrangedSubview(heatmap)
        content.addArrangedSubview(dateLabel)
        content.addArrangedSubview(toggle)
        toggle.addAction(UIAction { [weak self] _ in self?.toggleSelected() }, for: .touchUpInside)
        focusButton.configuration?.image = UIImage(systemName: "leaf")
        focusButton.configuration?.imagePadding = 8
        focusButton.addAction(UIAction { [weak self] _ in self?.startFocus() }, for: .touchUpInside)
        content.addArrangedSubview(focusButton)
        let hint = AmbientStyle.label("可修改最近七天。补卡更新历史与强度，不奖励水滴。", size: 12)
        hint.textColor = AmbientStyle.secondary
        content.addArrangedSubview(hint)
        services.$progress.receive(on: RunLoop.main).sink { [weak self] _ in self?.render() }.store(in: &subscriptions)
        for name in [UIApplication.didBecomeActiveNotification, .NSCalendarDayChanged] {
            NotificationCenter.default.publisher(for: name).receive(on: RunLoop.main).sink { [weak self] _ in self?.render() }.store(in: &subscriptions)
        }
        render()
    }
    private func startFocus() {
        guard let habit = services.progress.habits.first(where: { $0.id == id }) else { return }
        AmbientHabitFocus.start(habit, services: services, from: self)
    }
    private func render() {
        guard let habit = services.progress.habits.first(where: { $0.id == id }) else { toggle.isEnabled = false; focusButton.isEnabled = false; return }
        // 归档的习惯不再发起专注，与打卡按钮一致；按钮文案带上该习惯设定的时长。
        focusButton.isEnabled = habit.archivedDay == nil
        focusButton.configuration?.title = "为它专注 \(habit.focusMinutes) 分钟"
        title = habit.title
        let entries = services.progress.entries[id.uuidString] ?? []
        strength.text = "\(Int((habit.strength(completions: entries) * 100).rounded()))%"
        let calendar = AmbientDayKey.calendar
        let today = Date()
        let days: [AmbientFootprint.Day] = (0..<90).reversed().compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: -offset, to: today) else { return nil }
            let key = AmbientDayKey.key(date)
            return .init(date: date, key: key, focusSeconds: entries.contains(key) ? 6000 : 0, rounds: 0)
        }
        heatmap.configure(days: days, selectedKey: selectedKey, calendar: calendar)
        let completed = entries.contains(selectedKey)
        dateLabel.text = selectedKey + (completed ? " · 已完成" : " · 未完成")
        let oldest = AmbientDayKey.key(calendar.date(byAdding: .day, value: -6, to: today) ?? today)
        toggle.isEnabled = habit.archivedDay == nil && selectedKey >= max(oldest, habit.createdDay) && selectedKey <= AmbientDayKey.key(today)
        toggle.configuration?.title = completed ? "撤销这一天的打卡" : "完成这一天"
    }
    private func toggleSelected() {
        let day = selectedKey
        let completed = !(services.progress.entries[id.uuidString] ?? []).contains(day)
        toggle.isEnabled = false
        perform { [weak self] in
            guard let self else { return }
            defer { self.render() }
            try await AmbientProgressStore.shared.setHabitCompletion(self.id, day: day, completed: completed)
            await self.services.refreshProgressNow()
        }
    }
}
