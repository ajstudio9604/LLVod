//
//  AHVodPlayHistoryView.swift
//  LLVod
//
//  历史观看记录，数据来自 AHVodLocalStore 的播放记录
//

import SwiftUI

struct AHVodPlayHistoryView: View {

    @State private var records: [AHVodPlayRecord] = []
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
        .navigationTitle("历史记录")
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
            "清空全部观看记录？",
            isPresented: $showClearConfirm,
            titleVisibility: .visible
        ) {
            Button("清空", role: .destructive) {
                AHVodLocalStore.clearPlayRecords()
                records = []
            }
            Button("取消", role: .cancel) {}
        }
        .onAppear(perform: reload)
        .onReceive(NotificationCenter.default.publisher(for: .ahYunCloudDidMerge)) { _ in
            reload()
        }
        .onReceive(NotificationCenter.default.publisher(for: .ahVodPlayRecordDidChange)) { _ in
            reload()
        }
        .ahHideTabBar()
    }

    // MARK: - 列表行

    private func row(_ record: AHVodPlayRecord) -> some View {
        NavigationLink {
            AHVodDetailView(route: record.route, resumeRecord: record)
        } label: {
            HStack(spacing: 12) {
                poster(record)

                VStack(alignment: .leading, spacing: 6) {
                    Text(record.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    if !record.sourceName.isEmpty {
                        HStack(spacing: 3) {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 10))
                                .foregroundColor(.orange)

                            Text(record.sourceName)
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                        }
                    }

                    if !record.episodeTitle.isEmpty {
                        Text("观看至：\(record.episodeTitle)")
                            .font(.system(size: 12))
                            .foregroundColor(.green)
                            .lineLimit(1)
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(.vertical, 4)
        }
    }

    private func poster(_ record: AHVodPlayRecord) -> some View {
        CachedAsyncImageView(url: URL(string: record.pic))
            .frame(width: 104, height: 64)
            .background(Color(.tertiarySystemFill))
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(alignment: .bottomTrailing) {
                if record.position > 0 {
                    Text(AHVideoPlayerViewModel.formatTime(record.position))
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color.black.opacity(0.6))
                        )
                        .padding(4)
                }
            }
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: "clock.arrow.circlepath")
                .font(.system(size: 34))
                .foregroundColor(.secondary)

            Text("还没有观看记录")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - 数据

    private func reload() {
        records = AHVodLocalStore.playRecords()
    }

    private func syncFromCloud() async {
        await AHYunCloudService.syncIfLoggedIn()
        reload()
    }

    private func remove(_ record: AHVodPlayRecord) {
        AHVodLocalStore.removePlayRecord(record)
        records.removeAll { $0.id == record.id }
    }
}
