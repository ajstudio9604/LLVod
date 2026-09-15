//
//  AHJoinUsSheet.swift
//  LLVod
//
//  加入 QQ / TG 群，对应 Flutter qunSheet
//

import SwiftUI

struct AHJoinUsSheet: View {

    @ObservedObject private var appConfig = AHAppConfig.shared
    @Environment(\.dismiss) private var dismiss
    @State private var openFailedHint: String?

    var body: some View {
        NavigationView {
            List {
                if !appConfig.qqGroupURL.isEmpty {
                    Button {
                        open(appConfig.qqGroupURL, name: "QQ群")
                    } label: {
                        Label("加入QQ群", systemImage: "bubble.left.and.bubble.right.fill")
                    }
                }

                if !appConfig.tgGroupURL.isEmpty {
                    Button {
                        open(appConfig.tgGroupURL, name: "TG群")
                    } label: {
                        Label("加入TG群", systemImage: "paperplane.fill")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("加入我们")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("关闭") { dismiss() }
                }
            }
            .alert(
                "提示",
                isPresented: Binding(
                    get: { openFailedHint != nil },
                    set: { if !$0 { openFailedHint = nil } }
                )
            ) {
                Button("确定") { openFailedHint = nil }
            } message: {
                Text(openFailedHint ?? "")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func open(_ raw: String, name: String) {
        guard let url = URL(string: raw), !raw.isEmpty else {
            openFailedHint = "\(name)链接无效"
            return
        }

        UIApplication.shared.open(url, options: [:]) { success in
            if !success {
                openFailedHint = "无法打开\(name)链接"
            } else {
                dismiss()
            }
        }
    }
}
