import UIKit

/// 圆环只呈现计时器状态，不持有独立计时任务；顺时针消退后保留淡色底环。
final class AmbientFocusRingView: UIView {
    private let track = CAShapeLayer()
    private let progress = CAShapeLayer()
    private let animationKey = "focusProgress"
    private var expectedCompletion: CFTimeInterval?
    private var displayedDuration: TimeInterval?

    override init(frame: CGRect) {
        super.init(frame: frame)
        let color = UIColor(red: 0.95, green: 0.93, blue: 0.88, alpha: 1)
        for shape in [track, progress] {
            shape.fillColor = UIColor.clear.cgColor
            // 底环与进度环统一略微加粗，让倒计时轮廓更清晰。
            shape.lineWidth = 4
            shape.lineCap = .round
            layer.addSublayer(shape)
        }
        track.strokeColor = color.withAlphaComponent(0.16).cgColor
        progress.strokeColor = color.withAlphaComponent(0.92).cgColor
        // 圆弧是时间读数的视觉补充，辅助功能由内部时间标签表达。
        isAccessibilityElement = false
    }

    required init?(coder: NSCoder) { nil }

    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = max(0, min(bounds.width, bounds.height) / 2 - 2)
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: radius,
                                startAngle: -.pi / 2, endAngle: .pi * 1.5, clockwise: true)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        for shape in [track, progress] {
            shape.frame = bounds
            shape.path = path.cgPath
        }
        CATransaction.commit()
    }

    func update(remaining: TimeInterval, duration: TimeInterval, isRunning: Bool) {
        guard remaining.isFinite, duration.isFinite, duration > 0 else { return }
        let remaining = min(duration, max(0, remaining))
        let elapsed = CGFloat(1 - remaining / duration)
        let canAnimate = isRunning && remaining > 0 && window != nil &&
            UIApplication.shared.applicationState == .active && !UIAccessibility.isReduceMotionEnabled
        if canAnimate {
            let completion = CACurrentMediaTime() + remaining
            // 常规计时刷新不反复启动动画；恢复前台或截止时间变化时重新校准。
            if let expectedCompletion, abs(expectedCompletion - completion) < 0.75,
               displayedDuration == duration, progress.animation(forKey: animationKey) != nil { return }
            progress.removeAnimation(forKey: animationKey)
            setElapsed(1)
            let animation = CABasicAnimation(keyPath: "strokeStart")
            animation.fromValue = elapsed
            animation.toValue = 1
            animation.duration = remaining
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
            progress.add(animation, forKey: animationKey)
            expectedCompletion = completion
            displayedDuration = duration
        } else {
            progress.removeAnimation(forKey: animationKey)
            expectedCompletion = nil
            displayedDuration = nil
            setElapsed(elapsed)
        }
    }

    /// 页面隐藏或应用失去前台时冻结当前画面，返回后由实际剩余时间恢复。
    func stopAnimation() {
        let elapsed = progress.presentation()?.strokeStart ?? progress.strokeStart
        progress.removeAnimation(forKey: animationKey)
        expectedCompletion = nil
        displayedDuration = nil
        setElapsed(elapsed)
    }

    private func setElapsed(_ value: CGFloat) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progress.strokeStart = value
        CATransaction.commit()
    }
}
