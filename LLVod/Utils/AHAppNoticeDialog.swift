//
//  AHAppNoticeDialog.swift
//  LLVod
//
//  启动公告弹窗，对应 Flutter AppNoticeDialog
//

import SwiftUI

struct AHAppNoticeDialog: View {

    let info: AHAppNoticeInfo
    var onConfirm: () -> Void
    var onNeverShowAgain: () -> Void

    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        ZStack {
            Color.black.opacity(0.45)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Text("公告")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
                    .padding(.top, 20)
                    .padding(.bottom, 12)

                ScrollView {
                    Text(info.content)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 18)
                }
                .frame(maxHeight: 260)

                Divider().padding(.top, 14)

                HStack(spacing: 0) {
                    Button("不再提示") {
                        onNeverShowAgain()
                    }
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)

                    Divider().frame(height: 44)

                    Button("知道了") {
                        onConfirm()
                    }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(themeManager.mainTheme.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                }
            }
            .frame(width: 300)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(.systemBackground))
            )
            .padding(.horizontal, 28)
        }
    }
}
