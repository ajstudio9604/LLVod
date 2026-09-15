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
            AppBootstrapGate {
                AppRootView()
            }
            .environmentObject(ThemeManager.shared)
            .background(AppWindowBinder())
        }
    }
}
