import Combine
import UIKit

/// 首页和全屏页共用月亮菜单，统一呈现同一个睡眠计划；只按固定时长关停，与番茄钟各管一件事。
final class AmbientSleepButton: UIButton {
    private weak var services: AmbientServices?
    private var subscriptions = Set<AnyCancellable>()

    init(services: AmbientServices) {
        self.services = services
        super.init(frame: .zero)
        tintColor = AmbientStyle.accent
        setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 21, weight: .light), forImageIn: .normal)
        showsMenuAsPrimaryAction = true
        accessibilityLabel = "睡眠定时器"
        // 到点除了停止声音与画面，还会暂停进行中的专注，提示里一并说明。
        accessibilityHint = "选择自动关停时间，最后三十秒平滑降低环境音；到点停止播放并暂停进行中的专注"
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 44),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        services.sleepTimer.objectWillChange.receive(on: RunLoop.main).sink { [weak self] in
            self?.render()
        }.store(in: &subscriptions)
        render()
    }

    required init?(coder: NSCoder) { nil }

    private func render() {
        guard let services else { return }
        let timer = services.sleepTimer
        let active = timer.preset != nil
        setImage(UIImage(systemName: timer.isSleeping ? "moon.zzz" : (active ? "moon.fill" : "moon")), for: .normal)
        accessibilityValue = timer.status
        var children: [UIMenuElement] = AmbientSleepTimer.Preset.allCases.map { preset in
            UIAction(title: preset.title, state: timer.preset == preset ? .on : .off) { [weak self] _ in
                self?.services?.setSleepPreset(preset)
            }
        }
        if active {
            children.append(UIAction(title: "取消定时", image: UIImage(systemName: "xmark.circle")) { [weak self] _ in
                self?.services?.sleepTimer.cancel()
            })
        }
        menu = UIMenu(title: active || timer.isSleeping ? timer.status : "睡眠定时器", children: children)
    }
}
