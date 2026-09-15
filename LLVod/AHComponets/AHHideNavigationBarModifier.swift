//
//  AHHideNavigationBarModifier.swift
//  LLVod
//
//  详情/播放页自绘顶栏，需要把系统导航栏和返回按钮一起去掉
//

import SwiftUI
import UIKit

extension View {
    func ahHideNavigationBar() -> some View {
        modifier(AHHideNavigationBarModifier())
    }
}

struct AHHideNavigationBarModifier: ViewModifier {

    func body(content: Content) -> some View {
        declarativeHidden(content)
            .navigationBarBackButtonHidden(true)
            .background(AHNavigationBarHider())
    }

    @ViewBuilder
    private func declarativeHidden(_ content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.toolbar(.hidden, for: .navigationBar)
        } else {
            content.navigationBarHidden(true)
        }
    }
}

private struct AHNavigationBarHider: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> Hider { Hider() }

    func updateUIViewController(_ uiViewController: Hider, context: Context) {}

    final class Hider: UIViewController, UIGestureRecognizerDelegate {

        private var shouldRestore = false
        private var observation: NSKeyValueObservation?
        private var isEnforcing = false

        override func viewDidLoad() {
            super.viewDidLoad()
            // 必须关掉交互，否则会盖住整页，导致顶栏按钮点不到（iPadOS 15 尤其明显）
            view.backgroundColor = .clear
            view.isUserInteractionEnabled = false
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            if let nav = navigationController, !nav.isNavigationBarHidden {
                shouldRestore = true
                hideBar(nav)
            }
            enableInteractivePop()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            if shouldRestore, let nav = navigationController {
                // 系统可能在转场结束后又把导航栏显示回来，盯住它再关掉
                hideBar(nav)
                observation = nav.navigationBar.observe(\.isHidden, options: [.new]) { [weak self] _, change in
                    guard let self, !self.isEnforcing, change.newValue == false,
                          let nav = self.navigationController else { return }
                    self.hideBar(nav)
                    self.enableInteractivePop()
                }
            }
            enableInteractivePop()
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            observation = nil

            guard shouldRestore else { return }
            shouldRestore = false
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }

        private func hideBar(_ nav: UINavigationController) {
            isEnforcing = true
            nav.setNavigationBarHidden(true, animated: false)
            isEnforcing = false
        }

        private func enableInteractivePop() {
            guard let nav = navigationController,
                  let pop = nav.interactivePopGestureRecognizer else { return }
            pop.isEnabled = true
            // navigationBarBackButtonHidden(true) 后系统会禁止侧滑；自己当 delegate 放行
            pop.delegate = self
        }

        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            (navigationController?.viewControllers.count ?? 0) > 1
        }

        func gestureRecognizer(
            _ gestureRecognizer: UIGestureRecognizer,
            shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
        ) -> Bool {
            false
        }
    }
}
