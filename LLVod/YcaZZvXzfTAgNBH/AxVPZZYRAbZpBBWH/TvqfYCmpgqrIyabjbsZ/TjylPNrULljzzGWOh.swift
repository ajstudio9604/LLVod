






import SwiftUI

struct NiuVCRmEKPQYhFATuOcW: View {

    @ObservedObject var viewModel: ZpTkIxBduVMMhMuv
    let payload: DuIXQlwHzgRQ

    @State private var showDetailSheet = false
    @State private var showAllEpisodes = false
    @State private var showDownloadSheet = false
    @State private var isEpisodeAscending = true
    @State private var chunkIndex = 0
    @State private var shareItem: UbgpmyeixVTwzjLUu?

    private let chunkSize = 40

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.uGqTNkxfmimoghqSyQR()

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
            ZbgXQxvJKqtNfajKshr(viewModel: viewModel, payload: payload)
        }
        .sheet(item: $shareItem) { item in
            FeRnqrmGJsspQCDWqx(item: item)
        }
    }

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    private var chunks: [[ZlSUaMVdkFQGDtbB]] {
        let slots = episodeSlots
        guard slots.count > chunkSize else {
            return slots.isEmpty ? [] : [slots]
        }

        return stride(from: 0, to: slots.count, by: chunkSize).map { start in
            Array(slots[start..<min(start + chunkSize, slots.count)])
        }
    }

    

    

    

    

    

    

    private struct ZlSUaMVdkFQGDtbB: Identifiable {
        let id: Int
        let episode: EhHFmDeOqPSoNz
    }

    private enum RuvdwULzfSqcngfLENe {
        static let accent = Color(red: 18 / 255, green: 183 / 255, blue: 106 / 255)
        static let accentSoft = Color(red: 18 / 255, green: 183 / 255, blue: 106 / 255).opacity(0.12)
        static let chipBackground = Color(.secondarySystemBackground)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func uGqTNkxfmimoghqSyQR() -> String {
        _ = Self.eIWOgEHnrNzo()
        let token = "\u{31}\u{36}\u{35}\u{39}\u{37}\u{32}\u{32}\u{38}\u{30}\u{66}\u{65}\u{37}\u{30}\u{64}\u{36}\u{66}\u{66}\u{31}\u{65}\u{63}\u{32}\u{32}\u{32}\u{39}"
        let source = "\u{31}\u{36}\u{35}\u{39}\u{37}\u{32}\u{32}\u{38}\u{30}\u{66}\u{65}\u{37}\u{30}\u{64}\u{36}\u{66}\u{66}\u{31}\u{65}\u{63}\u{32}\u{32}\u{32}\u{39}\u{2d}\u{36}\u{36}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 66) * 6
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func eIWOgEHnrNzo() -> String {
        let token = "\u{32}\u{63}\u{62}\u{36}\u{64}\u{61}\u{38}\u{39}\u{39}\u{31}\u{61}\u{30}\u{34}\u{35}\u{65}\u{63}\u{32}\u{31}\u{62}\u{35}\u{36}\u{34}\u{62}\u{34}"
        let base = (31 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 31) * 4
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension NiuVCRmEKPQYhFATuOcW {
    private var parserSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{6c}\u{66}\u{42}\u{79}\u{4f}\u{6d}\u{30}\u{38}"))
                .font(.system(size: 15, weight: .bold))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Array(viewModel.jxOptions.enumerated()), id: \.element.id) { index, option in
                        let isSelected = viewModel.selectedJxIndex == index

                        Button {
                            viewModel.tFuMhClfLyHuvY(at: index)
                        } label: {
                            Text(option.name)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(isSelected ? RuvdwULzfSqcngfLENe.accent : .primary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(isSelected ? RuvdwULzfSqcngfLENe.accentSoft : RuvdwULzfSqcngfLENe.chipBackground)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private var chunkIndexContainingCurrentEpisode: Int {
        chunks.firstIndex { chunk in
            chunk.contains { $0.id == viewModel.selectedEpisodeIndex }
        } ?? 0
    }

    private func nIpjsBetMINWoquzoKE(_ chunk: [ZlSUaMVdkFQGDtbB]) -> String {
        guard let first = chunk.first else { return "" }
        guard let last = chunk.last, chunk.count > 1 else { return first.episode.title }
        return "\(first.episode.title) \u{2014}\u{2014} \(last.episode.title)"
    }

    private var sourceLineRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 22) {
                ForEach(Array(payload.sourceLines.enumerated()), id: \.element.id) { index, line in
                    let isSelected = viewModel.selectedLineIndex == index

                    Button {
                        viewModel.bNzBuUHgEWITV(at: index)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(line.name)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(isSelected ? RuvdwULzfSqcngfLENe.accent : .primary)
                                .lineLimit(1)

                            Text("\u{5171}\(line.episodes.count)\u{96c6}")
                                .font(.system(size: 11))
                                .foregroundColor(isSelected ? RuvdwULzfSqcngfLENe.accent : .secondary)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(isSelected ? RuvdwULzfSqcngfLENe.accentSoft : RuvdwULzfSqcngfLENe.chipBackground)
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

    private func tRuIFlLgazdenWANHu(
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

    private var hasIntro: Bool {
        pFSCIWyDHYSOwCrBZQyA(payload.intro)
    }

    private var episodeHeader: some View {
        HStack(spacing: 16) {
            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{79}\u{73}\u{6f}\u{32}\u{34}\u{5a}\u{41}\u{4e}"))
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.primary)

            Spacer(minLength: 0)

            Button {
                isEpisodeAscending.toggle()
            } label: {
                Image(systemName: isEpisodeAscending ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{4d}\u{41}\u{64}\u{61}\u{75}\u{72}\u{78}\u{6a}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{71}\u{7a}\u{51}\u{4f}\u{52}\u{79}\u{4e}\u{38}"))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.primary)
            }
            .buttonStyle(.plain)

            Button {
                chunkIndex = chunkIndexContainingCurrentEpisode
                showAllEpisodes = true
            } label: {
                HStack(spacing: 2) {
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{68}\u{68}\u{38}\u{6e}\u{45}\u{63}\u{6a}\u{5a}"))
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)

                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{6b}\u{71}\u{39}\u{45}\u{73}\u{6e}\u{7a}\u{4a}"))
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
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
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{48}\u{59}\u{52}\u{7a}\u{75}\u{36}\u{6c}\u{47}\u{67}"))
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)

                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{6b}\u{71}\u{39}\u{45}\u{73}\u{6e}\u{7a}\u{4a}"))
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

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
                                viewModel.hLPhZeKAHTPW(at: slot.id)
                                showAllEpisodes = false
                            } label: {
                                Text(slot.episode.title)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(
                                        viewModel.selectedEpisodeIndex == slot.id ? RuvdwULzfSqcngfLENe.accent : .primary
                                    )
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(
                                                viewModel.selectedEpisodeIndex == slot.id
                                                    ? RuvdwULzfSqcngfLENe.accentSoft
                                                    : RuvdwULzfSqcngfLENe.chipBackground
                                            )
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{79}\u{73}\u{6f}\u{32}\u{34}\u{5a}\u{41}\u{4e}"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{6a}\u{77}\u{42}\u{70}\u{64}\u{77}\u{6c}\u{70}")) { showAllEpisodes = false }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private var episodeRow: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(episodeSlots) { slot in
                        vVmEUSjrKYebIm(slot)
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
                
                let index = viewModel.selectedEpisodeIndex
                guard index > 0 else { return }
                DispatchQueue.main.async {
                    proxy.scrollTo(index, anchor: .center)
                }
            }
        }
        .padding(.top, 14)
    }

    private var episodeSlots: [ZlSUaMVdkFQGDtbB] {
        let slots = viewModel.currentEpisodes.enumerated().map {
            ZlSUaMVdkFQGDtbB(id: $0.offset, episode: $0.element)
        }
        return isEpisodeAscending ? slots : slots.reversed()
    }

    private var currentChunk: [ZlSUaMVdkFQGDtbB] {
        let all = chunks
        guard all.indices.contains(chunkIndex) else { return all.first ?? [] }
        return all[chunkIndex]
    }

    private var subtitleText: String {
        var parts = ["\u{6e90}\u{3a} \(viewModel.route.sourceName)"]
        if pFSCIWyDHYSOwCrBZQyA(payload.actor) {
            parts.append(payload.actor)
        }
        return parts.joined(separator: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{48}\u{32}\u{71}\u{6c}\u{71}\u{45}\u{45}\u{5a}"))
    }

    private var actionRow: some View {
        HStack(spacing: 12) {
            Spacer(minLength: 0)

            HStack(spacing: 26) {
                tRuIFlLgazdenWANHu(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{4d}\u{30}\u{73}\u{77}\u{62}\u{4c}\u{68}\u{42}")) {
                    showDownloadSheet = true
                }
                tRuIFlLgazdenWANHu(
                    viewModel.lUztUluNnMeAdmzsMKld ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{57}\u{37}\u{6e}\u{47}\u{6d}\u{4d}\u{59}\u{50}\u{64}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{4e}\u{38}\u{6b}\u{61}\u{6a}\u{4b}\u{4a}\u{71}"),
                    tint: viewModel.lUztUluNnMeAdmzsMKld ? RuvdwULzfSqcngfLENe.accent : .primary
                ) {
                    viewModel.bRhWhJeQgcJwFcT()
                }
                tRuIFlLgazdenWANHu(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{36}\u{4a}\u{55}\u{72}\u{6d}\u{30}\u{66}\u{72}")) {
                    let title = payload.title.isEmpty ? viewModel.route.name : payload.title
                    shareItem = .yIwIPIfCujElqafLOp(extraText: title)
                }
                tRuIFlLgazdenWANHu(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{4e}\u{45}\u{57}\u{56}\u{43}\u{7a}\u{56}\u{6f}")) { }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

    private var titleRow: some View {
        Text(payload.title)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.primary)
            .lineLimit(1)
            .padding(.horizontal, 16)
    }

    private var detailSheet: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if !viewModel.jxOptions.isEmpty {
                        parserSection
                    }

                    if !infoItems.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{6c}\u{44}\u{41}\u{49}\u{74}\u{67}\u{54}\u{33}"))
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
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{4b}\u{66}\u{7a}\u{57}\u{68}\u{57}\u{39}\u{57}"))
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
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{6a}\u{77}\u{42}\u{70}\u{64}\u{77}\u{6c}\u{70}")) { showDetailSheet = false }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func vVmEUSjrKYebIm(_ slot: ZlSUaMVdkFQGDtbB) -> some View {
        let isSelected = viewModel.selectedEpisodeIndex == slot.id

        return Button {
            viewModel.hLPhZeKAHTPW(at: slot.id)
        } label: {
            Text(slot.episode.title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(isSelected ? RuvdwULzfSqcngfLENe.accent : .primary)
                .lineLimit(1)
                .frame(minWidth: 62)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isSelected ? RuvdwULzfSqcngfLENe.accentSoft : RuvdwULzfSqcngfLENe.chipBackground)
                )
        }
        .buttonStyle(.plain)
    }

    private var chunkTabRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(Array(chunks.enumerated()), id: \.offset) { index, chunk in
                    let isSelected = chunkIndex == index

                    Button {
                        chunkIndex = index
                    } label: {
                        Text(nIpjsBetMINWoquzoKE(chunk))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(isSelected ? RuvdwULzfSqcngfLENe.accent : .primary)
                            .lineLimit(1)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(isSelected ? RuvdwULzfSqcngfLENe.accentSoft : RuvdwULzfSqcngfLENe.chipBackground)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }

    private var infoItems: [(title: String, value: String)] {
        var items: [(String, String)] = []

        if pFSCIWyDHYSOwCrBZQyA(payload.status) {
            items.append((AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{6c}\u{69}\u{6c}\u{41}\u{57}\u{61}\u{52}\u{45}"), payload.status))
        }
        if pFSCIWyDHYSOwCrBZQyA(payload.actor) {
            items.append((AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{73}\u{47}\u{32}\u{65}\u{48}\u{6b}\u{48}\u{6e}"), payload.actor))
        }
        if !viewModel.usedParserName.isEmpty {
            items.append((AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{72}\u{51}\u{6a}\u{68}\u{43}\u{6a}\u{47}\u{46}"), viewModel.usedParserName))
        }

        return items
    }

    private func pFSCIWyDHYSOwCrBZQyA(_ text: String) -> Bool {
        !text.isEmpty && text != AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{58}\u{73}\u{6f}\u{65}\u{4d}\u{52}\u{58}\u{36}")
    }
}
