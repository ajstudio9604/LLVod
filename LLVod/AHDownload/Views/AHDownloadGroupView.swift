//
//  AHDownloadGroupView.swift
//  LLVod
//
//  某一部剧的下载集列表
//

import SwiftUI

struct AHDownloadGroupView: View {

    let title: String
    let tab: AHDownloadManagerView.Tab

    @StateObject private var manager = AHDownloadManager.shared
    @State private var playback: AHLocalPlayback?

    var body: some View {
        List {
            ForEach(tasks) { task in
                row(task)
                    .swipeActions {
                        Button("删除", role: .destructive) {
                            manager.remove(task.id)
                        }
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        // 点击直接横屏播放，横屏里返回会转回竖屏并回到本页
        .ahFullscreen(item: $playback) { playback in
            AHLocalFullscreenPlayerView(
                url: playback.url,
                title: playback.title,
                episodeTitle: playback.episodeTitle
            )
        }
        .ahHideTabBar()
    }

    private var tasks: [AHDownloadTask] {
        manager.tasks.filter {
            guard $0.title == title else { return false }
            return tab == .completed ? $0.status == .completed : $0.status != .completed
        }
    }

    private func row(_ task: AHDownloadTask) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(task.subtitle)
                    .font(.system(size: 14, weight: .medium))
                    .lineLimit(1)

                if task.status == .completed {
                    Text(AHDownloadStatus.completed.text)
                        .font(.system(size: 12))
                        .foregroundColor(.green)
                } else {
                    ProgressView(value: task.progress)
                        .tint(.blue)

                    Text(subtitle(task))
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }

            Spacer(minLength: 0)

            actionButton(task)
        }
        .padding(.vertical, 6)
        .contentShape(Rectangle())
        .onTapGesture {
            guard task.status == .completed,
                  let url = manager.localPlayURL(for: task) else { return }
            playback = AHLocalPlayback(
                url: url,
                title: task.title,
                episodeTitle: task.subtitle
            )
        }
    }

    private func subtitle(_ task: AHDownloadTask) -> String {
        if let message = task.errorMessage, task.status == .failed {
            return message
        }

        guard task.totalSegments > 0 else { return task.status.text }
        return "\(task.status.text) \(task.completedSegments)/\(task.totalSegments)"
    }

    @ViewBuilder
    private func actionButton(_ task: AHDownloadTask) -> some View {
        switch task.status {
        case .completed:
            Image(systemName: "play.circle.fill")
                .font(.system(size: 22))
                .foregroundColor(.green)

        case .downloading, .pending:
            Button {
                manager.pause(task.id)
            } label: {
                Image(systemName: "pause.circle")
                    .font(.system(size: 22))
            }
            .buttonStyle(.plain)

        case .paused, .failed:
            Button {
                manager.resume(task.id)
            } label: {
                Image(systemName: "arrow.clockwise.circle")
                    .font(.system(size: 22))
            }
            .buttonStyle(.plain)
        }
    }
}
