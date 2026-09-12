






import SwiftUI
import AVKit
import SwiftUIPager

struct GsJOCBdoNInHfKqMeUj: View {

    @StateObject private var viewModel: ZpTkIxBduVMMhMuv
    @StateObject private var playerViewModel = JnMIqllTuKLJ(url: "")
    @State private var updateWorkItem: DispatchWorkItem?
    @Environment(\.dismiss) private var dismiss

    @State private var selectedIndex: Int = 0
    @State private var page = Page.withIndex(0)
    @State private var tabTitles: [FwWkbRgDQxhZSfi] = [
        FwWkbRgDQxhZSfi(text: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{64}\u{57}\u{59}\u{50}\u{54}\u{34}\u{68}\u{35}"), index: 0),
        FwWkbRgDQxhZSfi(text: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{37}\u{47}\u{71}\u{63}\u{37}\u{62}\u{39}\u{44}"), index: 1)
    ]

    init(route: RawJGVnXMRwEec, resumeRecord: BujroaRaxIvHZD? = nil) {
        // source-obfuscator:padding:v1
        _ = Self.jDMaYtzEvljnAYbIco()

        _viewModel = StateObject(
            wrappedValue: ZpTkIxBduVMMhMuv(route: route, resumeRecord: resumeRecord)
        )
    }

    var tabHeader: some View {
        BcDUWxEXrmtzl(
            tabs: tabTitles,
            selectedIndex: $selectedIndex
        ) { index in
            page.update(.new(index: index))
        }
    }

    @ViewBuilder
    func kDavZBPVGrNo(_ tab: FwWkbRgDQxhZSfi) -> some View {
        if tab.index == 0 {
            if let payload = viewModel.payload {
                NiuVCRmEKPQYhFATuOcW(viewModel: viewModel, payload: payload)
            } else {
                errorPlaceholder
            }
        } else {
            WuqIhKvqRzmVjxgEH(
                
                targetId: viewModel.payload?.title ?? viewModel.route.name,
                title: viewModel.payload?.title ?? viewModel.route.name,
                pic: viewModel.route.pic,
                sourceName: viewModel.route.sourceName
            )
        }
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)

                    Spacer()
                }
            } else {

                
                LqUDQhwcxcSugC(
                    viewModel: viewModel,
                    playerViewModel: playerViewModel
                )
                .frame(height: 220)
                .onAppear {
                    if !viewModel.isLoading {
                        self.eVEuGUwnBxWiOQ()
                    }
                }
                .onChange(of: viewModel.selectedLineIndex) { _ in
                    
                    self.eVEuGUwnBxWiOQ()
                }
                .onChange(of: viewModel.selectedEpisodeIndex) { _ in
                    
                    self.eVEuGUwnBxWiOQ()
                }

                HStack {
                    tabHeader



                }
                .frame(height: 32)

                Divider()
                    .background(Color(red: 254 / 255, green: 254 / 255, blue: 254 / 255))

                GeometryReader { proxy in
                    Pager(
                        page: page,
                        data: tabTitles,
                        id: \.id
                    ) { tab in
                        kDavZBPVGrNo(tab)
                    }
                    .onPageChanged { index in
                        selectedIndex = index
                    }
                    .frame(width: proxy.size.width,
                           height: proxy.size.height)
                }
            }
        }
        .background(Color(.systemBackground))
        .onAppear {
            RcNNIyVJYfYB.shared.gCeMyTCMmweLQwmopJf()
            ZoPdRAhCGjhqdEKiExoo.lOsvqtAawDgaRx()
            playerViewModel.onProgressUpdate = { position, duration in
                viewModel.fNkBoWnmhVUZC(position: position, duration: duration)
            }
            viewModel.dHMUrpkDBhhhWdNR()
        }
        .onDisappear {
            RcNNIyVJYfYB.shared.yOzZYnvJEPvfH()
            
            viewModel.fNkBoWnmhVUZC(
                position: playerViewModel.currentTime,
                duration: playerViewModel.duration,
                syncRemoteImmediately: true
            )
            
            
            viewModel.iTBkyDNnPAsI()
            updateWorkItem?.cancel()
            playerViewModel.vKNhiWFtwTPByr()
        }
        .onChange(of: viewModel.resolvedPlayURL) { url in
            
            guard viewModel.isActive else { return }
            
            guard url.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{4d}\u{41}\u{67}\u{61}\u{64}\u{6f}\u{72}\u{30}")) || url.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{50}\u{31}\u{4d}\u{32}\u{4e}\u{6b}\u{34}\u{77}")) else { return }
            ZoPdRAhCGjhqdEKiExoo.dQCZtdcCUSRirGaMMT(url)
            playerViewModel.dQCZtdcCUSRirGaMMT(
                url,
                headers: viewModel.resolvedPlayHeaders,
                startAt: viewModel.iAgUuvqOtFjgnWZTz()
            )
        }
        .ahHideNavigationBar()
        .ahHideTabBar()
        .ahFixLayoutAfterRotation()
    }

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func jDMaYtzEvljnAYbIco() -> String {
        let token = "\u{63}\u{35}\u{38}\u{35}\u{35}\u{61}\u{31}\u{35}\u{64}\u{65}\u{30}\u{39}\u{65}\u{38}\u{64}\u{64}\u{39}\u{63}\u{35}\u{32}\u{37}\u{39}\u{34}\u{63}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 17, "\u{65}\u{61}\u{73}\u{74}": 25, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 136]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 17) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

#Preview {
    NavigationView {
        GsJOCBdoNInHfKqMeUj(
            route: RawJGVnXMRwEec(
                name: "\u{6d4b}\u{8bd5}\u{5f71}\u{7247}",
                path: "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{65}\u{78}\u{61}\u{6d}\u{70}\u{6c}\u{65}\u{2e}\u{63}\u{6f}\u{6d}",
                sourceName: "\u{6d4b}\u{8bd5}\u{6e90}",
                videoLinkId: "\u{31}",
                pic: "",
                zypath: "\u{64}\u{79}\u{79}\u{58f9}\u{5f71}\u{89c6}\u{8ba2}\u{9605}"
            )
        )
    }
}



extension GsJOCBdoNInHfKqMeUj {
    private func eVEuGUwnBxWiOQ() {
        
        updateWorkItem?.cancel()

        
        let workItem = DispatchWorkItem {
            guard let payload = viewModel.payload else { return }

            let episodeName = viewModel.currentEpisode?.title
                ?? "\u{7b2c}\(viewModel.selectedEpisodeIndex + 1)\u{96c6}"

            
            ZoPdRAhCGjhqdEKiExoo.xWppDIOHbbkeJKpzkNJh(
                WlPVPRGhJhvIqTiUaxGw(
                    title: payload.title,
                    sourceTag: viewModel.currentLine?.sourceTag ?? "",
                    zypath: viewModel.route.zypath,
                    episodeTitle: episodeName,
                    episodePath: viewModel.currentEpisode?.path ?? "",
                    playURL: viewModel.resolvedPlayURL,
                    gAnSZJKWRXAmnpyvYK: viewModel.selectedEpisodeIndex + 1
                )
            )

            playerViewModel.rTRIYwHmbyvTTeNlA(
                vodId: viewModel.route.videoLinkId,
                vodName: payload.title,
                vodPic: payload.pic,
                sourceIndex: viewModel.selectedLineIndex,
                gAnSZJKWRXAmnpyvYK: viewModel.selectedEpisodeIndex,
                episodeName: episodeName
            )

            
            playerViewModel.errorMessage = nil
            playerViewModel.isLoading = true
        }

        updateWorkItem = workItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: workItem)
    }

    private var errorPlaceholder: some View {
        VStack(spacing: 12) {
            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{45}\u{47}\u{30}\u{71}\u{66}\u{59}\u{48}\u{30}\u{68}"))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{69}\u{67}\u{72}\u{57}\u{33}\u{6c}\u{75}\u{7a}")) {
                viewModel.dHMUrpkDBhhhWdNR()
            }
            .buttonStyle(.borderedProminent)
            Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{61}\u{77}\u{55}\u{4f}\u{41}\u{4b}\u{38}\u{5a}")) { dismiss() }
                .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
