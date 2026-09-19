import UIKit

/// 专注空间仅使用局部配色，不修改应用的全局主题。
enum AmbientStyle {
    static let background = UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 18.0 / 255, alpha: 1) : UIColor(red: 0.97, green: 0.96, blue: 0.93, alpha: 1) }
    static let surface = UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 26.0 / 255, alpha: 1) : UIColor(red: 1, green: 0.99, blue: 0.97, alpha: 1) }
    static let accent = UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 0.91, green: 0.76, blue: 0.55, alpha: 1) : UIColor(red: 0.48, green: 0.35, blue: 0.19, alpha: 1) }
    static let secondary = UIColor.secondaryLabel
    static let text = UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 0.95, green: 0.93, blue: 0.88, alpha: 1) : UIColor(red: 0.20, green: 0.23, blue: 0.20, alpha: 1) }

    // 次级首页沿用沉浸页的中性文字色；场景只提供氛围，不改变正文的对比度。
    static let pageBackground = UIColor { $0.userInterfaceStyle == .dark
        ? UIColor(red: 21 / 255, green: 23 / 255, blue: 22 / 255, alpha: 1)
        : UIColor(red: 0.97, green: 0.96, blue: 0.93, alpha: 1) }
    static let pageSecondary = text.withAlphaComponent(0.68)
    static let hairline = text.withAlphaComponent(0.16)

    /// 分段按钮在深浅主题下都使用同一套中性强调方式。
    static func styleSegment(_ control: UISegmentedControl) {
        control.backgroundColor = text.withAlphaComponent(0.08)
        control.selectedSegmentTintColor = text
        let font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: .systemFont(ofSize: 14, weight: .medium))
        control.setTitleTextAttributes([.foregroundColor: pageSecondary, .font: font], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: pageBackground, .font: font], for: .selected)
    }

    /// 专注空间统一使用系统内置的苹方字体；按字重映射到对应的字体名，取不到时退回同字重的系统字体。
    static func pingFang(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let name: String
        switch weight {
        case .ultraLight: name = "PingFangSC-Ultralight"
        case .thin: name = "PingFangSC-Thin"
        case .light: name = "PingFangSC-Light"
        case .medium: name = "PingFangSC-Medium"
        case .semibold, .bold, .heavy, .black: name = "PingFangSC-Semibold"
        default: name = "PingFangSC-Regular"
        }
        return UIFont(name: name, size: size) ?? .systemFont(ofSize: size, weight: weight)
    }

    /// 两种声音图标共用相同画布，避免切换后按钮宽度变化，带动文字或相邻滑杆移位。
    static func soundImages(pointSize: CGFloat) -> (enabled: UIImage?, disabled: UIImage?) {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .light)
        guard let enabled = UIImage(systemName: "speaker.wave.2", withConfiguration: configuration),
              let disabled = UIImage(systemName: "speaker.slash", withConfiguration: configuration) else {
            return (nil, nil)
        }
        let size = CGSize(width: ceil(max(enabled.size.width, disabled.size.width)),
                          height: ceil(max(enabled.size.height, disabled.size.height)))
        let format = UIGraphicsImageRendererFormat.default()
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        func aligned(_ image: UIImage) -> UIImage {
            renderer.image { _ in
                let scale = format.scale
                let origin = CGPoint(x: ((size.width - image.size.width) / 2 * scale).rounded() / scale,
                                     y: ((size.height - image.size.height) / 2 * scale).rounded() / scale)
                image.draw(in: CGRect(origin: origin, size: image.size))
            }.withRenderingMode(.alwaysTemplate)
        }
        return (aligned(enabled), aligned(disabled))
    }

    static func label(_ content: String, size: CGFloat, weight: UIFont.Weight = .regular) -> UILabel {
        let label = UILabel()
        label.text = content
        // 显式引用主题颜色，避免与标签的文字内容混淆。
        label.textColor = Self.text
        label.numberOfLines = 0
        label.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: size, weight: weight))
        label.adjustsFontForContentSizeCategory = true
        return label
    }

    static func button(_ title: String, primary: Bool = false) -> UIButton {
        var configuration = primary ? UIButton.Configuration.filled() : .tinted()
        configuration.title = title
        configuration.baseBackgroundColor = accent
        configuration.baseForegroundColor = primary ? background : accent
        configuration.cornerStyle = .large
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20)
        return UIButton(configuration: configuration)
    }

    static func message(on controller: UIViewController, title: String, text: String) {
        guard controller.viewIfLoaded?.window != nil, controller.presentedViewController == nil else { return }
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        controller.present(alert, animated: true)
    }
}

/// 资源使用唯一前缀，兼容同步分组构建时资源被复制到包根目录的行为。
struct AmbientScene: Sendable {
    /// 价格只限制场景画面，环境音仍免费用于混音。
    static let prices = ["ambient_rain": 20, "ambient_glow": 30, "ambient_ember": 50, "ambient_forest": 80, "ambient_jungle": 120]

    let identifier: String
    let title: String
    let subtitle: String
    // 视频与环境音独立映射；原片没有可用音轨的场景共用相近的环境音，避免包内重复文件。
    let audioIdentifier: String

    static let collection = [
        AmbientScene(identifier: "ambient_night", title: "夜雨", subtitle: "窗外灯火朦胧，雨声渐渐绵密", audioIdentifier: "ambient_jungle"),
        AmbientScene(identifier: "ambient_rain", title: "细雨", subtitle: "让雨声落下，让思绪沉静", audioIdentifier: "ambient_rain"),
        AmbientScene(identifier: "ambient_glow", title: "炉火", subtitle: "炉火噼啪作响，时间慢了下来", audioIdentifier: "ambient_ember"),
        AmbientScene(identifier: "ambient_ember", title: "余烬", subtitle: "火光明灭之间，心也安静下来", audioIdentifier: "ambient_ember"),
        AmbientScene(identifier: "ambient_forest", title: "林间", subtitle: "雨落林间，草木轻轻呼吸", audioIdentifier: "ambient_forest"),
        AmbientScene(identifier: "ambient_jungle", title: "雨林", subtitle: "大雨倾盆，世界只剩雨声", audioIdentifier: "ambient_jungle")
    ]

    func resource(_ extensionName: String) -> URL? {
        let name = extensionName == "m4a" ? audioIdentifier : identifier
        return Bundle.main.url(forResource: name, withExtension: extensionName)
            ?? Bundle.main.url(forResource: name, withExtension: extensionName, subdirectory: "Resources")
    }
}
