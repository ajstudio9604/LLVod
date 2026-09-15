//
//  ThemeManager.swift
//  LLVod
//
//  Created by minusapple on 2026/1/2.
//

import Combine
import Foundation
import SwiftUI
import Combine
import UIKit

extension Color {
    static let themeRed = Color(red: 233/255,
                                green: 82/255,
                                blue: 81/255)
}

final class ThemeManager: ObservableObject {
    static let shared = ThemeManager()

    @Published private(set) var mainTheme: Theme

    private let themeKey = "AppTheme"

    private init() {
        if let raw = UserDefaults.standard.object(forKey: themeKey) as? Int,
           let stored = Theme(rawValue: raw) {
            mainTheme = stored
        } else {
            mainTheme = .system
        }
        applyInterfaceStyle(mainTheme)
    }

    func setTheme(_ theme: Theme) {
        mainTheme = theme
        UserDefaults.standard.set(theme.rawValue, forKey: themeKey)
        applyInterfaceStyle(theme)
        AHTabBarAppearance.update(theme: theme)
    }

    func reapplyInterfaceStyle() {
        applyInterfaceStyle(mainTheme)
    }

    private func applyInterfaceStyle(_ theme: Theme) {
        let style: UIUserInterfaceStyle
        switch theme {
        case .system: style = .unspecified
        case .light: style = .light
        case .dark: style = .dark
        }

        let apply = {
            let windows = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap(\.windows)
            if windows.isEmpty {
                AppWindow.current?.overrideUserInterfaceStyle = style
                return
            }
            windows.forEach { $0.overrideUserInterfaceStyle = style }
        }

        if Thread.isMainThread {
            apply()
        } else {
            DispatchQueue.main.async(execute: apply)
        }
    }
}

enum Theme: Int, CaseIterable, Identifiable {

    case system = 0
    case light = 1
    case dark = 2

    var id: Int { self.rawValue }

    var description: String {
        switch self {
        case .system: return "跟随系统"
        case .light: return "浅色模式"
        case .dark: return "深色模式"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }

    var primary: Color {
        .themeRed   // #E95251
    }

    var background: Color {
        switch self {
        case .light: return .white
        case .dark: return .black
        // 跟随系统时不要用半透明色，否则 iPadOS 15 TabBar / 导航底会透出内容
        case .system: return Color(UIColor.systemBackground)
        }
    }

    var text: Color {
        switch self {
        case .light: return .black
        case .dark: return .white
        case .system: return Color(UIColor.label)
        }
    }
}
