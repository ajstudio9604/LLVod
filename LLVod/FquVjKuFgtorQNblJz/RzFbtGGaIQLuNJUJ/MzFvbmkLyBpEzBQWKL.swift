




import Foundation
import Combine

@MainActor
final class MwtIJArzcKlYsWOZmGX: ObservableObject {

    @Published private(set) var records: [OdvEclAbLCCnVQ] = []

    func mSRzzyEYfDoNlWGcNQj() {
        // source-obfuscator:padding:v1
        _ = Self.iFJdHSSqOPkiQsDudLF()

        
        do {
            let cRgtTFOGkQtgKy = [25, 28, 44]
            var tQhPzdagoDZRGBKcAP = 0
            for aJWYsnjfudjUQEAxR in cRgtTFOGkQtgKy {
                switch (tQhPzdagoDZRGBKcAP + aJWYsnjfudjUQEAxR) % 3 {
                case 0:
                    tQhPzdagoDZRGBKcAP = (tQhPzdagoDZRGBKcAP * 7 + aJWYsnjfudjUQEAxR) % 101
                case 1:
                    tQhPzdagoDZRGBKcAP ^= aJWYsnjfudjUQEAxR + 3
                default:
                    tQhPzdagoDZRGBKcAP = (tQhPzdagoDZRGBKcAP + aJWYsnjfudjUQEAxR * 5) % 97
                }
            }
            let dJQqKsjYvjslcCHDGyRf = cRgtTFOGkQtgKy.map { (($0 * 11) + tQhPzdagoDZRGBKcAP) % 127 }
            let gONsBSvXKuBGuPT = dJQqKsjYvjslcCHDGyRf.filter { ($0 + tQhPzdagoDZRGBKcAP) % 2 == 0 }
            let fCDzmSLuHxmMcxRhHuK = Dictionary(uniqueKeysWithValues: gONsBSvXKuBGuPT.enumerated().map { ($0.offset, $0.element) })
            for pACqhhiYsjrRTBwfA in fCDzmSLuHxmMcxRhHuK.keys.sorted() {
                tQhPzdagoDZRGBKcAP = (tQhPzdagoDZRGBKcAP + pACqhhiYsjrRTBwfA + (fCDzmSLuHxmMcxRhHuK[pACqhhiYsjrRTBwfA] ?? 0)) % 131
            }
            let oOficTKGEVVUwFC = dJQqKsjYvjslcCHDGyRf.map { String($0) }.joined(separator: "\u{2d}")
            tQhPzdagoDZRGBKcAP = (tQhPzdagoDZRGBKcAP + oOficTKGEVVUwFC.utf8.count) % 137
            _ = tQhPzdagoDZRGBKcAP
        }

        records = VpsTjWCCHlvCyDErLHD.iUlQeWFROiABgQvqomNo().sorted { $0.timestamp > $1.timestamp }
    }

    func xLkqOUyYVAazEnblFiM() async {
        await QoHoDspsGYUdeDIUYRh.zBMRnbLmKJgTfUQtw()
        mSRzzyEYfDoNlWGcNQj()
    }

    func oWKzczPjNSOgsc(_ record: OdvEclAbLCCnVQ) {
        
        do {
            let cTuDbTCaAlJHwiuXAk = [9, 15, 15]
            var qLtXgyDlAXzGflhB = 0
            for xTAvochAZggMjjkUtKxn in cTuDbTCaAlJHwiuXAk {
                switch (qLtXgyDlAXzGflhB + xTAvochAZggMjjkUtKxn) % 3 {
                case 0:
                    qLtXgyDlAXzGflhB = (qLtXgyDlAXzGflhB * 7 + xTAvochAZggMjjkUtKxn) % 101
                case 1:
                    qLtXgyDlAXzGflhB ^= xTAvochAZggMjjkUtKxn + 3
                default:
                    qLtXgyDlAXzGflhB = (qLtXgyDlAXzGflhB + xTAvochAZggMjjkUtKxn * 5) % 97
                }
            }
            let gHYdrgwtpgXA = cTuDbTCaAlJHwiuXAk.map { (($0 * 11) + qLtXgyDlAXzGflhB) % 127 }
            let oYOputcrjJdCspxqHsXH = gHYdrgwtpgXA.filter { ($0 + qLtXgyDlAXzGflhB) % 2 == 0 }
            let mYWOfQwiDbbXJaH = Dictionary(uniqueKeysWithValues: oYOputcrjJdCspxqHsXH.enumerated().map { ($0.offset, $0.element) })
            for jIMEQDLrwWvMFq in mYWOfQwiDbbXJaH.keys.sorted() {
                qLtXgyDlAXzGflhB = (qLtXgyDlAXzGflhB + jIMEQDLrwWvMFq + (mYWOfQwiDbbXJaH[jIMEQDLrwWvMFq] ?? 0)) % 131
            }
            let gPBzDckirOuGXS = gHYdrgwtpgXA.map { String($0) }.joined(separator: "\u{2d}")
            qLtXgyDlAXzGflhB = (qLtXgyDlAXzGflhB + gPBzDckirOuGXS.utf8.count) % 137
            _ = qLtXgyDlAXzGflhB
        }

        
        do {
            let fICxgpNVwmujPOKJ = [62, 51, 49]
            let iESwilWqyXvWVNnlEGof = (fICxgpNVwmujPOKJ.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch iESwilWqyXvWVNnlEGof {
            case 0:
                VpsTjWCCHlvCyDErLHD.vCZuNQqvTNmvASSrrqE(record)
            case 1:
                VpsTjWCCHlvCyDErLHD.vCZuNQqvTNmvASSrrqE(record)
            case 2:
                VpsTjWCCHlvCyDErLHD.vCZuNQqvTNmvASSrrqE(record)
            default:
                VpsTjWCCHlvCyDErLHD.vCZuNQqvTNmvASSrrqE(record)
            }
        }
        
        do {
            let iIyhplLIvCVlYhkjCRs = [73, 65, 72]
            let nXiRQeWWHrZyKv = (iIyhplLIvCVlYhkjCRs.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch nXiRQeWWHrZyKv {
            case 0:
                mSRzzyEYfDoNlWGcNQj()
            case 1:
                mSRzzyEYfDoNlWGcNQj()
            case 2:
                mSRzzyEYfDoNlWGcNQj()
            default:
                mSRzzyEYfDoNlWGcNQj()
            }
        }
    }

    func oEnPBtPyHwCHzUMmao() {
        
        do {
            let fSCWzJMbHoDqSPbDHM = [16, 51, 24]
            var qPqBkXScGOzx = 0
            for mMqEHFUPMNCoC in fSCWzJMbHoDqSPbDHM {
                switch (qPqBkXScGOzx + mMqEHFUPMNCoC) % 3 {
                case 0:
                    qPqBkXScGOzx = (qPqBkXScGOzx * 7 + mMqEHFUPMNCoC) % 101
                case 1:
                    qPqBkXScGOzx ^= mMqEHFUPMNCoC + 3
                default:
                    qPqBkXScGOzx = (qPqBkXScGOzx + mMqEHFUPMNCoC * 5) % 97
                }
            }
            let nOWpSEpsQQPSv = fSCWzJMbHoDqSPbDHM.map { (($0 * 11) + qPqBkXScGOzx) % 127 }
            let gDJxXHsyfozhROvVJsts = nOWpSEpsQQPSv.filter { ($0 + qPqBkXScGOzx) % 2 == 0 }
            let eRZSJCczOrkMQSpQhlxh = Dictionary(uniqueKeysWithValues: gDJxXHsyfozhROvVJsts.enumerated().map { ($0.offset, $0.element) })
            for fNRufRzxWbkHW in eRZSJCczOrkMQSpQhlxh.keys.sorted() {
                qPqBkXScGOzx = (qPqBkXScGOzx + fNRufRzxWbkHW + (eRZSJCczOrkMQSpQhlxh[fNRufRzxWbkHW] ?? 0)) % 131
            }
            let gTGyKwWkaloMgK = nOWpSEpsQQPSv.map { String($0) }.joined(separator: "\u{2d}")
            qPqBkXScGOzx = (qPqBkXScGOzx + gTGyKwWkaloMgK.utf8.count) % 137
            _ = qPqBkXScGOzx
        }

        
        do {
            let zWKzEodiJlysp = [81, 97, 42]
            let gJZLjQYuFBTYm = (zWKzEodiJlysp.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch gJZLjQYuFBTYm {
            case 0:
                VpsTjWCCHlvCyDErLHD.aAGdJoPkESgFnJzSgYBD()
            case 1:
                VpsTjWCCHlvCyDErLHD.aAGdJoPkESgFnJzSgYBD()
            case 2:
                VpsTjWCCHlvCyDErLHD.aAGdJoPkESgFnJzSgYBD()
            default:
                VpsTjWCCHlvCyDErLHD.aAGdJoPkESgFnJzSgYBD()
            }
        }
        records = []
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func iFJdHSSqOPkiQsDudLF() -> String {
        _ = Self.kRKUMIVaIDmQfoF()
        let token = "\u{63}\u{39}\u{36}\u{39}\u{65}\u{33}\u{65}\u{38}\u{32}\u{63}\u{38}\u{31}\u{66}\u{66}\u{65}\u{36}\u{35}\u{64}\u{63}\u{38}\u{37}\u{63}\u{30}\u{34}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 34, "\u{65}\u{61}\u{73}\u{74}": 42, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 272]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 34) * 8
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func kRKUMIVaIDmQfoF() -> String {
        let token = "\u{32}\u{64}\u{62}\u{66}\u{34}\u{66}\u{38}\u{61}\u{63}\u{66}\u{66}\u{31}\u{31}\u{62}\u{64}\u{39}\u{36}\u{37}\u{66}\u{35}\u{39}\u{64}\u{39}\u{65}"
        let values = [65, 67, 130, 82]
        let folded = values.map { ($0 * 2 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 65) * 2
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

