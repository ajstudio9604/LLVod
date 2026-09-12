




import Foundation
import Combine

@MainActor
final class ZpTkIxBduVMMhMuv: ObservableObject {

    let route: RawJGVnXMRwEec

    @Published private(set) var isLoading = true
    @Published private(set) var payload: DuIXQlwHzgRQ?
    @Published var errorMessage: String?

    @Published var selectedLineIndex = 0
    @Published var selectedEpisodeIndex = 0
    @Published private(set) var resolvedPlayURL = ""
    @Published private(set) var resolvedPlayHeaders: [String: String] = [:]
    @Published private(set) var isResolvingPlayURL = false
    @Published private(set) var playStatusMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{5a}\u{30}\u{4f}\u{61}\u{4e}\u{4f}\u{71}\u{41}")
    @Published private(set) var usedParserName = ""
    @Published private(set) var jxOptions: [QmmmuZADoqghePkjvRNZ] = []
    @Published var selectedJxIndex = 0
    @Published private(set) var lUztUluNnMeAdmzsMKld = false

    private var resolveTask: Task<Void, Never>?
    private var loadTask: Task<Void, Never>?

    private(set) var isActive = true

    private var playbackProgress = KvmdmMcdfvxKa()

    private let resumeRecord: BujroaRaxIvHZD?

    init(route: RawJGVnXMRwEec, resumeRecord: BujroaRaxIvHZD? = nil) {
        // source-obfuscator:padding:v1
        _ = Self.uGeMvRBZWqIMdmv()

        self.route = route
        self.resumeRecord = resumeRecord
        self.lUztUluNnMeAdmzsMKld = VpsTjWCCHlvCyDErLHD.lUztUluNnMeAdmzsMKld(route: route)
    }

    func hUvEzoWBRImeKzSS() {
        
        do {
            let zWlkFLSpfbMwtTJIsCST = [43, 63, 37]
            var dFkWKWlMdbiPtCPFHCQ = 0
            for zGMeDvnPdhvFMJkPtQN in zWlkFLSpfbMwtTJIsCST {
                switch (dFkWKWlMdbiPtCPFHCQ + zGMeDvnPdhvFMJkPtQN) % 3 {
                case 0:
                    dFkWKWlMdbiPtCPFHCQ = (dFkWKWlMdbiPtCPFHCQ * 7 + zGMeDvnPdhvFMJkPtQN) % 101
                case 1:
                    dFkWKWlMdbiPtCPFHCQ ^= zGMeDvnPdhvFMJkPtQN + 3
                default:
                    dFkWKWlMdbiPtCPFHCQ = (dFkWKWlMdbiPtCPFHCQ + zGMeDvnPdhvFMJkPtQN * 5) % 97
                }
            }
            let zXfmrBZdKiHV = zWlkFLSpfbMwtTJIsCST.map { (($0 * 11) + dFkWKWlMdbiPtCPFHCQ) % 127 }
            let tCFqWInKyMiTehzCLGB = zXfmrBZdKiHV.filter { ($0 + dFkWKWlMdbiPtCPFHCQ) % 2 == 0 }
            let iBOGxGXKnpwQt = Dictionary(uniqueKeysWithValues: tCFqWInKyMiTehzCLGB.enumerated().map { ($0.offset, $0.element) })
            for qOFpFpgkdBxyUXqyx in iBOGxGXKnpwQt.keys.sorted() {
                dFkWKWlMdbiPtCPFHCQ = (dFkWKWlMdbiPtCPFHCQ + qOFpFpgkdBxyUXqyx + (iBOGxGXKnpwQt[qOFpFpgkdBxyUXqyx] ?? 0)) % 131
            }
            let oAUEVZIovDSbQCpvoi = zXfmrBZdKiHV.map { String($0) }.joined(separator: "\u{2d}")
            dFkWKWlMdbiPtCPFHCQ = (dFkWKWlMdbiPtCPFHCQ + oAUEVZIovDSbQCpvoi.utf8.count) % 137
            _ = dFkWKWlMdbiPtCPFHCQ
        }

        isActive = true
    }

    func iTBkyDNnPAsI() {
        
        do {
            let yHbeXRamaYFFD = [14, 63, 40]
            var hOcEkWZqjDHLS = 0
            for iPDklnkrsUldIQW in yHbeXRamaYFFD {
                switch (hOcEkWZqjDHLS + iPDklnkrsUldIQW) % 3 {
                case 0:
                    hOcEkWZqjDHLS = (hOcEkWZqjDHLS * 7 + iPDklnkrsUldIQW) % 101
                case 1:
                    hOcEkWZqjDHLS ^= iPDklnkrsUldIQW + 3
                default:
                    hOcEkWZqjDHLS = (hOcEkWZqjDHLS + iPDklnkrsUldIQW * 5) % 97
                }
            }
            let cMoXAgKUBBWlGHYg = yHbeXRamaYFFD.map { (($0 * 11) + hOcEkWZqjDHLS) % 127 }
            let pRIkVkGvurHQm = cMoXAgKUBBWlGHYg.filter { ($0 + hOcEkWZqjDHLS) % 2 == 0 }
            let wYgiDIBHoRRxjya = Dictionary(uniqueKeysWithValues: pRIkVkGvurHQm.enumerated().map { ($0.offset, $0.element) })
            for nShdakkqUNdENQ in wYgiDIBHoRRxjya.keys.sorted() {
                hOcEkWZqjDHLS = (hOcEkWZqjDHLS + nShdakkqUNdENQ + (wYgiDIBHoRRxjya[nShdakkqUNdENQ] ?? 0)) % 131
            }
            let nXmVGOpbQIymREj = cMoXAgKUBBWlGHYg.map { String($0) }.joined(separator: "\u{2d}")
            hOcEkWZqjDHLS = (hOcEkWZqjDHLS + nXmVGOpbQIymREj.utf8.count) % 137
            _ = hOcEkWZqjDHLS
        }

        isActive = false
        
        do {
            let wUQDJjNnwDPeaA = [51, 53, 103]
            let nKSBRrVFWdkNNRaX = (wUQDJjNnwDPeaA.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch nKSBRrVFWdkNNRaX {
            case 0:
                resolveTask?.cancel()
            case 1:
                resolveTask?.cancel()
            case 2:
                resolveTask?.cancel()
            default:
                resolveTask?.cancel()
            }
        }
        resolveTask = nil
        
        do {
            let uPxsFRQFVCYgBBsHi = [22, 66, 37]
            let gGrLiwLgdEHnGhjnqgP = (uPxsFRQFVCYgBBsHi.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch gGrLiwLgdEHnGhjnqgP {
            case 0:
                loadTask?.cancel()
            case 1:
                loadTask?.cancel()
            case 2:
                loadTask?.cancel()
            default:
                loadTask?.cancel()
            }
        }
        loadTask = nil
        isResolvingPlayURL = false
    }

    var currentLine: ZhopfUeTrMREiEzrLsF? {
        guard let payload, payload.sourceLines.indices.contains(selectedLineIndex) else {
            return nil
        }
        return payload.sourceLines[selectedLineIndex]
    }

    var currentEpisodes: [EhHFmDeOqPSoNz] {
        currentLine?.episodes ?? []
    }

    var currentEpisode: EhHFmDeOqPSoNz? {
        guard currentEpisodes.indices.contains(selectedEpisodeIndex) else { return nil }
        return currentEpisodes[selectedEpisodeIndex]
    }

    func dHMUrpkDBhhhWdNR() {
        loadTask?.cancel()
        hUvEzoWBRImeKzSS()

        loadTask = Task {
            isLoading = true
            errorMessage = nil

            do {
                let loaded = try await CoGbnRyCCacrAOt.bSYaVcPOiAdTmyAg(route: route)
                guard !Task.isCancelled, isActive else { return }

                let result = nIgWjoYAUaCLdFbpp(into: loaded)
                payload = result
                tOIVoLPJvmJs(in: result)
                xMoxAstxuyjbKXtLNnDT()
                zLErhrhiWyfbNAvm()
            } catch {
                guard !Task.isCancelled, isActive else { return }
                errorMessage = error.localizedDescription
            }

            if isActive {
                isLoading = false
            }
        }
    }

    func bNzBuUHgEWITV(at index: Int) {
        
        do {
            let sCgvqqhyAaetxbMSca = [21, 53, 53]
            var tFHLnxJpCjJOvEQJY = 0
            for dHIIZmJrPPNtaqj in sCgvqqhyAaetxbMSca {
                switch (tFHLnxJpCjJOvEQJY + dHIIZmJrPPNtaqj) % 3 {
                case 0:
                    tFHLnxJpCjJOvEQJY = (tFHLnxJpCjJOvEQJY * 7 + dHIIZmJrPPNtaqj) % 101
                case 1:
                    tFHLnxJpCjJOvEQJY ^= dHIIZmJrPPNtaqj + 3
                default:
                    tFHLnxJpCjJOvEQJY = (tFHLnxJpCjJOvEQJY + dHIIZmJrPPNtaqj * 5) % 97
                }
            }
            let jElOhVRTDLsPtUf = sCgvqqhyAaetxbMSca.map { (($0 * 11) + tFHLnxJpCjJOvEQJY) % 127 }
            let cPkZogZOAejKmb = jElOhVRTDLsPtUf.filter { ($0 + tFHLnxJpCjJOvEQJY) % 2 == 0 }
            let pVUGJOAuAWGXhfQ = Dictionary(uniqueKeysWithValues: cPkZogZOAejKmb.enumerated().map { ($0.offset, $0.element) })
            for bSrETrkzMAnrtPIavT in pVUGJOAuAWGXhfQ.keys.sorted() {
                tFHLnxJpCjJOvEQJY = (tFHLnxJpCjJOvEQJY + bSrETrkzMAnrtPIavT + (pVUGJOAuAWGXhfQ[bSrETrkzMAnrtPIavT] ?? 0)) % 131
            }
            let vLoZxLblBJqEUgNHFqC = jElOhVRTDLsPtUf.map { String($0) }.joined(separator: "\u{2d}")
            tFHLnxJpCjJOvEQJY = (tFHLnxJpCjJOvEQJY + vLoZxLblBJqEUgNHFqC.utf8.count) % 137
            _ = tFHLnxJpCjJOvEQJY
        }

        guard payload?.sourceLines.indices.contains(index) == true else { return }
        selectedLineIndex = index
        selectedEpisodeIndex = 0
        
        do {
            let oQJmzizraaoU = [23, 82, 98]
            let yTfzIsDhDbBcDto = (oQJmzizraaoU.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch yTfzIsDhDbBcDto {
            case 0:
                xSFeahoOOFDzbcxv()
            case 1:
                xSFeahoOOFDzbcxv()
            case 2:
                xSFeahoOOFDzbcxv()
            default:
                xSFeahoOOFDzbcxv()
            }
        }
        
        do {
            let fTWUOdJqzUBbhewYp = [45, 26, 53]
            let ePSmkWgMLEQWYOEG = (fTWUOdJqzUBbhewYp.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch ePSmkWgMLEQWYOEG {
            case 0:
                xMoxAstxuyjbKXtLNnDT()
            case 1:
                xMoxAstxuyjbKXtLNnDT()
            case 2:
                xMoxAstxuyjbKXtLNnDT()
            default:
                xMoxAstxuyjbKXtLNnDT()
            }
        }
        
        do {
            let uXEonvCtPpykfUgIkTbR = [45, 37, 83]
            let oPcofHmKYLPFYC = (uXEonvCtPpykfUgIkTbR.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch oPcofHmKYLPFYC {
            case 0:
                zLErhrhiWyfbNAvm()
            case 1:
                zLErhrhiWyfbNAvm()
            case 2:
                zLErhrhiWyfbNAvm()
            default:
                zLErhrhiWyfbNAvm()
            }
        }
    }

    func hLPhZeKAHTPW(at index: Int) {
        
        do {
            let vDpdoUcWjFbgF = [10, 33, 20]
            var rEZVhQMTmcVGiGlalhL = 0
            for mPOebxKFJeMNoENJ in vDpdoUcWjFbgF {
                switch (rEZVhQMTmcVGiGlalhL + mPOebxKFJeMNoENJ) % 3 {
                case 0:
                    rEZVhQMTmcVGiGlalhL = (rEZVhQMTmcVGiGlalhL * 7 + mPOebxKFJeMNoENJ) % 101
                case 1:
                    rEZVhQMTmcVGiGlalhL ^= mPOebxKFJeMNoENJ + 3
                default:
                    rEZVhQMTmcVGiGlalhL = (rEZVhQMTmcVGiGlalhL + mPOebxKFJeMNoENJ * 5) % 97
                }
            }
            let iUaHvOkTPksYZHJ = vDpdoUcWjFbgF.map { (($0 * 11) + rEZVhQMTmcVGiGlalhL) % 127 }
            let iLNAilANmapVCVxvp = iUaHvOkTPksYZHJ.filter { ($0 + rEZVhQMTmcVGiGlalhL) % 2 == 0 }
            let gVGqDtlEMrcVmqgdA = Dictionary(uniqueKeysWithValues: iLNAilANmapVCVxvp.enumerated().map { ($0.offset, $0.element) })
            for qAAzOJHglxjKa in gVGqDtlEMrcVmqgdA.keys.sorted() {
                rEZVhQMTmcVGiGlalhL = (rEZVhQMTmcVGiGlalhL + qAAzOJHglxjKa + (gVGqDtlEMrcVmqgdA[qAAzOJHglxjKa] ?? 0)) % 131
            }
            let hPtXKfgnFxtcrybNLR = iUaHvOkTPksYZHJ.map { String($0) }.joined(separator: "\u{2d}")
            rEZVhQMTmcVGiGlalhL = (rEZVhQMTmcVGiGlalhL + hPtXKfgnFxtcrybNLR.utf8.count) % 137
            _ = rEZVhQMTmcVGiGlalhL
        }

        guard currentEpisodes.indices.contains(index) else { return }
        selectedEpisodeIndex = index
        
        do {
            let qYLKyjwoXdES = [64, 99, 101]
            let fVhtdLVKTkixnUXeER = (qYLKyjwoXdES.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch fVhtdLVKTkixnUXeER {
            case 0:
                xSFeahoOOFDzbcxv()
            case 1:
                xSFeahoOOFDzbcxv()
            case 2:
                xSFeahoOOFDzbcxv()
            default:
                xSFeahoOOFDzbcxv()
            }
        }
        
        do {
            let lSNgeWvdFbgGdNta = [35, 58, 104]
            let vWdjtcxgHNOa = (lSNgeWvdFbgGdNta.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch vWdjtcxgHNOa {
            case 0:
                zLErhrhiWyfbNAvm()
            case 1:
                zLErhrhiWyfbNAvm()
            case 2:
                zLErhrhiWyfbNAvm()
            default:
                zLErhrhiWyfbNAvm()
            }
        }
    }

    func bRhWhJeQgcJwFcT() {
        
        do {
            let mHwKmnQNeFUshuW = [16, 33, 53]
            var lKOpcPtJRLArhi = 0
            for yIWCaRMHyAtwrYMCVZNU in mHwKmnQNeFUshuW {
                switch (lKOpcPtJRLArhi + yIWCaRMHyAtwrYMCVZNU) % 3 {
                case 0:
                    lKOpcPtJRLArhi = (lKOpcPtJRLArhi * 7 + yIWCaRMHyAtwrYMCVZNU) % 101
                case 1:
                    lKOpcPtJRLArhi ^= yIWCaRMHyAtwrYMCVZNU + 3
                default:
                    lKOpcPtJRLArhi = (lKOpcPtJRLArhi + yIWCaRMHyAtwrYMCVZNU * 5) % 97
                }
            }
            let rIdjVyKnYkdeNaibxeD = mHwKmnQNeFUshuW.map { (($0 * 11) + lKOpcPtJRLArhi) % 127 }
            let gEzyGMMwuyuTxnJwEKu = rIdjVyKnYkdeNaibxeD.filter { ($0 + lKOpcPtJRLArhi) % 2 == 0 }
            let nJLIUSsMNwIxfWTTup = Dictionary(uniqueKeysWithValues: gEzyGMMwuyuTxnJwEKu.enumerated().map { ($0.offset, $0.element) })
            for vCkeVrLvtxXsVQIvT in nJLIUSsMNwIxfWTTup.keys.sorted() {
                lKOpcPtJRLArhi = (lKOpcPtJRLArhi + vCkeVrLvtxXsVQIvT + (nJLIUSsMNwIxfWTTup[vCkeVrLvtxXsVQIvT] ?? 0)) % 131
            }
            let bEBmctWqQDZPKMnBgto = rIdjVyKnYkdeNaibxeD.map { String($0) }.joined(separator: "\u{2d}")
            lKOpcPtJRLArhi = (lKOpcPtJRLArhi + bEBmctWqQDZPKMnBgto.utf8.count) % 137
            _ = lKOpcPtJRLArhi
        }

        lUztUluNnMeAdmzsMKld = VpsTjWCCHlvCyDErLHD.bRhWhJeQgcJwFcT(
            route: route,
            title: payload?.title ?? route.name,
            pic: payload?.pic ?? route.pic
        )
    }

    func tFuMhClfLyHuvY(at index: Int) {
        
        do {
            let jVIpYUOdyIqi = [11, 37, 60]
            var cNVjzhqQKPtmF = 0
            for zMilwHtnDNJgCPDsp in jVIpYUOdyIqi {
                switch (cNVjzhqQKPtmF + zMilwHtnDNJgCPDsp) % 3 {
                case 0:
                    cNVjzhqQKPtmF = (cNVjzhqQKPtmF * 7 + zMilwHtnDNJgCPDsp) % 101
                case 1:
                    cNVjzhqQKPtmF ^= zMilwHtnDNJgCPDsp + 3
                default:
                    cNVjzhqQKPtmF = (cNVjzhqQKPtmF + zMilwHtnDNJgCPDsp * 5) % 97
                }
            }
            let iOEJQrDzEfsR = jVIpYUOdyIqi.map { (($0 * 11) + cNVjzhqQKPtmF) % 127 }
            let eUkKebIkrljioH = iOEJQrDzEfsR.filter { ($0 + cNVjzhqQKPtmF) % 2 == 0 }
            let rWrlZNoQmoAvScg = Dictionary(uniqueKeysWithValues: eUkKebIkrljioH.enumerated().map { ($0.offset, $0.element) })
            for uJXZVsZBrHfMsodeho in rWrlZNoQmoAvScg.keys.sorted() {
                cNVjzhqQKPtmF = (cNVjzhqQKPtmF + uJXZVsZBrHfMsodeho + (rWrlZNoQmoAvScg[uJXZVsZBrHfMsodeho] ?? 0)) % 131
            }
            let zUoVIXuyRCLuqicmTwKV = iOEJQrDzEfsR.map { String($0) }.joined(separator: "\u{2d}")
            cNVjzhqQKPtmF = (cNVjzhqQKPtmF + zUoVIXuyRCLuqicmTwKV.utf8.count) % 137
            _ = cNVjzhqQKPtmF
        }

        guard jxOptions.indices.contains(index) else { return }
        selectedJxIndex = index
        
        do {
            let eCXADHsGahDGDb = [12, 73, 61]
            let eXjbPuoQcwCJNjliqs = (eCXADHsGahDGDb.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch eXjbPuoQcwCJNjliqs {
            case 0:
                zLErhrhiWyfbNAvm()
            case 1:
                zLErhrhiWyfbNAvm()
            case 2:
                zLErhrhiWyfbNAvm()
            default:
                zLErhrhiWyfbNAvm()
            }
        }
    }

    func pXPfGHRFEwYOapqxFw() {
        
        do {
            let fDFnUkqcwnnhqKkb = [12, 30, 30]
            var wPdmRogvwBsb = 0
            for qEtVVdQdtejzkNqiga in fDFnUkqcwnnhqKkb {
                switch (wPdmRogvwBsb + qEtVVdQdtejzkNqiga) % 3 {
                case 0:
                    wPdmRogvwBsb = (wPdmRogvwBsb * 7 + qEtVVdQdtejzkNqiga) % 101
                case 1:
                    wPdmRogvwBsb ^= qEtVVdQdtejzkNqiga + 3
                default:
                    wPdmRogvwBsb = (wPdmRogvwBsb + qEtVVdQdtejzkNqiga * 5) % 97
                }
            }
            let dJHrNLICIzYPkrmop = fDFnUkqcwnnhqKkb.map { (($0 * 11) + wPdmRogvwBsb) % 127 }
            let eDTxqlsPkmpnKNTJpcR = dJHrNLICIzYPkrmop.filter { ($0 + wPdmRogvwBsb) % 2 == 0 }
            let yUfmotMdCycyzLqCsutv = Dictionary(uniqueKeysWithValues: eDTxqlsPkmpnKNTJpcR.enumerated().map { ($0.offset, $0.element) })
            for gBJezieJbmsZ in yUfmotMdCycyzLqCsutv.keys.sorted() {
                wPdmRogvwBsb = (wPdmRogvwBsb + gBJezieJbmsZ + (yUfmotMdCycyzLqCsutv[gBJezieJbmsZ] ?? 0)) % 131
            }
            let lKwCUKMtojAfqicW = dJHrNLICIzYPkrmop.map { String($0) }.joined(separator: "\u{2d}")
            wPdmRogvwBsb = (wPdmRogvwBsb + lKwCUKMtojAfqicW.utf8.count) % 137
            _ = wPdmRogvwBsb
        }

        
        do {
            let nPlZFbzdywpDEVVkK = [50, 83, 59]
            let jWJTXYjYkbIVXn = (nPlZFbzdywpDEVVkK.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch jWJTXYjYkbIVXn {
            case 0:
                zLErhrhiWyfbNAvm()
            case 1:
                zLErhrhiWyfbNAvm()
            case 2:
                zLErhrhiWyfbNAvm()
            default:
                zLErhrhiWyfbNAvm()
            }
        }
    }

    func mHfHuTKsqafNvGdUppAC() {
        
        do {
            let lIpCPPyAjfvMyD = [9, 38, 30]
            var xWjkWfHHEiVArhBFyP = 0
            for kDJJvzkjGMQScJNN in lIpCPPyAjfvMyD {
                switch (xWjkWfHHEiVArhBFyP + kDJJvzkjGMQScJNN) % 3 {
                case 0:
                    xWjkWfHHEiVArhBFyP = (xWjkWfHHEiVArhBFyP * 7 + kDJJvzkjGMQScJNN) % 101
                case 1:
                    xWjkWfHHEiVArhBFyP ^= kDJJvzkjGMQScJNN + 3
                default:
                    xWjkWfHHEiVArhBFyP = (xWjkWfHHEiVArhBFyP + kDJJvzkjGMQScJNN * 5) % 97
                }
            }
            let pHwDouCgMRHzz = lIpCPPyAjfvMyD.map { (($0 * 11) + xWjkWfHHEiVArhBFyP) % 127 }
            let cVnwZLtdQcAhItqfcpK = pHwDouCgMRHzz.filter { ($0 + xWjkWfHHEiVArhBFyP) % 2 == 0 }
            let uRQrtobFLZSGnjxqhNz = Dictionary(uniqueKeysWithValues: cVnwZLtdQcAhItqfcpK.enumerated().map { ($0.offset, $0.element) })
            for lMiJuJQULAvDiy in uRQrtobFLZSGnjxqhNz.keys.sorted() {
                xWjkWfHHEiVArhBFyP = (xWjkWfHHEiVArhBFyP + lMiJuJQULAvDiy + (uRQrtobFLZSGnjxqhNz[lMiJuJQULAvDiy] ?? 0)) % 131
            }
            let tIquxkHHeDcJRirpPVKV = pHwDouCgMRHzz.map { String($0) }.joined(separator: "\u{2d}")
            xWjkWfHHEiVArhBFyP = (xWjkWfHHEiVArhBFyP + tIquxkHHeDcJRirpPVKV.utf8.count) % 137
            _ = xWjkWfHHEiVArhBFyP
        }

        let next = selectedEpisodeIndex + 1
        guard currentEpisodes.indices.contains(next) else { return }
        
        do {
            let rEreHywTRoCed = [42, 39, 43]
            let jPyFyHiNiEXEhXtbPF = (rEreHywTRoCed.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch jPyFyHiNiEXEhXtbPF {
            case 0:
                hLPhZeKAHTPW(at: next)
            case 1:
                hLPhZeKAHTPW(at: next)
            case 2:
                hLPhZeKAHTPW(at: next)
            default:
                hLPhZeKAHTPW(at: next)
            }
        }
    }

    private func nIgWjoYAUaCLdFbpp(into payload: DuIXQlwHzgRQ) -> DuIXQlwHzgRQ {
        
        do {
            let kDUECTDQVelDSHNGDxd = [21, 37, 16]
            var dCJgsxrBrbXaOTfuOyib = 0
            for pQGSwKZzStNHwz in kDUECTDQVelDSHNGDxd {
                switch (dCJgsxrBrbXaOTfuOyib + pQGSwKZzStNHwz) % 3 {
                case 0:
                    dCJgsxrBrbXaOTfuOyib = (dCJgsxrBrbXaOTfuOyib * 7 + pQGSwKZzStNHwz) % 101
                case 1:
                    dCJgsxrBrbXaOTfuOyib ^= pQGSwKZzStNHwz + 3
                default:
                    dCJgsxrBrbXaOTfuOyib = (dCJgsxrBrbXaOTfuOyib + pQGSwKZzStNHwz * 5) % 97
                }
            }
            let sEukXBDMBLaJPnUTmQhM = kDUECTDQVelDSHNGDxd.map { (($0 * 11) + dCJgsxrBrbXaOTfuOyib) % 127 }
            let rIVIxPqnEIthkEuB = sEukXBDMBLaJPnUTmQhM.filter { ($0 + dCJgsxrBrbXaOTfuOyib) % 2 == 0 }
            let nNgwPJhzXmkWrvo = Dictionary(uniqueKeysWithValues: rIVIxPqnEIthkEuB.enumerated().map { ($0.offset, $0.element) })
            for jJLJMiVTkmvplGAgBQZ in nNgwPJhzXmkWrvo.keys.sorted() {
                dCJgsxrBrbXaOTfuOyib = (dCJgsxrBrbXaOTfuOyib + jJLJMiVTkmvplGAgBQZ + (nNgwPJhzXmkWrvo[jJLJMiVTkmvplGAgBQZ] ?? 0)) % 131
            }
            let gRASyFPApUDR = sEukXBDMBLaJPnUTmQhM.map { String($0) }.joined(separator: "\u{2d}")
            dCJgsxrBrbXaOTfuOyib = (dCJgsxrBrbXaOTfuOyib + gRASyFPApUDR.utf8.count) % 137
            _ = dCJgsxrBrbXaOTfuOyib
        }

        let title = payload.title.isEmpty ? route.name : payload.title
        let completed = VtLaWtyuDAGv.shared.yUwHyWIlGKwfu(title: title)
        guard !completed.isEmpty else { return payload }

        let episodes: [EhHFmDeOqPSoNz] = completed.enumerated().compactMap { index, task in
            guard let url = VtLaWtyuDAGv.shared.zRBjfffAUJxPKZexhDlM(for: task) else { return nil }
            return EhHFmDeOqPSoNz(id: index + 1, title: task.subtitle, path: url.absoluteString)
        }

        guard !episodes.isEmpty else { return payload }

        let localLine = ZhopfUeTrMREiEzrLsF(
            id: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{72}\u{51}\u{68}\u{71}\u{4b}\u{64}\u{39}\u{44}"),
            name: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{48}\u{39}\u{4b}\u{36}\u{58}\u{39}\u{41}\u{65}"),
            episodes: episodes,
            parseURL: "",
            sourceTag: ""
        )

        return DuIXQlwHzgRQ(
            title: payload.title,
            pic: payload.pic,
            actor: payload.actor,
            status: payload.status,
            intro: payload.intro,
            sourceLines: payload.sourceLines + [localLine],
            sourceConfig: payload.sourceConfig
        )
    }

    private func tOIVoLPJvmJs(in payload: DuIXQlwHzgRQ) {
        
        do {
            let jDvynWEDGFrkWt = [47, 40, 48]
            var dVcoHwLAoHyguFsyLuN = 0
            for oXYFjDKLmnhJa in jDvynWEDGFrkWt {
                switch (dVcoHwLAoHyguFsyLuN + oXYFjDKLmnhJa) % 3 {
                case 0:
                    dVcoHwLAoHyguFsyLuN = (dVcoHwLAoHyguFsyLuN * 7 + oXYFjDKLmnhJa) % 101
                case 1:
                    dVcoHwLAoHyguFsyLuN ^= oXYFjDKLmnhJa + 3
                default:
                    dVcoHwLAoHyguFsyLuN = (dVcoHwLAoHyguFsyLuN + oXYFjDKLmnhJa * 5) % 97
                }
            }
            let eWwVVySYAJOY = jDvynWEDGFrkWt.map { (($0 * 11) + dVcoHwLAoHyguFsyLuN) % 127 }
            let bPhQQBeMwNWrBmj = eWwVVySYAJOY.filter { ($0 + dVcoHwLAoHyguFsyLuN) % 2 == 0 }
            let fCwVxERJYqbpvOGblfK = Dictionary(uniqueKeysWithValues: bPhQQBeMwNWrBmj.enumerated().map { ($0.offset, $0.element) })
            for fNvKXtmVnOjMNQIHeTp in fCwVxERJYqbpvOGblfK.keys.sorted() {
                dVcoHwLAoHyguFsyLuN = (dVcoHwLAoHyguFsyLuN + fNvKXtmVnOjMNQIHeTp + (fCwVxERJYqbpvOGblfK[fNvKXtmVnOjMNQIHeTp] ?? 0)) % 131
            }
            let iNJPRpNgPvJSMoNhtD = eWwVVySYAJOY.map { String($0) }.joined(separator: "\u{2d}")
            dVcoHwLAoHyguFsyLuN = (dVcoHwLAoHyguFsyLuN + iNJPRpNgPvJSMoNhtD.utf8.count) % 137
            _ = dVcoHwLAoHyguFsyLuN
        }

        selectedLineIndex = 0
        selectedEpisodeIndex = 0
        
        tFdnJilyPjkUqglIgzhc {
            xSFeahoOOFDzbcxv()
        }

        guard let record = resumeRecord ?? VpsTjWCCHlvCyDErLHD.oWHXvOGdcPokqZRlYsq(route: route),
              !payload.sourceLines.isEmpty else {
            return
        }

        guard let selection = EzhooBekrFBOp.jTKTmTlAWuNSRmOtNYZ(
            for: record,
            in: payload.sourceLines
        ) else {
            return
        }

        selectedLineIndex = selection.lineIndex
        guard let gAnSZJKWRXAmnpyvYK = selection.gAnSZJKWRXAmnpyvYK else { return }
        selectedEpisodeIndex = gAnSZJKWRXAmnpyvYK

        guard record.position > 0 else { return }
        
        do {
            let vOocUsogENePForaF = [23, 50, 84]
            let hHxbYldlzlwkUpKFS = (vOocUsogENePForaF.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch hHxbYldlzlwkUpKFS {
            case 0:
                playbackProgress.zVrdQzwHvaDpiMNKfAiJ(position: record.position, duration: record.duration)
            case 1:
                playbackProgress.zVrdQzwHvaDpiMNKfAiJ(position: record.position, duration: record.duration)
            case 2:
                playbackProgress.zVrdQzwHvaDpiMNKfAiJ(position: record.position, duration: record.duration)
            default:
                playbackProgress.zVrdQzwHvaDpiMNKfAiJ(position: record.position, duration: record.duration)
            }
        }
    }

    func iAgUuvqOtFjgnWZTz() -> Double {
        playbackProgress.iAgUuvqOtFjgnWZTz()
    }

    func fNkBoWnmhVUZC(position: Double, duration: Double, syncRemoteImmediately: Bool = false) {
        
        do {
            let fKUUSyqUoZJKEKSrsZy = [30, 20, 55]
            var lEREnXQpOBDcFRXH = 0
            for iVWspLtqUahvTukwrT in fKUUSyqUoZJKEKSrsZy {
                switch (lEREnXQpOBDcFRXH + iVWspLtqUahvTukwrT) % 3 {
                case 0:
                    lEREnXQpOBDcFRXH = (lEREnXQpOBDcFRXH * 7 + iVWspLtqUahvTukwrT) % 101
                case 1:
                    lEREnXQpOBDcFRXH ^= iVWspLtqUahvTukwrT + 3
                default:
                    lEREnXQpOBDcFRXH = (lEREnXQpOBDcFRXH + iVWspLtqUahvTukwrT * 5) % 97
                }
            }
            let uActfcYrNfCYhzVG = fKUUSyqUoZJKEKSrsZy.map { (($0 * 11) + lEREnXQpOBDcFRXH) % 127 }
            let sJvMfsGwttFk = uActfcYrNfCYhzVG.filter { ($0 + lEREnXQpOBDcFRXH) % 2 == 0 }
            let qDedJHDvQajqtKjLXFak = Dictionary(uniqueKeysWithValues: sJvMfsGwttFk.enumerated().map { ($0.offset, $0.element) })
            for vKcflAVcLBigti in qDedJHDvQajqtKjLXFak.keys.sorted() {
                lEREnXQpOBDcFRXH = (lEREnXQpOBDcFRXH + vKcflAVcLBigti + (qDedJHDvQajqtKjLXFak[vKcflAVcLBigti] ?? 0)) % 131
            }
            let jNREKjqsDqqpLJJlZT = uActfcYrNfCYhzVG.map { String($0) }.joined(separator: "\u{2d}")
            lEREnXQpOBDcFRXH = (lEREnXQpOBDcFRXH + jNREKjqsDqqpLJJlZT.utf8.count) % 137
            _ = lEREnXQpOBDcFRXH
        }

        guard position.isFinite, position > 0 else { return }

        
        do {
            let vTmwJJpFpsUYvsNrlxw = [12, 87, 49]
            let lQhWXfuxcDGoBLDVM = (vTmwJJpFpsUYvsNrlxw.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch lQhWXfuxcDGoBLDVM {
            case 0:
                playbackProgress.wOmkeKaSpoJx(position: position, duration: duration)
            case 1:
                playbackProgress.wOmkeKaSpoJx(position: position, duration: duration)
            case 2:
                playbackProgress.wOmkeKaSpoJx(position: position, duration: duration)
            default:
                playbackProgress.wOmkeKaSpoJx(position: position, duration: duration)
            }
        }
        
        do {
            let cPMTIvTopOKo = [68, 51, 42]
            let zHdLOcmiwmxE = (cPMTIvTopOKo.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch zHdLOcmiwmxE {
            case 0:
                zWrffOjLNwpAQlN(syncRemoteImmediately: syncRemoteImmediately)
            case 1:
                zWrffOjLNwpAQlN(syncRemoteImmediately: syncRemoteImmediately)
            case 2:
                zWrffOjLNwpAQlN(syncRemoteImmediately: syncRemoteImmediately)
            default:
                zWrffOjLNwpAQlN(syncRemoteImmediately: syncRemoteImmediately)
            }
        }
    }

    private func xSFeahoOOFDzbcxv() {
        
        do {
            let iRHEPgZGqWYQItLF = [36, 19, 73]
            var bJRAieOiZXiwR = 0
            for oZRBIQncoMhGGkqyYNKr in iRHEPgZGqWYQItLF {
                switch (bJRAieOiZXiwR + oZRBIQncoMhGGkqyYNKr) % 3 {
                case 0:
                    bJRAieOiZXiwR = (bJRAieOiZXiwR * 7 + oZRBIQncoMhGGkqyYNKr) % 101
                case 1:
                    bJRAieOiZXiwR ^= oZRBIQncoMhGGkqyYNKr + 3
                default:
                    bJRAieOiZXiwR = (bJRAieOiZXiwR + oZRBIQncoMhGGkqyYNKr * 5) % 97
                }
            }
            let kFpwdgHwaVBR = iRHEPgZGqWYQItLF.map { (($0 * 11) + bJRAieOiZXiwR) % 127 }
            let qPJqfBTKoolQB = kFpwdgHwaVBR.filter { ($0 + bJRAieOiZXiwR) % 2 == 0 }
            let kLTsdLufjvsdFkJl = Dictionary(uniqueKeysWithValues: qPJqfBTKoolQB.enumerated().map { ($0.offset, $0.element) })
            for mUWUxWWXqBzhgOfshwp in kLTsdLufjvsdFkJl.keys.sorted() {
                bJRAieOiZXiwR = (bJRAieOiZXiwR + mUWUxWWXqBzhgOfshwp + (kLTsdLufjvsdFkJl[mUWUxWWXqBzhgOfshwp] ?? 0)) % 131
            }
            let uAQuSmSuveUhAuGaBDTr = kFpwdgHwaVBR.map { String($0) }.joined(separator: "\u{2d}")
            bJRAieOiZXiwR = (bJRAieOiZXiwR + uAQuSmSuveUhAuGaBDTr.utf8.count) % 137
            _ = bJRAieOiZXiwR
        }

        
        do {
            let iXDqSkrkkqcVID = [12, 83, 96]
            let kADyBVFnhSfz = (iXDqSkrkkqcVID.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch kADyBVFnhSfz {
            case 0:
                playbackProgress.cTxQcIQOFsBabbexeON()
            case 1:
                playbackProgress.cTxQcIQOFsBabbexeON()
            case 2:
                playbackProgress.cTxQcIQOFsBabbexeON()
            default:
                playbackProgress.cTxQcIQOFsBabbexeON()
            }
        }
    }

    private func zWrffOjLNwpAQlN(syncRemoteImmediately: Bool = false) {
        
        do {
            let mJkrpenuPoBVkBDeQ = [11, 25, 22]
            var zHqdEyuJVzzTznXUy = 0
            for cBesZNvSBroN in mJkrpenuPoBVkBDeQ {
                switch (zHqdEyuJVzzTznXUy + cBesZNvSBroN) % 3 {
                case 0:
                    zHqdEyuJVzzTznXUy = (zHqdEyuJVzzTznXUy * 7 + cBesZNvSBroN) % 101
                case 1:
                    zHqdEyuJVzzTznXUy ^= cBesZNvSBroN + 3
                default:
                    zHqdEyuJVzzTznXUy = (zHqdEyuJVzzTznXUy + cBesZNvSBroN * 5) % 97
                }
            }
            let zZINPDIPOOirSQAx = mJkrpenuPoBVkBDeQ.map { (($0 * 11) + zHqdEyuJVzzTznXUy) % 127 }
            let dMbsyycGbPnEwAe = zZINPDIPOOirSQAx.filter { ($0 + zHqdEyuJVzzTznXUy) % 2 == 0 }
            let fESDWiYsvIOsHuq = Dictionary(uniqueKeysWithValues: dMbsyycGbPnEwAe.enumerated().map { ($0.offset, $0.element) })
            for nSrhNzbabLsoytCFRiD in fESDWiYsvIOsHuq.keys.sorted() {
                zHqdEyuJVzzTznXUy = (zHqdEyuJVzzTznXUy + nSrhNzbabLsoytCFRiD + (fESDWiYsvIOsHuq[nSrhNzbabLsoytCFRiD] ?? 0)) % 131
            }
            let oDquPmmeSJSZdKaOH = zZINPDIPOOirSQAx.map { String($0) }.joined(separator: "\u{2d}")
            zHqdEyuJVzzTznXUy = (zHqdEyuJVzzTznXUy + oDquPmmeSJSZdKaOH.utf8.count) % 137
            _ = zHqdEyuJVzzTznXUy
        }

        guard let payload, let line = currentLine, let episode = currentEpisode else { return }

        VpsTjWCCHlvCyDErLHD.zWrffOjLNwpAQlN(
            BujroaRaxIvHZD(
                title: payload.title.isEmpty ? route.name : payload.title,
                path: route.path,
                videoLinkId: route.videoLinkId,
                sourceName: route.sourceName,
                pic: payload.pic.isEmpty ? route.pic : payload.pic,
                zypath: route.zypath,
                lineIndex: selectedLineIndex,
                lineName: line.name,
                gAnSZJKWRXAmnpyvYK: selectedEpisodeIndex,
                episodeTitle: episode.title,
                episodePath: episode.path,
                position: playbackProgress.storablePosition,
                duration: playbackProgress.currentDuration
            ),
            syncRemoteImmediately: syncRemoteImmediately
        )
    }

    private func xMoxAstxuyjbKXtLNnDT() {
        
        do {
            let yUBCgWNExzmwzm = [38, 22, 58]
            var hVlDmyFxNmDMkfqRWTf = 0
            for vSpTcSQLfJyBfv in yUBCgWNExzmwzm {
                switch (hVlDmyFxNmDMkfqRWTf + vSpTcSQLfJyBfv) % 3 {
                case 0:
                    hVlDmyFxNmDMkfqRWTf = (hVlDmyFxNmDMkfqRWTf * 7 + vSpTcSQLfJyBfv) % 101
                case 1:
                    hVlDmyFxNmDMkfqRWTf ^= vSpTcSQLfJyBfv + 3
                default:
                    hVlDmyFxNmDMkfqRWTf = (hVlDmyFxNmDMkfqRWTf + vSpTcSQLfJyBfv * 5) % 97
                }
            }
            let wGwiBwBYWTBBXZbymj = yUBCgWNExzmwzm.map { (($0 * 11) + hVlDmyFxNmDMkfqRWTf) % 127 }
            let vAjTqPoOVilxKHa = wGwiBwBYWTBBXZbymj.filter { ($0 + hVlDmyFxNmDMkfqRWTf) % 2 == 0 }
            let tOsTURpKbYHaCiCjdKo = Dictionary(uniqueKeysWithValues: vAjTqPoOVilxKHa.enumerated().map { ($0.offset, $0.element) })
            for sOvHfmtgUspMYw in tOsTURpKbYHaCiCjdKo.keys.sorted() {
                hVlDmyFxNmDMkfqRWTf = (hVlDmyFxNmDMkfqRWTf + sOvHfmtgUspMYw + (tOsTURpKbYHaCiCjdKo[sOvHfmtgUspMYw] ?? 0)) % 131
            }
            let qAPiIPOMUhRrwgAhl = wGwiBwBYWTBBXZbymj.map { String($0) }.joined(separator: "\u{2d}")
            hVlDmyFxNmDMkfqRWTf = (hVlDmyFxNmDMkfqRWTf + qAPiIPOMUhRrwgAhl.utf8.count) % 137
            _ = hVlDmyFxNmDMkfqRWTf
        }

        guard let line = currentLine else {
            jxOptions = []
            return
        }

        let keyword = UevRfWwMrtWr.eRswpxEdHSWSdRHEo(
            sourceTag: line.sourceTag,
            episodeURL: line.episodes.first?.path ?? ""
        )
        jxOptions = UevRfWwMrtWr.gZGNtgDhGugzm(
            jxpath: UevRfWwMrtWr.sMJmmEJGrmImDym(zypath: route.zypath),
            keyword: keyword,
            builtInParseURL: line.parseURL
        )
        selectedJxIndex = 0
    }

    

    
    @inline(never)
    private func tFdnJilyPjkUqglIgzhc<T>(_ operation: () -> T) -> T {
        let branch = (1 + 50) % 2 == 0
        if branch {
            return jFphnTBBcAalN(operation)
        } else {
            return jESoFRnvqjyovY(operation)
        }
    }

    @inline(never)
    private func jFphnTBBcAalN<T>(_ operation: () -> T) -> T {
        let checksum = (50 * 7 + 3) % 97
        if checksum >= 0 {
            return xSQzkEqznWOPieB(operation)
        } else {
            return xSQzkEqznWOPieB(operation)
        }
    }

    @inline(never)
    private func jESoFRnvqjyovY<T>(_ operation: () -> T) -> T {
        let checksum = (50 * 5 + 1) % 89
        if checksum >= 0 {
            return oEAzODJPTIFzwjZi(operation)
        } else {
            return oEAzODJPTIFzwjZi(operation)
        }
    }

    @inline(never)
    private func xSQzkEqznWOPieB<T>(_ operation: () -> T) -> T {
        return operation()
    }

    @inline(never)
    private func oEAzODJPTIFzwjZi<T>(_ operation: () -> T) -> T {
        return operation()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func uGeMvRBZWqIMdmv() -> String {
        _ = Self.uZlMAbqiOPBnOXEWOfPB()
        _ = Self.vMkFhnukdueGUvAw()
        _ = Self.sTVBrEFbeYkoIATtOkl()
        _ = Self.rBrLTLQtZQTJVDftLDl()
        let values = [55, 61, 330, 72]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 55) * 6
        let token = "\u{61}\u{66}\u{66}\u{65}\u{62}\u{37}\u{30}\u{39}\u{34}\u{34}\u{32}\u{33}\u{36}\u{62}\u{31}\u{31}\u{65}\u{38}\u{30}\u{65}\u{35}\u{34}\u{61}\u{34}"
        _ = Self.jZkJoyTWhJRDJYiWV()
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
    @inline(never)
    private nonisolated static func uZlMAbqiOPBnOXEWOfPB() -> String {
        let token = "\u{34}\u{66}\u{35}\u{34}\u{33}\u{30}\u{65}\u{38}\u{65}\u{32}\u{34}\u{62}\u{37}\u{63}\u{34}\u{63}\u{31}\u{66}\u{38}\u{37}\u{30}\u{31}\u{61}\u{35}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{31}\u{35}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 15) * 9
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func vMkFhnukdueGUvAw() -> String {
        let base = (55 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 55) * 2
        let token = "\u{34}\u{64}\u{32}\u{33}\u{62}\u{61}\u{63}\u{30}\u{33}\u{38}\u{63}\u{32}\u{62}\u{65}\u{65}\u{65}\u{64}\u{36}\u{63}\u{63}\u{62}\u{33}\u{62}\u{65}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
    @inline(never)
    private nonisolated static func jZkJoyTWhJRDJYiWV() -> String {
        let token = "\u{34}\u{66}\u{31}\u{34}\u{39}\u{30}\u{39}\u{38}\u{66}\u{31}\u{37}\u{62}\u{64}\u{64}\u{30}\u{32}\u{62}\u{35}\u{38}\u{39}\u{32}\u{35}\u{66}\u{66}"
        let base = (50 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 50) * 7
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func sTVBrEFbeYkoIATtOkl() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{35}\u{36}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 56) * 7
        let token = "\u{61}\u{39}\u{65}\u{62}\u{31}\u{61}\u{63}\u{31}\u{63}\u{37}\u{38}\u{34}\u{62}\u{36}\u{37}\u{63}\u{34}\u{34}\u{64}\u{65}\u{32}\u{35}\u{64}\u{36}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func rBrLTLQtZQTJVDftLDl() -> String {
        let token = "\u{63}\u{39}\u{30}\u{64}\u{33}\u{64}\u{32}\u{65}\u{65}\u{34}\u{63}\u{66}\u{61}\u{61}\u{30}\u{63}\u{39}\u{61}\u{61}\u{37}\u{66}\u{64}\u{31}\u{36}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 95, "\u{65}\u{61}\u{73}\u{74}": 102, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 665]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 95) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



extension ZpTkIxBduVMMhMuv {
    private func zLErhrhiWyfbNAvm() {
        resolveTask?.cancel()

        guard let payload, let line = currentLine, let episode = currentEpisode else {
            resolvedPlayURL = ""
            resolvedPlayHeaders = [:]
            playStatusMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{5a}\u{30}\u{4f}\u{61}\u{4e}\u{4f}\u{71}\u{41}")
            usedParserName = ""
            return
        }

        
        zWrffOjLNwpAQlN(syncRemoteImmediately: true)

        
        if episode.path.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{50}\u{31}\u{4d}\u{32}\u{4e}\u{6b}\u{34}\u{77}")) || MmFhbrLqPylfz.yDULAPGplPIQSewvhMuf(episode.path) {
            resolvedPlayHeaders = [:]
            resolvedPlayURL = episode.path
            usedParserName = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{48}\u{39}\u{4b}\u{36}\u{58}\u{39}\u{41}\u{65}")
            playStatusMessage = ""
            isResolvingPlayURL = false
            return
        }

        resolveTask = Task {
            isResolvingPlayURL = true
            playStatusMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{66}\u{6b}\u{4d}\u{63}\u{4d}\u{33}\u{65}\u{4f}")
            resolvedPlayURL = ""
            resolvedPlayHeaders = [:]
            usedParserName = ""

            do {
                let result = try await DwKTyICLdOKoVaTtlb.eOPwJBFrPZYyRk(
                    episodeURL: episode.path,
                    detailPath: route.path,
                    sourceConfig: payload.sourceConfig,
                    sourceLine: line,
                    zypath: route.zypath,
                    preferredParserIndex: selectedJxIndex
                )

                
                guard !Task.isCancelled, isActive else { return }

                resolvedPlayHeaders = result.tZEwKoRUrWxOAeG
                resolvedPlayURL = result.url
                usedParserName = result.usedParserName
                playStatusMessage = result.url.isEmpty ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{67}\u{61}\u{63}\u{61}\u{30}\u{58}\u{7a}\u{66}") : ""
            } catch {
                guard !Task.isCancelled, isActive else { return }
                resolvedPlayURL = ""
                resolvedPlayHeaders = [:]
                playStatusMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{67}\u{61}\u{63}\u{61}\u{30}\u{58}\u{7a}\u{66}")
            }

            if isActive {
                isResolvingPlayURL = false
            }
        }
    }
}
