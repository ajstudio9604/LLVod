import AVFoundation
import UIKit

/// 首页只解码当前场景；封面负责加载占位，播放资源由服务统一裁决生命周期。
final class AmbientBackdropView: UIView {
    /// 承载封面与视频的画布；空间微动只变换画布，裁剪边界仍由背景视图本身保持，位移时不露出底色。
    private let canvas = UIView()
    private let cover = UIImageView()
    private var scene: AmbientScene?
    private var queue: AVQueuePlayer?
    private var looper: AVPlayerLooper?
    private var videoLayer: AVPlayerLayer?
    private var readyObservation: NSKeyValueObservation?
    private var statusObservation: NSKeyValueObservation?
    private var transitionCover: UIView?
    private var allowsPlayback = false
    private var isStopped = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        isAccessibilityElement = false
        clipsToBounds = true
        backgroundColor = AmbientStyle.background
        cover.contentMode = .scaleAspectFill
        cover.clipsToBounds = true
        canvas.isUserInteractionEnabled = false
        addSubview(canvas)
        canvas.addSubview(cover)
    }

    required init?(coder: NSCoder) { nil }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 旋转与窗口尺寸变化只更新显示区域，不重建播放器。
        // 画布带有变换时 frame 的语义不再可靠，改用 bounds 与 center 定位。
        canvas.bounds = CGRect(origin: .zero, size: bounds.size)
        canvas.center = CGPoint(x: bounds.midX, y: bounds.midY)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        videoLayer?.frame = canvas.bounds
        CATransaction.commit()
        cover.frame = canvas.bounds
        transitionCover?.frame = bounds
    }

    /// 空间微动输出：以画布中心为锚点放大后平移。调用方每帧传入已经过滤波与限幅的值，这里不再做动画。
    func setSpatialOffset(_ offset: CGPoint, scale: CGFloat) {
        canvas.transform = CGAffineTransform(translationX: offset.x, y: offset.y).scaledBy(x: scale, y: scale)
    }

    func display(_ scene: AmbientScene) {
        guard !isStopped, self.scene?.identifier != scene.identifier else { return }
        transitionCover?.removeFromSuperview()
        let previous = window != nil && !UIAccessibility.isReduceMotionEnabled
            ? snapshotView(afterScreenUpdates: false) : nil
        releasePlayback()
        self.scene = scene
        cover.image = scene.resource("jpg").flatMap { UIImage(contentsOfFile: $0.path) }
        if let previous {
            previous.frame = bounds
            addSubview(previous)
            transitionCover = previous
            UIView.animate(withDuration: 0.35, animations: { previous.alpha = 0 }) { [weak self, weak previous] _ in
                previous?.removeFromSuperview()
                if self?.transitionCover === previous { self?.transitionCover = nil }
            }
        }
        startIfNeeded()
    }

    func setPlaybackAllowed(_ allowed: Bool) {
        guard !isStopped else { return }
        allowsPlayback = allowed
        if allowed { startIfNeeded() } else { releasePlayback() }
    }

    /// 切换工作空间前同步清理，迟到的首帧通知不能恢复旧播放器。
    func shutdown() {
        isStopped = true
        allowsPlayback = false
        transitionCover?.removeFromSuperview()
        transitionCover = nil
        releasePlayback()
    }

    private func startIfNeeded() {
        guard allowsPlayback, !isStopped, queue == nil,
              let url = scene?.resource("mp4") else { return }
        let queue = AVQueuePlayer()
        queue.isMuted = true
        queue.volume = 0
        queue.preventsDisplaySleepDuringVideoPlayback = false
        queue.audiovisualBackgroundPlaybackPolicy = .pauses
        let item = AVPlayerItem(url: url)
        self.queue = queue
        looper = AVPlayerLooper(player: queue, templateItem: item)
        let videoLayer = AVPlayerLayer(player: queue)
        videoLayer.videoGravity = .resizeAspectFill
        videoLayer.frame = canvas.bounds
        // 视频层放在画布内、封面之下，与封面一起随空间微动移动。
        canvas.layer.insertSublayer(videoLayer, at: 0)
        self.videoLayer = videoLayer
        readyObservation = videoLayer.observe(\.isReadyForDisplay, options: [.initial, .new]) { [weak self, weak videoLayer] _, _ in
            Task { @MainActor in
                guard let self, let videoLayer, self.videoLayer === videoLayer,
                      videoLayer.isReadyForDisplay, self.allowsPlayback, !self.isStopped else { return }
                // 首帧可显示后才移开封面，失败时自然保留静态画面。
                UIView.animate(withDuration: UIAccessibility.isReduceMotionEnabled ? 0 : 0.45,
                               delay: 0, options: [.beginFromCurrentState, .curveEaseInOut]) {
                    self.cover.alpha = 0
                }
            }
        }
        statusObservation = queue.observe(\.currentItem?.status, options: [.initial, .new]) { [weak self, weak queue] _, _ in
            Task { @MainActor in
                guard let self, let queue, self.queue === queue, queue.currentItem?.status == .failed else { return }
                // 解码失败退回封面，不打断计时或环境音，也不在后台反复重试。
                self.releasePlayback()
            }
        }
        queue.play()
    }

    private func releasePlayback() {
        readyObservation?.invalidate()
        readyObservation = nil
        statusObservation?.invalidate()
        statusObservation = nil
        cover.layer.removeAllAnimations()
        cover.alpha = 1
        videoLayer?.player = nil
        videoLayer?.removeFromSuperlayer()
        videoLayer = nil
        queue?.pause()
        looper?.disableLooping()
        looper = nil
        queue?.removeAllItems()
        queue = nil
    }
}

/// 次级首页共享静态场景承托：习惯与空间页通透铺满，足迹页仅保留顶部氛围。
/// 不接入视频服务，也不记录陪伴时长，避免装饰背景改变播放生命周期。
final class AmbientSecondaryBackdropView: UIView {
    enum Appearance { case editorial, scenic }

    var appearance: Appearance = .editorial {
        didSet { updateAppearance(); setNeedsLayout() }
    }
    private let artwork = UIImageView()
    private let shade = CAGradientLayer()
    private var displayedIdentifier: String?
    private var transparencyObserver: NSObjectProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        isAccessibilityElement = false
        clipsToBounds = true
        artwork.contentMode = .scaleAspectFill
        artwork.clipsToBounds = true
        addSubview(artwork)
        layer.addSublayer(shade)
        transparencyObserver = NotificationCenter.default.addObserver(
            forName: UIAccessibility.reduceTransparencyStatusDidChangeNotification,
            object: nil, queue: .main
        ) { [weak self] _ in
            Task { @MainActor in self?.updateAppearance() }
        }
        updateAppearance()
    }

    required init?(coder: NSCoder) { nil }
    deinit {
        if let transparencyObserver { NotificationCenter.default.removeObserver(transparencyObserver) }
    }

    func display(_ scene: AmbientScene) {
        guard displayedIdentifier != scene.identifier else { return }
        displayedIdentifier = scene.identifier
        // 先清掉上一场景，异步返回时再次核对，快速切换也不会显示旧封面。
        artwork.image = nil
        AmbientSceneArtwork.backdrop(for: scene) { [weak self] image in
            guard let self, self.displayedIdentifier == scene.identifier else { return }
            self.artwork.image = image
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let height = appearance == .editorial ? min(bounds.height, safeAreaInsets.top + 240) : bounds.height
        let frame = CGRect(x: 0, y: 0, width: bounds.width, height: height)
        artwork.frame = frame
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        shade.frame = frame
        CATransaction.commit()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) { updateAppearance() }
    }

    private func updateAppearance() {
        let reduced = UIAccessibility.isReduceTransparencyEnabled
        let base = AmbientStyle.pageBackground.resolvedColor(with: traitCollection)
        backgroundColor = base
        artwork.isHidden = reduced
        let opacity: [CGFloat]
        switch appearance {
        case .editorial: opacity = [0.40, 0.80, 1]
        case .scenic:
            // 全屏场景仍有稳定的明暗承托，避免浅色画面影响设置项和分组说明。
            opacity = [0.60, 0.76, 0.92]
        }
        // 固定底色渐变隔离场景亮度；降低透明度时直接回退到实色页面。
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        shade.colors = opacity.map { base.withAlphaComponent(reduced ? 1 : $0).cgColor }
        shade.locations = [0, 0.5, 1]
        CATransaction.commit()
    }
}
