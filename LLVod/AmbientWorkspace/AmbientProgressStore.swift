import Foundation
import SQLite3

/// 每日习惯保留创建日期和归档日期；归档后不继续计算未完成日。
struct AmbientHabit: Codable, Identifiable, Sendable {
    var id = UUID()
    var title: String
    var createdDay: String
    var archivedDay: String?
    var order: Int
    /// 恢复归档习惯时保留暂停区间，暂停日不补记为失败。
    var pauses: [Pause] = []
    /// 每轮专注时长（分钟），默认 25；旧记录缺失时解码为默认值。
    var focusMinutes: Int = defaultFocusMinutes
    struct Pause: Codable, Sendable {
        let start: String
        var end: String?
    }

    static let defaultFocusMinutes = 25
    static let focusMinutesRange = 5...99
    static var focusSecondsRange: ClosedRange<TimeInterval> {
        TimeInterval(focusMinutesRange.lowerBound * 60)...TimeInterval(focusMinutesRange.upperBound * 60)
    }
    var focusSeconds: TimeInterval { TimeInterval(focusMinutes * 60) }

    enum CodingKeys: String, CodingKey { case id, title, createdDay, archivedDay, order, pauses, focusMinutes }

    /// 首次建库时预填的演示习惯，展示不同时长的用法。
    static func starters(createdDay: String) -> [AmbientHabit] {
        [("阅读", 30), ("冥想", 10), ("写作", 25)].enumerated().map { index, item in
            AmbientHabit(title: item.0, createdDay: createdDay, order: index, focusMinutes: item.1)
        }
    }

    func strength(completions: Set<String>, today: Date = Date()) -> Double {
        let calendar = AmbientDayKey.calendar
        let todayKey = AmbientDayKey.key(today)
        guard let start = AmbientDayKey.date(createdDay) else { return 0 }
        let endKey = min(archivedDay ?? todayKey, todayKey)
        guard let end = AmbientDayKey.date(endKey) else { return 0 }
        let count = max(0, calendar.dateComponents([.day], from: start, to: end).day ?? 0)
        let weight = pow(2.0, -1.0 / 13.0)
        var score = 0.0
        for offset in 0...count {
            guard let date = calendar.date(byAdding: .day, value: offset, to: start) else { continue }
            let key = AmbientDayKey.key(date)
            if key == todayKey && !completions.contains(key) { break }
            if !completions.contains(key) && pauses.contains(where: { key >= $0.start && key < ($0.end ?? "9999-12-31") }) { continue }
            score = score * weight + (completions.contains(key) ? 1 - weight : 0)
        }
        return score
    }
}

/// 流水的标识由来源事件决定，撤销打卡或删除记录都不删除流水。
struct AmbientRewardEntry: Codable, Sendable {
    let id: String
    let day: String
    let amount: Int
    let kind: String
}

/// 关联习惯由用户确认，提示持久化后可跨页面和重启恢复。
struct AmbientHabitPrompt: Codable, Identifiable, Sendable {
    let id: UUID
    let habitID: UUID
    let day: String
    let title: String
}

/// 所有可兑换进度以一个事务快照提交，避免记录、余额和解锁分开写入。
struct AmbientProgressPayload: Codable, Sendable {
    var version = 2
    var rounds: [String: AmbientFocusRound] = [:]
    var scenes: [String: [String: TimeInterval]] = [:]
    var habits: [AmbientHabit] = []
    var entries: [String: Set<String>] = [:]
    var ledger: [String: AmbientRewardEntry] = [:]
    var unlocks: Set<String> = ["ambient_night"]
    var prompts: [AmbientHabitPrompt] = []
    /// 删除标记阻止迟到的写入把用户删除的记录重新带回来。
    var deletedRounds: Set<String> = []
    var balance: Int { ledger.values.reduce(0) { $0 + $1.amount } }
}

extension AmbientHabit {
    /// 自定义解码只为给新增字段补默认值，旧记录没有 focusMinutes 也能读取；放在扩展里以保留成员初始化器。
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        createdDay = try container.decode(String.self, forKey: .createdDay)
        archivedDay = try container.decodeIfPresent(String.self, forKey: .archivedDay)
        order = try container.decode(Int.self, forKey: .order)
        pauses = try container.decodeIfPresent([Pause].self, forKey: .pauses) ?? []
        focusMinutes = try container.decodeIfPresent(Int.self, forKey: .focusMinutes) ?? Self.defaultFocusMinutes
    }
}

enum AmbientProgressError: LocalizedError {
    case storage, invalidBackup, invalidHabit, invalidDay, insufficient, missingResource
    var errorDescription: String? {
        switch self {
        case .storage: return "本地数据暂时无法保存，请保留当前页面并重试。"
        case .invalidBackup: return "备份格式或数据不完整，当前数据未被替换。"
        case .invalidHabit: return "请填写有效的习惯名称与 5 到 99 分钟的专注时长，或重新选择习惯。"
        case .invalidDay: return "只能修改最近七天且在习惯创建之后的记录。"
        case .insufficient: return "水滴还不够，完成专注或今日习惯后再来看看。"
        case .missingResource: return "场景素材不完整，本次没有扣除水滴。"
        }
    }
}

/// 系统数据库只保存本空间的数据；串行事务内不挂起，整个操作成功后才通知界面。
actor AmbientProgressStore {
    static let shared = AmbientProgressStore()
    static let didChange = Notification.Name("com.workspace.progress.changed")
    private var database: OpaquePointer?

    func prepare() throws { try openIfNeeded() }

    func snapshot() throws -> AmbientProgressPayload {
        try openIfNeeded()
        return try read()
    }

    private func openIfNeeded() throws {
        guard database == nil else { return }
        guard let url = AmbientFocusLog.storageURL(for: "progress.sqlite") else { throw AmbientProgressError.storage }
        var connection: OpaquePointer?
        guard sqlite3_open_v2(url.path, &connection, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX, nil) == SQLITE_OK else {
            sqlite3_close(connection)
            throw AmbientProgressError.storage
        }
        database = connection
        do {
            sqlite3_busy_timeout(connection, 3000)
            // 单行快照由主键约束保护；日志采用回滚模式，便于一致地备份和替换。
            try execute("PRAGMA journal_mode=DELETE")
            try execute("PRAGMA synchronous=FULL")
            try execute("CREATE TABLE IF NOT EXISTS workspace_state (id INTEGER PRIMARY KEY CHECK (id = 1), payload BLOB NOT NULL)")
            let count = try scalarCount()
            if count == 0 {
                var payload = AmbientProgressPayload()
                if let legacy = AmbientFocusLog.storageURL(for: "focus-log.json"), FileManager.default.fileExists(atPath: legacy.path) {
                    struct Legacy: Decodable {
                        let version: Int
                        let rounds: [String: AmbientFocusRound]
                        let scenes: [String: [String: TimeInterval]]
                    }
                    let old = try JSONDecoder().decode(Legacy.self, from: Data(contentsOf: legacy))
                    guard old.version == 1 else { throw AmbientProgressError.invalidBackup }
                    payload.rounds = old.rounds
                    payload.scenes = old.scenes
                    // 历史完成轮次登记零额流水，迁移后也不会被重放补奖。
                    for round in old.rounds.values where round.isCompleted {
                        let key = "focus:" + round.id.uuidString
                        payload.ledger[key] = .init(id: key, day: round.completedDay ?? AmbientDayKey.key(Date()), amount: 0, kind: "legacy")
                    }
                }
                // 首次建库且没有任何习惯时预填演示习惯；清空数据或恢复备份走替换流程，不会再补。
                if payload.habits.isEmpty { payload.habits = AmbientHabit.starters(createdDay: AmbientDayKey.key(Date())) }
                try execute("BEGIN IMMEDIATE")
                do { try write(payload); try execute("COMMIT") }
                catch { try? execute("ROLLBACK"); throw error }
            }
            try FileManager.default.setAttributes([.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication], ofItemAtPath: url.path)
        } catch {
            sqlite3_close(database)
            database = nil
            throw error
        }
    }

    private func execute(_ sql: String) throws {
        guard sqlite3_exec(database, sql, nil, nil, nil) == SQLITE_OK else { throw AmbientProgressError.storage }
    }

    private func scalarCount() throws -> Int {
        var statement: OpaquePointer?
        defer { sqlite3_finalize(statement) }
        guard sqlite3_prepare_v2(database, "SELECT COUNT(*) FROM workspace_state", -1, &statement, nil) == SQLITE_OK,
              sqlite3_step(statement) == SQLITE_ROW else { throw AmbientProgressError.storage }
        return Int(sqlite3_column_int(statement, 0))
    }

    private func read() throws -> AmbientProgressPayload {
        var statement: OpaquePointer?
        defer { sqlite3_finalize(statement) }
        guard sqlite3_prepare_v2(database, "SELECT payload FROM workspace_state WHERE id=1", -1, &statement, nil) == SQLITE_OK,
              sqlite3_step(statement) == SQLITE_ROW,
              let bytes = sqlite3_column_blob(statement, 0) else { throw AmbientProgressError.storage }
        let data = Data(bytes: bytes, count: Int(sqlite3_column_bytes(statement, 0)))
        let payload = try JSONDecoder().decode(AmbientProgressPayload.self, from: data)
        return try Self.upgraded(payload)
    }

    private func write(_ payload: AmbientProgressPayload) throws {
        let data = try JSONEncoder().encode(payload)
        var statement: OpaquePointer?
        defer { sqlite3_finalize(statement) }
        guard sqlite3_prepare_v2(database, "INSERT OR REPLACE INTO workspace_state(id,payload) VALUES(1,?)", -1, &statement, nil) == SQLITE_OK else {
            throw AmbientProgressError.storage
        }
        let transient = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        let bound = data.withUnsafeBytes { sqlite3_bind_blob(statement, 1, $0.baseAddress, Int32($0.count), transient) }
        guard bound == SQLITE_OK, sqlite3_step(statement) == SQLITE_DONE else { throw AmbientProgressError.storage }
    }

    private func transaction(_ change: (inout AmbientProgressPayload) throws -> Void) throws {
        try openIfNeeded()
        try execute("BEGIN IMMEDIATE")
        do {
            var payload = try read()
            try change(&payload)
            try write(payload)
            try execute("COMMIT")
        } catch {
            try? execute("ROLLBACK")
            throw error
        }
        Task { @MainActor in
            NotificationCenter.default.post(name: Self.didChange, object: nil)
            NotificationCenter.default.post(name: AmbientFocusLog.didChangeNotification, object: nil)
        }
    }

    /// 完成事件与水滴同一事务写入，轮次标识保证重试最多奖励一次。
    func completeFocusRound(_ round: AmbientFocusRound) throws {
        try transaction { payload in
            let id = round.id.uuidString
            guard !payload.deletedRounds.contains(id) else { return }
            payload.rounds[id] = payload.rounds[id].map { $0.merged(with: round) } ?? round
            // 只有完整走完目标时长的轮次才发放水滴，数量按每 5 分钟 1 滴向下取整。
            if round.isFullyCompleted, let day = round.completedDay {
                let key = "focus:" + id
                if payload.ledger[key] == nil {
                    payload.ledger[key] = .init(id: key, day: day, amount: round.rewardAmount, kind: "focus")
                    // 当天已打卡或已有同一习惯的待确认提示时不再追问，连续多轮关联同一习惯只确认一次。
                    if let habitID = round.habitID, let habit = payload.habits.first(where: { $0.id == habitID && $0.archivedDay == nil }),
                       payload.entries[habitID.uuidString]?.contains(day) != true,
                       !payload.prompts.contains(where: { $0.habitID == habitID && $0.day == day }) {
                        payload.prompts.append(.init(id: round.id, habitID: habitID, day: day, title: habit.title))
                    }
                }
            }
            Self.prune(&payload)
        }
    }

    func deleteRound(_ id: UUID) throws {
        try transaction { payload in
            payload.rounds.removeValue(forKey: id.uuidString)
            payload.deletedRounds.insert(id.uuidString)
            payload.prompts.removeAll { $0.id == id }
        }
    }

    func addCompanion(scene: String, seconds: [String: TimeInterval]) throws {
        try transaction { payload in
            for (day, value) in seconds where value.isFinite && value > 0 {
                payload.scenes[day, default: [:]][scene, default: 0] += value
            }
            Self.prune(&payload)
        }
    }

    func saveHabit(_ habit: AmbientHabit) throws {
        var habit = habit
        habit.title = habit.title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !habit.title.isEmpty, habit.title.count <= 80,
              AmbientHabit.focusMinutesRange.contains(habit.focusMinutes) else { throw AmbientProgressError.invalidHabit }
        try transaction { payload in
            if let index = payload.habits.firstIndex(where: { $0.id == habit.id }) {
                let old = payload.habits[index]
                habit.pauses = old.pauses
                if old.archivedDay == nil, let day = habit.archivedDay { habit.pauses.append(.init(start: day, end: nil)) }
                if old.archivedDay != nil, habit.archivedDay == nil, let last = habit.pauses.indices.last { habit.pauses[last].end = AmbientDayKey.key(Date()) }
                payload.habits[index] = habit
            }
            else { payload.habits.append(habit) }
        }
    }

    func reorderHabits(_ ids: [UUID]) throws {
        try transaction { payload in
            for (order, id) in ids.enumerated() {
                if let index = payload.habits.firstIndex(where: { $0.id == id }) { payload.habits[index].order = order }
            }
        }
    }

    func deleteHabit(_ id: UUID) throws {
        try transaction { payload in
            payload.habits.removeAll { $0.id == id }
            payload.entries.removeValue(forKey: id.uuidString)
            payload.prompts.removeAll { $0.habitID == id }
        }
    }

    func setHabitCompletion(_ id: UUID, day: String, completed: Bool) throws {
        try transaction { payload in
            guard let habit = payload.habits.first(where: { $0.id == id && $0.archivedDay == nil }) else { throw AmbientProgressError.invalidHabit }
            let today = AmbientDayKey.key(Date())
            let oldest = AmbientDayKey.key(AmbientDayKey.calendar.date(byAdding: .day, value: -6, to: Date()) ?? Date())
            guard day >= max(oldest, habit.createdDay), day <= today, AmbientDayKey.date(day) != nil else { throw AmbientProgressError.invalidDay }
            if completed {
                payload.entries[id.uuidString, default: []].insert(day)
                // 任一入口完成打卡后，同一习惯同一天的待确认提示随之失效，沉浸页不再追问。
                payload.prompts.removeAll { $0.habitID == id && $0.day == day }
            } else { payload.entries[id.uuidString, default: []].remove(day) }
            let key = "habit:" + id.uuidString + ":" + day
            if completed && day == today && payload.ledger[key] == nil {
                let earned = payload.ledger.values.filter { $0.kind == "habit" && $0.day == today }.reduce(0) { $0 + $1.amount }
                // 达到每日上限也记录零额事件，之后取消和重新勾选仍不补发。
                payload.ledger[key] = .init(id: key, day: day, amount: min(2, max(0, 10 - earned)), kind: "habit")
            }
        }
    }

    func dismissPrompt(_ id: UUID) throws {
        try transaction { $0.prompts.removeAll { $0.id == id } }
    }

    func redeemScene(_ scene: AmbientScene) throws {
        guard scene.resource("mp4") != nil, scene.resource("jpg") != nil, scene.resource("m4a") != nil else { throw AmbientProgressError.missingResource }
        try transaction { payload in
            guard !payload.unlocks.contains(scene.identifier) else { return }
            guard let price = AmbientScene.prices[scene.identifier], payload.balance >= price else { throw AmbientProgressError.insufficient }
            let key = "scene:" + scene.identifier
            payload.ledger[key] = .init(id: key, day: AmbientDayKey.key(Date()), amount: -price, kind: "scene")
            payload.unlocks.insert(scene.identifier)
        }
    }

    func replace(_ payload: AmbientProgressPayload) throws {
        let payload = try Self.upgraded(payload)
        try Self.validate(payload)
        try transaction { $0 = payload }
    }

    func clear() throws { try transaction { $0 = AmbientProgressPayload() } }

    /// 旧数据和旧备份统一移除细雨的免费赠送，不修改账本或已兑换场景。
    private static func upgraded(_ saved: AmbientProgressPayload) throws -> AmbientProgressPayload {
        var payload = saved
        if payload.version == 1 {
            if payload.ledger["scene:ambient_rain"] == nil { payload.unlocks.remove("ambient_rain") }
            payload.version = 2
        }
        guard payload.version == 2 else { throw AmbientProgressError.invalidBackup }
        return payload
    }

    /// 备份校验只接受已知资源与一致账本，失败时不开始替换事务。
    static func validate(_ payload: AmbientProgressPayload) throws {
        let payload = try upgraded(payload)
        let sceneIDs = Set(AmbientScene.collection.map(\.identifier))
        guard payload.version == 2, payload.ledger.count < 1_000_000,
              payload.ledger.values.allSatisfy({ (-200...AmbientFocusRound.maxReward).contains($0.amount) }), payload.balance >= 0,
              payload.unlocks.isSubset(of: sceneIDs),
              payload.unlocks.contains("ambient_night"),
              Set(payload.habits.map(\.id)).count == payload.habits.count else { throw AmbientProgressError.invalidBackup }
        for habit in payload.habits {
            guard !habit.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, habit.title.count <= 80,
                  AmbientHabit.focusMinutesRange.contains(habit.focusMinutes),
                  AmbientDayKey.date(habit.createdDay) != nil, habit.createdDay <= AmbientDayKey.key(Date()),
                  habit.pauses.allSatisfy({ AmbientDayKey.date($0.start) != nil && ($0.end == nil || (AmbientDayKey.date($0.end!) != nil && $0.end! >= $0.start)) }),
                  habit.archivedDay == nil || (AmbientDayKey.date(habit.archivedDay!) != nil && habit.archivedDay! >= habit.createdDay) else { throw AmbientProgressError.invalidBackup }
        }
        let habitIDs = Set(payload.habits.map { $0.id.uuidString })
        for (id, days) in payload.entries {
            guard habitIDs.contains(id), let habit = payload.habits.first(where: { $0.id.uuidString == id }),
                  days.allSatisfy({ AmbientDayKey.date($0) != nil && $0 >= habit.createdDay && $0 <= AmbientDayKey.key(Date()) }) else { throw AmbientProgressError.invalidBackup }
        }
        for (key, round) in payload.rounds {
            guard key == round.id.uuidString, !payload.deletedRounds.contains(key),
                  round.days.values.allSatisfy({ $0.isFinite && $0 >= 0 }),
                  // 时长上限以本轮目标为准；没有快照的旧记录按 25 分钟判定。
                  round.targetSeconds == nil || AmbientHabit.focusSecondsRange.contains(round.targetSeconds!),
                  round.totalSeconds <= round.resolvedTargetSeconds + 1,
                  round.days.keys.allSatisfy({ AmbientDayKey.date($0) != nil }),
                  round.completedAt?.timeIntervalSince1970.isFinite != false,
                  (round.completedAt == nil) == (round.completedDay == nil),
                  round.completedDay == nil || AmbientDayKey.date(round.completedDay!) != nil,
                  (round.goal?.count ?? 0) <= 80 else { throw AmbientProgressError.invalidBackup }
        }
        for (day, values) in payload.scenes {
            guard AmbientDayKey.date(day) != nil, Set(values.keys).isSubset(of: sceneIDs),
                  values.values.allSatisfy({ $0.isFinite && $0 >= 0 }) else { throw AmbientProgressError.invalidBackup }
        }
        for (key, item) in payload.ledger {
            guard key == item.id, AmbientDayKey.date(item.day) != nil else { throw AmbientProgressError.invalidBackup }
            switch item.kind {
            case "focus": guard key.hasPrefix("focus:"), UUID(uuidString: String(key.dropFirst(6))) != nil, (0...AmbientFocusRound.maxReward).contains(item.amount) else { throw AmbientProgressError.invalidBackup }
            case "legacy": guard key.hasPrefix("focus:"), UUID(uuidString: String(key.dropFirst(6))) != nil, item.amount == 0 else { throw AmbientProgressError.invalidBackup }
            case "habit":
                let parts = key.split(separator: ":")
                guard parts.count == 3, parts[0] == "habit", UUID(uuidString: String(parts[1])) != nil,
                      String(parts[2]) == item.day, [0, 2].contains(item.amount) else { throw AmbientProgressError.invalidBackup }
            case "scene":
                let id = String(key.dropFirst(6))
                guard key.hasPrefix("scene:"), let price = AmbientScene.prices[id], item.amount == -price, payload.unlocks.contains(id) else { throw AmbientProgressError.invalidBackup }
            default: throw AmbientProgressError.invalidBackup
            }
        }
        for id in payload.unlocks where AmbientScene.prices[id] != nil {
            guard payload.ledger["scene:" + id]?.amount == -(AmbientScene.prices[id] ?? 0) else { throw AmbientProgressError.invalidBackup }
        }
        guard Set(payload.prompts.map(\.id)).count == payload.prompts.count,
              payload.prompts.allSatisfy({ habitIDs.contains($0.habitID.uuidString) && AmbientDayKey.date($0.day) != nil && $0.title.count <= 80 }),
              payload.deletedRounds.allSatisfy({ UUID(uuidString: $0) != nil }) else { throw AmbientProgressError.invalidBackup }
        let rewards = Dictionary(grouping: payload.ledger.values.filter { $0.kind == "habit" }, by: \.day)
        guard rewards.values.allSatisfy({ $0.reduce(0) { $0 + $1.amount } <= 10 }) else { throw AmbientProgressError.invalidBackup }
    }

    private static func prune(_ payload: inout AmbientProgressPayload) {
        let cutoff = AmbientDayKey.key(AmbientDayKey.calendar.date(byAdding: .day, value: -400, to: Date()) ?? Date())
        payload.rounds = payload.rounds.filter { $0.value.days.keys.contains { $0 >= cutoff } }
        payload.scenes = payload.scenes.filter { $0.key >= cutoff }
        // 提示只能确认最近七天（与补卡范围一致），过期提示随整理一并移除，不在数据库里累积。
        let promptCutoff = AmbientDayKey.key(AmbientDayKey.calendar.date(byAdding: .day, value: -6, to: Date()) ?? Date())
        payload.prompts.removeAll { $0.day < promptCutoff }
    }

    deinit { sqlite3_close(database) }
}
