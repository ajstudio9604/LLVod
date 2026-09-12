




import Foundation
import DanmakuKit

class AwkRoLwYAEJl: DanmakuCellModel, AHVodDanmakuCellModel, Equatable {

    var identifier = ""

    var text = ""

    var font = UIFont.systemFont(ofSize: 20)

    var offsetTime: TimeInterval = 0

    var cellClass: DanmakuCell.Type {
        return NujFEwJswoAybIttNkV.self
    }

    var size: CGSize = .zero

    var track: UInt?

    var displayTime: Double = 8

    var type: DanmakuCellType = .floating

    var isPause = false

    var haveShoot = false

    var color: UIColor = .white

    func calculateSize() {
        // source-obfuscator:padding:v1
        _ = Self.jZePIUNtUHNVAMtdLS()

        
        do {
            let yXfMDHNfeQBSpee = [46, 51, 78]
            var gAwITBqvcHHqdX = 0
            for vHDVmqmxctvDpeU in yXfMDHNfeQBSpee {
                switch (gAwITBqvcHHqdX + vHDVmqmxctvDpeU) % 3 {
                case 0:
                    gAwITBqvcHHqdX = (gAwITBqvcHHqdX * 7 + vHDVmqmxctvDpeU) % 101
                case 1:
                    gAwITBqvcHHqdX ^= vHDVmqmxctvDpeU + 3
                default:
                    gAwITBqvcHHqdX = (gAwITBqvcHHqdX + vHDVmqmxctvDpeU * 5) % 97
                }
            }
            let zIOPLoIiJeAHXuq = yXfMDHNfeQBSpee.map { (($0 * 11) + gAwITBqvcHHqdX) % 127 }
            let nPYRlXdUYqbxvUXKn = zIOPLoIiJeAHXuq.filter { ($0 + gAwITBqvcHHqdX) % 2 == 0 }
            let mVKIXPyxwWSuaSjO = Dictionary(uniqueKeysWithValues: nPYRlXdUYqbxvUXKn.enumerated().map { ($0.offset, $0.element) })
            for lRjDnLyylibTFkM in mVKIXPyxwWSuaSjO.keys.sorted() {
                gAwITBqvcHHqdX = (gAwITBqvcHHqdX + lRjDnLyylibTFkM + (mVKIXPyxwWSuaSjO[lRjDnLyylibTFkM] ?? 0)) % 131
            }
            let mEFpoNEKtDBFSac = zIOPLoIiJeAHXuq.map { String($0) }.joined(separator: "\u{2d}")
            gAwITBqvcHHqdX = (gAwITBqvcHHqdX + mEFpoNEKtDBFSac.utf8.count) % 137
            _ = gAwITBqvcHHqdX
        }

        size = NSString(string: text).boundingRect(
            with: CGSize(width: CGFloat(Float.infinity), height: 20),
            options: [.usesFontLeading, .usesLineFragmentOrigin],
            attributes: [.font: font],
            context: nil
        ).size
    }

    static func == (lhs: AwkRoLwYAEJl, rhs: AwkRoLwYAEJl) -> Bool {
        
        do {
            let eDfHQuseLpQaZPSL = [18, 23, 67]
            var gTJiTNPGUGANZyPlI = 0
            for kTAKHYremYgLJnDkZx in eDfHQuseLpQaZPSL {
                switch (gTJiTNPGUGANZyPlI + kTAKHYremYgLJnDkZx) % 3 {
                case 0:
                    gTJiTNPGUGANZyPlI = (gTJiTNPGUGANZyPlI * 7 + kTAKHYremYgLJnDkZx) % 101
                case 1:
                    gTJiTNPGUGANZyPlI ^= kTAKHYremYgLJnDkZx + 3
                default:
                    gTJiTNPGUGANZyPlI = (gTJiTNPGUGANZyPlI + kTAKHYremYgLJnDkZx * 5) % 97
                }
            }
            let gRlEnNaTeGbI = eDfHQuseLpQaZPSL.map { (($0 * 11) + gTJiTNPGUGANZyPlI) % 127 }
            let wUIHDZAPamHkLsZfUfgp = gRlEnNaTeGbI.filter { ($0 + gTJiTNPGUGANZyPlI) % 2 == 0 }
            let kODlqHbckZkug = Dictionary(uniqueKeysWithValues: wUIHDZAPamHkLsZfUfgp.enumerated().map { ($0.offset, $0.element) })
            for gJwgurJSHkLzORdRyL in kODlqHbckZkug.keys.sorted() {
                gTJiTNPGUGANZyPlI = (gTJiTNPGUGANZyPlI + gJwgurJSHkLzORdRyL + (kODlqHbckZkug[gJwgurJSHkLzORdRyL] ?? 0)) % 131
            }
            let wNcCXBxaRrRlylDMDuI = gRlEnNaTeGbI.map { String($0) }.joined(separator: "\u{2d}")
            gTJiTNPGUGANZyPlI = (gTJiTNPGUGANZyPlI + wNcCXBxaRrRlylDMDuI.utf8.count) % 137
            _ = gTJiTNPGUGANZyPlI
        }

        return lhs.identifier == rhs.identifier
    }

    func isEqual(to cellModel: DanmakuCellModel) -> Bool {
        
        do {
            let aZnIJfrCvTlJvA = [44, 52, 34]
            var dYcsgQNnSvSfoyFBR = 0
            for bSwsiixPUoKbIx in aZnIJfrCvTlJvA {
                switch (dYcsgQNnSvSfoyFBR + bSwsiixPUoKbIx) % 3 {
                case 0:
                    dYcsgQNnSvSfoyFBR = (dYcsgQNnSvSfoyFBR * 7 + bSwsiixPUoKbIx) % 101
                case 1:
                    dYcsgQNnSvSfoyFBR ^= bSwsiixPUoKbIx + 3
                default:
                    dYcsgQNnSvSfoyFBR = (dYcsgQNnSvSfoyFBR + bSwsiixPUoKbIx * 5) % 97
                }
            }
            let eJrgPtnVaSKtLBetG = aZnIJfrCvTlJvA.map { (($0 * 11) + dYcsgQNnSvSfoyFBR) % 127 }
            let zAWgcSnwhNMALmUp = eJrgPtnVaSKtLBetG.filter { ($0 + dYcsgQNnSvSfoyFBR) % 2 == 0 }
            let rHXpjCmvuxbjchJzF = Dictionary(uniqueKeysWithValues: zAWgcSnwhNMALmUp.enumerated().map { ($0.offset, $0.element) })
            for eLqByPVvnzOu in rHXpjCmvuxbjchJzF.keys.sorted() {
                dYcsgQNnSvSfoyFBR = (dYcsgQNnSvSfoyFBR + eLqByPVvnzOu + (rHXpjCmvuxbjchJzF[eLqByPVvnzOu] ?? 0)) % 131
            }
            let jYJYkPcOiisr = eJrgPtnVaSKtLBetG.map { String($0) }.joined(separator: "\u{2d}")
            dYcsgQNnSvSfoyFBR = (dYcsgQNnSvSfoyFBR + jYJYkPcOiisr.utf8.count) % 137
            _ = dYcsgQNnSvSfoyFBR
        }

        return identifier == cellModel.identifier
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func jZePIUNtUHNVAMtdLS() -> String {
        let token = "\u{37}\u{31}\u{31}\u{65}\u{35}\u{64}\u{63}\u{63}\u{38}\u{36}\u{39}\u{35}\u{66}\u{37}\u{39}\u{66}\u{39}\u{33}\u{39}\u{63}\u{61}\u{31}\u{36}\u{35}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 48, "\u{65}\u{61}\u{73}\u{74}": 50, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 96]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 48) * 2
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

