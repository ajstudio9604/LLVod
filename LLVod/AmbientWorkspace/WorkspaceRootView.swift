import Combine
import SwiftUI
import UIKit

/// 窗口仍由 SwiftUI 管理，仅替换容器中的子控制器。
struct WorkspaceRootView: UIViewControllerRepresentable {
    let extendedRootFactory: () -> UIViewController

    func makeUIViewController(context: Context) -> WorkspaceContainerViewController {
        WorkspaceSceneContext.shared.phase = context.environment.scenePhase
        let coordinator = AppWorkspaceCoordinator.shared
        coordinator.configure(extendedRootFactory: extendedRootFactory)
        let container = WorkspaceContainerViewController()
        coordinator.attach(container)
        container.show(coordinator.makeInitialRootViewController(), animated: false)
        return container
    }

    func updateUIViewController(_ controller: WorkspaceContainerViewController, context: Context) {
        // UIKit 边界不会自动继承外层 SwiftUI 环境，显式保留前后台事件。
        let phase = context.environment.scenePhase
        DispatchQueue.main.async {
            if WorkspaceSceneContext.shared.phase != phase {
                WorkspaceSceneContext.shared.phase = phase
            }
        }
    }
}

/// 场景状态独立于业务实例，专注空间显示时不创建扩展根视图。
@MainActor
private final class WorkspaceSceneContext: ObservableObject {
    static let shared = WorkspaceSceneContext()
    @Published var phase: ScenePhase = .inactive
}

struct WorkspaceEnvironmentView<Content: View>: View {
    @ObservedObject private var scene = WorkspaceSceneContext.shared
    private let content: Content

    init(@ViewBuilder content: () -> Content) { self.content = content() }

    var body: some View {
        content.environment(\.scenePhase, scene.phase)
    }
}

/// 转发当前子控制器的状态栏和方向偏好，完整管理容器生命周期。
final class WorkspaceContainerViewController: UIViewController {
    private var content: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AmbientStyle.background
    }

    override var childForStatusBarStyle: UIViewController? { content }
    override var childForStatusBarHidden: UIViewController? { content }
    override var childForHomeIndicatorAutoHidden: UIViewController? { content }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        // 扩展业务沿用当前工程的默认方向策略，避免依赖 aPackage 的无关实现。
        AppWorkspaceCoordinator.shared.ambientOrientation ?? .all
    }

    @available(iOS 26.0, *)
    override var childForInterfaceOrientationLock: UIViewController? { content }

    func show(_ controller: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        loadViewIfNeeded()
        let previous = content
        previous?.willMove(toParent: nil)
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        content = controller
        let finish = {
            previous?.view.removeFromSuperview()
            previous?.removeFromParent()
            controller.didMove(toParent: self)
            self.setNeedsStatusBarAppearanceUpdate()
            AppWorkspaceCoordinator.shared.refreshOrientation(from: self)
            completion?()
        }
        guard animated, let previous else {
            finish()
            return
        }
        // 已显示的父容器中，用系统容器转场统一转发出现与消失回调。
        view.bringSubviewToFront(previous.view)
        transition(from: previous, to: controller, duration: UIAccessibility.isReduceMotionEnabled ? 0 : 0.35,
                   options: [.transitionCrossDissolve, .curveEaseInOut], animations: nil) { _ in finish() }
    }
}

final class AmbientNavigationController: UINavigationController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        view.backgroundColor = AmbientStyle.background
        navigationBar.tintColor = AmbientStyle.accent
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AmbientStyle.background
        appearance.titleTextAttributes = [.foregroundColor: AmbientStyle.text]
        appearance.shadowColor = .clear
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }

    /// 根页可使用自己的内容标题；推入详情、反馈或返回时统一恢复正确的导航栏。
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {
        let hidesBar = viewController is AmbientHomeViewController || viewController is AmbientAchievementsViewController || viewController is AmbientSpaceViewController
        setNavigationBarHidden(hidesBar, animated: animated)
        // 通透场景页的返回按钮与正文同色，保持反馈页和空间页的视觉连续性。
        let usesSceneText = viewController is AmbientHabitsViewController || viewController is FeedbackCollectorViewController
        navigationBar.tintColor = usesSceneText ? AmbientStyle.text : AmbientStyle.accent
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        topViewController is AmbientHomeViewController || traitCollection.userInterfaceStyle == .dark ? .lightContent : .darkContent
    }
    // 系统界面的隐藏偏好跟随当前顶层控制器，返回页面时同步恢复。
    override var childForStatusBarHidden: UIViewController? { topViewController }
    override var childForHomeIndicatorAutoHidden: UIViewController? { topViewController }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }

    @available(iOS 26.0, *)
    override var prefersInterfaceOrientationLocked: Bool { true }
}
