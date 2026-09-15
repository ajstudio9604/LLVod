//
//  AHPlayDownView.swift
//  LLVod
//
//  逐集点选下载，对应 Flutter PlayDown（playdown.dart）
//  点一集就解析这一集的真实地址再入队，不是勾选多集后批量提交
//

import SwiftUI

struct AHPlayDownView: View {

    @ObservedObject var viewModel: AHVodDetailViewModel
    let payload: AHVodDetailPayload

    @StateObject private var downloadManager = AHDownloadManager.shared
    @Environment(\.dismiss) private var dismiss

    @State private var resolvingIndex: Int?
    @State private var pendingRewardIndex: Int?
    @State private var showRewardConfirm = false
    @State private var isWaitingReward = false
    @State private var toast: String?
    @State private var showTaskList = false
    @State private var freeBytes: Int64 = 0

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                episodeGrid
                Divider()
                bottomBar
            }
            .navigationTitle("选择下载的集数")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("关闭") { dismiss() }
                }
            }
            .overlay(alignment: .center) {
                if isWaitingReward {
                    waitingRewardOverlay
                } else if resolvingIndex != nil {
                    resolvingOverlay
                }
            }
            .overlay(alignment: .bottom) {
                if let toast {
                    toastView(toast)
                }
            }
            .alert("下载前看一条视频", isPresented: $showRewardConfirm) {
                Button("暂不", role: .cancel) {
                    pendingRewardIndex = nil
                }
                Button("去观看") {
                    confirmWatchAndDownload()
                }
            } message: {
                Text("完整看完即可下载本集，并解锁 24 小时内免费下载。")
            }
            .sheet(isPresented: $showTaskList) {
                AHDownloadTaskListView()
            }
            .onAppear {
                freeBytes = AHDownloadPaths.freeBytes()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // MARK: - 集数网格

    private var episodeGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(Array(viewModel.currentEpisodes.enumerated()), id: \.element.id) { index, episode in
                    episodeCell(index: index, episode: episode)
                }
            }
            .padding(16)
        }
    }

    private func episodeCell(index: Int, episode: AHVodEpisode) -> some View {
        let task = downloadManager.task(title: payload.title, subtitle: episode.title)
        let isQueued = task != nil

        return Button {
            guard !isQueued else { return }
            requestDownload(index: index, episode: episode)
        } label: {
            Text(episode.title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(isQueued ? .secondary : .primary)
                .lineLimit(1)
                .frame(maxWidth: .infinity, minHeight: 42)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.secondarySystemBackground))
                )
                .overlay(alignment: .topTrailing) {
                    if let task {
                        Circle()
                            .fill(statusColor(task.status))
                            .frame(width: 6, height: 6)
                            .padding(4)
                    }
                }
        }
        .buttonStyle(.plain)
        .disabled(isQueued || resolvingIndex != nil || isWaitingReward)
    }

    private func statusColor(_ status: AHDownloadStatus) -> Color {
        switch status {
        case .completed: return .green
        case .failed: return .red
        case .paused: return .orange
        case .downloading, .pending: return .blue
        }
    }

    // MARK: - 底部栏

    private var bottomBar: some View {
        HStack {
            Button {
                showTaskList = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "arrow.down.circle")
                    Text("查看下载任务")
                        .font(.system(size: 14, weight: .medium))
                }
            }
            .buttonStyle(.plain)

            Spacer()

            Text("剩余 \(AHDownloadPaths.formatBytes(freeBytes))")
                .font(.system(size: 12))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private var waitingRewardOverlay: some View {
        VStack(spacing: 10) {
            ProgressView()
            Text("正在加载视频…")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(radius: 8)
        )
    }

    private var resolvingOverlay: some View {
        VStack(spacing: 10) {
            ProgressView()
            Text("获取视频中…")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(radius: 8)
        )
    }

    private func toastView(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 13))
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Capsule().fill(Color.black.opacity(0.8)))
            .padding(.bottom, 70)
            .transition(.opacity)
    }

    // MARK: - 下载

    private func requestDownload(index: Int, episode: AHVodEpisode) {
        if TADDownloadRewardGate.shared.isUnlocked {
            startDownload(index: index, episode: episode)
            return
        }
        pendingRewardIndex = index
        showRewardConfirm = true
    }

    private func confirmWatchAndDownload() {
        guard let index = pendingRewardIndex,
              viewModel.currentEpisodes.indices.contains(index) else {
            pendingRewardIndex = nil
            return
        }

        let episode = viewModel.currentEpisodes[index]
        pendingRewardIndex = nil
        isWaitingReward = true

        TADDownloadRewardGate.shared.authorize { granted in
            isWaitingReward = false
            if granted {
                startDownload(index: index, episode: episode)
            } else {
                show(toast: "需要看完视频才能下载")
            }
        }
    }

    private func startDownload(index: Int, episode: AHVodEpisode) {
        guard let line = viewModel.currentLine else { return }
        resolvingIndex = index

        Task {
            defer { resolvingIndex = nil }

            do {
                let result = try await AHVodPlayResolver.resolve(
                    episodeURL: episode.path,
                    detailPath: viewModel.route.path,
                    sourceConfig: payload.sourceConfig,
                    sourceLine: line,
                    zypath: viewModel.route.zypath,
                    preferredParserIndex: viewModel.selectedJxIndex
                )

                guard !result.url.isEmpty else {
                    show(toast: "解析失败，换个播放源试试")
                    return
                }

                let task = downloadManager.addToQueue(
                    url: result.url,
                    title: payload.title,
                    subtitle: episode.title,
                    pic: payload.pic,
                    zypath: viewModel.route.zypath,
                    headers: result.playerHeaders
                )

                show(toast: "\(episode.title) 加入下载")
                downloadDanmaku(for: task, episodeIndex: index, episode: episode, playURL: result.url)
            } catch {
                show(toast: error.localizedDescription)
            }
        }
    }

    private func downloadDanmaku(
        for task: AHDownloadTask,
        episodeIndex: Int,
        episode: AHVodEpisode,
        playURL: String
    ) {
        let context = AHVodDanmakuContext(
            title: payload.title,
            sourceTag: viewModel.currentLine?.sourceTag ?? "",
            zypath: viewModel.route.zypath,
            episodeTitle: episode.title,
            episodePath: episode.path,
            playURL: playURL,
            episodeIndex: episodeIndex + 1
        )
        let directory = AHDownloadPaths.directory(for: task)

        Task {
            let items = await AHDanmakuService.fetchDanmaku(context: context)
            guard !items.isEmpty else { return }
            AHDanmakuService.saveLocal(items, to: directory)
        }
    }

    private func show(toast text: String) {
        toast = text
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            if toast == text {
                toast = nil
            }
        }
    }
}
