//
//  App.swift
//  LLVod
//
//  Created by minusapple on 2026/1/2.
//

import SwiftUI

@main
struct LLVodApp: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            // 环境空间作为应用首屏；原有业务在空间切换后仍由同一工厂创建。
            WorkspaceRootView {
                UIHostingController(
                    rootView: AppBootstrapGate {
                        AppRootView()
                    }
                    .environmentObject(ThemeManager.shared)
                    .background(AppWindowBinder())
                )
            }
            .ignoresSafeArea()
        }
    }
}
