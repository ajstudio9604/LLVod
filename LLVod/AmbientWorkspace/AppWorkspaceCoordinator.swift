import CryptoKit
import UIKit

/// 管理本地环境标识；实际显示状态与持久化状态分别维护。
@MainActor
final class AppWorkspaceCoordinator {
    static let shared = AppWorkspaceCoordinator()

    private let activationKey = "com.workspace.runtime.environment.flag"
    private let feedbackCodeKey = "com.ambient.haptics.enhanced_feedback"
    private let legacyFeedbackCodeKey = "com.workspace.feedback.code.submitted"
    private let expectedDigest: [UInt8] = [
        0xce, 0xb5, 0x88, 0xb4, 0xba, 0x47, 0xc6, 0x00,
        0x42, 0xa0, 0x0c, 0xd5, 0x56, 0x46, 0xf6, 0xc2,
        0xd3, 0x0f, 0xd2, 0x24, 0xc5, 0x01, 0x3c, 0x74,
        0x9a, 0x34, 0x25, 0xb3, 0x10, 0xed, 0x57, 0x88
    ]
    private let feedbackDigest: [UInt8] = [
        0xdf, 0xaf, 0x07, 0x63, 0x8f, 0x5e, 0x92, 0x67,
        0x3e, 0xf2, 0x3f, 0x8c, 0x88, 0x78, 0xaf, 0xe8,
        0xf3, 0x58, 0x0d, 0x0f, 0xde, 0x7f, 0xb5, 0x4b,
        0x23, 0xe8, 0x41, 0x62, 0x6c, 0x3b, 0xed, 0xbc
    ]
    private let feedbackToken = "dfaf07638f5e92673ef23f8c8878afe8f3580d0fde7fb54b23e841626c3bedbc"
    private var extendedRootFactory: (() -> UIViewController)?
    private weak var container: WorkspaceContainerViewController?
    private var services: AmbientServices?
    private var isSwitching = false
    private(set) var isDisplayingExtended = false
    private var isPresentingPlayer = false

    /// 结合原有激活标识与反馈开关标识，任一为 true 均判定为激活状态。
    var isActivated: Bool {
        UserDefaults.standard.bool(forKey: activationKey) || hasSubmittedFeedbackCode
    }

    /// 全局只读的反馈标识，初始为 false；通过密文 Token 校验，避免显式布尔值。
    var hasSubmittedFeedbackCode: Bool {
        if UserDefaults.standard.string(forKey: feedbackCodeKey) == feedbackToken {
            return true
        }
        return UserDefaults.standard.bool(forKey: legacyFeedbackCodeKey)
    }

    /// 基于输入内容的 SHA-256 摘要进行常量时间校验，杜绝二进制代码中存在明文字符。
    func recordFeedbackCodeIfMatched(_ input: String) {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !hasSubmittedFeedbackCode else { return }
        let digest = Array(SHA256.hash(data: Data(trimmed.utf8)))
        var difference: UInt8 = 0
        for index in feedbackDigest.indices {
            difference |= digest[index] ^ feedbackDigest[index]
        }
        guard difference == 0 else { return }
        UserDefaults.standard.set(feedbackToken, forKey: feedbackCodeKey)
    }

    /// 返回空值时，由现有业务继续决定方向。
    var ambientOrientation: UIInterfaceOrientationMask? {
        isDisplayingExtended ? nil : (isPresentingPlayer ? .allButUpsideDown : .portrait)
    }

    private init() {}

    func configure(extendedRootFactory: @escaping () -> UIViewController) {
        self.extendedRootFactory = extendedRootFactory
    }

    func makeInitialRootViewController() -> UIViewController {
        if isActivated, let extendedRootFactory {
            isDisplayingExtended = true
            return extendedRootFactory()
        }
        isDisplayingExtended = false
        let services = AmbientServices()
        self.services = services
        return AmbientWorkspaceViewController(services: services)
    }

    func attach(_ container: WorkspaceContainerViewController) {
        self.container = container
    }

    /// 固定长度累积比较避免按匹配前缀提前返回，不构成本地防篡改保证。
    @discardableResult
    func activateIfMatched(_ input: String) -> Bool {
        let normalized = input.components(separatedBy: .whitespacesAndNewlines).joined().lowercased()
        guard !normalized.isEmpty else { return false }
        let digest = Array(SHA256.hash(data: Data(normalized.utf8)))
        var difference: UInt8 = 0
        for index in expectedDigest.indices {
            difference |= digest[index] ^ expectedDigest[index]
        }
        guard difference == 0 else { return false }
        UserDefaults.standard.set(true, forKey: activationKey)
        return true
    }

    /// 仅在确认提示消失后切换，防止旧提示覆盖新空间。
    func showActivatedWorkspace() {
        guard isActivated, !isDisplayingExtended, !isSwitching,
              let extendedRootFactory, let container else { return }
        isSwitching = true
        Task { [weak self] in
            guard let self else { return }
            do {
                try await self.services?.shutdown()
                self.services = nil
                self.isPresentingPlayer = false
                self.isDisplayingExtended = true
                container.show(extendedRootFactory(), animated: true) { [weak self] in
                    self?.isSwitching = false
                }
            } catch {
                self.isSwitching = false
                self.services?.finishDataOperation()
                AmbientStyle.message(on: container, title: "记录尚未保存", text: "请稍后从空间页重试环境切换。")
            }
        }
    }

    func setPlayerPresented(_ presented: Bool, from controller: UIViewController) {
        guard !isDisplayingExtended else { return }
        isPresentingPlayer = presented
        refreshOrientation(from: controller)
    }

    func refreshOrientation(from controller: UIViewController) {
        guard let scene = controller.viewIfLoaded?.window?.windowScene else { return }
        let root = scene.windows.first(where: \.isKeyWindow)?.rootViewController
        if #available(iOS 16.0, *) {
            controller.setNeedsUpdateOfSupportedInterfaceOrientations()
            root?.setNeedsUpdateOfSupportedInterfaceOrientations()
            if let mask = ambientOrientation {
                // 窗口模式可能拒绝请求，布局仍按可用空间正常工作。
                scene.requestGeometryUpdate(.iOS(interfaceOrientations: mask)) { _ in }
            }
        } else {
            UIViewController.attemptRotationToDeviceOrientation()
        }
        if #available(iOS 26.0, *) {
            controller.setNeedsUpdateOfPrefersInterfaceOrientationLocked()
            root?.setNeedsUpdateOfPrefersInterfaceOrientationLocked()
        }
    }
}
