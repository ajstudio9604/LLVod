import UIKit

/// 专注足迹独立页面：顶部核心指标、近九十天打卡方阵、场景陪伴分布与近期专注记录，全部数据来自本机记录。
/// 嵌入足迹与成就容器，与图鉴共用标题、分段按钮和水滴余额。
final class AmbientFootprintViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private enum Section: Int, CaseIterable { case overview, records }

    private weak var services: AmbientServices?
    private let cream = AmbientStyle.text
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let todayMetric = AmbientMetricView(title: "今日专注")
    private let totalMetric = AmbientMetricView(title: "累计专注")
    private let streakMetric = AmbientMetricView(title: "连续打卡")
    private let metricsRow = UIStackView()
    private var metricDividers: [UIView] = []
    private let heatmap = AmbientHeatmapView()
    private let heatSubtitle = AmbientStyle.label("", size: 12)
    private let heatFooter = UIStackView()
    private let dayLabel = AmbientStyle.label("", size: 13)
    private let legend = AmbientHeatLegendView()
    private let distribution = AmbientSceneDistributionView()
    /// 概览区三个单元格各只有一份，直接持有；数据刷新时原地更新，只重算高度，不重建视图。
    private var overviewCells: [UITableViewCell] = []
    private var records: [AmbientFootprint.Record] = []
    private var observers: [NSObjectProtocol] = []
    /// 用户点选的日期；为空时始终选中今天，跨零点后自动移到新的一天。
    private var selectedKey: String?
    /// 最近一次渲染记录列表时的日期与时制；跨零点或切换 12/24 小时制后，记录时刻需要重新生成。
    private var renderedKey: String?
    private var loadGeneration = 0
    private var isReloadScheduled = false

    init(services: AmbientServices) {
        self.services = services
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    deinit { observers.forEach(NotificationCenter.default.removeObserver) }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "专注足迹"
        view.backgroundColor = .clear
        buildOverview()
        buildTable()
        observeChanges()
        // 先把进行中的专注与陪伴片段落盘再读取，进入页面时看到的就是此刻的数据。
        services?.flushRecords()
        reload()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAdaptiveLayout()
    }

    // MARK: - 布局

    private func buildTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 56
        // 列表末尾留出呼吸空间，最后一条记录不贴底。
        tableView.contentInset.bottom = 24
        tableView.sectionHeaderTopPadding = 0
        // 宽屏设备上内容保持在易读宽度内，页面不被拉得过宽。
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.showsVerticalScrollIndicator = false
        tableView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        tableView.register(AmbientFocusRecordCell.self, forCellReuseIdentifier: AmbientFocusRecordCell.reuseIdentifier)
        tableView.register(AmbientFootprintMessageCell.self,
                           forCellReuseIdentifier: AmbientFootprintMessageCell.reuseIdentifier)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func buildOverview() {
        for metric in [todayMetric, totalMetric, streakMetric] { metricsRow.addArrangedSubview(metric) }
        metricsRow.spacing = 20
        // 分隔线作为装饰覆盖在间距中，不参与等宽分配，也不会挤小数字。
        for metric in [todayMetric, totalMetric] {
            let divider = UIView()
            divider.backgroundColor = AmbientStyle.hairline
            divider.translatesAutoresizingMaskIntoConstraints = false
            metricsRow.addSubview(divider)
            NSLayoutConstraint.activate([
                divider.leadingAnchor.constraint(equalTo: metric.trailingAnchor, constant: 10),
                divider.topAnchor.constraint(equalTo: metricsRow.topAnchor, constant: 8),
                divider.bottomAnchor.constraint(equalTo: metricsRow.bottomAnchor, constant: -8),
                divider.widthAnchor.constraint(equalToConstant: 0.5)
            ])
            metricDividers.append(divider)
        }
        overviewCells = [
            AmbientFootprintHostCell(content: metricsRow, top: 16, bottom: 12),
            AmbientFootprintHostCell(content: makeHeatSection(), top: 16, bottom: 16),
            AmbientFootprintHostCell(content: distribution, top: 16, bottom: 20)
        ]
        updateAdaptiveLayout()
    }

    private func makeHeatSection() -> UIView {
        let title = AmbientStyle.label("打卡热力图", size: 17, weight: .medium)
        title.textColor = cream
        title.accessibilityTraits = .header
        heatSubtitle.textColor = cream.withAlphaComponent(0.55)
        heatmap.onSelect = { [weak self] day in
            guard let self else { return }
            self.selectedKey = day.key
            self.dayLabel.text = AmbientFootprintText.daySummary(day)
            self.refreshOverviewHeights()
        }
        dayLabel.textColor = cream.withAlphaComponent(0.85)
        // 详情行已由方阵的无障碍值朗读，避免重复播报。
        dayLabel.isAccessibilityElement = false
        legend.setContentHuggingPriority(.required, for: .horizontal)
        legend.setContentCompressionResistancePriority(.required, for: .horizontal)
        heatFooter.addArrangedSubview(dayLabel)
        heatFooter.addArrangedSubview(legend)
        heatFooter.spacing = 12
        let section = UIStackView(arrangedSubviews: [title, heatSubtitle, heatmap, heatFooter])
        section.axis = .vertical
        section.spacing = 6
        section.setCustomSpacing(14, after: heatSubtitle)
        section.setCustomSpacing(12, after: heatmap)
        return section
    }

    private func makeRecordsHeader() -> UIView {
        let title = AmbientStyle.label("近期专注记录", size: 17, weight: .medium)
        title.textColor = cream
        title.accessibilityTraits = .header
        let caption = AmbientStyle.label("最近完成的 \(AmbientFocusLog.recentRecordLimit) 轮专注，左滑可删除", size: 12)
        caption.textColor = cream.withAlphaComponent(0.55)
        let stack = UIStackView(arrangedSubviews: [title, caption])
        stack.axis = .vertical
        stack.spacing = 4
        return wrap(stack, top: 12, bottom: 8)
    }

    /// 分组标题沿用单元格的易读边距，与上方内容左右对齐。
    private func wrap(_ content: UIView, top: CGFloat, bottom: CGFloat) -> UIView {
        let container = UITableViewHeaderFooterView(reuseIdentifier: nil)
        var background = UIBackgroundConfiguration.clear()
        background.backgroundColor = AmbientStyle.pageBackground
        container.backgroundConfiguration = background
        content.translatesAutoresizingMaskIntoConstraints = false
        container.contentView.addSubview(content)
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: container.contentView.layoutMarginsGuide.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: container.contentView.layoutMarginsGuide.trailingAnchor),
            content.topAnchor.constraint(equalTo: container.contentView.topAnchor, constant: top),
            content.bottomAnchor.constraint(equalTo: container.contentView.bottomAnchor, constant: -bottom)
        ])
        return container
    }

    private func updateAdaptiveLayout() {
        // 辅助字号下指标与热力图详情改为纵向排列，保证数字和文字完整显示。
        let stacked = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        metricsRow.axis = stacked ? .vertical : .horizontal
        metricsRow.distribution = stacked ? .fill : .fillEqually
        metricDividers.forEach { $0.isHidden = stacked }
        heatFooter.axis = stacked ? .vertical : .horizontal
        heatFooter.alignment = stacked ? .leading : .center
        refreshOverviewHeights()
    }

    /// 概览内容高度可能变化时（例如场景行增减、详情换行），只让表格重算高度，不重建单元格。
    private func refreshOverviewHeights() {
        guard tableView.window != nil else { return }
        UIView.performWithoutAnimation {
            tableView.performBatchUpdates(nil)
        }
    }

    // MARK: - 数据

    private func observeChanges() {
        let center = NotificationCenter.default
        let names = [AmbientFocusLog.didChangeNotification,
                     // 跨零点或系统时间变化后，"今天"会移动到下一格。
                     UIApplication.significantTimeChangeNotification,
                     // 切换 12/24 小时制等区域格式后，记录时刻需要重新生成。
                     NSLocale.currentLocaleDidChangeNotification]
        for name in names {
            observers.append(center.addObserver(forName: name, object: nil, queue: .main) { [weak self] _ in
                MainActor.assumeIsolated { self?.scheduleReload() }
            })
        }
        observers.append(center.addObserver(forName: UIApplication.didBecomeActiveNotification,
                                            object: nil, queue: .main) { [weak self] _ in
            MainActor.assumeIsolated {
                self?.services?.flushRecords()
                self?.scheduleReload()
            }
        })
    }

    /// 同一轮事件循环内的多次写入只触发一次读取。
    private func scheduleReload() {
        guard !isReloadScheduled else { return }
        isReloadScheduled = true
        DispatchQueue.main.async { [weak self] in
            self?.isReloadScheduled = false
            self?.reload()
        }
    }

    private func reload() {
        loadGeneration += 1
        let generation = loadGeneration
        Task { [weak self] in
            let footprint = await AmbientFocusLog.shared.footprint()
            // 只采用最后一次请求的结果，避免较早的读取覆盖较新的数据。
            guard let self, generation == self.loadGeneration else { return }
            self.apply(footprint)
        }
    }

    private func apply(_ footprint: AmbientFootprint) {
        let today = AmbientFootprintText.total(footprint.todaySeconds)
        todayMetric.update(value: today.value, unit: today.unit,
                           caption: "完成 \(footprint.days.last?.rounds ?? 0) 轮")
        let total = AmbientFootprintText.total(footprint.allTimeSeconds)
        totalMetric.update(value: total.value, unit: total.unit, caption: "共 \(footprint.completedRounds) 轮")
        streakMetric.update(value: "\(footprint.currentStreak)", unit: "天", caption: "最长 \(footprint.longestStreak) 天")
        heatSubtitle.text = "近 \(footprint.days.count) 天 · 打卡 \(footprint.activeDays) 天"
        heatmap.configure(days: footprint.days, selectedKey: selectedKey, calendar: footprint.calendar)
        dayLabel.text = heatmap.selectedDay.map(AmbientFootprintText.daySummary)
        distribution.configure(footprint.scenes)
        // 记录集合变化、跨零点或切换时制时才刷新列表，每分钟的例行刷新不打断正在进行的左滑。
        let renderKey = "\(footprint.days.last?.key ?? "")|\(AmbientClockText.usesTwelveHour)"
        if footprint.records.map(\.id) != records.map(\.id) || renderKey != renderedKey {
            records = footprint.records
            renderedKey = renderKey
            tableView.reloadSections(IndexSet(integer: Section.records.rawValue), with: .none)
        }
        refreshOverviewHeights()
    }

    private func deleteRecord(_ id: UUID) {
        // 事务成功后才更新界面，写入失败不会误报删除完成。
        Task { [weak self] in
            guard let self else { return }
            do {
                try await AmbientProgressStore.shared.deleteRound(id)
                self.reload()
                UIAccessibility.post(notification: .announcement, argument: "已删除这条专注记录")
            } catch {
                AmbientStyle.message(on: self, title: "记录未删除", text: error.localizedDescription)
            }
        }
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int { Section.allCases.count }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == Section.overview.rawValue ? overviewCells.count : max(1, records.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Section.overview.rawValue {
            return overviewCells[indexPath.row]
        }
        guard records.indices.contains(indexPath.row) else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AmbientFootprintMessageCell.reuseIdentifier,
                                                     for: indexPath)
            (cell as? AmbientFootprintMessageCell)?.configure("完成一轮专注后，这里会留下记录。")
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: AmbientFocusRecordCell.reuseIdentifier, for: indexPath)
        (cell as? AmbientFocusRecordCell)?.configure(records[indexPath.row])
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == Section.records.rawValue ? makeRecordsHeader() : nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == Section.records.rawValue ? UITableView.automaticDimension : .leastNonzeroMagnitude
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section == Section.records.rawValue, records.indices.contains(indexPath.row) else { return nil }
        let id = records[indexPath.row].id
        let delete = UIContextualAction(style: .destructive, title: "删除") { [weak self] _, _, completion in
            self?.deleteRecord(id)
            completion(true)
        }
        delete.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}
