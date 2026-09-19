import UIKit

/// 维护容器根控制器与播放器呈现状态，统一决定界面方向。
@MainActor
final class AppWorkspaceCoordinator {
    static let shared = AppWorkspaceCoordinator()

    private weak var container: WorkspaceContainerViewController?
    private var services: AmbientServices?
    private var isPresentingPlayer = false

    /// 播放器全屏时允许横屏，其余页面固定竖屏。
    var ambientOrientation: UIInterfaceOrientationMask {
        isPresentingPlayer ? .allButUpsideDown : .portrait
    }

    private init() {}

    func makeInitialRootViewController() -> UIViewController {
        let services = AmbientServices()
        self.services = services
        return AmbientWorkspaceViewController(services: services)
    }

    func attach(_ container: WorkspaceContainerViewController) {
        self.container = container
    }

    func setPlayerPresented(_ presented: Bool, from controller: UIViewController) {
        isPresentingPlayer = presented
        refreshOrientation(from: controller)
    }

    func refreshOrientation(from controller: UIViewController) {
        guard let scene = controller.viewIfLoaded?.window?.windowScene else { return }
        let root = scene.windows.first(where: \.isKeyWindow)?.rootViewController
        if #available(iOS 16.0, *) {
            controller.setNeedsUpdateOfSupportedInterfaceOrientations()
            root?.setNeedsUpdateOfSupportedInterfaceOrientations()
            // 窗口模式可能拒绝请求，布局仍按可用空间正常工作。
            scene.requestGeometryUpdate(.iOS(interfaceOrientations: ambientOrientation)) { _ in }
        } else {
            UIViewController.attemptRotationToDeviceOrientation()
        }
        if #available(iOS 26.0, *) {
            controller.setNeedsUpdateOfPrefersInterfaceOrientationLocked()
            root?.setNeedsUpdateOfPrefersInterfaceOrientationLocked()
        }
    }
}
