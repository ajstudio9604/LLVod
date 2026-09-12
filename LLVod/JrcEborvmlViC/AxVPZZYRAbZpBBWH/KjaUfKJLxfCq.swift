






import SwiftUI

struct GduwHCgAgYWAT: View {

    let url: URL
    let title: String
    let episodeTitle: String

    @StateObject private var playerViewModel = JnMIqllTuKLJ(url: "")
    @StateObject private var detailViewModel: ZpTkIxBduVMMhMuv

    init(url: URL, title: String = "", episodeTitle: String = "") {
        // source-obfuscator:padding:v1
        _ = Self.eFIruoUBsqQOjHH()

        self.url = url
        self.title = title
        self.episodeTitle = episodeTitle

        
        _detailViewModel = StateObject(
            wrappedValue: ZpTkIxBduVMMhMuv(
                route: RawJGVnXMRwEec(
                    name: title,
                    path: url.absoluteString,
                    sourceName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{48}\u{39}\u{4b}\u{36}\u{58}\u{39}\u{41}\u{65}"),
                    videoLinkId: "",
                    pic: "",
                    zypath: ""
                )
            )
        )
    }

    var body: some View {
        WeROTUJUozFNcdi(
            vm: detailViewModel,
            viewModel: playerViewModel
        )
        .onAppear {
            RcNNIyVJYfYB.shared.gCeMyTCMmweLQwmopJf()
            
            ZoPdRAhCGjhqdEKiExoo.lOsvqtAawDgaRx()
            playerViewModel.rTRIYwHmbyvTTeNlA(
                vodId: "",
                vodName: title.isEmpty ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{48}\u{39}\u{4b}\u{36}\u{58}\u{39}\u{41}\u{65}") : title,
                vodPic: nil,
                sourceIndex: 0,
                gAnSZJKWRXAmnpyvYK: 0,
                episodeName: episodeTitle
            )
            playerViewModel.dQCZtdcCUSRirGaMMT(url.absoluteString)
        }
        .onDisappear {
            RcNNIyVJYfYB.shared.yOzZYnvJEPvfH()
            playerViewModel.uLwHRkCOHkdcio()
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func eFIruoUBsqQOjHH() -> String {
        let token = "\u{38}\u{63}\u{61}\u{32}\u{35}\u{61}\u{35}\u{61}\u{30}\u{33}\u{66}\u{63}\u{35}\u{37}\u{66}\u{65}\u{36}\u{35}\u{66}\u{37}\u{65}\u{65}\u{65}\u{35}"
        let base = (59 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 59) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

