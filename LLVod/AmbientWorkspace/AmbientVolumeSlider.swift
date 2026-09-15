import AVFoundation
import MediaPlayer
import UIKit

/// 使用系统媒体音量滑杆，物理键与拖动操作共用音量；数值标签仅在拖动时出现。
final class AmbientVolumeSlider: MPVolumeView {
    private let bubble = UIView()
    private let valueLabel = UILabel()
    private let pointer = CAShapeLayer()
    private let cream = UIColor(red: 0.95, green: 0.93, blue: 0.88, alpha: 1)
    private weak var observedSlider: UISlider?
    private var volumeObservation: NSKeyValueObservation?
    private var isSynchronizing = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsRouteButton = false
        showsVolumeSlider = true
        setMinimumVolumeSliderImage(trackImage(color: cream), for: .normal)
        setMaximumVolumeSliderImage(trackImage(color: cream.withAlphaComponent(0.23)), for: .normal)
        let thumb = UIGraphicsImageRenderer(size: CGSize(width: 18, height: 18)).image { _ in
            cream.setFill()
            UIBezierPath(ovalIn: CGRect(x: 2, y: 2, width: 14, height: 14)).fill()
        }
        setVolumeThumbImage(thumb, for: .normal)
        setVolumeThumbImage(thumb, for: .highlighted)
        bubble.backgroundColor = cream
        bubble.layer.cornerRadius = 8
        bubble.isUserInteractionEnabled = false
        bubble.isAccessibilityElement = false
        valueLabel.textColor = UIColor(white: 0.08, alpha: 1)
        valueLabel.textAlignment = .center
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.75
        valueLabel.isAccessibilityElement = false
        bubble.addSubview(valueLabel)
        addSubview(bubble)
        pointer.fillColor = cream.cgColor
        pointer.zPosition = 1
        bubble.layer.zPosition = 2
        layer.addSublayer(pointer)
        setValueLabelVisible(false)
        setContentHuggingPriority(.defaultHigh, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .vertical)
        updateTypography()
    }

    required init?(coder: NSCoder) { nil }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: bubbleHeight + 44)
    }

    override func volumeSliderRect(forBounds bounds: CGRect) -> CGRect {
        // 下方四十四点交给系统滑杆，上方固定留给数值，显隐不改变布局。
        CGRect(x: bounds.minX, y: bounds.maxY - 44, width: bounds.width, height: 44)
    }

    /// 初次显示及返回首页都读取手机当前音量，不覆盖用户的系统设置。
    func beginSynchronizing() {
        isSynchronizing = true
        bindSystemSlider()
        if volumeObservation == nil {
            volumeObservation = AVAudioSession.sharedInstance().observe(\.outputVolume, options: [.initial, .new]) {
                [weak self] _, _ in
                Task { @MainActor in
                    guard let self, self.isSynchronizing else { return }
                    // 只读取系统音量用于标签，系统滑杆的位置由系统维护，避免双向回写循环。
                    self.updateValueLabel()
                    self.setNeedsLayout()
                }
            }
        }
    }

    func endSynchronizing() {
        isSynchronizing = false
        volumeObservation?.invalidate()
        volumeObservation = nil
        setValueLabelVisible(false)
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window == nil { endSynchronizing() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        bindSystemSlider()
        guard bounds.width > 0, let slider = observedSlider else { return }
        updateValueLabel()
        let localThumb = slider.thumbRect(forBounds: slider.bounds,
                                          trackRect: slider.trackRect(forBounds: slider.bounds), value: slider.value)
        let thumb = slider.convert(localThumb, to: self)
        let measured = valueLabel.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: bubbleHeight))
        let width = min(bounds.width, max(40, ceil(measured.width) + 16))
        let x = min(max(bounds.minX, thumb.midX - width / 2), bounds.maxX - width)
        let bottom = thumb.minY - 9
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        bubble.frame = CGRect(x: x, y: bottom - bubbleHeight, width: width, height: bubbleHeight)
        valueLabel.frame = bubble.bounds.insetBy(dx: 8, dy: 5)
        let base = min(max(thumb.midX, bubble.frame.minX + 10), bubble.frame.maxX - 10)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: base - 3, y: bottom - 0.5))
        path.addLine(to: CGPoint(x: thumb.midX, y: thumb.minY - 4))
        path.addLine(to: CGPoint(x: base + 3, y: bottom - 0.5))
        path.close()
        pointer.frame = bounds
        pointer.path = path.cgPath
        CATransaction.commit()
    }

    private func bindSystemSlider() {
        guard let slider = subviews.compactMap({ $0 as? UISlider }).first,
              observedSlider !== slider else { return }
        observedSlider?.removeTarget(self, action: nil, for: .allEvents)
        observedSlider = slider
        slider.accessibilityLabel = "媒体音量"
        slider.accessibilityHint = "与手机音量键同步"
        slider.addTarget(self, action: #selector(dragBegan), for: .touchDown)
        slider.addTarget(self, action: #selector(dragEnded), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        slider.addTarget(self, action: #selector(valueDidChange), for: .valueChanged)
    }

    @objc private func dragBegan() {
        setNeedsLayout()
        layoutIfNeeded()
        setValueLabelVisible(true)
    }

    @objc private func dragEnded() { setValueLabelVisible(false) }

    @objc private func valueDidChange() {
        updateValueLabel()
        setNeedsLayout()
    }

    private var bubbleHeight: CGFloat { ceil(valueLabel.font.lineHeight) + 10 }

    private func updateValueLabel() {
        let value = observedSlider?.isTracking == true
            ? (observedSlider?.value ?? 0) : AVAudioSession.sharedInstance().outputVolume
        valueLabel.text = "\(Int((min(1, max(0, value)) * 100).rounded()))%"
    }

    private func trackImage(color: UIColor) -> UIImage {
        UIGraphicsImageRenderer(size: CGSize(width: 4, height: 2)).image { _ in
            color.setFill()
            UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 4, height: 2), cornerRadius: 1).fill()
        }.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1))
    }

    private func setValueLabelVisible(_ visible: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        bubble.isHidden = !visible
        pointer.isHidden = !visible
        CATransaction.commit()
    }

    private func updateTypography() {
        valueLabel.font = UIFontMetrics.default.scaledFont(
            for: .monospacedDigitSystemFont(ofSize: 12, weight: .medium), maximumPointSize: 18)
        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            updateTypography()
        }
    }

    deinit {
        volumeObservation?.invalidate()
    }
}
