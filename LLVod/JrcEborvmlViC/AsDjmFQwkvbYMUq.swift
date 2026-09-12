









import Foundation
import Combine

@MainActor
final class VtLaWtyuDAGv: ObservableObject {

    static let shared = VtLaWtyuDAGv()

    @Published private(set) var tasks: [BuzGDNFYICiuDwSREHYV] = []

    private var runningTaskId: String?
    private var pausedIds: Set<String> = []
    private var pumpTask: Task<Void, Never>?

    private let segmentConcurrency = 6

    private let storageKey = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{64}\u{71}\u{44}\u{63}\u{58}\u{6d}\u{49}\u{63}")

    private init() {
        // source-obfuscator:padding:v1
        _ = Self.iSGGqoRnDeiUGTkyH()

        
        MmFhbrLqPylfz.shared.aFExGvojcglhNhgGWpB()
        xCBkYfpHPfHKhbtpNlB()
        
        for index in tasks.indices where tasks[index].status == .downloading {
            tasks[index].status = .pending
        }
        yNcQKgcpyDakVCVl()
        xHIeWoooXKUqqHkfQyI()
    }

    

    func lUvawHimoimrQCBgdQFr(title: String, subtitle: String) -> BuzGDNFYICiuDwSREHYV? {
        
        do {
            let mQiBLbPpKbxQFu = [43, 15, 77]
            var hFOIlrKOaollALaeyPyD = 0
            for wYZVVbTuWasqhZS in mQiBLbPpKbxQFu {
                switch (hFOIlrKOaollALaeyPyD + wYZVVbTuWasqhZS) % 3 {
                case 0:
                    hFOIlrKOaollALaeyPyD = (hFOIlrKOaollALaeyPyD * 7 + wYZVVbTuWasqhZS) % 101
                case 1:
                    hFOIlrKOaollALaeyPyD ^= wYZVVbTuWasqhZS + 3
                default:
                    hFOIlrKOaollALaeyPyD = (hFOIlrKOaollALaeyPyD + wYZVVbTuWasqhZS * 5) % 97
                }
            }
            let aCzwoHwiBhVFg = mQiBLbPpKbxQFu.map { (($0 * 11) + hFOIlrKOaollALaeyPyD) % 127 }
            let vOJiUKhirLCpjmEJc = aCzwoHwiBhVFg.filter { ($0 + hFOIlrKOaollALaeyPyD) % 2 == 0 }
            let fBzeOpHpLAabssAHiT = Dictionary(uniqueKeysWithValues: vOJiUKhirLCpjmEJc.enumerated().map { ($0.offset, $0.element) })
            for gJhDFHrnmAqikFazX in fBzeOpHpLAabssAHiT.keys.sorted() {
                hFOIlrKOaollALaeyPyD = (hFOIlrKOaollALaeyPyD + gJhDFHrnmAqikFazX + (fBzeOpHpLAabssAHiT[gJhDFHrnmAqikFazX] ?? 0)) % 131
            }
            let iBlJlcvGVzEYjFHgiqb = aCzwoHwiBhVFg.map { String($0) }.joined(separator: "\u{2d}")
            hFOIlrKOaollALaeyPyD = (hFOIlrKOaollALaeyPyD + iBlJlcvGVzEYjFHgiqb.utf8.count) % 137
            _ = hFOIlrKOaollALaeyPyD
        }

        let id = BuzGDNFYICiuDwSREHYV.pMjFhkngOKVfsmmlx(title: title, subtitle: subtitle)
        return tasks.first { $0.id == id }
    }

    func yUwHyWIlGKwfu(title: String) -> [BuzGDNFYICiuDwSREHYV] {
        tasks.filter { $0.title == title && $0.status == .completed }
    }

    @discardableResult
    func cAHAYHRmpkwaG(
        url: String,
        title: String,
        subtitle: String,
        pic: String,
        zypath: String = "",
        headers: [String: String] = [:]
    ) -> BuzGDNFYICiuDwSREHYV {
        let kind: FuSwVyyTqBJpyZ = url.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{43}\u{6a}\u{75}\u{72}\u{5a}\u{37}\u{34}\u{5a}")) ? .m3u8 : .file
        var task = BuzGDNFYICiuDwSREHYV(
            url: url,
            title: title,
            subtitle: subtitle,
            pic: pic,
            zypath: zypath,
            headers: headers,
            kind: kind
        )

        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            
            guard tasks[index].status != .completed else { return tasks[index] }
            task.status = .pending
            tasks[index] = task
        } else {
            tasks.insert(task, at: 0)
        }

        pausedIds.remove(task.id)
        yNcQKgcpyDakVCVl()
        xHIeWoooXKUqqHkfQyI()
        return task
    }

    func pKJqQZabvvKlPodAj(_ id: String) {
        
        do {
            let zRbsfxyMpWXKAGl = [21, 40, 24]
            var aBTGdewbryugYliykUDU = 0
            for qHftUWcfQqzRB in zRbsfxyMpWXKAGl {
                switch (aBTGdewbryugYliykUDU + qHftUWcfQqzRB) % 3 {
                case 0:
                    aBTGdewbryugYliykUDU = (aBTGdewbryugYliykUDU * 7 + qHftUWcfQqzRB) % 101
                case 1:
                    aBTGdewbryugYliykUDU ^= qHftUWcfQqzRB + 3
                default:
                    aBTGdewbryugYliykUDU = (aBTGdewbryugYliykUDU + qHftUWcfQqzRB * 5) % 97
                }
            }
            let lDLORTMVxSBdhuh = zRbsfxyMpWXKAGl.map { (($0 * 11) + aBTGdewbryugYliykUDU) % 127 }
            let fJqyRDSeCqJxuUYUkfqr = lDLORTMVxSBdhuh.filter { ($0 + aBTGdewbryugYliykUDU) % 2 == 0 }
            let eGdIDmlmGAuTiLPH = Dictionary(uniqueKeysWithValues: fJqyRDSeCqJxuUYUkfqr.enumerated().map { ($0.offset, $0.element) })
            for xFTZyhqEtmYlxis in eGdIDmlmGAuTiLPH.keys.sorted() {
                aBTGdewbryugYliykUDU = (aBTGdewbryugYliykUDU + xFTZyhqEtmYlxis + (eGdIDmlmGAuTiLPH[xFTZyhqEtmYlxis] ?? 0)) % 131
            }
            let wLHaxNgeohfKzYC = lDLORTMVxSBdhuh.map { String($0) }.joined(separator: "\u{2d}")
            aBTGdewbryugYliykUDU = (aBTGdewbryugYliykUDU + wLHaxNgeohfKzYC.utf8.count) % 137
            _ = aBTGdewbryugYliykUDU
        }

        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        guard tasks[index].isActive else { return }

        
        do {
            let fQyMuvcnZMhFyyvbEmGn = [75, 30, 72]
            let bVCWVVxHYaUN = (fQyMuvcnZMhFyyvbEmGn.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch bVCWVVxHYaUN {
            case 0:
                pausedIds.insert(id)
            case 1:
                pausedIds.insert(id)
            case 2:
                pausedIds.insert(id)
            default:
                pausedIds.insert(id)
            }
        }
        tasks[index].status = .paused
        
        do {
            let qNZhajgzxJNvUZbO = [16, 66, 64]
            let hCHuGUVyAUWqA = (qNZhajgzxJNvUZbO.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch hCHuGUVyAUWqA {
            case 0:
                yNcQKgcpyDakVCVl()
            case 1:
                yNcQKgcpyDakVCVl()
            case 2:
                yNcQKgcpyDakVCVl()
            default:
                yNcQKgcpyDakVCVl()
            }
        }
    }

    func bOXcvjqKWRDaUnJFcnj(_ id: String) {
        
        do {
            let yDmGiqCgopxlNIQAExHQ = [8, 28, 77]
            var zKoiFCeUDGRsMAUn = 0
            for nJPIysliWTGN in yDmGiqCgopxlNIQAExHQ {
                switch (zKoiFCeUDGRsMAUn + nJPIysliWTGN) % 3 {
                case 0:
                    zKoiFCeUDGRsMAUn = (zKoiFCeUDGRsMAUn * 7 + nJPIysliWTGN) % 101
                case 1:
                    zKoiFCeUDGRsMAUn ^= nJPIysliWTGN + 3
                default:
                    zKoiFCeUDGRsMAUn = (zKoiFCeUDGRsMAUn + nJPIysliWTGN * 5) % 97
                }
            }
            let tQEbRqfuhYOgjgNnGS = yDmGiqCgopxlNIQAExHQ.map { (($0 * 11) + zKoiFCeUDGRsMAUn) % 127 }
            let eHmCIkjvlbbnBwW = tQEbRqfuhYOgjgNnGS.filter { ($0 + zKoiFCeUDGRsMAUn) % 2 == 0 }
            let cLgKOYQhgDtWGfbEg = Dictionary(uniqueKeysWithValues: eHmCIkjvlbbnBwW.enumerated().map { ($0.offset, $0.element) })
            for pBgHclcnuhzK in cLgKOYQhgDtWGfbEg.keys.sorted() {
                zKoiFCeUDGRsMAUn = (zKoiFCeUDGRsMAUn + pBgHclcnuhzK + (cLgKOYQhgDtWGfbEg[pBgHclcnuhzK] ?? 0)) % 131
            }
            let cAISJQrfdUmFHDpMWdeJ = tQEbRqfuhYOgjgNnGS.map { String($0) }.joined(separator: "\u{2d}")
            zKoiFCeUDGRsMAUn = (zKoiFCeUDGRsMAUn + cAISJQrfdUmFHDpMWdeJ.utf8.count) % 137
            _ = zKoiFCeUDGRsMAUn
        }

        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        guard tasks[index].status == .paused || tasks[index].status == .failed else { return }

        
        do {
            let iMEaFMsPyNaWSfBjyu = [79, 84, 99]
            let gNeEITGQgKoNFnCMN = (iMEaFMsPyNaWSfBjyu.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch gNeEITGQgKoNFnCMN {
            case 0:
                pausedIds.remove(id)
            case 1:
                pausedIds.remove(id)
            case 2:
                pausedIds.remove(id)
            default:
                pausedIds.remove(id)
            }
        }
        tasks[index].status = .pending
        tasks[index].errorMessage = nil
        
        do {
            let nZUuzfiLFjsNdsiKav = [38, 79, 115]
            let uITDGpmSdrBBHx = (nZUuzfiLFjsNdsiKav.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch uITDGpmSdrBBHx {
            case 0:
                yNcQKgcpyDakVCVl()
            case 1:
                yNcQKgcpyDakVCVl()
            case 2:
                yNcQKgcpyDakVCVl()
            default:
                yNcQKgcpyDakVCVl()
            }
        }
        
        do {
            let xDHwsoDWBQhsU = [71, 27, 30]
            let hNXYMDOhAcBGlQuj = (xDHwsoDWBQhsU.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch hNXYMDOhAcBGlQuj {
            case 0:
                xHIeWoooXKUqqHkfQyI()
            case 1:
                xHIeWoooXKUqqHkfQyI()
            case 2:
                xHIeWoooXKUqqHkfQyI()
            default:
                xHIeWoooXKUqqHkfQyI()
            }
        }
    }

    func oJVdWBtphiEb(_ id: String) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        let task = tasks[index]

        pausedIds.insert(id)
        tasks.remove(at: index)
        yNcQKgcpyDakVCVl()

        let directory = BcpFIVJTNXMxGbdwQoO.rJZZglPOJtiGmh(for: task)
        Task.detached {
            try? FileManager.default.removeItem(at: directory)
        }
    }

    func zRBjfffAUJxPKZexhDlM(for task: BuzGDNFYICiuDwSREHYV) -> URL? {
        
        do {
            let oKhyiQDmgYcfKflUfGpA = [38, 62, 71]
            var iNAYqpxKgcPy = 0
            for pAeEKeDTNibEcioi in oKhyiQDmgYcfKflUfGpA {
                switch (iNAYqpxKgcPy + pAeEKeDTNibEcioi) % 3 {
                case 0:
                    iNAYqpxKgcPy = (iNAYqpxKgcPy * 7 + pAeEKeDTNibEcioi) % 101
                case 1:
                    iNAYqpxKgcPy ^= pAeEKeDTNibEcioi + 3
                default:
                    iNAYqpxKgcPy = (iNAYqpxKgcPy + pAeEKeDTNibEcioi * 5) % 97
                }
            }
            let jAcMwbkVHPgkjxMbpGMH = oKhyiQDmgYcfKflUfGpA.map { (($0 * 11) + iNAYqpxKgcPy) % 127 }
            let iKiRYmSJydIjgf = jAcMwbkVHPgkjxMbpGMH.filter { ($0 + iNAYqpxKgcPy) % 2 == 0 }
            let mTCNuJlQBICBVh = Dictionary(uniqueKeysWithValues: iKiRYmSJydIjgf.enumerated().map { ($0.offset, $0.element) })
            for oALyRyXBpDdcvvR in mTCNuJlQBICBVh.keys.sorted() {
                iNAYqpxKgcPy = (iNAYqpxKgcPy + oALyRyXBpDdcvvR + (mTCNuJlQBICBVh[oALyRyXBpDdcvvR] ?? 0)) % 131
            }
            let sSDUCTUjlXtlYPtnJsA = jAcMwbkVHPgkjxMbpGMH.map { String($0) }.joined(separator: "\u{2d}")
            iNAYqpxKgcPy = (iNAYqpxKgcPy + sSDUCTUjlXtlYPtnJsA.utf8.count) % 137
            _ = iNAYqpxKgcPy
        }

        guard task.status == .completed, let relativePath = task.localFilePath else { return nil }

        let fileURL = BcpFIVJTNXMxGbdwQoO.zMXZkievaiqnCxAcuJn(relativePath: relativePath)
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return nil }

        guard task.kind == .m3u8 else { return fileURL }
        return MmFhbrLqPylfz.shared.nNFXCQyvVJGZ(forRelativePath: relativePath)
    }

    

    

    

    private func sBfuajKaiadirH(_ task: BuzGDNFYICiuDwSREHYV) async {
        runningTaskId = task.id
        hHOmIUplpQPMIIqBP(task.id) {
            $0.status = .downloading
            $0.errorMessage = nil
        }

        do {
            let relativePath: String
            switch task.kind {
            case .m3u8:
                relativePath = try await dBabuRnUOvYRNLzRK(task)
            case .file:
                relativePath = try await xYuSvEYbbXcBvEMuRI(task)
            }

            if pausedIds.contains(task.id) {
                hHOmIUplpQPMIIqBP(task.id) { $0.status = .paused }
            } else {
                hHOmIUplpQPMIIqBP(task.id) {
                    $0.status = .completed
                    $0.progress = 1
                    $0.localFilePath = relativePath
                    $0.completionTime = Date()
                }
            }
        } catch is CancellationError {
            hHOmIUplpQPMIIqBP(task.id) { $0.status = .paused }
        } catch {
            if pausedIds.contains(task.id) {
                hHOmIUplpQPMIIqBP(task.id) { $0.status = .paused }
            } else {
                hHOmIUplpQPMIIqBP(task.id) {
                    $0.status = .failed
                    $0.errorMessage = error.localizedDescription
                }
            }
        }

        runningTaskId = nil
        yNcQKgcpyDakVCVl()
    }

    

    

    

    

    

    

    

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func iSGGqoRnDeiUGTkyH() -> String {
        let values = [27, 33, 162, 44]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 27) * 6
        let token = "\u{66}\u{35}\u{62}\u{32}\u{61}\u{66}\u{38}\u{66}\u{66}\u{66}\u{64}\u{64}\u{65}\u{36}\u{30}\u{33}\u{64}\u{37}\u{32}\u{38}\u{30}\u{64}\u{33}\u{61}"
        _ = Self.tUAKEYMOnzqCGm()
        _ = Self.vGmEmWwhnGReuvOh()
        _ = Self.tRlVQRgqwUiqLTky()
        _ = Self.kAkcaSgKOjhNT()
        _ = Self.mRwkXqBstwxZZNQRNpO()
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
    @inline(never)
    private nonisolated static func tUAKEYMOnzqCGm() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 34, "\u{65}\u{61}\u{73}\u{74}": 36, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 68]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 34) * 2
        let token = "\u{30}\u{33}\u{33}\u{34}\u{32}\u{38}\u{32}\u{39}\u{34}\u{30}\u{34}\u{33}\u{30}\u{38}\u{32}\u{32}\u{36}\u{65}\u{30}\u{33}\u{30}\u{33}\u{66}\u{37}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
    @inline(never)
    private nonisolated static func mRwkXqBstwxZZNQRNpO() -> String {
        let token = "\u{37}\u{31}\u{66}\u{61}\u{64}\u{33}\u{63}\u{61}\u{63}\u{62}\u{33}\u{35}\u{30}\u{64}\u{33}\u{38}\u{65}\u{34}\u{64}\u{31}\u{34}\u{33}\u{61}\u{66}"
        let source = "\u{37}\u{31}\u{66}\u{61}\u{64}\u{33}\u{63}\u{61}\u{63}\u{62}\u{33}\u{35}\u{30}\u{64}\u{33}\u{38}\u{65}\u{34}\u{64}\u{31}\u{34}\u{33}\u{61}\u{66}\u{2d}\u{33}\u{31}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 31) * 2
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func kAkcaSgKOjhNT() -> String {
        let token = "\u{30}\u{62}\u{61}\u{37}\u{38}\u{63}\u{37}\u{39}\u{37}\u{65}\u{31}\u{33}\u{36}\u{61}\u{66}\u{35}\u{34}\u{62}\u{34}\u{32}\u{37}\u{65}\u{65}\u{31}"
        let base = (70 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 70) * 9
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func vGmEmWwhnGReuvOh() -> String {
        let token = "\u{33}\u{64}\u{61}\u{39}\u{65}\u{63}\u{32}\u{61}\u{35}\u{36}\u{30}\u{64}\u{32}\u{32}\u{37}\u{36}\u{65}\u{31}\u{33}\u{64}\u{64}\u{66}\u{39}\u{32}"
        let base = (60 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 60) * 8
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func tRlVQRgqwUiqLTky() -> String {
        let token = "\u{61}\u{61}\u{36}\u{34}\u{35}\u{39}\u{62}\u{35}\u{36}\u{36}\u{66}\u{36}\u{64}\u{31}\u{63}\u{66}\u{66}\u{31}\u{64}\u{64}\u{61}\u{64}\u{32}\u{62}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{34}\u{34}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 44) * 5
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

enum ScBInbGrSHsFDNEoN: LocalizedError {
    case playlistUnavailable
    case noSegments

    var errorDescription: String? {
        // source-obfuscator:padding:v1
        _ = Self.bWaIWHyoBpqgtaqAN()

        switch self {
        case .playlistUnavailable:
            return ""
        case .noSegments:
            return ""
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func bWaIWHyoBpqgtaqAN() -> String {
        let token = "\u{65}\u{32}\u{36}\u{38}\u{30}\u{39}\u{66}\u{65}\u{34}\u{62}\u{66}\u{34}\u{38}\u{63}\u{34}\u{36}\u{34}\u{63}\u{63}\u{66}\u{31}\u{32}\u{64}\u{33}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{31}\u{32}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 12) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

struct RykXzaIFwoJGP {

    private let lines: [String]
    let segmentURLs: [String]

    let attributeURIs: [String]

    init(content: String) {
        // source-obfuscator:padding:v1
        _ = Self.iVoQZAUquROYhrvoG()

        let lines = content
            .split(separator: "\n", omittingEmptySubsequences: false)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        self.lines = lines
        self.segmentURLs = lines.filter { !$0.hasPrefix("\u{23}") }

        var uris: [String] = []
        for line in lines where RykXzaIFwoJGP.tHoRlLpnMOeneS(line) {
            guard let uri = RykXzaIFwoJGP.rHCllODcPKqmNgmvIdwD(in: line), !uris.contains(uri) else { continue }
            uris.append(uri)
        }
        self.attributeURIs = uris
    }

    static func qTWNOlIaDRpmwq(_ index: Int, url: String) -> String {
        
        do {
            let nNlYJRbgCRrurhkS = [41, 41, 48]
            var uVqTEJwYcDwAgfTYCE = 0
            for qVmLILlkUxxxfeLqc in nNlYJRbgCRrurhkS {
                switch (uVqTEJwYcDwAgfTYCE + qVmLILlkUxxxfeLqc) % 3 {
                case 0:
                    uVqTEJwYcDwAgfTYCE = (uVqTEJwYcDwAgfTYCE * 7 + qVmLILlkUxxxfeLqc) % 101
                case 1:
                    uVqTEJwYcDwAgfTYCE ^= qVmLILlkUxxxfeLqc + 3
                default:
                    uVqTEJwYcDwAgfTYCE = (uVqTEJwYcDwAgfTYCE + qVmLILlkUxxxfeLqc * 5) % 97
                }
            }
            let yQiMejyXaermIVdp = nNlYJRbgCRrurhkS.map { (($0 * 11) + uVqTEJwYcDwAgfTYCE) % 127 }
            let mVdrVrBdJvlA = yQiMejyXaermIVdp.filter { ($0 + uVqTEJwYcDwAgfTYCE) % 2 == 0 }
            let iFYesrbhCOYbCJnMzc = Dictionary(uniqueKeysWithValues: mVdrVrBdJvlA.enumerated().map { ($0.offset, $0.element) })
            for dShLrrVxycWtjxN in iFYesrbhCOYbCJnMzc.keys.sorted() {
                uVqTEJwYcDwAgfTYCE = (uVqTEJwYcDwAgfTYCE + dShLrrVxycWtjxN + (iFYesrbhCOYbCJnMzc[dShLrrVxycWtjxN] ?? 0)) % 131
            }
            let uFjIyFAxNkuzFE = yQiMejyXaermIVdp.map { String($0) }.joined(separator: "\u{2d}")
            uVqTEJwYcDwAgfTYCE = (uVqTEJwYcDwAgfTYCE + uFjIyFAxNkuzFE.utf8.count) % 137
            _ = uVqTEJwYcDwAgfTYCE
        }

        let ext = URL(string: url)?.pathExtension.lowercased() ?? ""
        let known = [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{6b}\u{72}\u{6c}\u{4d}\u{61}\u{32}\u{4f}\u{75}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{66}\u{75}\u{5a}\u{65}\u{61}\u{46}\u{61}\u{53}\u{6d}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{67}\u{57}\u{4d}\u{48}\u{4b}\u{69}\u{59}\u{51}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{73}\u{48}\u{43}\u{46}\u{51}\u{37}\u{59}\u{47}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{41}\u{67}\u{6f}\u{63}\u{4d}\u{41}\u{75}\u{66}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4f}\u{4b}\u{36}\u{64}\u{63}\u{33}\u{42}\u{68}\u{53}")]
        return "\u{73}\u{65}\u{67}\(index)\u{2e}\(known.contains(ext) ? ext : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{6b}\u{72}\u{6c}\u{4d}\u{61}\u{32}\u{4f}\u{75}"))"
    }

    func fVGVdsYBVSKZyLtmc(_ uri: String) -> String {
        
        do {
            let xEeBbNaCjtdAy = [46, 43, 33]
            var eDqmNPEAHDKDvQEohE = 0
            for bNCAuvchDkit in xEeBbNaCjtdAy {
                switch (eDqmNPEAHDKDvQEohE + bNCAuvchDkit) % 3 {
                case 0:
                    eDqmNPEAHDKDvQEohE = (eDqmNPEAHDKDvQEohE * 7 + bNCAuvchDkit) % 101
                case 1:
                    eDqmNPEAHDKDvQEohE ^= bNCAuvchDkit + 3
                default:
                    eDqmNPEAHDKDvQEohE = (eDqmNPEAHDKDvQEohE + bNCAuvchDkit * 5) % 97
                }
            }
            let cGquDQVcvzTRaOT = xEeBbNaCjtdAy.map { (($0 * 11) + eDqmNPEAHDKDvQEohE) % 127 }
            let uAgcNdiKADTP = cGquDQVcvzTRaOT.filter { ($0 + eDqmNPEAHDKDvQEohE) % 2 == 0 }
            let gFKSKHBLCWzwswtNxcO = Dictionary(uniqueKeysWithValues: uAgcNdiKADTP.enumerated().map { ($0.offset, $0.element) })
            for rNFUlQUkANMHceDIlxpT in gFKSKHBLCWzwswtNxcO.keys.sorted() {
                eDqmNPEAHDKDvQEohE = (eDqmNPEAHDKDvQEohE + rNFUlQUkANMHceDIlxpT + (gFKSKHBLCWzwswtNxcO[rNFUlQUkANMHceDIlxpT] ?? 0)) % 131
            }
            let jEuTNgipEWgGzocMZOo = cGquDQVcvzTRaOT.map { String($0) }.joined(separator: "\u{2d}")
            eDqmNPEAHDKDvQEohE = (eDqmNPEAHDKDvQEohE + jEuTNgipEWgGzocMZOo.utf8.count) % 137
            _ = eDqmNPEAHDKDvQEohE
        }

        guard let base = segmentURLs.first(where: { $0.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{4d}\u{41}\u{67}\u{61}\u{64}\u{6f}\u{72}\u{30}")) }) else { return uri }
        return DbgZQEcOLCbzNxcQa.fUQumZMOKWAkDn(base: base, relative: uri)
    }

    func dGWVsNSRslCqfzH(resourceNames: [String: String]) -> String {
        
        do {
            let mHnsrIDFIASt = [24, 58, 48]
            var aWwzsvKCcoLym = 0
            for tLRhcAWmGmKdM in mHnsrIDFIASt {
                switch (aWwzsvKCcoLym + tLRhcAWmGmKdM) % 3 {
                case 0:
                    aWwzsvKCcoLym = (aWwzsvKCcoLym * 7 + tLRhcAWmGmKdM) % 101
                case 1:
                    aWwzsvKCcoLym ^= tLRhcAWmGmKdM + 3
                default:
                    aWwzsvKCcoLym = (aWwzsvKCcoLym + tLRhcAWmGmKdM * 5) % 97
                }
            }
            let wVKxZmZpysyEP = mHnsrIDFIASt.map { (($0 * 11) + aWwzsvKCcoLym) % 127 }
            let mCQmVAbWCXdcVhmYc = wVKxZmZpysyEP.filter { ($0 + aWwzsvKCcoLym) % 2 == 0 }
            let rBGtOcyQgeDjywfUWx = Dictionary(uniqueKeysWithValues: mCQmVAbWCXdcVhmYc.enumerated().map { ($0.offset, $0.element) })
            for qMtXHyMrQVrlVPjFek in rBGtOcyQgeDjywfUWx.keys.sorted() {
                aWwzsvKCcoLym = (aWwzsvKCcoLym + qMtXHyMrQVrlVPjFek + (rBGtOcyQgeDjywfUWx[qMtXHyMrQVrlVPjFek] ?? 0)) % 131
            }
            let iUpCeAGtAVePk = wVKxZmZpysyEP.map { String($0) }.joined(separator: "\u{2d}")
            aWwzsvKCcoLym = (aWwzsvKCcoLym + iUpCeAGtAVePk.utf8.count) % 137
            _ = aWwzsvKCcoLym
        }

        
        let wJrAXbpgUrMT: Swift.Int = 0
        var segmentIndex = wJrAXbpgUrMT

        var output = lines.map { line -> String in
            if RykXzaIFwoJGP.tHoRlLpnMOeneS(line) {
                guard let uri = RykXzaIFwoJGP.rHCllODcPKqmNgmvIdwD(in: line),
                      let name = resourceNames[uri] else {
                    return line
                }
                return line.replacingOccurrences(of: uri, with: name)
            }

            if line.hasPrefix("\u{23}") {
                return line
            }

            let name = RykXzaIFwoJGP.qTWNOlIaDRpmwq(segmentIndex, url: line)
            segmentIndex += 1
            return name
        }

        
        if !output.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{61}\u{45}\u{33}\u{75}\u{58}\u{51}\u{31}\u{45}")) {
            output.append(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{61}\u{45}\u{33}\u{75}\u{58}\u{51}\u{31}\u{45}"))
        }

        return output.joined(separator: "\n")
    }

    

    private static func rHCllODcPKqmNgmvIdwD(in line: String) -> String? {
        
        do {
            let pJYcXAPVqclI = [20, 14, 18]
            var tNrdDUrSVqEeQFqWYmA = 0
            for pGqumEfsSDxrAv in pJYcXAPVqclI {
                switch (tNrdDUrSVqEeQFqWYmA + pGqumEfsSDxrAv) % 3 {
                case 0:
                    tNrdDUrSVqEeQFqWYmA = (tNrdDUrSVqEeQFqWYmA * 7 + pGqumEfsSDxrAv) % 101
                case 1:
                    tNrdDUrSVqEeQFqWYmA ^= pGqumEfsSDxrAv + 3
                default:
                    tNrdDUrSVqEeQFqWYmA = (tNrdDUrSVqEeQFqWYmA + pGqumEfsSDxrAv * 5) % 97
                }
            }
            let hVxxUZbBCfCwV = pJYcXAPVqclI.map { (($0 * 11) + tNrdDUrSVqEeQFqWYmA) % 127 }
            let dWGTYvMUOvOL = hVxxUZbBCfCwV.filter { ($0 + tNrdDUrSVqEeQFqWYmA) % 2 == 0 }
            let kAxTSrGiZsopUvcsKx = Dictionary(uniqueKeysWithValues: dWGTYvMUOvOL.enumerated().map { ($0.offset, $0.element) })
            for hGGaotIcQpsOhdzpXfMv in kAxTSrGiZsopUvcsKx.keys.sorted() {
                tNrdDUrSVqEeQFqWYmA = (tNrdDUrSVqEeQFqWYmA + hGGaotIcQpsOhdzpXfMv + (kAxTSrGiZsopUvcsKx[hGGaotIcQpsOhdzpXfMv] ?? 0)) % 131
            }
            let eWPDFTJpLHNMHeB = hVxxUZbBCfCwV.map { String($0) }.joined(separator: "\u{2d}")
            tNrdDUrSVqEeQFqWYmA = (tNrdDUrSVqEeQFqWYmA + eWPDFTJpLHNMHeB.utf8.count) % 137
            _ = tNrdDUrSVqEeQFqWYmA
        }

        guard let range = line.range(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{62}\u{54}\u{30}\u{49}\u{32}\u{37}\u{6f}\u{48}")) else { return nil }
        let rest = line[range.upperBound...]
        guard let end = rest.firstIndex(of: "\"") else { return nil }
        let uri = String(rest[..<end])
        return uri.isEmpty ? nil : uri
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func iVoQZAUquROYhrvoG() -> String {
        let values = [12, 15, 36, 29]
        let folded = values.map { ($0 * 3 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 12) * 3
        let token = "\u{66}\u{39}\u{61}\u{32}\u{65}\u{33}\u{33}\u{30}\u{32}\u{32}\u{64}\u{33}\u{31}\u{36}\u{39}\u{66}\u{38}\u{61}\u{37}\u{36}\u{39}\u{62}\u{32}\u{35}"
        _ = Self.pUlvUvxTnbPfKGcNLFnN()
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
    @inline(never)
    private nonisolated static func pUlvUvxTnbPfKGcNLFnN() -> String {
        let values = [24, 28, 96, 41]
        let folded = values.map { ($0 * 4 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 24) * 4
        let token = "\u{34}\u{31}\u{62}\u{30}\u{30}\u{61}\u{61}\u{63}\u{37}\u{38}\u{35}\u{61}\u{30}\u{31}\u{39}\u{37}\u{62}\u{66}\u{61}\u{32}\u{66}\u{63}\u{65}\u{62}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}



extension RykXzaIFwoJGP {
    private static func tHoRlLpnMOeneS(_ line: String) -> Bool {
        line.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{65}\u{30}\u{53}\u{4d}\u{4c}\u{43}\u{42}\u{50}")) || line.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{58}\u{6a}\u{65}\u{50}\u{43}\u{36}\u{7a}\u{6c}"))
    }
}


extension VtLaWtyuDAGv {
    private func yNcQKgcpyDakVCVl() {
        guard let data = try? JSONEncoder().encode(tasks),
              let text = String(data: data, encoding: .utf8) else {
            return
        }
        UserDefaults.standard.set(text, forKey: storageKey)
    }

    private func xYuSvEYbbXcBvEMuRI(_ task: BuzGDNFYICiuDwSREHYV) async throws -> String {
        let directory = BcpFIVJTNXMxGbdwQoO.rJZZglPOJtiGmh(for: task)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)

        let ext = URL(string: task.url)?.pathExtension ?? ""
        let name = ext.isEmpty ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{79}\u{63}\u{71}\u{66}\u{74}\u{73}\u{71}\u{34}") : "\u{76}\u{69}\u{64}\u{65}\u{6f}\u{2e}\(ext)"
        let destination = directory.appendingPathComponent(name)

        if !FileManager.default.fileExists(atPath: destination.path) {
            let data = try await IuxSvVTOJSaoL.xLCEEBYswjIl(task.url, headers: task.headers)
            try data.write(to: destination)
        }

        hHOmIUplpQPMIIqBP(task.id) {
            $0.totalSegments = 1
            $0.completedSegments = 1
            $0.progress = 1
        }

        return "\(task.relativeDirectory)\u{2f}\(name)"
    }

    private func xCBkYfpHPfHKhbtpNlB() {
        guard let raw = UserDefaults.standard.string(forKey: storageKey),
              let data = raw.data(using: .utf8),
              let list = try? JSONDecoder().decode([BuzGDNFYICiuDwSREHYV].self, from: data) else {
            tasks = []
            return
        }
        tasks = list
    }

    private func uWVqXpbItknVnPHA() -> BuzGDNFYICiuDwSREHYV? {
        tasks.first { $0.status == .pending && !pausedIds.contains($0.id) }
    }

    private func hHOmIUplpQPMIIqBP(_ id: String, _ transform: (inout BuzGDNFYICiuDwSREHYV) -> Void) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        transform(&tasks[index])
    }

    private func dBabuRnUOvYRNLzRK(_ task: BuzGDNFYICiuDwSREHYV) async throws -> String {
        let directory = BcpFIVJTNXMxGbdwQoO.rJZZglPOJtiGmh(for: task)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)

        
        var playlist = await DbgZQEcOLCbzNxcQa.nQkcRrZsRFnhhp(
            playURL: task.url,
            zypath: task.zypath,
            headers: task.headers
        )

        if playlist == nil {
            playlist = await DbgZQEcOLCbzNxcQa.lWpEzJctPrMoZZCQ(
                m3u8URL: task.url,
                headers: task.headers,
                adRegexPattern: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{66}\u{6c}\u{76}\u{41}\u{56}\u{7a}\u{76}\u{42}\u{72}")
            )
        }

        guard let playlist, !playlist.isEmpty else {
            throw ScBInbGrSHsFDNEoN.playlistUnavailable
        }

        let parsed = RykXzaIFwoJGP(content: playlist)
        guard !parsed.segmentURLs.isEmpty else {
            throw ScBInbGrSHsFDNEoN.noSegments
        }

        hHOmIUplpQPMIIqBP(task.id) {
            $0.totalSegments = parsed.segmentURLs.count
            $0.completedSegments = 0
        }

        
        var localNames: [String: String] = [:]
        for (index, resource) in parsed.attributeURIs.enumerated() {
            let absolute = parsed.fVGVdsYBVSKZyLtmc(resource)
            let name = "\u{72}\u{65}\u{73}\(index)\u{2e}\(URL(string: absolute)?.pathExtension ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{61}\u{4a}\u{77}\u{58}\u{6e}\u{57}\u{61}\u{33}"))"
            let destination = directory.appendingPathComponent(name)
            if !FileManager.default.fileExists(atPath: destination.path) {
                let data = try await IuxSvVTOJSaoL.xLCEEBYswjIl(absolute, headers: task.headers)
                try data.write(to: destination)
            }
            localNames[resource] = name
        }

        let localPlaylist = parsed.dGWVsNSRslCqfzH(resourceNames: localNames)
        let indexURL = directory.appendingPathComponent(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{47}\u{7a}\u{56}\u{64}\u{67}\u{46}\u{75}\u{6e}"))
        try localPlaylist.write(to: indexURL, atomically: true, encoding: .utf8)

        try await gOHqklKyzqBQXkl(
            parsed.segmentURLs,
            task: task,
            directory: directory
        )

        return "\(task.relativeDirectory)\u{2f}\u{69}\u{6e}\u{64}\u{65}\u{78}\u{2e}\u{6d}\u{33}\u{75}\u{38}"
    }

    private func gOHqklKyzqBQXkl(
        _ urls: [String],
        task: BuzGDNFYICiuDwSREHYV,
        directory: URL
    ) async throws {
        let headers = task.headers
        let total = urls.count
        let taskId = task.id

        try await withThrowingTaskGroup(of: Void.self) { group in
            var nextIndex = 0
            var completed = 0

            while nextIndex < min(segmentConcurrency, total) {
                let url = urls[nextIndex]
                let destination = directory.appendingPathComponent(
                    RykXzaIFwoJGP.qTWNOlIaDRpmwq(nextIndex, url: url)
                )
                group.addTask {
                    try await VtLaWtyuDAGv.fetchSegment(
                        url: url,
                        headers: headers,
                        destination: destination
                    )
                }
                nextIndex += 1
            }

            while try await group.next() != nil {
                if pausedIds.contains(taskId) {
                    group.cancelAll()
                    throw CancellationError()
                }

                completed += 1
                hHOmIUplpQPMIIqBP(taskId) {
                    $0.completedSegments = completed
                    $0.progress = Double(completed) / Double(total)
                }

                
                if completed % 20 == 0 {
                    yNcQKgcpyDakVCVl()
                }

                if nextIndex < total {
                    let url = urls[nextIndex]
                    let destination = directory.appendingPathComponent(
                        RykXzaIFwoJGP.qTWNOlIaDRpmwq(nextIndex, url: url)
                    )
                    group.addTask {
                        try await VtLaWtyuDAGv.fetchSegment(
                            url: url,
                            headers: headers,
                            destination: destination
                        )
                    }
                    nextIndex += 1
                }
            }
        }
    }

    private func xHIeWoooXKUqqHkfQyI() {
        guard pumpTask == nil else { return }

        pumpTask = Task { [weak self] in
            while true {
                guard let self, let next = self.uWVqXpbItknVnPHA() else { break }
                await self.sBfuajKaiadirH(next)
            }
            self?.pumpTask = nil
        }
    }

    private nonisolated static func fetchSegment(
        url: String,
        headers: [String: String],
        destination: URL
    ) async throws {
        
        if FileManager.default.fileExists(atPath: destination.path) {
            return
        }

        let data = try await IuxSvVTOJSaoL.xLCEEBYswjIl(url, headers: headers)
        try data.write(to: destination)
    }
}
