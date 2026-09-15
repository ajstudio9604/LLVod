import Foundation

/// 场景陪伴计时：环境音或全屏视频正在播放时，按场景累计陪伴时长写入本地专注记录。
/// 由专注服务在播放状态变化时告知当前场景，本类只负责分段与落盘，不判断播放状态。
@MainActor
final class AmbientCompanionTracker {
    private var scene: String?
    private var start: Date?
    private var timer: Timer?
    private var pending: [(id: UUID, scene: String, days: [String: TimeInterval])] = []
    private var writeTask: Task<Void, Error>?

    /// 页面切换和备份等待已排队的陪伴片段落盘。
    func finishPersistence() async throws {
        if let writeTask { try await writeTask.value }
        if !pending.isEmpty {
            writePending()
            if let writeTask { try await writeTask.value }
        }
    }

    private func writePending() {
        guard writeTask == nil, !pending.isEmpty else { return }
        writeTask = Task { [weak self] in
            guard let self else { return }
            defer { self.writeTask = nil }
            while let item = self.pending.first {
                try await AmbientProgressStore.shared.addCompanion(scene: item.scene, seconds: item.days)
                self.pending.removeAll { $0.id == item.id }
            }
        }
    }
    /// 播放期间每分钟结算一次，进程被结束时最多丢失不足一分钟的片段。
    private let checkpointInterval: TimeInterval = 60

    /// 传入正在陪伴的场景标识，没有播放时传 nil；场景变化时先结算上一段再开始新的一段。
    func update(scene identifier: String?) {
        guard identifier != scene else { return }
        settle(keepRunning: false)
        scene = identifier
        start = identifier == nil ? nil : Date()
        if identifier == nil { stopTimer() } else { startTimer() }
    }

    /// 结算已累计的片段并从此刻继续计时，用于进入后台和打开足迹页前。
    func checkpoint() { settle(keepRunning: true) }

    private func settle(keepRunning: Bool) {
        guard let scene, let segmentStart = start else { return }
        let now = Date()
        // 正常情况下每分钟都会结算；间隔明显超出说明进程曾被挂起，只计入两个检查周期内的时长。
        let end = min(now, segmentStart.addingTimeInterval(checkpointInterval * 2))
        let slice = AmbientDayKey.split(from: segmentStart, to: end)
        if !slice.isEmpty {
            pending.append((UUID(), scene, slice))
            writePending()
        }
        // 系统时间被回拨时同样以此刻重新锚定，避免长时间不结算。
        start = keepRunning ? now : nil
    }

    private func startTimer() {
        guard timer == nil else { return }
        let timer = Timer(timeInterval: checkpointInterval, repeats: true) { [weak self] _ in
            Task { @MainActor in self?.checkpoint() }
        }
        self.timer = timer
        RunLoop.main.add(timer, forMode: .common)
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    deinit { timer?.invalidate() }
}
