//
//  AHRotationLayoutFix.swift
//  LLVod
//

import SwiftUI
import UIKit

extension View {
    func ahFixLayoutAfterRotation() -> some View {
        modifier(AHRotationLayoutFixModifier())
    }
}

private struct AHRotationLayoutFixModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .onAppear {
                AHRotationLayoutFix.scheduleRefresh()
            }
            .onReceive(
                NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            ) { _ in
                AHRotationLayoutFix.scheduleRefresh()
            }
    }
}

enum AHRotationLayoutFix {

    private static var pendingRefresh: DispatchWorkItem?

    static func scheduleRefresh() {
        pendingRefresh?.cancel()

        let work = DispatchWorkItem { refresh() }
        pendingRefresh = work
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: work)
    }

    static func refresh() {
        guard let window = activeWindow else { return }

        window.setNeedsLayout()
        window.layoutIfNeeded()

        if let root = window.rootViewController {
            relayout(root)
        }
    }

    private static func relayout(_ controller: UIViewController) {
        controller.view.setNeedsLayout()
        controller.view.layoutIfNeeded()
        controller.children.forEach(relayout)
        if let presented = controller.presentedViewController {
            relayout(presented)
        }
    }

    private static var activeWindow: UIWindow? {
        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        guard let scene = scenes.first(where: { $0.activationState == .foregroundActive }) ?? scenes.first else {
            return nil
        }
        return scene.windows.first { $0.isKeyWindow } ?? scene.windows.first
    }
}
