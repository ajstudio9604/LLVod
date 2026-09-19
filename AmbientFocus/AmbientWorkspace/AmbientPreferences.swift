import Combine
import UIKit

/// 只管理专注空间的偏好，不覆盖现有业务主题和手机系统媒体音量。
@MainActor
final class AmbientPreferences: ObservableObject {
    static let shared = AmbientPreferences()
    enum Theme: String, Codable, CaseIterable, Sendable {
        case dark, light, system
        var title: String { self == .dark ? "深色" : self == .light ? "浅色" : "跟随系统" }
        var style: UIUserInterfaceStyle { self == .dark ? .dark : self == .light ? .light : .unspecified }
    }
    struct Values: Codable, Sendable {
        var theme: Theme = .dark
        /// 环境音默认关闭，用户在设置中开启后才会在进入专注空间时自动播放。
        var soundEnabled = false
        var phaseSound = true
        var motionEnabled = true
        var followsScene = true
        var levels: [String: Float] = [:]
        /// 休息期间的手动配比优先，重启或恢复备份后也保留这一选择。
        var restMixIsCustom: Bool?
    }
    @Published private(set) var values: Values
    private let key = "com.workspace.preferences"

    private init() {
        if let data = UserDefaults.standard.data(forKey: key), let saved = try? JSONDecoder().decode(Values.self, from: data) {
            values = saved
        } else {
            var initial = Values()
            initial.motionEnabled = UserDefaults.standard.object(forKey: "com.workspace.spatial.motion.enabled") as? Bool ?? true
            values = initial
        }
    }

    func update(_ change: (inout Values) -> Void) {
        var next = values
        change(&next)
        replace(next)
    }

    func replace(_ next: Values) {
        values = next
        UserDefaults.standard.set(try? JSONEncoder().encode(next), forKey: key)
        UserDefaults.standard.set(next.motionEnabled, forKey: "com.workspace.spatial.motion.enabled")
        NotificationCenter.default.post(name: Self.didChange, object: nil)
    }

    static let didChange = Notification.Name("com.workspace.preferences.changed")
}
