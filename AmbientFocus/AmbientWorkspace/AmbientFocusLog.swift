import Foundation

/// 一轮专注的累计记录；跨午夜时 days 会包含多个日期键。
/// 同一轮的时长只增不减，写入时逐日取较大值、完成标记以先到者为准，重复或乱序写入都不会重复计数。
struct AmbientFocusRound: Codable, Sendable, Equatable {
    let id: UUID
    var days: [String: TimeInterval]
    var completedAt: Date?
    var completedDay: String?
    /// 完成时所在的场景标识；旧版本记录没有这个字段，按未记录处理。
    var sceneIdentifier: String?
    /// 本轮目标快照与可选习惯关联，旧记录缺失时保持为空。
    var goal: String? = nil
    var habitID: UUID? = nil
    /// 本轮开始时按习惯设定快照的目标时长（秒）；旧记录缺失时按 25 分钟处理。
    var targetSeconds: TimeInterval? = nil

    /// 旧版本固定的一轮时长，用于没有目标快照的历史记录。
    static let legacyTargetSeconds: TimeInterval = 1500
    /// 每满这么多秒发放一滴水。
    static let secondsPerDrop: TimeInterval = 300
    /// 单轮水滴上限，对应 99 分钟的最长习惯时长。
    static let maxReward = 19

    /// 该轮在所有日期上的专注总时长。
    var totalSeconds: TimeInterval { days.values.reduce(0, +) }
    var isCompleted: Bool { completedAt != nil }
    /// 本轮的目标时长，旧记录回退到 25 分钟。
    var resolvedTargetSeconds: TimeInterval { targetSeconds ?? Self.legacyTargetSeconds }
    /// 是否完整走完目标时长；允许 1 秒的结算误差。
    var isFullyCompleted: Bool { isCompleted && totalSeconds >= resolvedTargetSeconds - 1 }
    /// 完整走完时按每 5 分钟 1 滴发放，不足 5 分钟按 0 计；未走完不发放。
    var rewardAmount: Int { isFullyCompleted ? min(Self.maxReward, Int(totalSeconds / Self.secondsPerDrop)) : 0 }

    /// 合并同一轮的两份快照，结果与写入先后无关。
    func merged(with other: AmbientFocusRound) -> AmbientFocusRound {
        var result = self
        for (day, seconds) in other.days {
            result.days[day] = max(result.days[day] ?? 0, seconds)
        }
        if result.completedAt == nil, other.completedAt != nil {
            // 完成信息整体以完成那次写入为准，场景也取完成时所在的场景。
            result.completedAt = other.completedAt
            result.completedDay = other.completedDay
            result.sceneIdentifier = other.sceneIdentifier ?? result.sceneIdentifier
        } else if result.sceneIdentifier == nil {
            result.sceneIdentifier = other.sceneIdentifier
        }
        result.goal = other.goal ?? result.goal
        result.habitID = other.habitID ?? result.habitID
        result.targetSeconds = other.targetSeconds ?? result.targetSeconds
        return result
    }
}

/// 本地时区下的日期键与跨零点拆分。
enum AmbientDayKey {
    /// 严格解析日期键，不把非法日期自动滚动到下个月。
    static func date(_ key: String) -> Date? {
        let parts = key.split(separator: "-").compactMap { Int($0) }
        guard parts.count == 3, (1900...9999).contains(parts[0]),
              let date = calendar.date(from: DateComponents(year: parts[0], month: parts[1], day: parts[2])),
              self.key(date) == key else { return nil }
        return date
    }

    /// 日期键固定使用公历与当前时区，用户切换日历类型不会改变已记录的键；每周起始日跟随系统设置。
    static var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        calendar.firstWeekday = Calendar.current.firstWeekday
        return calendar
    }

    /// 统一使用零填充的 yyyy-MM-dd，字典序与日期序一致，便于比较和清理。
    static func key(_ date: Date, calendar: Calendar = AmbientDayKey.calendar) -> String {
        let parts = calendar.dateComponents([.year, .month, .day], from: date)
        return String(format: "%04d-%02d-%02d", parts.year ?? 0, parts.month ?? 0, parts.day ?? 0)
    }

    /// 把 [from, to) 按本地零点拆成若干天，返回每天累计的秒数。
    static func split(from: Date, to: Date, calendar: Calendar = AmbientDayKey.calendar) -> [String: TimeInterval] {
        guard to > from else { return [:] }
        var result: [String: TimeInterval] = [:]
        var cursor = from
        // 按系统给出的当天区间推进：零点切换夏令时的日子当天从 01:00 开始，次日零点仍然准确；
        // 日期计算异常时直接收尾，不会死循环。
        while cursor < to {
            let day = calendar.dateInterval(of: .day, for: cursor)
            let dayEnd = day?.end ?? to
            let segmentEnd = dayEnd > cursor ? min(dayEnd, to) : to
            result[key(day?.start ?? cursor, calendar: calendar), default: 0] += segmentEnd.timeIntervalSince(cursor)
            cursor = segmentEnd
        }
        return result
    }
}

/// 界面上的时刻文本：符号固定为中文，12/24 小时制每次按系统设置实时判断，运行中切换系统设置也能立即跟随。
enum AmbientClockText {
    private static let twelveHour = makeFormatter("ah:mm")
    private static let twentyFourHour = makeFormatter("HH:mm")

    /// 系统当前是否使用 12 小时制。工程只有英文本地化，Locale.current 的符号会是 AM/PM，这里只借系统区域判断时制。
    static var usesTwelveHour: Bool {
        DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: .autoupdatingCurrent)?.contains("a") == true
    }

    static func string(from date: Date) -> String {
        (usesTwelveHour ? twelveHour : twentyFourHour).string(from: date)
    }

    private static func makeFormatter(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = format
        return formatter
    }
}

/// 足迹页渲染用的聚合快照，全部由本地记录即时计算。
struct AmbientFootprint: Sendable, Equatable {
    /// 单日专注满一分钟才算打卡，过滤误触产生的零碎时长。
    static let activeThreshold: TimeInterval = 60

    struct Day: Sendable, Equatable {
        let date: Date
        let key: String
        let focusSeconds: TimeInterval
        let rounds: Int

        var isActive: Bool { focusSeconds >= AmbientFootprint.activeThreshold }
    }

    struct SceneShare: Sendable, Equatable {
        let identifier: String
        let seconds: TimeInterval
    }

    /// 一条已完成的专注记录，供近期记录列表展示与删除。
    struct Record: Sendable, Equatable {
        let id: UUID
        let sceneIdentifier: String?
        let completedAt: Date
        let seconds: TimeInterval
        var goal: String? = nil
    }

    /// 时间升序，最后一项为今天。
    let days: [Day]
    /// 统计窗口内的打卡天数。
    let activeDays: Int
    /// 今天的专注时长。
    let todaySeconds: TimeInterval
    /// 保留期内（最多四百天）的累计专注时长。
    let allTimeSeconds: TimeInterval
    /// 保留期内完成的轮数。
    let completedRounds: Int
    /// 截至今天的连续打卡天数；今天尚未打卡时截至昨天，不提前打断连续。
    let currentStreak: Int
    /// 全部保留记录中的最长连续打卡天数。
    let longestStreak: Int
    /// 统计窗口内的场景陪伴时长，按时长降序。
    let scenes: [SceneShare]
    /// 最近完成的专注记录，按完成时间倒序。
    let records: [Record]
    /// 生成日期键所用的日历；热力图按它排列星期，系统时区变化后也不会错位。
    let calendar: Calendar
}

/// 兼容原有足迹接口，从事务存储读取后复用日期聚合与统计。
actor AmbientFocusLog {
    static let shared = AmbientFocusLog()
    /// 记录写入后在主队列发出，供界面刷新。
    static let didChangeNotification = Notification.Name("com.workspace.focus.log.didChange")
    /// 足迹统计窗口：含今天在内的近九十天。
    static let windowDays = 90
    /// 近期记录列表最多展示的条数。
    static let recentRecordLimit = 20
    private static let retainedDays = 400
    private static let fileVersion = 1

    private struct Payload: Codable {
        var version: Int
        var rounds: [String: AmbientFocusRound]
        var scenes: [String: [String: TimeInterval]]
    }

    private var payload = Payload(version: AmbientFocusLog.fileVersion, rounds: [:], scenes: [:])

    /// 专注记录目录 Application Support/AmbientWorkspace 下的文件地址；目录排除 iCloud 与电脑备份，记录只留在本机。
    static func storageURL(for fileName: String) -> URL? {
        let manager = FileManager.default
        guard let support = try? manager.url(for: .applicationSupportDirectory, in: .userDomainMask,
                                             appropriateFor: nil, create: true) else { return nil }
        var directory = support.appendingPathComponent("AmbientWorkspace", isDirectory: true)
        do {
            try manager.createDirectory(at: directory, withIntermediateDirectories: true)
            var values = URLResourceValues()
            values.isExcludedFromBackup = true
            try directory.setResourceValues(values)
        } catch {
            // 目录已存在或属性设置失败都不阻断写入。
        }
        return directory.appendingPathComponent(fileName)
    }

    /// 兼容既有调用，实际写入统一交给进度事务。
    func upsert(_ round: AmbientFocusRound) async {
        do { try await AmbientProgressStore.shared.completeFocusRound(round) }
        catch { postFailure() }
    }

    func deleteRound(id: UUID) async {
        do { try await AmbientProgressStore.shared.deleteRound(id) }
        catch { postFailure() }
    }

    func addCompanion(scene identifier: String, seconds daySeconds: [String: TimeInterval]) async {
        do { try await AmbientProgressStore.shared.addCompanion(scene: identifier, seconds: daySeconds) }
        catch { postFailure() }
    }

    private func postFailure() {
        Task { @MainActor in
            NotificationCenter.default.post(name: Notification.Name("com.workspace.storage.failed"), object: nil)
        }
    }

    /// 汇总热力、指标、场景占比与近期记录。
    func footprint(days: Int = AmbientFocusLog.windowDays, now: Date = Date(),
                   calendar: Calendar = AmbientDayKey.calendar) async -> AmbientFootprint {
        do {
            let stored = try await AmbientProgressStore.shared.snapshot()
            payload.rounds = stored.rounds
            payload.scenes = stored.scenes
        } catch { postFailure() }
        let today = calendar.startOfDay(for: now)

        // 每天的专注时长与完成轮数；未完成且不足一分钟的轮视为误触，不计入。
        var focusByDay: [String: TimeInterval] = [:]
        var roundsByDay: [String: Int] = [:]
        var completedRounds = 0
        var records: [AmbientFootprint.Record] = []
        for round in payload.rounds.values {
            if !round.isCompleted && round.totalSeconds < AmbientFootprint.activeThreshold { continue }
            for (day, seconds) in round.days { focusByDay[day, default: 0] += seconds }
            if let day = round.completedDay { roundsByDay[day, default: 0] += 1 }
            if let completedAt = round.completedAt {
                completedRounds += 1
                records.append(.init(id: round.id, sceneIdentifier: round.sceneIdentifier,
                                     completedAt: completedAt, seconds: round.totalSeconds, goal: round.goal))
            }
        }
        records.sort { $0.completedAt > $1.completedAt }

        // 窗口内每天一项，时间升序，最后一项为今天。
        var resultDays: [AmbientFootprint.Day] = []
        for offset in stride(from: max(1, days) - 1, through: 0, by: -1) {
            guard let date = calendar.date(byAdding: .day, value: -offset, to: today) else { continue }
            let key = AmbientDayKey.key(date, calendar: calendar)
            resultDays.append(.init(date: date, key: key, focusSeconds: focusByDay[key] ?? 0,
                                    rounds: roundsByDay[key] ?? 0))
        }

        // 在全部保留期内逐日扫描连续打卡。每一天都从今天按偏移直接推算，
        // 夏令时切换日即使落在 01:00 也不会让后续日期漂移；扫描到今天之前的连续值用于今天尚未打卡的情况。
        let activeKeys = Set(focusByDay.filter { $0.value >= AmbientFootprint.activeThreshold }.keys)
        var longest = 0
        var running = 0
        var runningBeforeToday = 0
        for offset in stride(from: Self.retainedDays, through: 0, by: -1) {
            guard let date = calendar.date(byAdding: .day, value: -offset, to: today) else { continue }
            if offset == 0 { runningBeforeToday = running }
            running = activeKeys.contains(AmbientDayKey.key(date, calendar: calendar)) ? running + 1 : 0
            longest = max(longest, running)
        }
        let todayActive = resultDays.last?.isActive ?? false
        let current = todayActive ? running : runningBeforeToday

        // 场景占比与热力图使用同一个统计窗口。
        let windowKeys = Set(resultDays.map(\.key))
        var sceneTotals: [String: TimeInterval] = [:]
        for (day, sceneMap) in payload.scenes where windowKeys.contains(day) {
            for (identifier, seconds) in sceneMap { sceneTotals[identifier, default: 0] += seconds }
        }
        let scenes = sceneTotals.filter { $0.value > 0 }
            .map { AmbientFootprint.SceneShare(identifier: $0.key, seconds: $0.value) }
            .sorted { $0.seconds != $1.seconds ? $0.seconds > $1.seconds : $0.identifier < $1.identifier }

        return AmbientFootprint(days: resultDays,
                                activeDays: resultDays.filter(\.isActive).count,
                                todaySeconds: focusByDay[AmbientDayKey.key(today, calendar: calendar)] ?? 0,
                                allTimeSeconds: focusByDay.values.reduce(0, +),
                                completedRounds: completedRounds,
                                currentStreak: current,
                                longestStreak: max(longest, current),
                                scenes: scenes,
                                records: Array(records.prefix(Self.recentRecordLimit)),
                                calendar: calendar)
    }

}
