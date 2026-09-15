//
//  AHDownloadManagerView.swift
//  LLVod
//
//  下载管理：按片名分组展示，对应 Flutter 的 Down 页
//

import SwiftUI

struct AHDownloadManagerView: View {

    enum Tab: Hashable, CaseIterable {
        case completed
        case downloading

        var title: String {
            switch self {
            case .completed: return "已完成"
            case .downloading: return "下载中"
            }
        }
    }

    @StateObject private var manager = AHDownloadManager.shared
    @State private var tab: Tab = .completed

    var body: some View {
        VStack(spacing: 0) {
            Picker("", selection: $tab) {
                ForEach(Tab.allCases, id: \.self) { item in
                    Text(item.title).tag(item)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(.horizontal, 16)
            .padding(.vertical, 8)

            Divider()

            if groups.isEmpty {
                emptyState
            } else {
                List {
                    ForEach(groups) { group in
                        groupRow(group)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("下载管理")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            directoryBar
        }
        .ahHideTabBar()
    }

    // MARK: - 分组

    private var tasks: [AHDownloadTask] {
        switch tab {
        case .completed:
            return manager.tasks.filter { $0.status == .completed }
        case .downloading:
            return manager.tasks.filter { $0.status != .completed }
        }
    }

    private var groups: [AHDownloadGroup] {
        var order: [String] = []
        var grouped: [String: [AHDownloadTask]] = [:]

        for task in tasks {
            if grouped[task.title] == nil {
                order.append(task.title)
                grouped[task.title] = []
            }
            grouped[task.title]?.append(task)
        }

        return order.compactMap { title in
            guard let items = grouped[title] else { return nil }
            return AHDownloadGroup(title: title, tasks: items)
        }
    }

    private func groupRow(_ group: AHDownloadGroup) -> some View {
        NavigationLink {
            AHDownloadGroupView(title: group.title, tab: tab)
        } label: {
            HStack(spacing: 12) {
                CachedAsyncImageView(url: URL(string: group.pic))
                    .frame(width: 66, height: 88)
                    .background(Color(.tertiarySystemFill))
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 6))

                VStack(alignment: .leading, spacing: 8) {
                    Text(group.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    Text("共\(group.tasks.count)集")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)

                    if tab == .downloading {
                        ProgressView(value: group.progress)
                            .tint(.blue)

                        Text(group.statusText)
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(.vertical, 6)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: "arrow.down.circle")
                .font(.system(size: 34))
                .foregroundColor(.secondary)

            Text(tab == .completed ? "还没有下载完成的影片" : "没有正在下载的任务")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var directoryBar: some View {
        VStack(spacing: 0) {
            Divider()

            Text("下载目录：\(AHDownloadPaths.root.path)")
                .font(.system(size: 11))
                .foregroundColor(.secondary)
                .lineLimit(2)
                .truncationMode(.middle)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .background(Color(.systemBackground))
    }
}

struct AHDownloadGroup: Identifiable {
    var id: String { title }

    let title: String
    let tasks: [AHDownloadTask]

    var pic: String {
        tasks.first { !$0.pic.isEmpty }?.pic ?? ""
    }

    var progress: Double {
        guard !tasks.isEmpty else { return 0 }
        return tasks.reduce(0) { $0 + $1.progress } / Double(tasks.count)
    }

    var statusText: String {
        if let failed = tasks.first(where: { $0.status == .failed }) {
            return failed.errorMessage ?? AHDownloadStatus.failed.text
        }
        if tasks.contains(where: { $0.status == .downloading }) {
            return "\(AHDownloadStatus.downloading.text) \(Int(progress * 100))%"
        }
        if tasks.allSatisfy({ $0.status == .paused }) {
            return AHDownloadStatus.paused.text
        }
        return AHDownloadStatus.pending.text
    }
}
