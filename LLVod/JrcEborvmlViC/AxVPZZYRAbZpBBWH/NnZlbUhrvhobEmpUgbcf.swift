







import SwiftUI

struct ZbgXQxvJKqtNfajKshr: View {

    @ObservedObject var viewModel: ZpTkIxBduVMMhMuv
    let payload: DuIXQlwHzgRQ

    @StateObject private var downloadManager = VtLaWtyuDAGv.shared
    @Environment(\.dismiss) private var dismiss

    @State private var resolvingIndex: Int?
    @State private var pendingRewardIndex: Int?
    @State private var showRewardConfirm = false
    @State private var isWaitingReward = false
    @State private var toast: String?
    @State private var retryDownload: (index: Int, episode: EhHFmDeOqPSoNz)?
    @State private var showTaskList = false
    @State private var bPpKwcDGSarZholuKvA: Int64 = 0

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.lTzCMfLsEFakKOP()

        NavigationView {
            VStack(spacing: 0) {
                episodeGrid
                Divider()
                bottomBar
            }
            .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{48}\u{7a}\u{7a}\u{65}\u{46}\u{6d}\u{70}\u{75}"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{6a}\u{77}\u{42}\u{70}\u{64}\u{77}\u{6c}\u{70}")) { dismiss() }
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
                    gAJyTODTaMIPilGR(toast)
                }
            }
            .alert(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{4c}\u{31}\u{70}\u{49}\u{35}\u{62}\u{48}\u{71}"), isPresented: $showRewardConfirm) {
                Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{79}\u{74}\u{6a}\u{6f}\u{31}\u{37}\u{65}\u{6d}"), role: .cancel) {
                    pendingRewardIndex = nil
                }
                Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{51}\u{34}\u{6a}\u{39}\u{50}\u{79}\u{78}\u{36}")) {
                    kTcTkVBBOvgTmBlo()
                }
            } message: {
                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{67}\u{57}\u{33}\u{44}\u{68}\u{64}\u{6b}\u{73}"))
            }
            .sheet(isPresented: $showTaskList) {
                MqJtOaRZEIOVZ()
            }
            .onAppear {
                bPpKwcDGSarZholuKvA = BcpFIVJTNXMxGbdwQoO.bPpKwcDGSarZholuKvA()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func lTzCMfLsEFakKOP() -> String {
        _ = Self.jJmuTBmwaiUoqj()
        let base = (28 * 6 + 19) % 997
        let width = (base) % 17
        let score = (width + 28) * 6
        let token = "\u{65}\u{61}\u{65}\u{31}\u{30}\u{66}\u{32}\u{63}\u{62}\u{61}\u{31}\u{37}\u{61}\u{34}\u{31}\u{62}\u{33}\u{37}\u{65}\u{64}\u{66}\u{33}\u{61}\u{38}"
        _ = Self.hCmqNNGPANym()
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
    @inline(never)
    private nonisolated static func hCmqNNGPANym() -> String {
        let values = [78, 82, 312, 95]
        let folded = values.map { ($0 * 4 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 78) * 4
        let token = "\u{32}\u{65}\u{64}\u{64}\u{37}\u{32}\u{39}\u{32}\u{30}\u{62}\u{64}\u{31}\u{66}\u{64}\u{63}\u{62}\u{65}\u{64}\u{64}\u{62}\u{35}\u{61}\u{37}\u{63}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
    @inline(never)
    private nonisolated static func jJmuTBmwaiUoqj() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{39}\u{37}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 97) * 8
        let token = "\u{66}\u{61}\u{63}\u{62}\u{33}\u{37}\u{61}\u{32}\u{36}\u{31}\u{61}\u{62}\u{38}\u{37}\u{31}\u{33}\u{37}\u{33}\u{35}\u{63}\u{33}\u{38}\u{62}\u{33}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}



extension ZbgXQxvJKqtNfajKshr {
    private func vGCYVGblQouJfTtI(toast text: String) {
        retryDownload = nil
        toast = text
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            if toast == text {
                toast = nil
            }
        }
    }

    private var episodeGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(Array(viewModel.currentEpisodes.enumerated()), id: \.element.id) { index, episode in
                    oYWMyJqdWTTxFBinS(index: index, episode: episode)
                }
            }
            .padding(16)
        }
    }

    private func oYWMyJqdWTTxFBinS(index: Int, episode: EhHFmDeOqPSoNz) -> some View {
        let task = downloadManager.lUvawHimoimrQCBgdQFr(title: payload.title, subtitle: episode.title)
        let isQueued = task != nil

        return Button {
            guard !isQueued else { return }
            cBRfAzqFIHCDseBT(index: index, episode: episode)
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
                            .fill(uTQwyxwZLqRjH(task.status))
                            .frame(width: 6, height: 6)
                            .padding(4)
                    }
                }
        }
        .buttonStyle(.plain)
        .disabled(isQueued || resolvingIndex != nil || isWaitingReward)
    }

    private func kTcTkVBBOvgTmBlo() {
        guard let index = pendingRewardIndex,
              viewModel.currentEpisodes.indices.contains(index) else {
            pendingRewardIndex = nil
            return
        }

        let episode = viewModel.currentEpisodes[index]
        pendingRewardIndex = nil
        isWaitingReward = true

        RpOmwPsWgtwXT.shared.aHaqUoFUkuNODvav { granted in
            isWaitingReward = false
            if granted {
                uJhKtBccDiFk(index: index, episode: episode)
            } else {
                vGCYVGblQouJfTtI(toast: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{36}\u{39}\u{6d}\u{6a}\u{36}\u{61}\u{36}\u{4a}"))
            }
        }
    }

    private var canRetryDownload: Bool {
        if case .some = retryDownload { return true }
        return false
    }

    private func oFZfOAyZvliWhDgapi(index: Int, episode: EhHFmDeOqPSoNz) {
        retryDownload = (index, episode)
        toast = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{58}\u{74}\u{61}\u{46}\u{4f}\u{6d}\u{6e}\u{6d}")
    }

    private func sERAtXUhBIZhV(
        for task: BuzGDNFYICiuDwSREHYV,
        gAnSZJKWRXAmnpyvYK: Int,
        episode: EhHFmDeOqPSoNz,
        playURL: String
    ) {
        let context = WlPVPRGhJhvIqTiUaxGw(
            title: payload.title,
            sourceTag: viewModel.currentLine?.sourceTag ?? "",
            zypath: viewModel.route.zypath,
            episodeTitle: episode.title,
            episodePath: episode.path,
            playURL: playURL,
            gAnSZJKWRXAmnpyvYK: gAnSZJKWRXAmnpyvYK + 1
        )
        let directory = BcpFIVJTNXMxGbdwQoO.rJZZglPOJtiGmh(for: task)

        Task {
            let items = await LkzXORcEdLaolfAi.mSPdHfgBrknIFudyTNhN(context: context)
            guard !items.isEmpty else { return }
            LkzXORcEdLaolfAi.bXPBLVzsHUhrdyhx(items, to: directory)
        }
    }

    private var waitingRewardOverlay: some View {
        VStack(spacing: 10) {
            ProgressView()
            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{57}\u{69}\u{6e}\u{78}\u{54}\u{69}\u{61}\u{66}"))
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
            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{4d}\u{33}\u{50}\u{39}\u{4a}\u{48}\u{43}\u{4a}"))
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

    private func cBRfAzqFIHCDseBT(index: Int, episode: EhHFmDeOqPSoNz) {
        if RpOmwPsWgtwXT.shared.isUnlocked {
            uJhKtBccDiFk(index: index, episode: episode)
            return
        }
        pendingRewardIndex = index
        showRewardConfirm = true
    }

    private var bottomBar: some View {
        HStack {
            Button {
                showTaskList = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{48}\u{66}\u{51}\u{48}\u{36}\u{44}\u{66}\u{4a}\u{68}"))
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{62}\u{4c}\u{59}\u{68}\u{30}\u{50}\u{4f}\u{38}"))
                        .font(.system(size: 14, weight: .medium))
                }
            }
            .buttonStyle(.plain)

            Spacer()

            Text("\u{5269}\u{4f59} \(BcpFIVJTNXMxGbdwQoO.bQiDnlVYlVCRbeAdKSa(bPpKwcDGSarZholuKvA))")
                .font(.system(size: 12))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private func gAJyTODTaMIPilGR(_ text: String) -> some View {
        Button {
            guard let retryDownload else { return }
            self.retryDownload = nil
            uJhKtBccDiFk(index: retryDownload.index, episode: retryDownload.episode)
        } label: {
            HStack(spacing: 6) {
                Text(text)
                if canRetryDownload {
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{69}\u{67}\u{72}\u{57}\u{33}\u{6c}\u{75}\u{7a}"))
                        .fontWeight(.semibold)
                }
            }
            .font(.system(size: 13))
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Capsule().fill(Color.black.opacity(0.8)))
        }
        .buttonStyle(.plain)
        .disabled(!canRetryDownload)
        .padding(.bottom, 70)
        .transition(.opacity)
    }

    private func uTQwyxwZLqRjH(_ status: LlKdecruirFxhTQho) -> Color {
        switch status {
        case .completed: return .green
        case .failed: return .red
        case .paused: return .orange
        case .downloading, .pending: return .blue
        }
    }

    private func uJhKtBccDiFk(index: Int, episode: EhHFmDeOqPSoNz) {
        guard let line = viewModel.currentLine else { return }
        resolvingIndex = index
        retryDownload = nil

        Task {
            defer { resolvingIndex = nil }

            do {
                let result = try await DwKTyICLdOKoVaTtlb.eOPwJBFrPZYyRk(
                    episodeURL: episode.path,
                    detailPath: viewModel.route.path,
                    sourceConfig: payload.sourceConfig,
                    sourceLine: line,
                    zypath: viewModel.route.zypath,
                    preferredParserIndex: viewModel.selectedJxIndex
                )

                guard !result.url.isEmpty else {
                    oFZfOAyZvliWhDgapi(index: index, episode: episode)
                    return
                }

                let task = downloadManager.cAHAYHRmpkwaG(
                    url: result.url,
                    title: payload.title,
                    subtitle: episode.title,
                    pic: payload.pic,
                    zypath: viewModel.route.zypath,
                    headers: result.tZEwKoRUrWxOAeG
                )

                vGCYVGblQouJfTtI(toast: "\(episode.title) \u{52a0}\u{5165}\u{4e0b}\u{8f7d}")
                sERAtXUhBIZhV(for: task, gAnSZJKWRXAmnpyvYK: index, episode: episode, playURL: result.url)
            } catch {
                oFZfOAyZvliWhDgapi(index: index, episode: episode)
            }
        }
    }
}
