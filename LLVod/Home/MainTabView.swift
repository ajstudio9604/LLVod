//
//  MainTabbarView.swift
//  LLVod
//
//  Created by minusapple on 2026/1/2.
//

import SwiftUI
import Combine
import UIKit

struct MainTabView: View {
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        TabView {

            AHHomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("首页")
                }

            AHDouBanCategoryView()
                .tabItem {
                    Image(systemName: "rectangle.stack")
                    Text("片单")
                }

            AHFilterView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("分类")
                }

            RankView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("排行")
                }

            AHMineView()
                .tabItem {
                    Image(systemName: "person")
                    Text("我的")
                }
        }
        .onAppear {
            AHTabBarAppearance.update(theme: themeManager.mainTheme)
        }
        .onChange(of: themeManager.mainTheme) { theme in
            AHTabBarAppearance.update(theme: theme)
        }
    }
}

enum AHTabBarAppearance {

    static func update(theme: Theme) {
        let primary = UIColor(theme.primary)
        let appearance = UITabBarAppearance()

        if #available(iOS 26.0, *) {
            appearance.configureWithTransparentBackground()
        } else {
            appearance.configureWithDefaultBackground()
        }
        appearance.shadowColor = UIColor.separator.withAlphaComponent(0.25)

        configureItemAppearance(appearance.stackedLayoutAppearance, primary: primary)
        configureItemAppearance(appearance.inlineLayoutAppearance, primary: primary)
        configureItemAppearance(appearance.compactInlineLayoutAppearance, primary: primary)

        let proxy = UITabBar.appearance()
        proxy.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            proxy.scrollEdgeAppearance = appearance
        }
        proxy.isTranslucent = true
        proxy.backgroundColor = .clear
        proxy.barTintColor = nil
        proxy.tintColor = primary
        proxy.unselectedItemTintColor = .gray
        
        proxy.itemPositioning = .fill

        DispatchQueue.main.async {
            for window in UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap(\.windows) {
                apply(appearance, primary: primary, in: window.rootViewController)
            }
        }
    }

    private static func configureItemAppearance(
        _ itemAppearance: UITabBarItemAppearance,
        primary: UIColor
    ) {
        // 显式小字号，防止 iPadOS 15 未选中项标题被截成省略号
        let font = UIFont.systemFont(ofSize: 10)
        itemAppearance.normal.iconColor = .gray
        itemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray,
            .font: font
        ]
        itemAppearance.selected.iconColor = primary
        itemAppearance.selected.titleTextAttributes = [
            .foregroundColor: primary,
            .font: font
        ]
        itemAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        itemAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
    }

    private static func apply(
        _ appearance: UITabBarAppearance,
        primary: UIColor,
        in controller: UIViewController?
    ) {
        guard let controller else { return }

        if let tab = controller as? UITabBarController {
            let tabBar = tab.tabBar
            tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
            tabBar.isTranslucent = true
            tabBar.backgroundColor = .clear
            tabBar.barTintColor = nil
            tabBar.tintColor = primary
            tabBar.itemPositioning = .fill
        }

        for child in controller.children {
            apply(appearance, primary: primary, in: child)
        }
        if let presented = controller.presentedViewController {
            apply(appearance, primary: primary, in: presented)
        }
    }
}
