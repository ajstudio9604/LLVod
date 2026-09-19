//
//  App.swift
//  LLVod
//
//  Created by minusapple on 2026/1/2.
//

import SwiftUI

@main
struct LLVodApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            // 应用只包含环境空间业务，直接作为根视图显示。
            WorkspaceRootView()
                .ignoresSafeArea()
        }
    }
}
