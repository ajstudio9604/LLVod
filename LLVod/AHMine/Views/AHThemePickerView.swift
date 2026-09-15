//
//  AHThemePickerView.swift
//  LLVod
//
//  主题风格，对应 Flutter Themegl
//

import SwiftUI

struct AHThemePickerView: View {

    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        List {
            Section {
                ForEach(Theme.allCases) { theme in
                    Button {
                        themeManager.setTheme(theme)
                    } label: {
                        HStack {
                            Text(theme.description)
                                .foregroundColor(.primary)

                            Spacer()

                            if themeManager.mainTheme == theme {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(themeManager.mainTheme.primary)
                            }
                        }
                    }
                }
            } footer: {
                Text("切换后立即生效，并会记住你的选择。")
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("主题风格")
        .navigationBarTitleDisplayMode(.inline)
        .ahHideTabBar()
    }
}
