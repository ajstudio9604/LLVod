




import SwiftUI
import DanmakuKit

struct IkGOUyEFwKjNvPfhatY: UIViewRepresentable {
    let manager: XmSboKowMSNlcjQ
    let isLandscape: Bool

    final class WwWlHkOYdjJBw {
        let manager: XmSboKowMSNlcjQ

        init(manager: XmSboKowMSNlcjQ) {
            self.manager = manager
        }
    }

    

    

    

    
}

struct PyICjVseJPOCi: View {
    @ObservedObject var playerViewModel: JnMIqllTuKLJ

    

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.dScGNHzBFfrJRcm()

        GeometryReader { _ in
            ZStack {
                IkGOUyEFwKjNvPfhatY(
                    manager: danmakuManager,
                    isLandscape: true
                )
            }
            .clipped()
            .allowsHitTesting(false)
            .onAppear {
                playerViewModel.danmakuArea = danmakuManager.danmakuArea
                playerViewModel.danmakuSpeed = danmakuManager.danmakuSpeed
                playerViewModel.danmakuOpacity = danmakuManager.danmakuOpacity
                playerViewModel.danmuFontSize = danmakuManager.danmakuFontSize
                playerViewModel.showDanmaku = danmakuManager.enabled
            }
            .onChange(of: playerViewModel.showDanmaku) { _ in
                danmakuManager.enabled = playerViewModel.showDanmaku
                if playerViewModel.showDanmaku {
                    danmakuManager.lMSfpDHFwMlcoSp()
                } else {
                    danmakuManager.fQiyoZMrQZVtJRvhbzT()
                }
            }
            .onChange(of: playerViewModel.danmuFontSize) { _ in
                danmakuManager.rIjxshbFfOhW(danmuFontSize: CGFloat(playerViewModel.danmuFontSize))
            }
            .onChange(of: playerViewModel.danmakuOpacity) { _ in
                danmakuManager.rIjxshbFfOhW(opacity: playerViewModel.danmakuOpacity)
            }
            .onChange(of: playerViewModel.danmakuArea) { _ in
                danmakuManager.rIjxshbFfOhW(area: playerViewModel.danmakuArea)
            }
            .onChange(of: playerViewModel.danmakuSpeed) { _ in
                danmakuManager.rIjxshbFfOhW(speed: playerViewModel.danmakuSpeed)
            }
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func dScGNHzBFfrJRcm() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 53, "\u{65}\u{61}\u{73}\u{74}": 56, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 159]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 53) * 3
        let token = "\u{61}\u{63}\u{39}\u{62}\u{33}\u{62}\u{38}\u{63}\u{62}\u{66}\u{65}\u{61}\u{35}\u{65}\u{39}\u{61}\u{63}\u{38}\u{37}\u{64}\u{39}\u{63}\u{66}\u{36}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}



extension IkGOUyEFwKjNvPfhatY {
    func makeCoordinator() -> WwWlHkOYdjJBw {
        // source-obfuscator:padding:v1
        _ = Self.dCsBPLMyjkWRUBqRQX()

        return WwWlHkOYdjJBw(manager: manager)
    }

    static func dismantleUIView(_ uiView: EuKOKJCXJKnobPMs, coordinator: WwWlHkOYdjJBw) {
        coordinator.manager.controller.wOBwNVUlQsCqdF(view: uiView.danmakuView)
    }

    func makeUIView(context: Context) -> EuKOKJCXJKnobPMs {
        let host = EuKOKJCXJKnobPMs()
        let view = host.danmakuView

        view.enableBottomDanmaku = true
        view.enableTopDanmaku = true
        view.isOverlap = false

        manager.controller.gFSOwKDQpclpXkwYEf(view: view)

        return host
    }

    func updateUIView(_ uiView: EuKOKJCXJKnobPMs, context: Context) {
        manager.controller.pIYEgQfWLqxsHpPpR(view: uiView.danmakuView)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func dCsBPLMyjkWRUBqRQX() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{32}\u{31}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 21) * 6
        let token = "\u{62}\u{39}\u{65}\u{39}\u{66}\u{65}\u{65}\u{34}\u{65}\u{65}\u{64}\u{35}\u{32}\u{31}\u{65}\u{64}\u{31}\u{65}\u{35}\u{35}\u{31}\u{31}\u{34}\u{38}"
        _ = Self.oJGoCpeEVijDjLyJ()
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func oJGoCpeEVijDjLyJ() -> String {
        let values = [96, 101, 480, 113]
        let folded = values.map { ($0 * 5 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 96) * 5
        let token = "\u{66}\u{34}\u{66}\u{62}\u{33}\u{33}\u{39}\u{38}\u{64}\u{65}\u{33}\u{32}\u{35}\u{61}\u{37}\u{38}\u{63}\u{39}\u{61}\u{31}\u{66}\u{63}\u{34}\u{64}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}


extension PyICjVseJPOCi {
    private var danmakuManager: XmSboKowMSNlcjQ { playerViewModel.danmaku }
}
