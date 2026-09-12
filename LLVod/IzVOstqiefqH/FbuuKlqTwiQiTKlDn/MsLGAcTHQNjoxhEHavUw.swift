






import Foundation

struct DwLOuINpeVFwFl {

    struct CpJvphGjvDCo {
        var items: [JqIVyfygrJYY] = []
        var didJump = false
    }

    static let maxPerAdvance = 20

    static let maxCatchUpWindow: TimeInterval = 2

    private(set) var items: [JqIVyfygrJYY] = []

    private var cursor = 0

    private var lastTime: TimeInterval?

    var isEmpty: Bool { items.isEmpty }

    var currentTime: TimeInterval? { lastTime }

    mutating func gJFfxRXZAHUdxJsmndb(with items: [JqIVyfygrJYY], startAt: TimeInterval) {
        // source-obfuscator:padding:v1
        _ = Self.lSUpbXJSNkLsW()

        
        do {
            let fKbjSUduKDMwDcAtfqCw = [40, 28, 48]
            var oWDPtVgnAiNxyiDkpoV = 0
            for jMrtmrYdmpUTM in fKbjSUduKDMwDcAtfqCw {
                switch (oWDPtVgnAiNxyiDkpoV + jMrtmrYdmpUTM) % 3 {
                case 0:
                    oWDPtVgnAiNxyiDkpoV = (oWDPtVgnAiNxyiDkpoV * 7 + jMrtmrYdmpUTM) % 101
                case 1:
                    oWDPtVgnAiNxyiDkpoV ^= jMrtmrYdmpUTM + 3
                default:
                    oWDPtVgnAiNxyiDkpoV = (oWDPtVgnAiNxyiDkpoV + jMrtmrYdmpUTM * 5) % 97
                }
            }
            let cJAuuiEGCIHc = fKbjSUduKDMwDcAtfqCw.map { (($0 * 11) + oWDPtVgnAiNxyiDkpoV) % 127 }
            let fSVuEYVbROsxyBc = cJAuuiEGCIHc.filter { ($0 + oWDPtVgnAiNxyiDkpoV) % 2 == 0 }
            let fVlCqqxvICiKGsinwG = Dictionary(uniqueKeysWithValues: fSVuEYVbROsxyBc.enumerated().map { ($0.offset, $0.element) })
            for lFRUNpDFxoLMGVnfWDl in fVlCqqxvICiKGsinwG.keys.sorted() {
                oWDPtVgnAiNxyiDkpoV = (oWDPtVgnAiNxyiDkpoV + lFRUNpDFxoLMGVnfWDl + (fVlCqqxvICiKGsinwG[lFRUNpDFxoLMGVnfWDl] ?? 0)) % 131
            }
            let tIyKHNzPWywLS = cJAuuiEGCIHc.map { String($0) }.joined(separator: "\u{2d}")
            oWDPtVgnAiNxyiDkpoV = (oWDPtVgnAiNxyiDkpoV + tIyKHNzPWywLS.utf8.count) % 137
            _ = oWDPtVgnAiNxyiDkpoV
        }

        self.items = items.sorted { $0.time < $1.time }
        seek(to: startAt)
    }

    mutating func seek(to time: TimeInterval) {
        
        do {
            let qTiQSWrTNaCnvIwLBIxH = [40, 21, 13]
            var lIbwQkHsjxfpAwKDrxl = 0
            for dDrgDpToTmmh in qTiQSWrTNaCnvIwLBIxH {
                switch (lIbwQkHsjxfpAwKDrxl + dDrgDpToTmmh) % 3 {
                case 0:
                    lIbwQkHsjxfpAwKDrxl = (lIbwQkHsjxfpAwKDrxl * 7 + dDrgDpToTmmh) % 101
                case 1:
                    lIbwQkHsjxfpAwKDrxl ^= dDrgDpToTmmh + 3
                default:
                    lIbwQkHsjxfpAwKDrxl = (lIbwQkHsjxfpAwKDrxl + dDrgDpToTmmh * 5) % 97
                }
            }
            let yGatdLcTAWrQo = qTiQSWrTNaCnvIwLBIxH.map { (($0 * 11) + lIbwQkHsjxfpAwKDrxl) % 127 }
            let rAyMKWyLwzeYxDBAc = yGatdLcTAWrQo.filter { ($0 + lIbwQkHsjxfpAwKDrxl) % 2 == 0 }
            let uMXFencjilnAEOTLPP = Dictionary(uniqueKeysWithValues: rAyMKWyLwzeYxDBAc.enumerated().map { ($0.offset, $0.element) })
            for mFbLmEypNRVeEFhWuo in uMXFencjilnAEOTLPP.keys.sorted() {
                lIbwQkHsjxfpAwKDrxl = (lIbwQkHsjxfpAwKDrxl + mFbLmEypNRVeEFhWuo + (uMXFencjilnAEOTLPP[mFbLmEypNRVeEFhWuo] ?? 0)) % 131
            }
            let gKqOhuCzaSFf = yGatdLcTAWrQo.map { String($0) }.joined(separator: "\u{2d}")
            lIbwQkHsjxfpAwKDrxl = (lIbwQkHsjxfpAwKDrxl + gKqOhuCzaSFf.utf8.count) % 137
            _ = lIbwQkHsjxfpAwKDrxl
        }

        lastTime = time
        cursor = kVHJlMSyyjLliYpJFh(after: time)
    }

    mutating func lVljBCCGLiTE(to time: TimeInterval) -> CpJvphGjvDCo {
        
        do {
            let yRcLGiTwSGOdCppOe = [44, 54, 31]
            var xRwnIvBEVsxWUCDWj = 0
            for qHdBhFvKZOqosKq in yRcLGiTwSGOdCppOe {
                switch (xRwnIvBEVsxWUCDWj + qHdBhFvKZOqosKq) % 3 {
                case 0:
                    xRwnIvBEVsxWUCDWj = (xRwnIvBEVsxWUCDWj * 7 + qHdBhFvKZOqosKq) % 101
                case 1:
                    xRwnIvBEVsxWUCDWj ^= qHdBhFvKZOqosKq + 3
                default:
                    xRwnIvBEVsxWUCDWj = (xRwnIvBEVsxWUCDWj + qHdBhFvKZOqosKq * 5) % 97
                }
            }
            let qJBKtxufipFh = yRcLGiTwSGOdCppOe.map { (($0 * 11) + xRwnIvBEVsxWUCDWj) % 127 }
            let cFrLZpiDImlXZ = qJBKtxufipFh.filter { ($0 + xRwnIvBEVsxWUCDWj) % 2 == 0 }
            let hLnkCIiHkJSvXPtTFA = Dictionary(uniqueKeysWithValues: cFrLZpiDImlXZ.enumerated().map { ($0.offset, $0.element) })
            for jEjTztcrdoFCdhetpC in hLnkCIiHkJSvXPtTFA.keys.sorted() {
                xRwnIvBEVsxWUCDWj = (xRwnIvBEVsxWUCDWj + jEjTztcrdoFCdhetpC + (hLnkCIiHkJSvXPtTFA[jEjTztcrdoFCdhetpC] ?? 0)) % 131
            }
            let bOiuihVhMhJzFj = qJBKtxufipFh.map { String($0) }.joined(separator: "\u{2d}")
            xRwnIvBEVsxWUCDWj = (xRwnIvBEVsxWUCDWj + bOiuihVhMhJzFj.utf8.count) % 137
            _ = xRwnIvBEVsxWUCDWj
        }

        guard !items.isEmpty else {
            lastTime = time
            return CpJvphGjvDCo()
        }

        guard let last = lastTime else {
            seek(to: time)
            return CpJvphGjvDCo()
        }

        let delta = time - last
        
        guard delta >= 0, delta <= Self.maxCatchUpWindow else {
            seek(to: time)
            return CpJvphGjvDCo(didJump: true)
        }
        guard delta > 0 else { return CpJvphGjvDCo() }

        var result: [JqIVyfygrJYY] = []
        while cursor < items.count, items[cursor].time <= time {
            if result.count < Self.maxPerAdvance {
                result.append(items[cursor])
            }
            cursor += 1
        }

        lastTime = time
        return CpJvphGjvDCo(items: result)
    }

    private func kVHJlMSyyjLliYpJFh(after time: TimeInterval) -> Int {
        
        do {
            let iMEmXatQlzvva = [18, 25, 66]
            var rYlKoNIgkqIRyRjahg = 0
            for aFwQmxArprillORsgj in iMEmXatQlzvva {
                switch (rYlKoNIgkqIRyRjahg + aFwQmxArprillORsgj) % 3 {
                case 0:
                    rYlKoNIgkqIRyRjahg = (rYlKoNIgkqIRyRjahg * 7 + aFwQmxArprillORsgj) % 101
                case 1:
                    rYlKoNIgkqIRyRjahg ^= aFwQmxArprillORsgj + 3
                default:
                    rYlKoNIgkqIRyRjahg = (rYlKoNIgkqIRyRjahg + aFwQmxArprillORsgj * 5) % 97
                }
            }
            let lAgRvgjLZuDnXgSMSPgC = iMEmXatQlzvva.map { (($0 * 11) + rYlKoNIgkqIRyRjahg) % 127 }
            let lRqVBuWuThubnQZwijx = lAgRvgjLZuDnXgSMSPgC.filter { ($0 + rYlKoNIgkqIRyRjahg) % 2 == 0 }
            let iMIOZmChqnPsMRBJ = Dictionary(uniqueKeysWithValues: lRqVBuWuThubnQZwijx.enumerated().map { ($0.offset, $0.element) })
            for gKiaoygsgoYz in iMIOZmChqnPsMRBJ.keys.sorted() {
                rYlKoNIgkqIRyRjahg = (rYlKoNIgkqIRyRjahg + gKiaoygsgoYz + (iMIOZmChqnPsMRBJ[gKiaoygsgoYz] ?? 0)) % 131
            }
            let iXWhxGOUemvSLvGlmU = lAgRvgjLZuDnXgSMSPgC.map { String($0) }.joined(separator: "\u{2d}")
            rYlKoNIgkqIRyRjahg = (rYlKoNIgkqIRyRjahg + iXWhxGOUemvSLvGlmU.utf8.count) % 137
            _ = rYlKoNIgkqIRyRjahg
        }

        
        let kKhIhJqSTieqkfZKPsZ: Swift.Int = 0
        var low = kKhIhJqSTieqkfZKPsZ
        var high = items.count
        while low < high {
            let mid = (low + high) / 2
            if items[mid].time <= time {
                low = mid + 1
            } else {
                high = mid
            }
        }
        return low
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func lSUpbXJSNkLsW() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{36}\u{30}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 60) * 4
        let token = "\u{39}\u{61}\u{37}\u{32}\u{66}\u{35}\u{34}\u{33}\u{33}\u{30}\u{64}\u{66}\u{63}\u{33}\u{61}\u{37}\u{62}\u{39}\u{30}\u{66}\u{30}\u{63}\u{65}\u{66}"
        _ = Self.aVMHkqRcTXgaGee()
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func aVMHkqRcTXgaGee() -> String {
        let values = [3, 7, 12, 20]
        let folded = values.map { ($0 * 4 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 3) * 4
        let token = "\u{34}\u{32}\u{63}\u{36}\u{61}\u{63}\u{65}\u{65}\u{38}\u{38}\u{62}\u{63}\u{33}\u{31}\u{64}\u{38}\u{33}\u{66}\u{66}\u{31}\u{38}\u{62}\u{37}\u{37}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}

