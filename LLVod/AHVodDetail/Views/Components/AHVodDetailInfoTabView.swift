//
//  AHVodDetailInfoTabView.swift
//  LLVod
//
//  「剧集」分页内容
//

import SwiftUI

struct AHVodDetailInfoTabView: View {

    @ObservedObject var viewModel: AHVodDetailViewModel
    let payload: AHVodDetailPayload

    @State private var showDetailSheet = false
    @State private var showAllEpisodes = false
    @State private var showDownloadSheet = false
    @State private var isEpisodeAscending = true
    @State private var chunkIndex = 0
    @State private var shareItem: AHShareItem?

    private let chunkSize = 40

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                titleRow
                subtitleRow
                actionRow

                Divider()
                    .padding(.horizontal, 16)
                    .padding(.top, 16)

                sourceLineRow
                episodeHeader
                episodeRow
            }
            .padding(.top, 14)
            .padding(.bottom, 24)
        }
        .sheet(isPresented: $showDetailSheet) {
            detailSheet
        }
        .sheet(isPresented: $showAllEpisodes) {
            allEpisodesSheet
        }
        .sheet(isPresented: $showDownloadSheet) {
            AHPlayDownView(viewModel: viewModel, payload: payload)
        }
        .sheet(item: $shareItem) { item in
            AHShareSheet(item: item)
        }
    }

    // MARK: - 标题

    private var titleRow: some View {
        Text(payload.title)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.primary)
            .lineLimit(1)
            .padding(.horizontal, 16)
    }

    private var subtitleRow: some View {
        HStack(spacing: 12) {
            Text(subtitleText)
                .font(.system(size: 13))
                .foregroundColor(.secondary)
                .lineLimit(1)

            Spacer(minLength: 0)

            Button {
                showDetailSheet = true
            } label: {
                HStack(spacing: 2) {
                    Text("详情")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)

                    Image(systemName: "chevron.right")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private var actionRow: some View {
        HStack(spacing: 12) {
            Spacer(minLength: 0)

            HStack(spacing: 26) {
                actionIcon("arrow.down.circle.fill") {
                    showDownloadSheet = true
                }
                actionIcon(
                    viewModel.isFavorited ? "heart.fill" : "heart",
                    tint: viewModel.isFavorited ? Palette.accent : .primary
                ) {
                    viewModel.toggleFavorite()
                }
                actionIcon("square.and.arrow.up.fill") {
                    let title = payload.title.isEmpty ? viewModel.route.name : payload.title
                    shareItem = .website(extraText: title)
                }
                actionIcon("exclamationmark.circle.fill") { }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

    private func actionIcon(
        _ systemName: String,
        tint: Color = .primary,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 19))
                .foregroundColor(tint)
        }
        .buttonStyle(.plain)
    }

    // MARK: - 播放源

    private var sourceLineRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 22) {
                ForEach(Array(payload.sourceLines.enumerated()), id: \.element.id) { index, line in
                    let isSelected = viewModel.selectedLineIndex == index

                    Button {
                        viewModel.selectLine(at: index)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(line.name)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(isSelected ? Palette.accent : .primary)
                                .lineLimit(1)

                            Text("共\(line.episodes.count)集")
                                .font(.system(size: 11))
                                .foregroundColor(isSelected ? Palette.accent : .secondary)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(isSelected ? Palette.accentSoft : Palette.chipBackground)
                                )
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.top, 16)
    }

    // MARK: - 剧集列表

    private var episodeHeader: some View {
        HStack(spacing: 16) {
            Text("剧集列表")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.primary)

            Spacer(minLength: 0)

            Button {
                isEpisodeAscending.toggle()
            } label: {
                Image(systemName: isEpisodeAscending ? "arrow.up.arrow.down" : "arrow.down.arrow.up")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.primary)
            }
            .buttonStyle(.plain)

            Button {
                chunkIndex = chunkIndexContainingCurrentEpisode
                showAllEpisodes = true
            } label: {
                HStack(spacing: 2) {
                    Text("查看全部")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)

                    Image(systemName: "chevron.right")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
    }

    private var episodeRow: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(episodeSlots) { slot in
                        episodeChip(slot)
                            .id(slot.id)
                    }
                }
                .padding(.horizontal, 16)
            }
            .onChange(of: viewModel.selectedEpisodeIndex) { index in
                withAnimation {
                    proxy.scrollTo(index, anchor: .center)
                }
            }
            .onAppear {
                // 续播恢复的集数是首帧就定好的，onChange 不会触发，这里补一次定位
                let index = viewModel.selectedEpisodeIndex
                guard index > 0 else { return }
                DispatchQueue.main.async {
                    proxy.scrollTo(index, anchor: .center)
                }
            }
        }
        .padding(.top, 14)
    }

    private func episodeChip(_ slot: EpisodeSlot) -> some View {
        let isSelected = viewModel.selectedEpisodeIndex == slot.id

        return Button {
            viewModel.selectEpisode(at: slot.id)
        } label: {
            Text(slot.episode.title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(isSelected ? Palette.accent : .primary)
                .lineLimit(1)
                .frame(minWidth: 62)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isSelected ? Palette.accentSoft : Palette.chipBackground)
                )
        }
        .buttonStyle(.plain)
    }

    // MARK: - 详情弹窗

    private var detailSheet: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if !viewModel.jxOptions.isEmpty {
                        parserSection
                    }

                    if !infoItems.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("影片信息")
                                .font(.system(size: 15, weight: .bold))

                            ForEach(infoItems, id: \.title) { item in
                                HStack(alignment: .top, spacing: 8) {
                                    Text(item.title)
                                        .font(.system(size: 13))
                                        .foregroundColor(.secondary)
                                        .frame(width: 44, alignment: .leading)

                                    Text(item.value)
                                        .font(.system(size: 13))
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }

                    if hasIntro {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("简介")
                                .font(.system(size: 15, weight: .bold))

                            Text(payload.intro)
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                                .lineSpacing(4)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
            }
            .navigationTitle(payload.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("关闭") { showDetailSheet = false }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private var parserSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("解析接口")
                .font(.system(size: 15, weight: .bold))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Array(viewModel.jxOptions.enumerated()), id: \.element.id) { index, option in
                        let isSelected = viewModel.selectedJxIndex == index

                        Button {
                            viewModel.selectParser(at: index)
                        } label: {
                            Text(option.name)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(isSelected ? Palette.accent : .primary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(isSelected ? Palette.accentSoft : Palette.chipBackground)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    // MARK: - 全部剧集弹窗

    private var allEpisodesSheet: some View {
        NavigationView {
            VStack(spacing: 0) {
                if chunks.count > 1 {
                    chunkTabRow
                    Divider()
                }

                ScrollView {
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4),
                        spacing: 10
                    ) {
                        ForEach(currentChunk) { slot in
                            Button {
                                viewModel.selectEpisode(at: slot.id)
                                showAllEpisodes = false
                            } label: {
                                Text(slot.episode.title)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(
                                        viewModel.selectedEpisodeIndex == slot.id ? Palette.accent : .primary
                                    )
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(
                                                viewModel.selectedEpisodeIndex == slot.id
                                                    ? Palette.accentSoft
                                                    : Palette.chipBackground
                                            )
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("剧集列表")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("关闭") { showAllEpisodes = false }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private var chunkTabRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(Array(chunks.enumerated()), id: \.offset) { index, chunk in
                    let isSelected = chunkIndex == index

                    Button {
                        chunkIndex = index
                    } label: {
                        Text(chunkLabel(chunk))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(isSelected ? Palette.accent : .primary)
                            .lineLimit(1)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(isSelected ? Palette.accentSoft : Palette.chipBackground)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }

    private func chunkLabel(_ chunk: [EpisodeSlot]) -> String {
        guard let first = chunk.first else { return "" }
        guard let last = chunk.last, chunk.count > 1 else { return first.episode.title }
        return "\(first.episode.title) —— \(last.episode.title)"
    }

    // MARK: - 数据

    private var episodeSlots: [EpisodeSlot] {
        let slots = viewModel.currentEpisodes.enumerated().map {
            EpisodeSlot(id: $0.offset, episode: $0.element)
        }
        return isEpisodeAscending ? slots : slots.reversed()
    }

    private var chunks: [[EpisodeSlot]] {
        let slots = episodeSlots
        guard slots.count > chunkSize else {
            return slots.isEmpty ? [] : [slots]
        }

        return stride(from: 0, to: slots.count, by: chunkSize).map { start in
            Array(slots[start..<min(start + chunkSize, slots.count)])
        }
    }

    private var currentChunk: [EpisodeSlot] {
        let all = chunks
        guard all.indices.contains(chunkIndex) else { return all.first ?? [] }
        return all[chunkIndex]
    }

    private var chunkIndexContainingCurrentEpisode: Int {
        chunks.firstIndex { chunk in
            chunk.contains { $0.id == viewModel.selectedEpisodeIndex }
        } ?? 0
    }

    private var subtitleText: String {
        var parts = ["源: \(viewModel.route.sourceName)"]
        if isValid(payload.actor) {
            parts.append(payload.actor)
        }
        return parts.joined(separator: " ｜ ")
    }

    private var infoItems: [(title: String, value: String)] {
        var items: [(String, String)] = []

        if isValid(payload.status) {
            items.append(("状态", payload.status))
        }
        if isValid(payload.actor) {
            items.append(("演员", payload.actor))
        }
        if !viewModel.usedParserName.isEmpty {
            items.append(("解析", viewModel.usedParserName))
        }

        return items
    }

    private var hasIntro: Bool {
        isValid(payload.intro)
    }

    private func isValid(_ text: String) -> Bool {
        !text.isEmpty && text != "N/A"
    }

    private struct EpisodeSlot: Identifiable {
        let id: Int
        let episode: AHVodEpisode
    }

    private enum Palette {
        static let accent = Color(red: 18 / 255, green: 183 / 255, blue: 106 / 255)
        static let accentSoft = Color(red: 18 / 255, green: 183 / 255, blue: 106 / 255).opacity(0.12)
        static let chipBackground = Color(.secondarySystemBackground)
    }
}
