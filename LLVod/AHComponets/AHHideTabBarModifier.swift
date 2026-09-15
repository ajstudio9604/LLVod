//
//  AHHideTabBarModifier.swift
//  LLVod
//
//  push 进来的页面都不该再显示底部 TabBar，退回到 MainTabView 的某个根页面才显示
//

import SwiftUI
import UIKit

extension View {
    func ahHideTabBar() -> some View {
        modifier(AHHideTabBarModifier())
    }
}

struct AHHideTabBarModifier: ViewModifier {

    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            // 系统自带的写法，跟 push 转场一起动，最干净
            content.toolbar(.hidden, for: .tabBar)
        } else {
            content.background(AHTabBarHider())
        }
    }
}

struct AHTabBarHider: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> Hider { Hider() }

    func updateUIViewController(_ uiViewController: Hider, context: Context) {}

    final class Hider: UIViewController {

        private var shouldRestore = false

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .clear
            view.isUserInteractionEnabled = false
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            guard let tabBarController, !tabBarController.tabBar.isHidden else { return }

            shouldRestore = true
            tabBarController.tabBar.isHidden = true
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            guard shouldRestore else { return }

            shouldRestore = false
            tabBarController?.tabBar.isHidden = false
        }
    }
}
