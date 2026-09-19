import Combine
import Foundation

/// 睡眠关停以截止时间为准，音量增益独立于用户设定的音量；只按固定时长定时，不与番茄钟联动。
@MainActor
final class AmbientSleepTimer: ObservableObject {
    enum Preset: String, Codable, CaseIterable {
        case minutes15, minutes30, minutes45, minutes60

        var title: String {
            switch self {
            case .minutes15: return "15 分钟后"
            case .minutes30: return "30 分钟后"
            case .minutes45: return "45 分钟后"
            case .minutes60: return "60 分钟后"
            }
        }

        var duration: TimeInterval {
            switch self {
            case .minutes15: return 15 * 60
            case .minutes30: return 30 * 60
            case .minutes45: return 45 * 60
            case .minutes60: return 60 * 60
            }
        }
    }

    private struct Snapshot: Codable {
        let preset: Preset?
        let deadline: Date?
        let isSleeping: Bool
    }

    @Published private(set) var preset: Preset?
    @Published private(set) var remainingSeconds = 0
    @Published private(set) var isSleeping = false
    private(set) var gain: Float = 1
    /// 渐隐进度，零为未开始、一为已静音；与增益同源但保持线性尺度，供画面类效果随声音一起缓慢归零。
    private(set) var fadeProgress: Double = 0
    var onGainChange: ((Float) -> Void)?
    /// 到期回调携带实际到期时刻；进程挂起期间到期时，恢复后才回调，但时刻仍是原定的截止时间。
    var onExpiration: ((Date) -> Void)?
    private var deadline: Date?
    /// 最后三十秒平滑渐隐。
    private let fadeWindow: TimeInterval = 30
    private var ticker: DispatchSourceTimer?
    private var isStopped = false
    private let storageKey = "com.workspace.sleep.timer"

    /// 显示结束时刻而不是剩余分秒，避免与中间番茄钟同格式的倒计时并排出现、被当成第二个番茄钟。
    /// 时刻使用中文符号并实时跟随系统的 12/24 小时制，例如"23:15"或"下午11:15"。
    var status: String {
        if isSleeping { return "已休眠" }
        guard preset != nil, let deadline else { return "睡眠定时" }
        if remainingSeconds <= Int(fadeWindow) { return "声音渐弱中" }
        return "\(AmbientClockText.string(from: deadline)) 停止播放"
    }

    init() {
        // 旧版本保存的"当前专注结束后"已无法解码，按没有定时处理。
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let saved = try? JSONDecoder().decode(Snapshot.self, from: data),
              saved.deadline?.timeIntervalSince1970.isFinite != false,
              saved.preset == nil || saved.deadline != nil else { return }
        preset = saved.preset
        deadline = saved.deadline
        isSleeping = saved.isSleeping
        if isSleeping {
            gain = 0
            fadeProgress = 1
        }
    }

    /// 选中任一时长都从此刻重新计时；再次选择同一项同样重新开始。
    func schedule(_ preset: Preset) {
        guard !isStopped else { return }
        stopTicker()
        self.preset = preset
        isSleeping = false
        deadline = Date().addingTimeInterval(preset.duration)
        refresh()
        persist()
    }

    /// 前台恢复必须先校准，再允许媒体恢复，避免过期计划被自动播放绕过。
    func refresh() {
        guard !isStopped, !isSleeping, preset != nil else { return }
        let remaining = max(0, deadline?.timeIntervalSinceNow ?? 0)
        if remaining <= 0 {
            expire()
            return
        }
        let seconds = Int(ceil(min(remaining, 3600)))
        if remainingSeconds != seconds { remainingSeconds = seconds }
        // 分贝变化经过平滑插值，再转换为振幅；尾端衰减至千分之一后静音。
        let progress = min(1, max(0, 1 - remaining / fadeWindow))
        let eased = progress * progress * (3 - 2 * progress)
        fadeProgress = eased
        setGain(Float(pow(10, -60 * eased / 20)))
        startTickerIfNeeded()
    }

    func cancel() {
        stopTicker()
        preset = nil
        deadline = nil
        remainingSeconds = 0
        fadeProgress = isSleeping ? 1 : 0
        setGain(isSleeping ? 0 : 1)
        persist()
    }

    /// 唤醒只由用户操作触发，取消旧关停计划，但不擅自重新打开声音。
    func wake() {
        guard !isStopped, isSleeping else { return }
        isSleeping = false
        cancel()
    }

    func shutdown() {
        onGainChange = nil
        onExpiration = nil
        cancel()
        isStopped = true
    }

    private func expire() {
        guard !isStopped, !isSleeping else { return }
        // 记下实际到期时刻，供专注计时按睡眠到期而不是恢复运行的时刻结算。
        let expiredAt = min(deadline ?? Date(), Date())
        stopTicker()
        isSleeping = true
        preset = nil
        deadline = nil
        remainingSeconds = 0
        fadeProgress = 1
        setGain(0)
        persist()
        onExpiration?(expiredAt)
    }

    private func setGain(_ gain: Float) {
        guard abs(self.gain - gain) > 0.000001 else { return }
        self.gain = gain
        onGainChange?(gain)
    }

    private func startTickerIfNeeded() {
        guard ticker == nil, deadline != nil else { return }
        let timer = DispatchSource.makeTimerSource(queue: .main)
        // 常规阶段按秒唤醒，最后三十秒才提高频率，降低长时间等待的开销。
        let interval: TimeInterval = remainingSeconds <= 30 ? 0.1 : 1
        timer.schedule(deadline: .now(), repeating: interval, leeway: .milliseconds(20))
        timer.setEventHandler { [weak self] in
            guard let self else { return }
            let wasFading = self.remainingSeconds <= 30
            self.refresh()
            if !wasFading && self.remainingSeconds <= 30 && !self.isSleeping {
                self.stopTicker()
                self.startTickerIfNeeded()
            }
        }
        ticker = timer
        timer.resume()
    }

    private func stopTicker() {
        ticker?.setEventHandler {}
        ticker?.cancel()
        ticker = nil
    }

    private func persist() {
        let saved = Snapshot(preset: preset, deadline: deadline, isSleeping: isSleeping)
        if let data = try? JSONEncoder().encode(saved) { UserDefaults.standard.set(data, forKey: storageKey) }
    }

    deinit { ticker?.cancel() }
}
