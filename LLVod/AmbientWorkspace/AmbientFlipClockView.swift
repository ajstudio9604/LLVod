import UIKit

/// 四格机械倒计时仅呈现现有计时状态，不创建计时器，也不修改截止时间。
final class AmbientFlipClockView: UIView {
    private let digits = (0..<4).map { _ in AmbientFlipDigitView() }
    private let separator = UILabel()
    private var lastSeconds: Int?

    override init(frame: CGRect) {
        super.init(frame: frame)
        isAccessibilityElement = true
        accessibilityLabel = "剩余时间"
        separator.text = ":"
        separator.textColor = UIColor(white: 0.94, alpha: 1)
        separator.textAlignment = .center
        separator.isAccessibilityElement = false
        addSubview(separator)
        digits.forEach { addSubview($0) }
    }

    required init?(coder: NSCoder) { nil }

    override func layoutSubviews() {
        super.layoutSubviews()
        let gap = bounds.width * 0.025
        let separatorWidth = bounds.width * 0.06
        let digitWidth = max(0, (bounds.width - separatorWidth - gap * 4) / 4)
        var x: CGFloat = 0
        for index in digits.indices {
            if index == 2 {
                separator.frame = CGRect(x: x, y: 0, width: separatorWidth, height: bounds.height)
                x += separatorWidth + gap
            }
            digits[index].frame = CGRect(x: x, y: 0, width: digitWidth, height: bounds.height)
            x += digitWidth + gap
        }
        separator.font = .systemFont(ofSize: bounds.height * 0.43, weight: .light)
    }

    func update(remaining: TimeInterval, animated: Bool) {
        guard remaining.isFinite else { return }
        let seconds = Int(ceil(min(5999, max(0, remaining))))
        // 仅连续减少一秒时翻页，重置、前台校准或切换显示直接落到正确读数。
        let shouldAnimate = animated && lastSeconds == seconds + 1 && window != nil &&
            UIApplication.shared.applicationState == .active && !UIAccessibility.isReduceMotionEnabled
        let values = [seconds / 600, seconds / 60 % 10, seconds / 10 % 6, seconds % 10]
        for (digit, value) in zip(digits, values) {
            digit.setDigit(value, animated: shouldAnimate)
        }
        lastSeconds = seconds
        accessibilityValue = "\(seconds / 60)分\(seconds % 60)秒"
    }

    /// 页面离开、模式切换或系统中断时立即收好翻片，避免恢复后停在半页。
    func stopAnimation() {
        digits.forEach { $0.finishAnimation() }
        lastSeconds = nil
    }
}

/// 数字分成上下半页，以中缝为转轴依次落下；位图只在数字或尺寸变化时生成。
private final class AmbientFlipDigitView: UIView {
    private let face = CALayer()
    private var flaps: [CALayer] = []
    private var digit: Int?
    private var renderedSize = CGSize.zero
    private var finalImage: CGImage?
    private var animationRevision = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        isAccessibilityElement = false
        layer.addSublayer(face)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 3)
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / 450
        layer.sublayerTransform = perspective
    }

    required init?(coder: NSCoder) { nil }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard bounds.size != renderedSize else { return }
        finishAnimation()
        renderedSize = bounds.size
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        face.frame = bounds
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 6).cgPath
        if let digit {
            finalImage = renderDigit(digit)?.cgImage
            face.contents = finalImage
        }
        CATransaction.commit()
    }

    func setDigit(_ value: Int, animated: Bool) {
        guard digit != value else { return }
        let previous = finalImage
        finishAnimation()
        digit = value
        finalImage = renderDigit(value)?.cgImage
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        face.contents = finalImage
        CATransaction.commit()
        guard animated, let previous, let next = finalImage, bounds.height > 0 else { return }

        let previousBottom = makeHalf(image: previous, upper: false)
        let fallingTop = makeHalf(image: previous, upper: true)
        let arrivingBottom = makeHalf(image: next, upper: false)
        flaps = [previousBottom, fallingTop, arrivingBottom]
        flaps.forEach { layer.addSublayer($0) }
        let revision = animationRevision
        let halfDuration = 0.17
        let now = layer.convertTime(CACurrentMediaTime(), from: nil)

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        fallingTop.transform = CATransform3DMakeRotation(-.pi / 2, 1, 0, 0)
        arrivingBottom.transform = CATransform3DIdentity
        CATransaction.setCompletionBlock { [weak self] in
            guard let self, self.animationRevision == revision else { return }
            self.finishAnimation()
        }
        let outgoing = CABasicAnimation(keyPath: "transform.rotation.x")
        outgoing.fromValue = 0
        outgoing.toValue = -CGFloat.pi / 2
        outgoing.duration = halfDuration
        outgoing.timingFunction = CAMediaTimingFunction(name: .easeIn)
        fallingTop.add(outgoing, forKey: "upperFold")

        let incoming = CABasicAnimation(keyPath: "transform.rotation.x")
        incoming.fromValue = CGFloat.pi / 2
        incoming.toValue = 0
        incoming.beginTime = now + halfDuration
        incoming.duration = halfDuration
        incoming.fillMode = .backwards
        incoming.timingFunction = CAMediaTimingFunction(name: .easeOut)
        arrivingBottom.add(incoming, forKey: "lowerFold")
        CATransaction.commit()
    }

    func finishAnimation() {
        // 先使旧完成回调失效，再移除动画，防止快速重置时清理掉新一轮翻片。
        animationRevision += 1
        let previous = flaps
        flaps.removeAll()
        previous.forEach {
            $0.removeAllAnimations()
            $0.removeFromSuperlayer()
        }
    }

    private func makeHalf(image: CGImage, upper: Bool) -> CALayer {
        let half = CALayer()
        half.bounds = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height / 2)
        half.anchorPoint = CGPoint(x: 0.5, y: upper ? 1 : 0)
        half.position = CGPoint(x: bounds.midX, y: bounds.midY)
        half.contents = image
        half.contentsRect = CGRect(x: 0, y: upper ? 0 : 0.5, width: 1, height: 0.5)
        half.isDoubleSided = false
        return half
    }

    private func renderDigit(_ value: Int) -> UIImage? {
        guard bounds.width > 0, bounds.height > 0 else { return nil }
        return UIGraphicsImageRenderer(size: bounds.size).image { context in
            let rect = CGRect(origin: .zero, size: bounds.size)
            let outline = UIBezierPath(roundedRect: rect.insetBy(dx: 0.5, dy: 0.5), cornerRadius: 6)
            context.cgContext.saveGState()
            outline.addClip()
            let colors = [UIColor(white: 0.12, alpha: 1).cgColor, UIColor(white: 0.045, alpha: 1).cgColor]
            if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray,
                                         locations: [0, 1]) {
                context.cgContext.drawLinearGradient(gradient, start: .zero,
                                                     end: CGPoint(x: 0, y: rect.height), options: [])
            }
            // 阴影先以正常混合叠加到底板，再绘制数字；不能用覆盖填充擦掉下半页内容。
            context.cgContext.setBlendMode(.normal)
            context.cgContext.setFillColor(UIColor.black.withAlphaComponent(0.16).cgColor)
            context.cgContext.fill(CGRect(x: 0, y: rect.midY, width: rect.width, height: rect.height / 2))
            let base = UIFont.monospacedDigitSystemFont(ofSize: rect.height * 0.74, weight: .semibold)
            let descriptor = base.fontDescriptor.withSymbolicTraits(.traitCondensed) ?? base.fontDescriptor
            var font = UIFont(descriptor: descriptor, size: base.pointSize)
            let text = String(value) as NSString
            let measured = text.size(withAttributes: [.font: font])
            let scale = min(1, (rect.width - 10) / max(1, measured.width))
            font = font.withSize(font.pointSize * max(0.1, scale))
            let size = text.size(withAttributes: [.font: font])
            text.draw(at: CGPoint(x: (rect.width - size.width) / 2, y: (rect.height - size.height) / 2),
                      withAttributes: [.font: font, .foregroundColor: UIColor(white: 0.96, alpha: 1)])
            // 完整数字上只覆盖细中缝，静止和翻页时都保留上下半部。
            context.cgContext.setFillColor(UIColor.black.cgColor)
            context.cgContext.fill(CGRect(x: 0, y: rect.midY - 0.75, width: rect.width, height: 1.5))
            context.cgContext.restoreGState()
            UIColor.white.withAlphaComponent(0.13).setStroke()
            outline.lineWidth = 0.5
            outline.stroke()
            // 两侧铰链保持细小，避免抢占数字宽度。
            UIColor(white: 0.32, alpha: 1).setFill()
            for x in [CGFloat(0), rect.width - 2] {
                UIBezierPath(roundedRect: CGRect(x: x, y: rect.midY - 3, width: 2, height: 6),
                             cornerRadius: 1).fill()
            }
        }
    }
}
