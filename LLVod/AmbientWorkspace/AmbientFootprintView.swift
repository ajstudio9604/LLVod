import ImageIO
import UIKit

/// F3 热力方阵沿用中性文字色的四档强度，深色越亮、浅色越深表示专注越久。
/// 阈值和日期计算保持不变，图例与格子共用色阶，场景分类仍使用各自的颜色。
enum AmbientHeatScale {
    static let empty = AmbientStyle.text.withAlphaComponent(0.07)
    static let levels: [UIColor] = [
        AmbientStyle.text.withAlphaComponent(0.26),
        AmbientStyle.text.withAlphaComponent(0.46),
        AmbientStyle.text.withAlphaComponent(0.70),
        AmbientStyle.text
    ]
    /// 各档下限（分钟）：不足一轮、一轮、两轮、四轮番茄钟。
    static let thresholds = [1, 25, 50, 100]

    /// 0 表示未打卡，1 到 4 为打卡档位；按四舍五入后的分钟数分档，与详情文案保持一致。
    static func level(for seconds: TimeInterval) -> Int {
        guard seconds >= AmbientFootprint.activeThreshold else { return 0 }
        let minutes = Int((seconds / 60).rounded())
        return (thresholds.lastIndex { minutes >= $0 } ?? 0) + 1
    }

    static func color(forLevel level: Int) -> UIColor {
        level <= 0 ? empty : levels[min(level, levels.count) - 1]
    }
}

/// 场景陪伴分布的分类配色：颜色跟随场景本身而不是排名；分段条按这里的固定顺序排列，
/// 相邻色已在深色背景上通过明度、彩度、色觉差异与对比度校验，另有文字标注与段间缝隙，不单靠颜色辨认。
enum AmbientScenePalette {
    private static let entries: [(identifier: String, color: UIColor)] = [
        ("ambient_rain", UIColor(red: 57 / 255, green: 135 / 255, blue: 229 / 255, alpha: 1)),
        ("ambient_glow", UIColor(red: 217 / 255, green: 89 / 255, blue: 38 / 255, alpha: 1)),
        ("ambient_jungle", UIColor(red: 25 / 255, green: 158 / 255, blue: 112 / 255, alpha: 1)),
        ("ambient_ember", UIColor(red: 201 / 255, green: 133 / 255, blue: 0, alpha: 1)),
        ("ambient_night", UIColor(red: 144 / 255, green: 133 / 255, blue: 233 / 255, alpha: 1)),
        ("ambient_forest", UIColor(red: 0, green: 131 / 255, blue: 0, alpha: 1))
    ]
    /// 不在配色表中的场景（例如以后下线的场景）使用中性灰。
    private static let fallback = UIColor(white: 0.5, alpha: 1)

    static func color(for identifier: String) -> UIColor {
        entries.first { $0.identifier == identifier }?.color ?? fallback
    }

    /// 分段条中的固定位置，未知场景排在最后。
    static func rank(of identifier: String) -> Int {
        entries.firstIndex { $0.identifier == identifier } ?? entries.count
    }
}

/// 足迹页的时长、日期与占比文案，界面统一使用中文格式。
enum AmbientFootprintText {
    private static let locale = Locale(identifier: "zh_CN")

    /// 中文星期简称，下标 0 为周日；每周起始日仍跟随系统设置。
    static let weekdaySymbols: [String] = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = locale
        return calendar.veryShortStandaloneWeekdaySymbols
    }()

    private static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = "M月"
        return formatter
    }()

    private static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = "M月d日 EEE"
        return formatter
    }()

    private static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = "M月d日"
        return formatter
    }()

    static func month(_ date: Date) -> String { monthFormatter.string(from: date) }

    /// 今天、昨天直接称呼，其余显示为"9月3日 周三"。
    static func dayTitle(_ date: Date) -> String {
        let calendar = AmbientDayKey.calendar
        if calendar.isDateInToday(date) { return "今天" }
        if calendar.isDateInYesterday(date) { return "昨天" }
        return dayFormatter.string(from: date)
    }

    /// 记录的完成时刻，例如"今天 14:30""昨天 09:12""9月3日 21:05"。
    static func recordTime(_ date: Date) -> String {
        let calendar = AmbientDayKey.calendar
        let day: String
        if calendar.isDateInToday(date) {
            day = "今天"
        } else if calendar.isDateInYesterday(date) {
            day = "昨天"
        } else {
            day = shortDateFormatter.string(from: date)
        }
        return "\(day) \(AmbientClockText.string(from: date))"
    }

    /// 以分钟为最小单位的时长，例如"45 分钟""2 小时 5 分"。
    static func duration(_ seconds: TimeInterval) -> String {
        // 与打卡门槛一致：不足一分钟统一显示"不足 1 分钟"，避免文案写着 1 分钟而格子仍是未打卡。
        guard seconds >= AmbientFootprint.activeThreshold else { return seconds > 0 ? "不足 1 分钟" : "0 分钟" }
        let minutes = Int((seconds / 60).rounded())
        guard minutes >= 60 else { return "\(minutes) 分钟" }
        let rest = minutes % 60
        return rest == 0 ? "\(minutes / 60) 小时" : "\(minutes / 60) 小时 \(rest) 分"
    }

    /// 指标卡的时长：不足一小时显示分钟，否则显示保留一位小数的小时。
    static func total(_ seconds: TimeInterval) -> (value: String, unit: String) {
        // 与打卡门槛一致：不足一分钟记为 0，避免指标写着 1 分钟而今天的格子仍是未打卡。
        guard seconds >= AmbientFootprint.activeThreshold else { return ("0", "分钟") }
        let minutes = Int((seconds / 60).rounded())
        guard minutes >= 60 else { return ("\(minutes)", "分钟") }
        let hours = Double(minutes) / 60
        return (String(format: hours >= 100 ? "%.0f" : "%.1f", hours), "小时")
    }

    /// 选中日期的说明，同时作为热力图的无障碍朗读内容。
    static func daySummary(_ day: AmbientFootprint.Day) -> String {
        let title = dayTitle(day.date)
        guard day.focusSeconds > 0 else { return "\(title) · 没有专注记录" }
        let rounds = day.rounds > 0 ? " · 完成 \(day.rounds) 轮" : ""
        return "\(title) · 专注 \(duration(day.focusSeconds))\(rounds)"
    }

    /// 按最大余数法分配整数百分比，保证各项合计恰好为 100。
    static func percentages(_ values: [TimeInterval]) -> [Int] {
        let total = values.reduce(0, +)
        guard total > 0 else { return values.map { _ in 0 } }
        let exact = values.map { $0 / total * 100 }
        var result = exact.map { Int($0.rounded(.down)) }
        let order = exact.indices.sorted { (exact[$0] - Double(result[$0])) > (exact[$1] - Double(result[$1])) }
        var remainder = 100 - result.reduce(0, +)
        for index in order where remainder > 0 {
            result[index] += 1
            remainder -= 1
        }
        return result
    }
}

/// 近九十天打卡方阵：七行对应星期、十四列对应周，今天固定在最右列；一次绘制全部方块，不创建大量子视图。
final class AmbientHeatmapView: UIView {
    /// 用户点选或无障碍切换日期后回调，供详情行展示当日数据。
    var onSelect: ((AmbientFootprint.Day) -> Void)?
    /// 习惯历史使用相同色阶与日期布局，旁白改为完成状态。
    var isHabitHistory = false

    private struct Geometry {
        let origin: CGPoint
        let pitch: CGFloat
    }

    private let columns = 14
    private let rows = 7
    private let gap: CGFloat = 3
    private let maximumPitch: CGFloat = 28
    /// 选中框外扩到方块间空隙里，右侧与底部额外预留的空间，保证不被视图边界裁切。
    private let ringMargin: CGFloat = 1
    private let labelColor = AmbientStyle.text.withAlphaComponent(0.5)
    private let ringColor = AmbientStyle.text.withAlphaComponent(0.95)
    private let feedback = UISelectionFeedbackGenerator()
    /// 与生成日期键的日历保持一致，每次配置数据时更新。
    private var calendar = AmbientDayKey.calendar
    private var days: [AmbientFootprint.Day] = []
    /// 网格第一格到窗口第一天之间的空格数。
    private var leadingBlank = 0
    private var selectedIndex: Int?
    private var monthMarks: [(column: Int, text: String)] = []
    private var weekdayMarks: [(row: Int, text: String)] = []
    private var labelFont = UIFont.systemFont(ofSize: 10)
    /// 高度按宽度等比约束，放进自适应高度的表格单元格也能一次算准，不依赖首次布局后的回算。
    private var aspectHeight: NSLayoutConstraint?
    private var maximumHeight: NSLayoutConstraint?

    var selectedDay: AmbientFootprint.Day? {
        guard let selectedIndex, days.indices.contains(selectedIndex) else { return nil }
        return days[selectedIndex]
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isOpaque = false
        contentMode = .redraw
        // 整张方阵作为一个可调节元素，上下轻扫逐日朗读，等同于一份可访问的数据表。
        isAccessibilityElement = true
        accessibilityLabel = "近九十天专注热力图"
        accessibilityHint = "上下轻扫切换日期"
        accessibilityTraits = .adjustable
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        let aspect = heightAnchor.constraint(equalTo: widthAnchor, multiplier: CGFloat(rows) / CGFloat(columns))
        aspect.priority = UILayoutPriority(999)
        let maximum = heightAnchor.constraint(lessThanOrEqualToConstant: 0)
        NSLayoutConstraint.activate([aspect, maximum])
        aspectHeight = aspect
        maximumHeight = maximum
        buildWeekdayMarks()
        updateTypography()
    }

    required init?(coder: NSCoder) { nil }

    /// days 为时间升序、最后一项为今天；selectedKey 为空时选中今天；calendar 为生成这批日期键的日历。
    func configure(days: [AmbientFootprint.Day], selectedKey: String?, calendar: Calendar) {
        self.calendar = calendar
        self.days = days
        buildWeekdayMarks()
        updateHeightConstraints()
        guard let today = days.last else {
            selectedIndex = nil
            monthMarks = []
            updateAccessibility()
            setNeedsDisplay()
            return
        }
        // 今天所在行按每周起始日计算；窗口第一天之前的格子留空。
        let rowOfToday = (calendar.component(.weekday, from: today.date) - calendar.firstWeekday + 7) % 7
        leadingBlank = (columns - 1) * rows + rowOfToday - (days.count - 1)
        selectedIndex = selectedKey.flatMap { key in days.lastIndex { $0.key == key } } ?? days.count - 1
        buildMonthMarks()
        updateAccessibility()
        setNeedsDisplay()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            updateTypography()
        }
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        let geometry = geometry(for: bounds.width)
        guard geometry.pitch > gap else { return }
        let attributes: [NSAttributedString.Key: Any] = [.font: labelFont, .foregroundColor: labelColor]
        // 星期标签贴在方阵左侧，与所在行垂直居中。
        for mark in weekdayMarks {
            let text = mark.text as NSString
            let size = text.size(withAttributes: attributes)
            let y = geometry.origin.y + CGFloat(mark.row) * geometry.pitch + (geometry.pitch - size.height) / 2
            text.draw(at: CGPoint(x: geometry.origin.x - 6 - size.width, y: y), withAttributes: attributes)
        }
        // 月份标签位于方阵上方，与所在列左对齐；靠近右边缘时向左收回，大字号下也不会被裁切。
        for mark in monthMarks {
            let text = mark.text as NSString
            let width = ceil(text.size(withAttributes: attributes).width)
            let x = min(geometry.origin.x + CGFloat(mark.column) * geometry.pitch + gap / 2, bounds.width - width)
            text.draw(at: CGPoint(x: max(0, x), y: 0), withAttributes: attributes)
        }
        for column in 0..<columns {
            for row in 0..<rows {
                let index = column * rows + row - leadingBlank
                guard days.indices.contains(index) else { continue }
                let frame = cellFrame(column: column, row: row, geometry: geometry)
                AmbientHeatScale.color(forLevel: AmbientHeatScale.level(for: days[index].focusSeconds)).setFill()
                UIBezierPath(roundedRect: frame, cornerRadius: min(4, frame.width / 4)).fill()
            }
        }
        // 选中框画在方块之间的空隙里，与方块留出细缝，最亮一档也能分辨。
        if let selectedIndex, days.indices.contains(selectedIndex) {
            let gridIndex = selectedIndex + leadingBlank
            let frame = cellFrame(column: gridIndex / rows, row: gridIndex % rows, geometry: geometry)
                .insetBy(dx: -1.25, dy: -1.25)
            let ring = UIBezierPath(roundedRect: frame, cornerRadius: min(5, frame.width / 4))
            ring.lineWidth = 1.5
            ringColor.setStroke()
            ring.stroke()
        }
    }

    override func accessibilityIncrement() { moveSelection(by: 1) }
    override func accessibilityDecrement() { moveSelection(by: -1) }

    /// 旁白双击不合成轻点，避免把选中日期跳到方阵中心那一天；切换日期只通过上下轻扫。
    override func accessibilityActivate() -> Bool { true }

    private var weekdayGutter: CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: labelFont]
        let widest = weekdayMarks.map { ($0.text as NSString).size(withAttributes: attributes).width }.max() ?? 0
        return ceil(widest) + 6
    }

    private var monthGutter: CGFloat { ceil(labelFont.lineHeight) + 4 }

    private func geometry(for width: CGFloat) -> Geometry {
        let gutter = weekdayGutter
        let available = max(0, width - gutter - ringMargin)
        let pitch = min(maximumPitch, floor(available / CGFloat(columns)))
        // 宽屏时限制方块尺寸并整体居中，避免方阵被拉得过大。
        let x = gutter + max(0, (available - pitch * CGFloat(columns)) / 2)
        return Geometry(origin: CGPoint(x: x, y: monthGutter), pitch: pitch)
    }

    /// 高度 = 月份标签 + 七行方块 + 底部余量；方块边长约为可用宽度的十四分之一，宽屏时按最大边长封顶。
    private func updateHeightConstraints() {
        let ratio = CGFloat(rows) / CGFloat(columns)
        aspectHeight?.constant = monthGutter + ringMargin - ratio * (weekdayGutter + ringMargin)
        maximumHeight?.constant = monthGutter + CGFloat(rows) * maximumPitch + ringMargin
    }

    private func cellFrame(column: Int, row: Int, geometry: Geometry) -> CGRect {
        CGRect(x: geometry.origin.x + CGFloat(column) * geometry.pitch + gap / 2,
               y: geometry.origin.y + CGFloat(row) * geometry.pitch + gap / 2,
               width: geometry.pitch - gap, height: geometry.pitch - gap)
    }

    private func buildWeekdayMarks() {
        // 隔行标注星期，方阵左侧保持安静。
        weekdayMarks = [0, 2, 4, 6].map { row in
            (row, AmbientFootprintText.weekdaySymbols[(calendar.firstWeekday - 1 + row) % 7])
        }
    }

    private func buildMonthMarks() {
        var marks: [(column: Int, text: String)] = []
        var firstVisible: (column: Int, text: String)?
        for (index, day) in days.enumerated() {
            let gridIndex = index + leadingBlank
            guard gridIndex >= 0 else { continue }
            let column = gridIndex / rows
            if firstVisible == nil { firstVisible = (column, AmbientFootprintText.month(day.date)) }
            if calendar.component(.day, from: day.date) == 1 {
                marks.append((column, AmbientFootprintText.month(day.date)))
            }
        }
        // 窗口起点所在月份也标注，但离下一个月份太近时省略，避免文字重叠。
        if let firstVisible, marks.first.map({ $0.column - firstVisible.column >= 2 }) ?? true {
            marks.insert(firstVisible, at: 0)
        }
        monthMarks = marks
    }

    private func updateTypography() {
        labelFont = UIFontMetrics(forTextStyle: .caption2).scaledFont(for: .systemFont(ofSize: 10),
                                                                     maximumPointSize: 13,
                                                                     compatibleWith: traitCollection)
        updateHeightConstraints()
        setNeedsDisplay()
    }

    @objc private func handleTap(_ recognizer: UITapGestureRecognizer) {
        let geometry = geometry(for: bounds.width)
        guard geometry.pitch > 0 else { return }
        let point = recognizer.location(in: self)
        let column = Int(floor((point.x - geometry.origin.x) / geometry.pitch))
        let row = Int(floor((point.y - geometry.origin.y) / geometry.pitch))
        guard (0..<columns).contains(column), (0..<rows).contains(row) else { return }
        select(index: column * rows + row - leadingBlank)
    }

    private func moveSelection(by delta: Int) {
        guard let selectedIndex else { return }
        select(index: min(max(0, selectedIndex + delta), days.count - 1))
    }

    private func select(index: Int) {
        guard days.indices.contains(index), index != selectedIndex else { return }
        selectedIndex = index
        feedback.selectionChanged()
        updateAccessibility()
        setNeedsDisplay()
        onSelect?(days[index])
    }

    private func updateAccessibility() {
        accessibilityLabel = isHabitHistory ? "近九十天习惯热力图" : "近九十天专注热力图"
        accessibilityValue = isHabitHistory
            ? selectedDay.map { $0.key + ($0.isActive ? "，已完成" : "，未完成") }
            : selectedDay.map(AmbientFootprintText.daySummary)
    }
}

/// 色阶图例：从"少"到"多"的五个小方块。
final class AmbientHeatLegendView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let cream = AmbientStyle.text
        let less = AmbientStyle.label("少", size: 11)
        let more = AmbientStyle.label("多", size: 11)
        for label in [less, more] {
            label.textColor = cream.withAlphaComponent(0.5)
            label.numberOfLines = 1
        }
        let stack = UIStackView(arrangedSubviews: [less])
        stack.alignment = .center
        stack.spacing = 3
        stack.setCustomSpacing(6, after: less)
        for level in 0...AmbientHeatScale.levels.count {
            let swatch = UIView()
            swatch.backgroundColor = AmbientHeatScale.color(forLevel: level)
            swatch.layer.cornerRadius = 2.5
            swatch.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                swatch.widthAnchor.constraint(equalToConstant: 11),
                swatch.heightAnchor.constraint(equalToConstant: 11)
            ])
            stack.addArrangedSubview(swatch)
        }
        if let last = stack.arrangedSubviews.last { stack.setCustomSpacing(6, after: last) }
        stack.addArrangedSubview(more)
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        isAccessibilityElement = true
        accessibilityLabel = "色阶说明"
        accessibilityValue = "颜色越亮当天专注越久，分为未打卡、不足 25 分钟、25 分钟起、50 分钟起、100 分钟起五档"
    }

    required init?(coder: NSCoder) { nil }
}

/// F3 顶部核心指标以左对齐的文字排版呈现，不增加卡片或数字光晕。
final class AmbientMetricView: UIView {
    private let cream = AmbientStyle.text
    private let titleLabel: UILabel
    private let valueLabel = UILabel()
    private let captionLabel: UILabel
    private var content: (value: String, unit: String, caption: String?) = ("0", "", nil)

    init(title: String) {
        titleLabel = AmbientStyle.label(title, size: 12)
        captionLabel = AmbientStyle.label("", size: 11)
        super.init(frame: .zero)
        titleLabel.textColor = cream.withAlphaComponent(0.6)
        titleLabel.textAlignment = .left
        // 小字号说明的透明度不低于 0.55，保证在深色背景上的对比度达到 4.5:1。
        captionLabel.textColor = cream.withAlphaComponent(0.55)
        captionLabel.textAlignment = .left
        valueLabel.numberOfLines = 1
        valueLabel.textAlignment = .left
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.5
        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel, captionLabel])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        isAccessibilityElement = true
        accessibilityLabel = title
        render()
    }

    required init?(coder: NSCoder) { nil }

    func update(value: String, unit: String, caption: String?) {
        content = (value, unit, caption)
        render()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            render()
        }
    }

    private func render() {
        // 常规字重的大数字配小号单位，突出读数；使用比例数字，不做等宽。
        let valueFont = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(
            for: .systemFont(ofSize: 32, weight: .regular), maximumPointSize: 44, compatibleWith: traitCollection)
        let unitFont = UIFontMetrics.default.scaledFont(
            for: .systemFont(ofSize: 12), maximumPointSize: 18, compatibleWith: traitCollection)
        let text = NSMutableAttributedString(string: content.value,
                                             attributes: [.font: valueFont, .foregroundColor: cream])
        text.append(NSAttributedString(string: " " + content.unit,
                                       attributes: [.font: unitFont, .foregroundColor: cream.withAlphaComponent(0.7)]))
        valueLabel.attributedText = text
        captionLabel.text = content.caption
        captionLabel.isHidden = content.caption == nil
        accessibilityValue = content.value + content.unit + (content.caption.map { "，" + $0 } ?? "")
    }
}

/// 场景陪伴分布：一条按固定顺序排列的分段色条，下方按占比从高到低列出场景、占比与时长。
final class AmbientSceneDistributionView: UIView {
    private let cream = AmbientStyle.text
    private let bar = AmbientSegmentedBarView()
    private let rows = UIStackView()
    private let emptyLabel = AmbientStyle.label("开启环境音或全屏播放后，这里会显示各场景的陪伴比例。", size: 13)
    /// 图例行按场景复用；场景集合与排序不变时原地更新，每分钟刷新不会打断旁白焦点。
    private var rowViews: [String: AmbientSceneLegendRow] = [:]
    private var renderedOrder: [String] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        let title = AmbientStyle.label("场景陪伴", size: 17, weight: .medium)
        title.textColor = cream
        title.accessibilityTraits = .header
        let caption = AmbientStyle.label("近 90 天环境音与全屏播放的陪伴时长", size: 12)
        caption.textColor = cream.withAlphaComponent(0.55)
        emptyLabel.textColor = cream.withAlphaComponent(0.6)
        rows.axis = .vertical
        rows.spacing = 12
        let stack = UIStackView(arrangedSubviews: [title, caption, bar, rows, emptyLabel])
        stack.axis = .vertical
        stack.spacing = 6
        stack.setCustomSpacing(16, after: caption)
        stack.setCustomSpacing(18, after: bar)
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            bar.heightAnchor.constraint(equalToConstant: 10)
        ])
    }

    required init?(coder: NSCoder) { nil }

    /// scenes 按陪伴时长降序；分段条改用固定顺序，颜色跟随场景，不随排名变化。
    func configure(_ scenes: [AmbientFootprint.SceneShare]) {
        let total = scenes.reduce(0) { $0 + $1.seconds }
        bar.isHidden = scenes.isEmpty
        rows.isHidden = scenes.isEmpty
        emptyLabel.isHidden = !scenes.isEmpty
        bar.segments = scenes
            .sorted { AmbientScenePalette.rank(of: $0.identifier) < AmbientScenePalette.rank(of: $1.identifier) }
            .map { (fraction: total > 0 ? CGFloat($0.seconds / total) : 0,
                    color: AmbientScenePalette.color(for: $0.identifier)) }
        let order = scenes.map(\.identifier)
        if order != renderedOrder {
            rows.arrangedSubviews.forEach { $0.removeFromSuperview() }
            for identifier in order {
                let row = rowViews[identifier] ?? AmbientSceneLegendRow(identifier: identifier)
                rowViews[identifier] = row
                rows.addArrangedSubview(row)
            }
            renderedOrder = order
        }
        let percents = AmbientFootprintText.percentages(scenes.map(\.seconds))
        for (index, share) in scenes.enumerated() {
            rowViews[share.identifier]?.update(percent: percents[index], seconds: share.seconds)
        }
    }
}

/// 场景分布图例的一行：色点、场景名、占比与陪伴时长；文字使用正文颜色，身份由旁边的色点承担。
private final class AmbientSceneLegendRow: UIView {
    private let cream = AmbientStyle.text
    private let titles = UIStackView()
    private let valueLabel = AmbientStyle.label("", size: 13)
    private let title: String

    init(identifier: String) {
        title = AmbientScene.collection.first { $0.identifier == identifier }?.title ?? "其他场景"
        super.init(frame: .zero)
        let swatch = UIView()
        swatch.backgroundColor = AmbientScenePalette.color(for: identifier)
        swatch.layer.cornerRadius = 5
        swatch.translatesAutoresizingMaskIntoConstraints = false
        let name = AmbientStyle.label(title, size: 15)
        name.textColor = cream
        valueLabel.textColor = cream.withAlphaComponent(0.65)
        valueLabel.setContentHuggingPriority(.required, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titles.addArrangedSubview(name)
        titles.addArrangedSubview(valueLabel)
        titles.spacing = 8
        let row = UIStackView(arrangedSubviews: [swatch, titles])
        row.alignment = .center
        row.spacing = 10
        row.translatesAutoresizingMaskIntoConstraints = false
        addSubview(row)
        NSLayoutConstraint.activate([
            row.leadingAnchor.constraint(equalTo: leadingAnchor),
            row.trailingAnchor.constraint(equalTo: trailingAnchor),
            row.topAnchor.constraint(equalTo: topAnchor),
            row.bottomAnchor.constraint(equalTo: bottomAnchor),
            swatch.widthAnchor.constraint(equalToConstant: 10),
            swatch.heightAnchor.constraint(equalToConstant: 10)
        ])
        updateTitlesLayout()
        isAccessibilityElement = true
        accessibilityLabel = title
    }

    required init?(coder: NSCoder) { nil }

    func update(percent: Int, seconds: TimeInterval) {
        let percentText = percent > 0 ? "\(percent)%" : "不足 1%"
        let duration = AmbientFootprintText.duration(seconds)
        valueLabel.text = "\(percentText) · \(duration)"
        accessibilityValue = "占比\(percentText)，陪伴\(duration)"
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateTitlesLayout()
    }

    private func updateTitlesLayout() {
        // 辅助字号下名称与数值上下排列，避免名称被挤成竖排。
        let stacked = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        titles.axis = stacked ? .vertical : .horizontal
        titles.alignment = stacked ? .leading : .firstBaseline
    }
}

/// 分段色条：各段按占比铺满整条，段与段之间留两点背景缝隙，相邻颜色接近时也能区分。
private final class AmbientSegmentedBarView: UIView {
    var segments: [(fraction: CGFloat, color: UIColor)] = [] { didSet { setNeedsDisplay() } }
    private let track = AmbientStyle.text.withAlphaComponent(0.08)
    private let gap: CGFloat = 2

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isOpaque = false
        contentMode = .redraw
        // 占比已由下方图例逐行朗读，色条本身不重复播报。
        isAccessibilityElement = false
    }

    required init?(coder: NSCoder) { nil }

    override func draw(_ rect: CGRect) {
        UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2).addClip()
        track.setFill()
        UIRectFill(bounds)
        let visible = segments.filter { $0.fraction > 0 }
        guard !visible.isEmpty else { return }
        let usable = max(0, bounds.width - gap * CGFloat(visible.count - 1))
        // 占比极小的场景至少保留两点宽度，多出的宽度从最宽的一段扣回，总宽不变，末尾的段不会被截掉。
        var widths = visible.map { max(2, usable * $0.fraction) }
        let overflow = widths.reduce(0, +) - usable
        if overflow > 0, let widest = widths.indices.max(by: { widths[$0] < widths[$1] }) {
            widths[widest] = max(2, widths[widest] - overflow)
        }
        var x: CGFloat = 0
        for (segment, width) in zip(visible, widths) {
            segment.color.setFill()
            UIRectFill(CGRect(x: x, y: 0, width: width, height: bounds.height))
            x += width + gap
        }
    }
}

/// 足迹页概览区的单元格：承载指标、热力图或场景分布等自定义视图，不参与选中，也不支持左滑。
final class AmbientFootprintHostCell: UITableViewCell {
    init(content: UIView, top: CGFloat = 12, bottom: CGFloat = 12) {
        super.init(style: .default, reuseIdentifier: nil)
        backgroundColor = .clear
        selectionStyle = .none
        // 平面概览仅以细线分组，装饰线不参与内容高度的计算。
        let divider = UIView()
        divider.backgroundColor = AmbientStyle.hairline
        divider.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(divider)
        content.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(content)
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            content.topAnchor.constraint(equalTo: contentView.topAnchor, constant: top),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -bottom),
            divider.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

    required init?(coder: NSCoder) { nil }
}

/// 近期专注记录的一行：场景封面、场景名、完成时刻与专注时长；左滑可删除。
final class AmbientFocusRecordCell: UITableViewCell {
    static let reuseIdentifier = "AmbientFocusRecordCell"
    private let cream = AmbientStyle.text
    private let artwork = UIImageView()
    private let titleLabel = AmbientStyle.label("", size: 15)
    private let timeLabel = AmbientStyle.label("", size: 12)
    private let durationLabel = AmbientStyle.label("", size: 14)
    private let divider = UIView()
    private let row = UIStackView()
    /// 当前展示的场景；异步取回的封面只在单元格仍展示同一场景时才使用，避免复用后错图。
    private var displayedScene: String?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        artwork.contentMode = .scaleAspectFill
        artwork.clipsToBounds = true
        artwork.layer.cornerRadius = 8
        artwork.layer.cornerCurve = .circular
        artwork.backgroundColor = cream.withAlphaComponent(0.08)
        artwork.tintColor = cream.withAlphaComponent(0.7)
        titleLabel.textColor = cream
        titleLabel.numberOfLines = 1
        timeLabel.textColor = cream.withAlphaComponent(0.55)
        timeLabel.numberOfLines = 1
        durationLabel.textColor = cream.withAlphaComponent(0.85)
        durationLabel.numberOfLines = 1
        durationLabel.setContentHuggingPriority(.required, for: .horizontal)
        durationLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        divider.backgroundColor = cream.withAlphaComponent(0.06)
        let texts = UIStackView(arrangedSubviews: [titleLabel, timeLabel])
        texts.axis = .vertical
        texts.spacing = 3
        for item in [artwork, texts, durationLabel] { row.addArrangedSubview(item) }
        row.spacing = 12
        for item in [row, divider] {
            item.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(item)
        }
        NSLayoutConstraint.activate([
            row.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            row.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            row.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            row.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            artwork.widthAnchor.constraint(equalToConstant: 42),
            artwork.heightAnchor.constraint(equalToConstant: 42),
            divider.leadingAnchor.constraint(equalTo: texts.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
        isAccessibilityElement = true
        updateLayoutForContentSize()
    }

    required init?(coder: NSCoder) { nil }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            updateLayoutForContentSize()
        }
    }

    /// 辅助字号下封面、文字、时长纵向排列，场景名与时刻允许换行，不被时长挤到截断。
    private func updateLayoutForContentSize() {
        let stacked = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        row.axis = stacked ? .vertical : .horizontal
        // 纵排用 .leading 而非 .fill，避免与封面的固定宽度约束冲突。
        row.alignment = stacked ? .leading : .center
        titleLabel.numberOfLines = stacked ? 0 : 1
        timeLabel.numberOfLines = stacked ? 0 : 1
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        displayedScene = nil
        artwork.image = nil
    }

    func configure(_ record: AmbientFootprint.Record) {
        let scene = AmbientScene.collection.first { $0.identifier == record.sceneIdentifier }
        let title = scene?.title ?? "专注"
        let time = AmbientFootprintText.recordTime(record.completedAt)
        let duration = AmbientFootprintText.duration(record.seconds)
        titleLabel.text = record.goal?.isEmpty == false ? record.goal : title
        timeLabel.text = time
        durationLabel.text = duration
        accessibilityLabel = "\(titleLabel.text ?? title)，\(time)，专注 \(duration)"
        displayedScene = scene?.identifier
        if let scene {
            artwork.contentMode = .scaleAspectFill
            artwork.image = nil
            AmbientSceneArtwork.thumbnail(for: scene) { [weak self] image in
                guard let self, self.displayedScene == scene.identifier else { return }
                self.artwork.image = image
            }
        } else {
            // 旧版本记录没有场景信息，使用通用计时图标。
            artwork.contentMode = .center
            artwork.image = UIImage(systemName: "timer",
                                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .light))
        }
    }
}

/// 足迹页的单行提示，例如还没有专注记录时的空态说明。
final class AmbientFootprintMessageCell: UITableViewCell {
    static let reuseIdentifier = "AmbientFootprintMessageCell"
    private let messageLabel = AmbientStyle.label("", size: 13)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        messageLabel.textColor = AmbientStyle.text.withAlphaComponent(0.6)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ])
    }

    required init?(coder: NSCoder) { nil }

    func configure(_ message: String) { messageLabel.text = message }
}

/// 场景封面缩略图：在后台按显示尺寸降采样并缓存，不在主线程解码整张封面。
enum AmbientSceneArtwork {
    private static let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        // 背景比列表封面更大，限制总成本，避免浏览全部场景后长期占用内存。
        cache.totalCostLimit = 24 * 1024 * 1024
        return cache
    }()
    private static let queue = DispatchQueue(label: "com.workspace.focus.artwork", qos: .userInitiated)

    static func thumbnail(for scene: AmbientScene, completion: @escaping (UIImage?) -> Void) {
        image(for: scene, maxPixelSize: 240, completion: completion)
    }

    /// 背景与列表使用不同缓存键，避免把列表的小缩略图放大成模糊的页眉。
    static func backdrop(for scene: AmbientScene, completion: @escaping (UIImage?) -> Void) {
        image(for: scene, maxPixelSize: 1280, completion: completion)
    }

    private static func image(for scene: AmbientScene, maxPixelSize: Int, completion: @escaping (UIImage?) -> Void) {
        let key = "\(scene.identifier)-\(maxPixelSize)" as NSString
        if let cached = cache.object(forKey: key) {
            completion(cached)
            return
        }
        guard let url = scene.resource("jpg") else {
            completion(nil)
            return
        }
        queue.async {
            // 在后台按用途降采样，封面解码不阻塞滚动与场景切换。
            let options: [CFString: Any] = [
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceShouldCacheImmediately: true,
                kCGImageSourceThumbnailMaxPixelSize: maxPixelSize
            ]
            let image = CGImageSourceCreateWithURL(url as CFURL, nil)
                .flatMap { CGImageSourceCreateThumbnailAtIndex($0, 0, options as CFDictionary) }
                .map { UIImage(cgImage: $0) }
            DispatchQueue.main.async {
                if let image { cache.setObject(image, forKey: key, cost: maxPixelSize * maxPixelSize * 4) }
                completion(image)
            }
        }
    }
}
