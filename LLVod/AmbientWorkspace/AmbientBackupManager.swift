import Foundation

/// 备份只包含专注空间的数据，不包含环境标识、反馈内容、视频素材或系统音量。
struct AmbientWorkspaceBackup: Codable, Sendable {
    var version = 1
    let createdAt: Date
    let progress: AmbientProgressPayload
    let clock: AmbientFocusClock.Archive
    let preferences: AmbientPreferences.Values

    @MainActor func validate() throws {
        guard version == 1, createdAt.timeIntervalSince1970.isFinite else { throw AmbientProgressError.invalidBackup }
        try AmbientProgressStore.validate(progress)
        try AmbientFocusClock.validate(clock)
        let trackIDs: Set<String> = ["ambient_rain", "ambient_forest", "ambient_jungle", "ambient_ember"]
        guard Set(preferences.levels.keys).isSubset(of: trackIDs), preferences.levels.values.allSatisfy({ $0.isFinite && (0...1).contains($0) }) else { throw AmbientProgressError.invalidBackup }
    }
}

/// 导入先写旧状态恢复日志，应用在任意一步退出后，下次启动都会回滚到旧数据。
@MainActor
enum AmbientBackupManager {
    private static var recoveryURL: URL? { AmbientFocusLog.storageURL(for: "restore-recovery.json") }

    static func make(services: AmbientServices) async throws -> AmbientWorkspaceBackup {
        try await services.pauseForDataOperation()
        return AmbientWorkspaceBackup(createdAt: Date(), progress: try await AmbientProgressStore.shared.snapshot(),
                                      clock: services.clock.backupArchive(), preferences: AmbientPreferences.shared.values)
    }

    static func restore(_ backup: AmbientWorkspaceBackup, services: AmbientServices) async throws {
        try backup.validate()
        let old = try await make(services: services)
        guard let recoveryURL else { throw AmbientProgressError.storage }
        try JSONEncoder().encode(old).write(to: recoveryURL, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
        do {
            try await AmbientProgressStore.shared.replace(backup.progress)
            try services.clock.restore(backup.clock)
            AmbientPreferences.shared.replace(backup.preferences)
            try FileManager.default.removeItem(at: recoveryURL)
            services.sleepTimer.wake()
            services.sleepTimer.cancel()
            await services.refreshProgressNow()
        } catch {
            try await AmbientProgressStore.shared.replace(old.progress)
            try services.clock.restore(old.clock)
            AmbientPreferences.shared.replace(old.preferences)
            try? FileManager.default.removeItem(at: recoveryURL)
            await services.refreshProgressNow()
            throw error
        }
    }

    /// 迁移准备完成后、计时激活前调用，恢复事务绝不触发奖励结算。
    static func recoverIfNeeded(clock: AmbientFocusClock) async throws {
        guard let recoveryURL, FileManager.default.fileExists(atPath: recoveryURL.path) else { return }
        let backup = try JSONDecoder().decode(AmbientWorkspaceBackup.self, from: Data(contentsOf: recoveryURL))
        try backup.validate()
        try await AmbientProgressStore.shared.replace(backup.progress)
        try clock.restore(backup.clock)
        AmbientPreferences.shared.replace(backup.preferences)
        try FileManager.default.removeItem(at: recoveryURL)
    }
}
