//
//  AHAppUpdateDialog.swift
//  LLVod
//
//  版本更新弹窗，对应 Flutter UpdateDialog
//  强制更新：不可关闭、无「暂不更新」、点遮罩无效
//

import SwiftUI

struct AHAppUpdateDialog: View {

    let info: AHAppUpdateInfo
    var onUpdate: () -> Void
    var onIgnore: (() -> Void)?

    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                // 强制更新时拦截所有穿透点击，且不响应关闭
                .allowsHitTesting(true)

            VStack(spacing: 0) {
                // 顶部装饰条
                LinearGradient(
                    colors: [
                        themeManager.mainTheme.primary,
                        themeManager.mainTheme.primary.opacity(0.75)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 72)
                .overlay(
                    Text("版本更新")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                )

                VStack(alignment: .leading, spacing: 12) {
                    Text(info.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)

                    ScrollView {
                        Text(info.bodyText.isEmpty ? "修复已知问题，提升使用体验。" : info.bodyText)
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxHeight: 180)

                    Button(action: onUpdate) {
                        Text(info.updateButtonTitle)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(themeManager.mainTheme.primary)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)

                    if !info.isForce {
                        Button("暂不更新") {
                            onIgnore?()
                        }
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 2)
                        .padding(.bottom, 4)
                    }
                }
                .padding(18)
            }
            .frame(width: 290)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(.systemBackground))
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: .black.opacity(0.2), radius: 16, y: 8)
        }
    }
}
