//
//  AHSettingsView.swift
//  LLVod
//
//  设置页（对应 Flutter SZ 的精简版）
//

import SwiftUI
import Kingfisher

struct AHSettingsView: View {

    @EnvironmentObject private var themeManager: ThemeManager
    @State private var showClearCacheConfirm = false
    @State private var toast: String?

    var body: some View {
        List {
            Section("外观") {
                NavigationLink {
                    AHThemePickerView()
                } label: {
                    HStack {
                        Text("主题风格")
                        Spacer()
                        Text(themeManager.mainTheme.description)
                            .foregroundColor(.secondary)
                    }
                }
            }

            Section("存储") {
                Button("清理图片缓存") {
                    showClearCacheConfirm = true
                }
            }

            Section("关于") {
                NavigationLink("应用协议") {
                    AHAboutView()
                }

                HStack {
                    Text("当前版本")
                    Spacer()
                    Text(appVersion)
                        .foregroundColor(.secondary)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("设置")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog(
            "清理本地图片缓存？",
            isPresented: $showClearCacheConfirm,
            titleVisibility: .visible
        ) {
            Button("清理", role: .destructive) {
                clearImageCache()
            }
            Button("取消", role: .cancel) {}
        }
        .overlay(alignment: .bottom) {
            if let toast {
                Text(toast)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Capsule().fill(Color.black.opacity(0.75)))
                    .padding(.bottom, 24)
            }
        }
        .ahHideTabBar()
    }

    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "-"
        return "\(version) (\(build))"
    }

    private func clearImageCache() {
        // Kingfisher 全局缓存
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache {
            DispatchQueue.main.async {
                toast = "图片缓存已清理"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    toast = nil
                }
            }
        }
    }
}
