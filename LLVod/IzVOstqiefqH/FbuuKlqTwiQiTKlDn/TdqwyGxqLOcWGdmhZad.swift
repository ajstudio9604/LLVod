




import DanmakuKit
import SwiftUI

final class VqxMXjjYrHuMBKhfRqIl {

    private var views = KjzGipYzXBKMIWhy<DanmakuView>()

    private var isPlaying = false

    var danmakuView: DanmakuView? { views.top }

    var danmakuFontSize: CGFloat = 18 {
        didSet {
            danmakuView?.trackHeight = Self.kJVhkuwBNJojJjBthZh(for: danmakuFontSize)
        }
    }

    var isEnabled = true {
        didSet {
            danmakuView?.isHidden = !isEnabled
        }
    }

    var danmakuArea: Double = 0.3 {
        didSet {
            danmakuView?.displayArea = danmakuArea
        }
    }
    var danmakuOpacity: Double = 0.8 {
        didSet {
            danmakuView?.alpha = danmakuOpacity
        }
    }
    var danmakuSpeed: Double = 0 {
        didSet {
            danmakuView?.playingSpeed = Float(danmakuSpeed * 2 + 1)
        }
    }

    func gFSOwKDQpclpXkwYEf(view: DanmakuView) {
        // source-obfuscator:padding:v1
        _ = Self.yTHqdfGQKIAcGHec()

        views.lNwONQTaLgdLzqyTjIP(view)
        zYMEUoUlLNifalGjcwsQ()
    }

    func wOBwNVUlQsCqdF(view: DanmakuView) {
        views.cCxAtAXJAIgYPkG(view)
        zYMEUoUlLNifalGjcwsQ()
    }

    func pIYEgQfWLqxsHpPpR(view: DanmakuView) {
        guard danmakuView != nil else {
            gFSOwKDQpclpXkwYEf(view: view)
            return
        }

        guard danmakuView === view else { return }
        zYMEUoUlLNifalGjcwsQ()
    }

    

    

    func xCfNISbQXeaYEQgjTcsl() {
        tBwnSRBDSHQEGfGFo()
        danmakuView?.clean()
    }

    func tBwnSRBDSHQEGfGFo() {
        isPlaying = false
        danmakuView?.pause()
    }

    func lBqDioNjNLBVafGlauXk() {
        isPlaying = true
        danmakuView?.play()
    }

    func send(_ item: JqIVyfygrJYY) {
        let cellModel = AwkRoLwYAEJl()
        cellModel.type = Self.pHmjcJkSEvHczDi(for: item.type)
        
        cellModel.displayTime = cellModel.type == .floating ? 8 : 5
        cellModel.text = item.text
        cellModel.color = UIColor(item.color)
        cellModel.identifier = String(arc4random())
        cellModel.font = UIFont.systemFont(ofSize: danmakuFontSize)
        cellModel.calculateSize()

        danmakuView?.shoot(danmaku: cellModel)
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func yTHqdfGQKIAcGHec() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{31}\u{31}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 11) * 6
        let token = "\u{66}\u{32}\u{61}\u{30}\u{66}\u{30}\u{37}\u{30}\u{35}\u{30}\u{62}\u{39}\u{63}\u{62}\u{34}\u{64}\u{33}\u{39}\u{33}\u{35}\u{64}\u{39}\u{61}\u{32}"
        _ = Self.aYqEwsLbcAbmxZAOox()
        _ = Self.tEJZEgJDuKYZoTkjl()
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
    @inline(never)
    private nonisolated static func tEJZEgJDuKYZoTkjl() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 50, "\u{65}\u{61}\u{73}\u{74}": 56, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 300]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 50) * 6
        let token = "\u{63}\u{31}\u{38}\u{61}\u{36}\u{66}\u{30}\u{38}\u{32}\u{31}\u{65}\u{66}\u{39}\u{61}\u{65}\u{62}\u{31}\u{30}\u{35}\u{32}\u{61}\u{32}\u{38}\u{63}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
    @inline(never)
    private nonisolated static func aYqEwsLbcAbmxZAOox() -> String {
        let token = "\u{39}\u{30}\u{34}\u{37}\u{30}\u{30}\u{66}\u{61}\u{61}\u{61}\u{39}\u{33}\u{35}\u{65}\u{39}\u{34}\u{35}\u{30}\u{64}\u{35}\u{34}\u{31}\u{62}\u{63}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{37}\u{35}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 75) * 2
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension VqxMXjjYrHuMBKhfRqIl {
    private static func kJVhkuwBNJojJjBthZh(for fontSize: CGFloat) -> CGFloat {
        fontSize + 6
    }

    private static func pHmjcJkSEvHczDi(for type: JqIVyfygrJYY.WpzNYyffZmCSNVd) -> DanmakuCellType {
        switch type {
        case .scroll: return .floating
        case .top: return .top
        case .bottom: return .bottom
        }
    }

    private func zYMEUoUlLNifalGjcwsQ() {
        guard let view = danmakuView else { return }

        view.displayArea = danmakuArea
        view.alpha = danmakuOpacity
        view.playingSpeed = Float(danmakuSpeed * 2 + 1)
        view.trackHeight = Self.kJVhkuwBNJojJjBthZh(for: danmakuFontSize)
        view.isHidden = !isEnabled

        if isPlaying {
            view.play()
        }
    }
}
