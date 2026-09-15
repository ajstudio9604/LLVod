import CoreMotion
import UIKit

/// 空间微动：读取系统融合后的设备姿态，以进入页面时的持姿为基准，把小幅倾斜换算成背景画面的 2.5D 位移。
/// 原始陀螺仪读数不直接驱动画面：先求相对基准的旋转，再经过死区、限幅、慢速回中与低通，最后按屏幕刷新输出。
/// 不支持、数据异常或停止更新时画面平滑回到原位，不弹提示；减弱动态效果、低电量、发热、休眠与离开页面都会停止采样。
@MainActor
final class AmbientSpatialMotion {
    /// 起始参数，按画面尺寸与素材调试；位移上限在运行时还会受放大预留的边缘限制。
    enum Tuning {
        /// 姿态采样间隔（秒）：约每秒三十次，渲染由屏幕刷新单独驱动。
        static let sampleInterval: TimeInterval = 1.0 / 30
        /// 背景放大比例，为位移预留边缘，避免露出底色。
        static let scale: CGFloat = 1.03
        /// 单轴最大位移（点），经软饱和逼近，不会硬顶到上限。
        static let maxDisplacement: CGFloat = 6
        /// 倾斜约五度时到达最大位移。
        static let fullTiltRadians: Double = 5 * .pi / 180
        /// 方向：正值为窗口效果，画面随视线同向移动；负值为镜面效果。
        static let direction: CGFloat = 1
        /// 小于此角度（弧度，约零点三五度）的抖动忽略，软过渡避免在阈值处跳变。
        static let deadZone: Double = 0.006
        /// 跟手时的输出低通时间常数（秒）。
        static let followTimeConstant: TimeInterval = 0.12
        /// 关闭或数据中断时回到原位的时间常数（秒），比跟手慢，避免画面弹回。
        static let releaseTimeConstant: TimeInterval = 0.45
        /// 慢速回中的时间常数（秒）：持续保持某个倾斜时，画面在十余秒内缓慢回到中心，抵消陀螺漂移与换姿势。
        static let recenterTimeConstant: TimeInterval = 5
        /// 判定持姿稳定的角速度上限（弧度/秒）与持续时长（秒）。
        static let stableRotationRate: Double = 0.2
        static let stableDuration: TimeInterval = 0.4
        /// 等待稳定的最长时间（秒），超时后直接以当前姿态为基准。
        static let baselineTimeout: TimeInterval = 1.5
        /// 基准确立后效果渐入的时长（秒）。
        static let rampDuration: TimeInterval = 0.6
        /// 偏离基准超过此角度（弧度，约三十五度）并持续一秒，视为换了姿势，重新锚定基准。
        static let reanchorAngle: Double = 0.6
        static let reanchorDuration: TimeInterval = 1
        /// 超过此时长没有新样本即视为数据中断，画面回到原位。
        static let stallTimeout: TimeInterval = 1
        /// 中断超过此时长后停止采样，等下次进入页面再尝试。
        static let abandonTimeout: TimeInterval = 4
        /// 连续多少个异常样本后放弃本次采样。
        static let faultSampleLimit = 10
    }

    private struct Sample {
        let attitude: CMRotationMatrix
        let rotationRate: Double
        let time: TimeInterval
    }

    private static let preferenceKey = "com.workspace.spatial.motion.enabled"

    private let motion = CMMotionManager()
    private let proxy = AmbientDisplayLinkProxy()
    private weak var backdrop: AmbientBackdropView?
    private var displayLink: CADisplayLink?
    private var observers: [NSObjectProtocol] = []

    // 启停条件；任一条件变化都重新判断是否采样。
    private var isPageVisible = false
    private var isAppActive = UIApplication.shared.applicationState == .active
    private var isReduceMotionEnabled = UIAccessibility.isReduceMotionEnabled
    private var isLowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled
    private var isThermalHigh = ProcessInfo.processInfo.thermalState.rawValue >= ProcessInfo.ThermalState.serious.rawValue
    private var hasFault = false
    var isSleeping = false { didSet { if oldValue != isSleeping { updateActivation() } } }
    /// 睡眠渐隐等外部强度因子，取值零到一，每帧读取；为空视为一。
    var intensitySource: (() -> Double)?

    // 采样与滤波状态。
    private var isSampling = false
    private var latest: Sample?
    private var lastDataTime: TimeInterval = 0
    private var faultCount = 0
    private var baseline: CMRotationMatrix?
    private var baselineTime: TimeInterval = 0
    private var awaitingSince: TimeInterval = 0
    private var stableSince: TimeInterval?
    private var largeDeviationSince: TimeInterval?
    /// 慢速回中的低频分量（弧度），从相对角度中减去。
    private var slowOffset = (x: 0.0, y: 0.0)

    // 输出状态：位移与放大存在度都经过低通，关闭时一起缓慢回到原位。
    private var offset = CGPoint.zero
    private var presence: CGFloat = 0
    private var lastStepTime: TimeInterval?

    /// 用户开关，默认开启；只保存在本机。
    var isUserEnabled: Bool {
        get { UserDefaults.standard.object(forKey: Self.preferenceKey) as? Bool ?? true }
        set {
            UserDefaults.standard.set(newValue, forKey: Self.preferenceKey)
            updateActivation()
        }
    }

    /// 设备是否提供融合后的姿态数据。
    var isSupported: Bool { motion.isDeviceMotionAvailable }

    /// 供设置菜单展示的当前状态说明。
    var statusDescription: String {
        if !isSupported { return "当前设备不支持" }
        if !isUserEnabled { return "已关闭" }
        if isReduceMotionEnabled { return "已随系统“减弱动态效果”暂停" }
        if isLowPowerMode { return "低电量模式下暂停" }
        if isThermalHigh { return "设备发热时暂停" }
        return "倾斜手机时背景轻微移动"
    }

    init() {
        proxy.owner = self
        observe(AmbientPreferences.didChange) { [weak self] in self?.updateActivation() }
        observe(UIApplication.willResignActiveNotification) { [weak self] in
            self?.isAppActive = false
            self?.updateActivation()
        }
        observe(UIApplication.didBecomeActiveNotification) { [weak self] in
            self?.isAppActive = true
            self?.updateActivation()
        }
        observe(UIAccessibility.reduceMotionStatusDidChangeNotification) { [weak self] in
            self?.isReduceMotionEnabled = UIAccessibility.isReduceMotionEnabled
            self?.updateActivation()
        }
        observe(.NSProcessInfoPowerStateDidChange) { [weak self] in
            self?.isLowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled
            self?.updateActivation()
        }
        observe(ProcessInfo.thermalStateDidChangeNotification) { [weak self] in
            self?.isThermalHigh = ProcessInfo.processInfo.thermalState.rawValue >= ProcessInfo.ThermalState.serious.rawValue
            self?.updateActivation()
        }
    }

    /// 绑定承载画面的背景视图；位移限制按其尺寸与放大比例计算。
    func attach(to backdrop: AmbientBackdropView) {
        self.backdrop = backdrop
    }

    /// 页面出现时开始采样并重新取基准，离开时停止；每次重新进入都按当下持姿重新对齐。
    func setPageVisible(_ visible: Bool) {
        guard isPageVisible != visible else { return }
        isPageVisible = visible
        if visible { hasFault = false }
        updateActivation()
    }

    private var shouldSample: Bool {
        isPageVisible && isAppActive && !isSleeping && !isReduceMotionEnabled && !isLowPowerMode &&
            !isThermalHigh && isUserEnabled && !hasFault && isSupported
    }

    private func updateActivation() {
        if shouldSample {
            startSampling()
        } else {
            stopSampling()
        }
        // 停止采样后仍要驱动画面回到原位，回位完成后再停掉刷新。
        ensureDisplayLink()
    }

    private func startSampling() {
        guard !isSampling else { return }
        isSampling = true
        latest = nil
        faultCount = 0
        baseline = nil
        stableSince = nil
        largeDeviationSince = nil
        slowOffset = (0, 0)
        let now = CACurrentMediaTime()
        awaitingSince = now
        lastDataTime = now
        motion.deviceMotionUpdateInterval = Tuning.sampleInterval
        // 重力方向由系统融合校正，偏航任意；偏航的慢速漂移只体现为相对角度的低频分量，由慢速回中抵消。
        motion.startDeviceMotionUpdates(using: .xArbitraryZVertical, to: .main) { [weak self] data, error in
            MainActor.assumeIsolated { self?.receive(data, error: error) }
        }
    }

    private func stopSampling() {
        guard isSampling else { return }
        isSampling = false
        motion.stopDeviceMotionUpdates()
        latest = nil
        baseline = nil
    }

    private func receive(_ data: CMDeviceMotion?, error: Error?) {
        guard isSampling else { return }
        // 出错或数值异常都不提示用户；连续异常达到上限后放弃本次采样，画面自行回位。
        guard error == nil, let data, Self.isPlausible(data) else {
            faultCount += 1
            if faultCount >= Tuning.faultSampleLimit { abandon() }
            return
        }
        faultCount = 0
        let rate = data.rotationRate
        let now = CACurrentMediaTime()
        latest = Sample(attitude: data.attitude.rotationMatrix,
                        rotationRate: sqrt(rate.x * rate.x + rate.y * rate.y + rate.z * rate.z), time: now)
        lastDataTime = now
    }

    private func abandon() {
        hasFault = true
        stopSampling()
        ensureDisplayLink()
    }

    /// 重力量级明显偏离一个重力加速度，或矩阵、角速度含非数值，都视为异常样本。
    private static func isPlausible(_ data: CMDeviceMotion) -> Bool {
        let matrix = data.attitude.rotationMatrix
        let values = [matrix.m11, matrix.m12, matrix.m13, matrix.m21, matrix.m22, matrix.m23,
                      matrix.m31, matrix.m32, matrix.m33,
                      data.rotationRate.x, data.rotationRate.y, data.rotationRate.z]
        guard values.allSatisfy(\.isFinite) else { return false }
        let gravity = data.gravity
        let magnitude = sqrt(gravity.x * gravity.x + gravity.y * gravity.y + gravity.z * gravity.z)
        return magnitude.isFinite && magnitude > 0.5 && magnitude < 1.5
    }

    private func ensureDisplayLink() {
        let settled = !isSampling && abs(offset.x) < 0.02 && abs(offset.y) < 0.02 && presence < 0.002
        if settled {
            displayLink?.invalidate()
            displayLink = nil
            lastStepTime = nil
            if offset != .zero || presence != 0 {
                offset = .zero
                presence = 0
                backdrop?.setSpatialOffset(.zero, scale: 1)
            }
            return
        }
        guard displayLink == nil else { return }
        let link = CADisplayLink(target: proxy, selector: #selector(AmbientDisplayLinkProxy.step(_:)))
        // 位移每帧只有零点几个点，六十帧足够平滑，也避免高刷屏为此维持最高刷新率。
        link.preferredFrameRateRange = CAFrameRateRange(minimum: 30, maximum: 60, preferred: 60)
        link.add(to: .main, forMode: .common)
        displayLink = link
    }

    fileprivate func step(_ link: CADisplayLink) {
        let now = link.timestamp
        let dt = lastStepTime.map { min(0.1, max(0, now - $0)) } ?? 1.0 / 60
        lastStepTime = now
        var target = CGPoint.zero
        var presenceTarget: CGFloat = 0
        var timeConstant = Tuning.releaseTimeConstant
        if isSampling {
            if now - lastDataTime > Tuning.abandonTimeout {
                abandon()
            } else if let sample = latest, now - sample.time <= Tuning.stallTimeout,
                      let angles = trackedAngles(for: sample, at: now) {
                target = displacement(for: angles, at: now, dt: dt)
                presenceTarget = 1
                timeConstant = Tuning.followTimeConstant
            }
        }
        let blend = CGFloat(1 - exp(-dt / timeConstant))
        offset.x += (target.x - offset.x) * blend
        offset.y += (target.y - offset.y) * blend
        // 放大比例的进出始终用较慢的时间常数，进入页面或重新开启时不会出现可察觉的缩放跳动。
        let presenceBlend = CGFloat(1 - exp(-dt / Tuning.releaseTimeConstant))
        presence += (presenceTarget - presence) * presenceBlend
        render()
        if !isSampling { ensureDisplayLink() }
    }

    /// 返回相对基准的倾斜角（弧度）；基准尚未确立时返回空，此时画面保持原位。
    private func trackedAngles(for sample: Sample, at now: TimeInterval) -> (x: Double, y: Double)? {
        guard let baseline else {
            // 等待手部稳定后再取基准，避免把进入页面时的动作当成持姿；超时则直接采用当前姿态。
            if sample.rotationRate < Tuning.stableRotationRate {
                let since = stableSince ?? now
                stableSince = since
                if now - since >= Tuning.stableDuration { establishBaseline(sample.attitude, at: now) }
            } else {
                stableSince = nil
            }
            if self.baseline == nil, now - awaitingSince >= Tuning.baselineTimeout {
                establishBaseline(sample.attitude, at: now)
            }
            return nil
        }
        var angles = Self.tiltAngles(from: Self.relativeRotation(base: baseline, current: sample.attitude))
        // 大幅偏离并持续一段时间说明换了姿势：重新锚定基准，并把当前相对角度并入慢速分量，输出保持连续后再缓慢回中。
        if sqrt(angles.x * angles.x + angles.y * angles.y) > Tuning.reanchorAngle {
            let since = largeDeviationSince ?? now
            largeDeviationSince = since
            if now - since >= Tuning.reanchorDuration {
                self.baseline = sample.attitude
                largeDeviationSince = nil
                slowOffset = (slowOffset.x - angles.x, slowOffset.y - angles.y)
                angles = (0, 0)
            }
        } else {
            largeDeviationSince = nil
        }
        return (angles.x - slowOffset.x, angles.y - slowOffset.y)
    }

    private func establishBaseline(_ attitude: CMRotationMatrix, at now: TimeInterval) {
        baseline = attitude
        baselineTime = now
        stableSince = nil
        largeDeviationSince = nil
        slowOffset = (0, 0)
    }

    /// 把相对倾斜角换算为屏幕坐标下的目标位移（点）。
    private func displacement(for angles: (x: Double, y: Double), at now: TimeInterval, dt: TimeInterval) -> CGPoint {
        // 慢速回中：低频分量按长时间常数跟随当前角度；传入的角度已减去低频分量，直接按其比例逼近。
        let recenter = 1 - exp(-dt / Tuning.recenterTimeConstant)
        slowOffset.x += angles.x * recenter
        slowOffset.y += angles.y * recenter
        let tiltX = Self.softDeadZone(angles.x)
        let tiltY = Self.softDeadZone(angles.y)
        // 绕设备 Y 轴正向旋转时屏幕法线偏向右侧，视线相对屏幕位于左侧；绕 X 轴正向旋转时视线位于上方。
        // 窗口效果下远处画面随视线同向移动，因此设备坐标（X 向右、Y 向上）下的位移为 (-tiltY, +tiltX)，
        // 换到竖屏 UIKit 坐标（Y 向下）即 (-tiltY, -tiltX)。
        let gain = Tuning.maxDisplacement / CGFloat(Tuning.fullTiltRadians) * Tuning.direction
        let fixed = CGPoint(x: CGFloat(-tiltY) * gain, y: CGFloat(-tiltX) * gain)
        var raw = orientedVector(fixed)
        // 软饱和：逼近上限而不是硬截断，上限不超过放大后预留的边缘。
        let limit = displacementLimit()
        let radius = sqrt(raw.x * raw.x + raw.y * raw.y)
        if radius > 0, limit > 0 {
            let factor = limit * CGFloat(tanh(Double(radius / limit))) / radius
            raw.x *= factor
            raw.y *= factor
        }
        // 基准确立后渐入，再乘以睡眠渐隐等外部强度。
        let ramp = min(1, max(0, (now - baselineTime) / Tuning.rampDuration))
        let eased = CGFloat(ramp * ramp * (3 - 2 * ramp))
        let external = CGFloat(min(1, max(0, intensitySource?() ?? 1)))
        return CGPoint(x: raw.x * eased * external, y: raw.y * eased * external)
    }

    /// 位移上限：不超过配置值，也不超过放大比例在较短边上预留的边缘。
    private func displacementLimit() -> CGFloat {
        guard let backdrop else { return Tuning.maxDisplacement }
        let side = min(backdrop.bounds.width, backdrop.bounds.height)
        return min(Tuning.maxDisplacement, max(0, (Tuning.scale - 1) / 2 * side))
    }

    /// 把竖屏固定坐标下的向量转换到当前界面方向的坐标：用屏幕的固定坐标空间与界面坐标空间之间的换算求基向量，
    /// 不依赖对横屏枚举方向的记忆，iPad 旋转与倒置都按同一规则处理。
    private func orientedVector(_ vector: CGPoint) -> CGPoint {
        guard let screen = backdrop?.window?.screen else { return vector }
        let fixed = screen.fixedCoordinateSpace
        let current = screen.coordinateSpace
        let origin = fixed.convert(CGPoint.zero, to: current)
        let unitX = fixed.convert(CGPoint(x: 1, y: 0), to: current)
        let unitY = fixed.convert(CGPoint(x: 0, y: 1), to: current)
        let axisX = CGPoint(x: unitX.x - origin.x, y: unitX.y - origin.y)
        let axisY = CGPoint(x: unitY.x - origin.x, y: unitY.y - origin.y)
        return CGPoint(x: vector.x * axisX.x + vector.y * axisY.x,
                       y: vector.x * axisX.y + vector.y * axisY.y)
    }

    private func render() {
        guard let backdrop else { return }
        let scale = 1 + (Tuning.scale - 1) * presence
        // 渐入渐出期间放大比例小于目标值，位移按当前实际预留的边缘再限制一次，任何时刻都不露出底色。
        let marginX = max(0, (scale - 1) / 2 * backdrop.bounds.width)
        let marginY = max(0, (scale - 1) / 2 * backdrop.bounds.height)
        let clamped = CGPoint(x: min(marginX, max(-marginX, offset.x)),
                              y: min(marginY, max(-marginY, offset.y)))
        backdrop.setSpatialOffset(clamped, scale: scale)
    }

    /// 基准的转置乘当前姿态，得到从基准到当前的相对旋转，表达在基准时的设备坐标系中。
    /// 系统矩阵把设备坐标映射到参考坐标，字段 m(行)(列)。
    private static func relativeRotation(base: CMRotationMatrix, current: CMRotationMatrix) -> CMRotationMatrix {
        var result = CMRotationMatrix()
        result.m11 = base.m11 * current.m11 + base.m21 * current.m21 + base.m31 * current.m31
        result.m12 = base.m11 * current.m12 + base.m21 * current.m22 + base.m31 * current.m32
        result.m13 = base.m11 * current.m13 + base.m21 * current.m23 + base.m31 * current.m33
        result.m21 = base.m12 * current.m11 + base.m22 * current.m21 + base.m32 * current.m31
        result.m22 = base.m12 * current.m12 + base.m22 * current.m22 + base.m32 * current.m32
        result.m23 = base.m12 * current.m13 + base.m22 * current.m23 + base.m32 * current.m33
        result.m31 = base.m13 * current.m11 + base.m23 * current.m21 + base.m33 * current.m31
        result.m32 = base.m13 * current.m12 + base.m23 * current.m22 + base.m33 * current.m32
        result.m33 = base.m13 * current.m13 + base.m23 * current.m23 + base.m33 * current.m33
        return result
    }

    /// 由旋转矩阵求旋转向量在设备 X、Y 轴上的分量（弧度）。绕屏幕法线的旋转不改变视角，忽略 Z 分量。
    /// 小角度时退化为反对称部分的一半，大角度用旋转角与轴的乘积保持正确，不会在换姿势时失真。
    private static func tiltAngles(from matrix: CMRotationMatrix) -> (x: Double, y: Double) {
        let cosine = min(1, max(-1, (matrix.m11 + matrix.m22 + matrix.m33 - 1) / 2))
        let angle = acos(cosine)
        let sine = sin(angle)
        let factor = angle < 1e-4 || sine < 1e-6 ? 0.5 : angle / (2 * sine)
        return (x: (matrix.m32 - matrix.m23) * factor, y: (matrix.m13 - matrix.m31) * factor)
    }

    /// 软死区：阈值内输出趋近于零，阈值外平滑衔接，不在边界产生跳变。
    private static func softDeadZone(_ value: Double) -> Double {
        value - Tuning.deadZone * tanh(value / Tuning.deadZone)
    }

    private func observe(_ name: Notification.Name, handler: @escaping () -> Void) {
        observers.append(NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { _ in
            // 电量与温度通知来自后台线程，统一投递到主队列后再同步处理。
            MainActor.assumeIsolated { handler() }
        })
    }

    deinit {
        observers.forEach(NotificationCenter.default.removeObserver)
        displayLink?.invalidate()
        motion.stopDeviceMotionUpdates()
    }
}

/// 屏幕刷新回调的弱引用中转，避免刷新链持有控制器形成循环引用。
@MainActor
private final class AmbientDisplayLinkProxy: NSObject {
    weak var owner: AmbientSpatialMotion?

    @objc func step(_ link: CADisplayLink) {
        owner?.step(link)
    }
}
