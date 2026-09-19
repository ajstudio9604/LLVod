import Combine
import UniformTypeIdentifiers
import UIKit

/// 偏好与本地数据集中在空间页，修改只影响专注业务。
final class AmbientSpaceViewController: UITableViewController, UIDocumentPickerDelegate {
    private let services: AmbientServices
    private var subscription: AnyCancellable?
    private var isBusy = false
    private var importCandidate: AmbientWorkspaceBackup?
    private let pageTitle = AmbientTableTitleView(title: "我的空间")
    // S1 的辅助文案覆盖在场景上，比实色页面使用更高的不透明度。
    private let secondaryText = AmbientStyle.text.withAlphaComponent(0.80)
    init(services: AmbientServices) { self.services = services; super.init(style: .insetGrouped) }
    required init?(coder: NSCoder) { nil }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的空间"
        // 反馈页使用简短的来源名称作为返回文案。
        navigationItem.backButtonTitle = "空间"
        // S1 保留透明分组与细线，完整场景由工作空间容器承托。
        tableView.backgroundColor = .clear
        tableView.separatorColor = AmbientStyle.hairline
        tableView.separatorInset = .zero
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 48
        // 分组标题按内容自动增高，字体放大或换行时不裁切。
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 44
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "AmbientSpaceSectionHeader")
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset.bottom = 24
        tableView.sectionHeaderTopPadding = 0
        subscription = services.objectWillChange.receive(on: RunLoop.main).sink { [weak self] _ in
            guard self?.isBusy == false else { return }
            self?.tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated); navigationController?.setNavigationBarHidden(true, animated: false); tableView.reloadData() }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        AmbientPageUI.sizeHeader(pageTitle, in: tableView)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AmbientSpaceSectionHeader") else { return nil }
        // 在测量前配置标题，以字号、字重和主题强调色区分设置项及下方说明。
        var configuration = UIListContentConfiguration.groupedHeader()
        configuration.text = self.tableView(tableView, titleForHeaderInSection: section)
        configuration.textProperties.font = UIFontMetrics(forTextStyle: .headline).scaledFont(
            for: .systemFont(ofSize: 17, weight: .semibold))
        configuration.textProperties.color = AmbientStyle.accent
        configuration.textProperties.numberOfLines = 0
        header.contentConfiguration = configuration
        header.backgroundConfiguration = .clear()
        header.isAccessibilityElement = true
        header.accessibilityTraits = .header
        header.accessibilityLabel = configuration.text
        return header
    }

    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        AmbientPageUI.styleCaption(view, footer: true)
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = secondaryText
    }
    override func numberOfSections(in tableView: UITableView) -> Int { 4 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { [5, 1, 3, 3][section] }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { ["声音与节奏", "外观", "本地数据", "关于"][section] }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 { return "阶段提示仅在应用内提供。后台挂起时，返回后会按实际时间恢复阶段。" }
        if section == 2 { return "数据保存在本机。导入、导出前会暂停计时与播放；备份由你选择保存位置。" }
        return nil
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.backgroundColor = .clear
        cell.backgroundConfiguration = .clear()
        cell.tintColor = secondaryText
        cell.textLabel?.textColor = AmbientStyle.text
        cell.textLabel?.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: .systemFont(ofSize: 16))
        cell.textLabel?.adjustsFontForContentSizeCategory = true
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.textColor = secondaryText
        cell.detailTextLabel?.font = .preferredFont(forTextStyle: .caption1)
        cell.detailTextLabel?.adjustsFontForContentSizeCategory = true
        cell.detailTextLabel?.numberOfLines = 0
        // 开关和普通入口共用至少 48 点的触摸高度；大字号可继续撑高。
        cell.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
        cell.accessoryType = .disclosureIndicator
        let values = AmbientPreferences.shared.values
        switch (indexPath.section, indexPath.row) {
        case (0, 0): cell.textLabel?.text = "定时关闭"; cell.detailTextLabel?.text = services.sleepTimer.preset == nil ? "未设置" : services.sleepTimer.status
        case (0, 1): configureSwitch(cell, title: "启动时开启环境音", value: values.soundEnabled) { value in AmbientPreferences.shared.update { $0.soundEnabled = value } }
        case (0, 2): cell.textLabel?.text = "自然声混音"
        case (0, 3): configureSwitch(cell, title: "阶段提示音", value: values.phaseSound) { value in AmbientPreferences.shared.update { $0.phaseSound = value } }
        case (0, 4):
            configureSwitch(cell, title: "空间微动", value: values.motionEnabled) { value in AmbientPreferences.shared.update { $0.motionEnabled = value } }
            cell.accessoryView?.accessibilityHint = services.spatialMotion.statusDescription
            cell.accessoryView?.isUserInteractionEnabled = services.spatialMotion.isSupported
        case (1, _): cell.textLabel?.text = "颜色模式"; cell.detailTextLabel?.text = values.theme.title
        case (2, 0): cell.textLabel?.text = "导出本地备份"
        case (2, 1): cell.textLabel?.text = "从备份恢复"
        case (2, 2): cell.textLabel?.text = "清空自律数据"; cell.textLabel?.textColor = .systemRed
        case (3, 0): cell.textLabel?.text = "意见与建议"
        case (3, 1): cell.textLabel?.text = "关于" + AmbientAppInfo.name
        default:
            cell.textLabel?.text = "重新读取本地数据"
            cell.detailTextLabel?.text = services.loadError == nil ? "" : "读取失败"
        }
        cell.isUserInteractionEnabled = !isBusy
        return cell
    }
    private func configureSwitch(_ cell: UITableViewCell, title: String, value: Bool, change: @escaping (Bool) -> Void) {
        cell.textLabel?.text = title
        let control = UISwitch()
        control.onTintColor = AmbientStyle.text
        control.thumbTintColor = AmbientStyle.pageBackground
        control.isOn = value
        control.accessibilityLabel = title
        control.addAction(UIAction { [weak control] _ in if let control { change(control.isOn) } }, for: .valueChanged)
        cell.accessoryView = control
        cell.selectionStyle = .none
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard !isBusy else { return }
        switch (indexPath.section, indexPath.row) {
        case (0, 0): chooseSleep(from: indexPath)
        case (0, 2): AmbientPageUI.present(AmbientMixerViewController(services: services), from: self)
        case (1, _): chooseTheme(from: indexPath)
        case (2, 0): exportBackup(from: indexPath)
        case (2, 1):
            let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.json], asCopy: true)
            picker.delegate = self
            present(picker, animated: true)
        case (2, 2): confirmClear()
        case (3, 0): navigationController?.pushViewController(FeedbackCollectorViewController(), animated: true)
        case (3, 1): AmbientStyle.message(on: self, title: AmbientAppInfo.name, text: AmbientAppInfo.about)
        case (3, 2): services.prepareProgress()
        default: break
        }
    }
    private func chooseSleep(from indexPath: IndexPath) {
        let alert = UIAlertController(title: "定时关闭", message: "到期前声音渐弱，并暂停正在进行的计时。", preferredStyle: .actionSheet)
        for preset in AmbientSleepTimer.Preset.allCases {
            alert.addAction(UIAlertAction(title: "\(Int(preset.duration / 60)) 分钟后", style: .default) { [weak self] _ in self?.services.setSleepPreset(preset); self?.tableView.reloadData() })
        }
        alert.addAction(UIAlertAction(title: "取消定时", style: .default) { [weak self] _ in self?.services.sleepTimer.cancel(); self?.tableView.reloadData() })
        alert.addAction(UIAlertAction(title: "返回", style: .cancel))
        showActions(alert, from: indexPath)
    }
    private func chooseTheme(from indexPath: IndexPath) {
        let alert = UIAlertController(title: "颜色模式", message: nil, preferredStyle: .actionSheet)
        for theme in AmbientPreferences.Theme.allCases {
            alert.addAction(UIAlertAction(title: theme.title, style: .default) { [weak self] _ in AmbientPreferences.shared.update { $0.theme = theme }; self?.tableView.reloadData() })
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        showActions(alert, from: indexPath)
    }
    private func showActions(_ alert: UIAlertController, from indexPath: IndexPath) {
        anchor(alert.popoverPresentationController, at: indexPath)
        present(alert, animated: true)
    }
    /// 选项框从被点击的那一行弹出（iOS 26 的 iPhone 与 iPad 以浮层呈现）。
    /// 锚定表格坐标中的行区域而不是单元格：本页随服务状态刷新列表，单元格会被替换，行区域不受影响。
    private func anchor(_ popover: UIPopoverPresentationController?, at indexPath: IndexPath) {
        popover?.sourceView = tableView
        popover?.sourceRect = tableView.rectForRow(at: indexPath)
        popover?.permittedArrowDirections = [.up, .down]
    }
    private func exportBackup(from indexPath: IndexPath) {
        perform { [weak self] in
            guard let self else { return }
            let backup = try await AmbientBackupManager.make(services: self.services)
            let data = try JSONEncoder().encode(backup)
            let url = FileManager.default.temporaryDirectory.appendingPathComponent("\(AmbientAppInfo.name)备份-\(UUID().uuidString).json")
            try data.write(to: url, options: .atomic)
            let share = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            self.anchor(share.popoverPresentationController, at: indexPath)
            share.completionWithItemsHandler = { _, _, _, _ in try? FileManager.default.removeItem(at: url) }
            self.present(share, animated: true)
        }
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        controller.dismiss(animated: true) { [weak self] in self?.reviewImport(url) }
    }
    private func reviewImport(_ url: URL) {
        perform { [weak self] in
            guard let self else { return }
            let allowed = url.startAccessingSecurityScopedResource()
            defer { if allowed { url.stopAccessingSecurityScopedResource() } }
            let size = try url.resourceValues(forKeys: [.fileSizeKey]).fileSize ?? 0
            guard size <= 25 * 1024 * 1024 else { throw AmbientProgressError.invalidBackup }
            let backup = try JSONDecoder().decode(AmbientWorkspaceBackup.self, from: Data(contentsOf: url))
            try backup.validate()
            try await self.services.pauseForDataOperation()
            self.importCandidate = backup
            let alert = UIAlertController(title: "恢复这份备份？", message: "包含 \(backup.progress.habits.count) 项习惯、\(backup.progress.rounds.count) 条专注记录和 \(backup.progress.balance) 滴水滴。\n将整体替换当前自律数据，恢复后保持暂停。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "取消", style: .cancel) { [weak self] _ in self?.importCandidate = nil })
            alert.addAction(UIAlertAction(title: "确认恢复", style: .destructive) { [weak self] _ in self?.restoreCandidate() })
            self.present(alert, animated: true)
        }
    }
    private func restoreCandidate() {
        guard let candidate = importCandidate else { return }
        importCandidate = nil
        perform { [weak self] in
            guard let self else { return }
            try await AmbientBackupManager.restore(candidate, services: self.services)
            AmbientStyle.message(on: self, title: "恢复完成", text: "数据已恢复，计时与声音保持暂停。")
        }
    }
    private func confirmClear() {
        let alert = UIAlertController(title: "清空自律数据？", message: "将删除专注记录、习惯、打卡、水滴和场景解锁，仅保留夜雨免费场景。此操作无法撤销，请先导出备份。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "清空", style: .destructive) { [weak self] _ in
            self?.perform { [weak self] in
                guard let self else { return }
                let empty = AmbientWorkspaceBackup(createdAt: Date(), progress: AmbientProgressPayload(), clock: AmbientFocusClock.Archive(), preferences: AmbientPreferences.shared.values)
                try await AmbientBackupManager.restore(empty, services: self.services)
            }
        })
        present(alert, animated: true)
    }
    private func perform(_ action: @escaping () async throws -> Void) {
        guard !isBusy else { return }
        isBusy = true
        tableView.reloadData()
        Task { [weak self] in
            guard let self else { return }
            defer { self.isBusy = false; self.services.finishDataOperation(); self.tableView.reloadData() }
            do { try await action() }
            catch { AmbientStyle.message(on: self, title: "暂时无法完成", text: error.localizedDescription) }
        }
    }
}
