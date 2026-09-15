import Combine
import Foundation
import UIKit

/// 工作与休息共用持久化截止时间；后台最多补判一轮工作，休息后等待用户开始。
@MainActor
final class AmbientFocusClock: ObservableObject {
    enum Stage: String, Codable, Sendable { case focus, rest }
    enum State: String, Codable, Sendable { case ready, running, paused, completed }

    /// 计时、目标与待结算轮次放在同一快照里，先保存待办，再提交进度事务。
    struct Archive: Codable, Sendable {
        var stage: Stage = .focus
        var state: State = .ready
        var remaining: TimeInterval = 1500
        var deadline: Date?
        var pausedBySleep = false
        var goal = ""
        var habitID: UUID?
        var round: AmbientFocusRound?
        var segmentStart: Date?
        var pending: [String: AmbientFocusRound] = [:]
        /// 本轮专注时长（秒），由关联习惯设定；重启或后台恢复后沿用，旧存档缺失时为 25 分钟。
        var focusDuration: TimeInterval = 1500

        enum CodingKeys: String, CodingKey {
            case stage, state, remaining, deadline, pausedBySleep, goal, habitID, round, segmentStart, pending, focusDuration
        }
    }

    /// 休息固定 5 分钟，不随习惯时长变化。
    static let restDuration: TimeInterval = 300

    @Published private(set) var stage: Stage = .focus
    @Published private(set) var state: State = .ready
    @Published private(set) var remaining: TimeInterval = 1500
    @Published private(set) var isPausedBySleep = false
    @Published private(set) var goal = ""
    @Published private(set) var storageMessage: String?
    var sceneIdentifierProvider: (() -> String?)?
    /// 回调在完整阶段转换后发送，声音由服务统一调度。
    var onPhaseChange: ((Stage, Bool) -> Void)?
    private var archive = Archive()
    private var ticker: Timer?
    private var observers: [NSObjectProtocol] = []
    private var writeTask: Task<Void, Error>?
    private var isActive = false
    private var isRefreshing = false
    private var hasReadFailure = false

    var duration: TimeInterval { stage == .focus ? archive.focusDuration : Self.restDuration }
    /// 当前阶段的完整时长，专注取本轮快照，休息取固定值。
    private var archiveDuration: TimeInterval { archive.stage == .focus ? archive.focusDuration : Self.restDuration }
    /// 下一次点击开始会开启一轮专注的状态：专注就绪，或休息结束等待开始新一轮。
    var isAwaitingFocusStart: Bool {
        (archive.stage == .focus && archive.state == .ready) || (archive.stage == .rest && archive.state == .completed)
    }
    var canEditGoal: Bool { archive.round == nil && !(stage == .focus && state == .running) }
    var display: String {
        let seconds = max(0, Int(ceil(remaining)))
        return String(format: "%02d:%02d", seconds / 60, seconds % 60)
    }

    init() {
        do {
            if let url = Self.fileURL(), FileManager.default.fileExists(atPath: url.path) {
                archive = try JSONDecoder().decode(Archive.self, from: Data(contentsOf: url))
                try Self.validate(archive)
            } else { try restoreLegacy() }
        } catch {
            hasReadFailure = true
            storageMessage = "计时记录暂时无法读取，请保留数据并稍后重试。"
        }
        publish()
        observe(UIApplication.didEnterBackgroundNotification) { [weak self] in
            self?.flushProgress()
            self?.stopTicker()
        }
        // 前台恢复由服务先校准睡眠定时，再恢复本计时器。
    }

    func activate() {
        guard storageMessage == nil else { return }
        isActive = true
        refresh()
        startTickerIfNeeded()
        scheduleWrite()
    }

    func refreshAfterActivation() {
        guard isActive else { return }
        refresh()
        startTickerIfNeeded()
        scheduleWrite()
    }

    /// 设定本轮目标与关联习惯；时长取自习惯设置，未传习惯时保留当前时长。就绪状态下同步把倒计时重置为新时长。
    func setGoal(_ text: String, habit: AmbientHabit?) {
        guard canEditGoal else { return }
        archive.goal = String(text.trimmingCharacters(in: .whitespacesAndNewlines).prefix(80))
        archive.habitID = habit?.id
        if let habit { archive.focusDuration = habit.focusSeconds }
        if archive.stage == .focus, archive.state == .ready { archive.remaining = archive.focusDuration }
        publish()
        persist()
    }

    func primaryAction() {
        guard isActive else { return }
        refresh()
        archive.pausedBySleep = false
        if archive.state == .running {
            settle(until: Date())
            archive.state = .paused
            archive.deadline = nil
            stopTicker()
        } else {
            if archive.state == .completed {
                archive.stage = .focus
                archive.remaining = archive.focusDuration
                archive.round = nil
            }
            archive.state = .running
            archive.deadline = Date().addingTimeInterval(archive.remaining)
            if archive.stage == .focus {
                if archive.round == nil {
                    // 开始时快照本轮目标时长，习惯之后被修改或删除都不影响这一轮。
                    archive.round = AmbientFocusRound(id: UUID(), days: [:], completedAt: nil, completedDay: nil,
                                                      sceneIdentifier: sceneIdentifierProvider?(), goal: archive.goal, habitID: archive.habitID,
                                                      targetSeconds: archive.focusDuration)
                }
                archive.segmentStart = Date()
            }
        }
        publish()
        persist()
        onPhaseChange?(archive.stage, false)
        startTickerIfNeeded()
    }

    func reset() {
        refresh()
        if archive.state == .running { settle(until: Date()) }
        let pending = archive.pending
        let goal = archive.goal
        let habitID = archive.habitID
        let focusDuration = archive.focusDuration
        archive = Archive()
        archive.pending = pending
        archive.goal = goal
        archive.habitID = habitID
        // 重置后仍按关联习惯的时长开始，而不是回到固定 25 分钟。
        archive.focusDuration = focusDuration
        archive.remaining = focusDuration
        stopTicker()
        publish()
        persist()
        onPhaseChange?(.focus, false)
    }

    func pauseForSleep(at moment: Date = Date()) {
        guard archive.state == .running, let deadline = archive.deadline else { return }
        // 已完成工作先准确结算；休息同样按睡眠到期时刻截断，不继续发声。
        if moment >= deadline { refresh(now: moment, audible: false) }
        guard archive.state == .running, let currentDeadline = archive.deadline else { return }
        let end = min(moment, Date())
        settle(until: end)
        archive.remaining = max(0, min(archiveDuration, currentDeadline.timeIntervalSince(end)))
        archive.state = .paused
        archive.pausedBySleep = true
        archive.deadline = nil
        stopTicker()
        publish()
        persist()
    }

    func pauseForDataOperation() {
        refresh()
        if archive.state == .running { primaryAction() }
    }

    func flushProgress() {
        refresh()
        if archive.state == .running { settle(until: Date(), keepRunning: true) }
        persist()
    }

    /// 保存失败时保留快照内的待结算轮次，下次恢复或显式重试继续提交。
    func finishPersistence() async throws {
        guard persist() else { throw AmbientProgressError.storage }
        if let writeTask { try await writeTask.value }
        if !archive.pending.isEmpty {
            scheduleWrite()
            if let writeTask { try await writeTask.value }
        }
        guard archive.pending.isEmpty else { throw AmbientProgressError.storage }
    }

    func backupArchive() -> Archive { archive }

    /// 读取失败时重新读取原文件，不能用内存中的空快照覆盖原始数据。
    func retryPersistence() async throws {
        if hasReadFailure {
            if let url = Self.fileURL(), FileManager.default.fileExists(atPath: url.path) {
                let saved = try JSONDecoder().decode(Archive.self, from: Data(contentsOf: url))
                try Self.validate(saved)
                archive = saved
            } else {
                try restoreLegacy()
            }
            hasReadFailure = false
            storageMessage = nil
            publish()
            activate()
        }
        try await finishPersistence()
    }

    func restore(_ saved: Archive) throws {
        try Self.validate(saved)
        stopTicker()
        archive = saved
        hasReadFailure = false
        isActive = true
        // 恢复时不把离开备份文件的这段时间算作新的专注。
        if archive.state == .running { archive.state = .paused }
        archive.deadline = nil
        archive.segmentStart = nil
        storageMessage = nil
        publish()
        guard persist() else { throw AmbientProgressError.storage }
    }

    func shutdown() async throws {
        pauseForDataOperation()
        try await finishPersistence()
        isActive = false
        stopTicker()
        observers.forEach(NotificationCenter.default.removeObserver)
        observers.removeAll()
        onPhaseChange = nil
    }

    private func refresh(now: Date = Date(), audible: Bool = true) {
        guard !isRefreshing, archive.state == .running, let deadline = archive.deadline else { return }
        isRefreshing = true
        defer { isRefreshing = false }
        archive.remaining = max(0, min(archiveDuration, deadline.timeIntervalSince(now)))
        if archive.remaining == 0 {
            let fresh = audible && abs(now.timeIntervalSince(deadline)) < 2 && UIApplication.shared.applicationState == .active
            if archive.stage == .focus {
                settle(until: deadline, completed: true)
                archive.round = nil
                archive.stage = .rest
                archive.deadline = deadline.addingTimeInterval(Self.restDuration)
                archive.remaining = max(0, archive.deadline!.timeIntervalSince(now))
                archive.state = archive.remaining > 0 ? .running : .completed
                if archive.state == .completed { archive.deadline = nil }
            } else {
                archive.state = .completed
                archive.deadline = nil
            }
            publish()
            persist()
            onPhaseChange?(archive.stage, fresh)
            if archive.state != .running { stopTicker() }
        } else {
            if let start = archive.segmentStart, abs(now.timeIntervalSince(start)) >= 60 {
                settle(until: now, keepRunning: true)
                persist()
            }
            publish()
        }
    }

    private func settle(until end: Date, keepRunning: Bool = false, completed: Bool = false) {
        guard archive.stage == .focus, var round = archive.round else { archive.segmentStart = nil; return }
        if let start = archive.segmentStart {
            // 单轮累计上限以本轮目标时长为准。
            let allowed = max(0, round.resolvedTargetSeconds - round.totalSeconds)
            let stop = min(end, start.addingTimeInterval(allowed))
            for (day, seconds) in AmbientDayKey.split(from: start, to: stop) { round.days[day, default: 0] += seconds }
        }
        round.sceneIdentifier = sceneIdentifierProvider?() ?? round.sceneIdentifier
        if completed {
            round.completedAt = end
            round.completedDay = AmbientDayKey.key(end)
        }
        archive.round = round
        archive.segmentStart = keepRunning ? end : nil
        if !round.days.isEmpty {
            let key = round.id.uuidString
            archive.pending[key] = archive.pending[key].map { $0.merged(with: round) } ?? round
        }
    }

    @discardableResult private func persist() -> Bool {
        do {
            guard !hasReadFailure else { throw AmbientProgressError.storage }
            guard let url = Self.fileURL() else { throw AmbientProgressError.storage }
            try JSONEncoder().encode(archive).write(to: url, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
            storageMessage = nil
            scheduleWrite()
            return true
        } catch {
            storageMessage = "专注进度尚未保存，请稍后重试。"
            return false
        }
    }

    private func scheduleWrite() {
        guard isActive, writeTask == nil, !archive.pending.isEmpty else { return }
        writeTask = Task { [weak self] in
            guard let self else { return }
            defer { self.writeTask = nil }
            do {
                while let round = self.archive.pending.values.first {
                    try await AmbientProgressStore.shared.completeFocusRound(round)
                    let key = round.id.uuidString
                    if self.archive.pending[key] == round { self.archive.pending.removeValue(forKey: key) }
                    guard self.persist() else { throw AmbientProgressError.storage }
                }
            } catch {
                self.storageMessage = "本轮记录等待保存，水滴将在保存成功后到账。"
                throw error
            }
        }
    }

    private func publish() {
        if stage != archive.stage { stage = archive.stage }
        if state != archive.state { state = archive.state }
        if remaining != archive.remaining { remaining = archive.remaining }
        if isPausedBySleep != archive.pausedBySleep { isPausedBySleep = archive.pausedBySleep }
        if goal != archive.goal { goal = archive.goal }
    }

    private func startTickerIfNeeded() {
        guard isActive, archive.state == .running, ticker == nil,
              UIApplication.shared.applicationState == .active else { return }
        let timer = Timer(timeInterval: 0.5, repeats: true) { [weak self] _ in
            MainActor.assumeIsolated { self?.refresh() }
        }
        ticker = timer
        RunLoop.main.add(timer, forMode: .common)
    }
    private func stopTicker() { ticker?.invalidate(); ticker = nil }
    private static func fileURL() -> URL? { AmbientFocusLog.storageURL(for: "focus-state.json") }

    static func validate(_ saved: Archive) throws {
        guard saved.remaining.isFinite, saved.remaining >= 0,
              AmbientHabit.focusSecondsRange.contains(saved.focusDuration),
              saved.remaining <= (saved.stage == .focus ? saved.focusDuration : restDuration), saved.goal.count <= 80,
              saved.deadline?.timeIntervalSince1970.isFinite != false,
              saved.segmentStart?.timeIntervalSince1970.isFinite != false,
              saved.state != .running || saved.deadline != nil else { throw AmbientProgressError.invalidBackup }
        var payload = AmbientProgressPayload()
        payload.rounds = saved.pending
        if let round = saved.round { payload.rounds[round.id.uuidString] = round }
        try AmbientProgressStore.validate(payload)
    }

    private func restoreLegacy() throws {
        struct Legacy: Decodable {
            let stage: Stage
            let state: State
            let remaining: TimeInterval
            let deadline: Date?
            let pausedBySleep: Bool?
        }
        struct Round: Decodable {
            let id: UUID
            let days: [String: TimeInterval]
            let segmentStart: Date?
            let sceneIdentifier: String?
        }
        guard let data = UserDefaults.standard.data(forKey: "com.workspace.focus.clock") else { return }
        let old = try JSONDecoder().decode(Legacy.self, from: data)
        archive.stage = old.stage
        archive.state = old.state
        archive.remaining = old.remaining
        archive.deadline = old.deadline
        archive.pausedBySleep = old.pausedBySleep ?? false
        if old.stage == .focus, old.state == .running || old.state == .paused,
           let url = AmbientFocusLog.storageURL(for: "focus-round.json"), FileManager.default.fileExists(atPath: url.path) {
            let round = try JSONDecoder().decode(Round.self, from: Data(contentsOf: url))
            archive.round = .init(id: round.id, days: round.days, completedAt: nil, completedDay: nil, sceneIdentifier: round.sceneIdentifier)
            archive.segmentStart = round.segmentStart
        }
        if old.stage == .focus && old.state == .running && archive.round == nil {
            // 无法证明起点的旧轮次暂停保留读数，不凭空产生完成奖励。
            archive.state = .paused
            archive.deadline = nil
        }
        try Self.validate(archive)
    }

    private func observe(_ name: Notification.Name, action: @escaping () -> Void) {
        observers.append(NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { _ in
            MainActor.assumeIsolated { action() }
        })
    }
    deinit { ticker?.invalidate(); observers.forEach(NotificationCenter.default.removeObserver) }
}

extension AmbientFocusClock.Archive {
    /// 自定义解码只为给新增的 focusDuration 补默认值，旧存档也能读取；放在扩展里以保留默认初始化器。
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stage = try container.decode(AmbientFocusClock.Stage.self, forKey: .stage)
        state = try container.decode(AmbientFocusClock.State.self, forKey: .state)
        remaining = try container.decode(TimeInterval.self, forKey: .remaining)
        deadline = try container.decodeIfPresent(Date.self, forKey: .deadline)
        pausedBySleep = try container.decodeIfPresent(Bool.self, forKey: .pausedBySleep) ?? false
        goal = try container.decodeIfPresent(String.self, forKey: .goal) ?? ""
        habitID = try container.decodeIfPresent(UUID.self, forKey: .habitID)
        round = try container.decodeIfPresent(AmbientFocusRound.self, forKey: .round)
        segmentStart = try container.decodeIfPresent(Date.self, forKey: .segmentStart)
        pending = try container.decodeIfPresent([String: AmbientFocusRound].self, forKey: .pending) ?? [:]
        focusDuration = try container.decodeIfPresent(TimeInterval.self, forKey: .focusDuration) ?? 1500
    }
}
