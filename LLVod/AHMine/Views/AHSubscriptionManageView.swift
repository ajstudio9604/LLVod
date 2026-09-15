//
//  AHSubscriptionManageView.swift
//  LLVod
//
//  订阅管理，对应 Flutter kz/dygl.dart：开关控制搜索是否使用该订阅
//

import SwiftUI

struct AHSubscriptionManageView: View {

    @State private var items: [AHMineSubscriptionItem] = []
    @State private var isRefreshing = false
    @State private var errorMessage: String?
    @State private var toast: String?

    var body: some View {
        Group {
            if items.isEmpty && isRefreshing {
                ProgressView("正在加载订阅")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if items.isEmpty {
                emptyState
            } else {
                List {
                    Section {
                        ForEach($items) { $item in
                            Toggle(isOn: $item.isEnabled) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title)
                                        .font(.system(size: 15, weight: .semibold))

                                    if !item.author.isEmpty {
                                        Text(item.author)
                                            .font(.system(size: 12))
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .onChange(of: item.isEnabled) { enabled in
                                SearchStorage.setSubscriptionEnabled(
                                    title: item.title,
                                    enabled: enabled
                                )
                                showToast(enabled ? "已开启 \(item.title)" : "已关闭 \(item.title)")
                            }
                        }
                    } footer: {
                        Text("关闭后搜索不会使用该订阅的站源。至少保留一个开启，否则搜索会提示没有可用订阅。")
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("订阅管理")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task { await refreshRemote() }
                } label: {
                    if isRefreshing {
                        ProgressView()
                    } else {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                .disabled(isRefreshing)
            }
        }
        .alert(
            "提示",
            isPresented: Binding(
                get: { errorMessage != nil },
                set: { if !$0 { errorMessage = nil } }
            )
        ) {
            Button("确定") { errorMessage = nil }
        } message: {
            Text(errorMessage ?? "")
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
                    .transition(.opacity)
            }
        }
        .task {
            await load()
        }
        .ahHideTabBar()
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "list.bullet.rectangle")
                .font(.system(size: 36))
                .foregroundColor(.secondary)
            Text("暂无订阅")
                .font(.headline)
            Button("重新获取") {
                Task { await refreshRemote() }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func load() async {
        // 先尽量保证本地有一份，再读 yhcache 列表
        _ = try? await AHSearchSubscriptionLoader.ensureLoaded()
        if let subscription = AHSearchSubscriptionLoader.load() {
            SearchStorage.saveDictionaryList("xdycache", list: [[
                "订阅标题": subscription.name,
                "作者": subscription.author
            ]])
        }

        let list = SearchStorage.rslzDictionaryList("xdycache")
        items = list.compactMap { dict in
            guard let title = dict["订阅标题"] as? String, !title.isEmpty else {
                return nil
            }
            return AHMineSubscriptionItem(
                title: title,
                author: dict["作者"] as? String ?? "",
                isEnabled: SearchStorage.isSubscriptionEnabled(title: title)
            )
        }
    }

    private func refreshRemote() async {
        isRefreshing = true
        defer { isRefreshing = false }

        do {
            _ = try await AHSearchSubscriptionLoader.refresh()
            await load()
            showToast("订阅已更新")
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func showToast(_ text: String) {
        toast = text
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if toast == text { toast = nil }
        }
    }
}

private struct AHMineSubscriptionItem: Identifiable {
    var id: String { title }
    let title: String
    let author: String
    var isEnabled: Bool
}
