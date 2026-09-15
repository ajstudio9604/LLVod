//
//  AHFavoriteListView.swift
//  LLVod
//
//  收藏列表，对应 Flutter browse/sc.dart
//

import SwiftUI

struct AHFavoriteListView: View {

    @State private var records: [AHVodFavoriteRecord] = []
    @State private var showClearConfirm = false

    var body: some View {
        Group {
            if records.isEmpty {
                ScrollView {
                    emptyState
                        .frame(maxWidth: .infinity, minHeight: 420)
                }
                .refreshable {
                    await syncFromCloud()
                }
            } else {
                List {
                    ForEach(records) { record in
                        row(record)
                            .swipeActions {
                                Button("删除", role: .destructive) {
                                    remove(record)
                                }
                            }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await syncFromCloud()
                }
            }
        }
        .navigationTitle("我的收藏")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showClearConfirm = true
                } label: {
                    Image(systemName: "trash")
                }
                .disabled(records.isEmpty)
            }
        }
        .confirmationDialog(
            "清空全部收藏？",
            isPresented: $showClearConfirm,
            titleVisibility: .visible
        ) {
            Button("清空", role: .destructive) {
                AHVodLocalStore.clearFavorites()
                records = []
            }
            Button("取消", role: .cancel) {}
        }
        .onAppear(perform: reload)
        .onReceive(NotificationCenter.default.publisher(for: .ahVodFavoriteDidChange)) { _ in
            reload()
        }
        .onReceive(NotificationCenter.default.publisher(for: .ahYunCloudDidMerge)) { _ in
            reload()
        }
        .ahHideTabBar()
    }

    private func row(_ record: AHVodFavoriteRecord) -> some View {
        NavigationLink {
            AHVodDetailView(route: record.route)
        } label: {
            HStack(spacing: 12) {
                CachedAsyncImageView(url: URL(string: record.pic))
                    .frame(width: 56, height: 78)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .background(Color.gray.opacity(0.08))

                VStack(alignment: .leading, spacing: 6) {
                    Text(record.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(2)

                    if !record.sourceName.isEmpty {
                        Text(record.sourceName)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(.vertical, 4)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "heart")
                .font(.system(size: 36))
                .foregroundColor(.secondary)
            Text("暂无收藏")
                .font(.headline)
            Text("在详情页点收藏，影片会出现在这里")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func reload() {
        records = AHVodLocalStore.favorites()
            .sorted { $0.timestamp > $1.timestamp }
    }

    private func syncFromCloud() async {
        await AHYunCloudService.syncIfLoggedIn()
        reload()
    }

    private func remove(_ record: AHVodFavoriteRecord) {
        AHVodLocalStore.removeFavorite(record)
        reload()
    }
}
