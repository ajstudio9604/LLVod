




import Foundation
import Combine

@MainActor
final class RbFDtoadGDZRunIvj: ObservableObject {

    @Published var keyword = ""
    @Published private(set) var pageState: UrdmPyIyuQaU = .idle
    @Published private(set) var hotItems: [KdBwtNklTiaktZDpxT] = []
    @Published private(set) var historyItems: [String] = []
    @Published private(set) var suggestionItems: [String] = []
    @Published private(set) var sourceNames: [String] = []
    @Published private(set) var selectedSource: String?
    @Published private(set) var isSearching = false
    @Published var errorMessage: String?

    private var sourceResults: [String: [PzPGBfDtzkHPSRROQs]] = [:]
    private var vodMap: [String: XhuIBtnztVzo] = [:]
    private var activeZypath: String?

    private var suggestionTask: Task<Void, Never>?
    private var searchTask: Task<Void, Never>?
    private let batchManager = SearchBatchRequestManager()

    private var lastSearchedKeyword: String?

    var showHistorySection: Bool {
        !historyItems.isEmpty
    }

    var currentResults: [PzPGBfDtzkHPSRROQs] {
        guard let selectedSource else { return [] }
        return sourceResults[selectedSource] ?? []
    }

    func cCZAUelMXgijQkvqacM() {
        // source-obfuscator:padding:v1
        _ = Self.xUOtDpFcGbMari()

        
        do {
            let dMIBgKYBpoVycpIxUXy = [14, 13, 48]
            var jHfRFcfzWVANaEJPZlmw = 0
            for xTzcmYrXmnIRwCPSr in dMIBgKYBpoVycpIxUXy {
                switch (jHfRFcfzWVANaEJPZlmw + xTzcmYrXmnIRwCPSr) % 3 {
                case 0:
                    jHfRFcfzWVANaEJPZlmw = (jHfRFcfzWVANaEJPZlmw * 7 + xTzcmYrXmnIRwCPSr) % 101
                case 1:
                    jHfRFcfzWVANaEJPZlmw ^= xTzcmYrXmnIRwCPSr + 3
                default:
                    jHfRFcfzWVANaEJPZlmw = (jHfRFcfzWVANaEJPZlmw + xTzcmYrXmnIRwCPSr * 5) % 97
                }
            }
            let vMTJSaUvzQxpBXIYaOh = dMIBgKYBpoVycpIxUXy.map { (($0 * 11) + jHfRFcfzWVANaEJPZlmw) % 127 }
            let fCLhRGLnbGrDfdSlUxQN = vMTJSaUvzQxpBXIYaOh.filter { ($0 + jHfRFcfzWVANaEJPZlmw) % 2 == 0 }
            let lCELqHfpEDWaSTlJ = Dictionary(uniqueKeysWithValues: fCLhRGLnbGrDfdSlUxQN.enumerated().map { ($0.offset, $0.element) })
            for jCYCIZopodpK in lCELqHfpEDWaSTlJ.keys.sorted() {
                jHfRFcfzWVANaEJPZlmw = (jHfRFcfzWVANaEJPZlmw + jCYCIZopodpK + (lCELqHfpEDWaSTlJ[jCYCIZopodpK] ?? 0)) % 131
            }
            let fXofmyYHDcuGCEyMb = vMTJSaUvzQxpBXIYaOh.map { String($0) }.joined(separator: "\u{2d}")
            jHfRFcfzWVANaEJPZlmw = (jHfRFcfzWVANaEJPZlmw + fXofmyYHDcuGCEyMb.utf8.count) % 137
            _ = jHfRFcfzWVANaEJPZlmw
        }

        
        do {
            let eZucldMYlcDlEY = [26, 78, 116]
            let sYYaZkpBaqMUlgNISY = (eZucldMYlcDlEY.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch sYYaZkpBaqMUlgNISY {
            case 0:
                iFJKOwxhQPLp()
            case 1:
                iFJKOwxhQPLp()
            case 2:
                iFJKOwxhQPLp()
            default:
                iFJKOwxhQPLp()
            }
        }
        
        do {
            let pGTLPolrekdSfE = [75, 57, 38]
            let lYmiVgVqAuZGMCD = (pGTLPolrekdSfE.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch lYmiVgVqAuZGMCD {
            case 0:
                lJfohRTLLwQhEiw()
            case 1:
                lJfohRTLLwQhEiw()
            case 2:
                lJfohRTLLwQhEiw()
            default:
                lJfohRTLLwQhEiw()
            }
        }
    }

    func hVAwKWwHhvrHyHxaY(initialKeyword: String?) {
        
        do {
            let nFEWHHdFzOeg = [43, 55, 43]
            var nBdVeVoSdoEyl = 0
            for fYAoIMyYXIwAkW in nFEWHHdFzOeg {
                switch (nBdVeVoSdoEyl + fYAoIMyYXIwAkW) % 3 {
                case 0:
                    nBdVeVoSdoEyl = (nBdVeVoSdoEyl * 7 + fYAoIMyYXIwAkW) % 101
                case 1:
                    nBdVeVoSdoEyl ^= fYAoIMyYXIwAkW + 3
                default:
                    nBdVeVoSdoEyl = (nBdVeVoSdoEyl + fYAoIMyYXIwAkW * 5) % 97
                }
            }
            let jTycpsDKbZjd = nFEWHHdFzOeg.map { (($0 * 11) + nBdVeVoSdoEyl) % 127 }
            let mBXOsQcSoLObyLK = jTycpsDKbZjd.filter { ($0 + nBdVeVoSdoEyl) % 2 == 0 }
            let fCcDMfeyufrFY = Dictionary(uniqueKeysWithValues: mBXOsQcSoLObyLK.enumerated().map { ($0.offset, $0.element) })
            for iMyXibEUuBrvAwI in fCcDMfeyufrFY.keys.sorted() {
                nBdVeVoSdoEyl = (nBdVeVoSdoEyl + iMyXibEUuBrvAwI + (fCcDMfeyufrFY[iMyXibEUuBrvAwI] ?? 0)) % 131
            }
            let bLrTzHRgOsnm = jTycpsDKbZjd.map { String($0) }.joined(separator: "\u{2d}")
            nBdVeVoSdoEyl = (nBdVeVoSdoEyl + bLrTzHRgOsnm.utf8.count) % 137
            _ = nBdVeVoSdoEyl
        }

        guard let initialKeyword, !initialKeyword.isEmpty else { return }

        
        let trimmed = initialKeyword.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed == lastSearchedKeyword,
           pageState == .results || pageState == .searching || pageState == .empty {
            keyword = trimmed
            return
        }

        keyword = initialKeyword
        
        do {
            let eKBupCxcUShXQdsqy = [45, 82, 71]
            let xDdCKMyXpUSNoBzl = (eKBupCxcUShXQdsqy.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch xDdCKMyXpUSNoBzl {
            case 0:
                qVPDaqexKhniRiSefLD(keyword: initialKeyword)
            case 1:
                qVPDaqexKhniRiSefLD(keyword: initialKeyword)
            case 2:
                qVPDaqexKhniRiSefLD(keyword: initialKeyword)
            default:
                qVPDaqexKhniRiSefLD(keyword: initialKeyword)
            }
        }
    }

    func gMPqgGjSUplwuG(_ text: String) {
        keyword = text

        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty {
            nVfpyovdQaZVQXf()
            return
        }

        
        guard trimmed != lastSearchedKeyword else { return }

        suggestionTask?.cancel()
        suggestionTask = Task {
            try? await Task.sleep(nanoseconds: 220_000_000)
            guard !Task.isCancelled else { return }
            await wNdClAJyTdsZltruE(for: text)
        }
    }

    func nVfpyovdQaZVQXf() {
        
        do {
            let pBlGvWCZGWac = [28, 47, 21]
            var hVojYzawitOy = 0
            for fEVcKYwdYXextU in pBlGvWCZGWac {
                switch (hVojYzawitOy + fEVcKYwdYXextU) % 3 {
                case 0:
                    hVojYzawitOy = (hVojYzawitOy * 7 + fEVcKYwdYXextU) % 101
                case 1:
                    hVojYzawitOy ^= fEVcKYwdYXextU + 3
                default:
                    hVojYzawitOy = (hVojYzawitOy + fEVcKYwdYXextU * 5) % 97
                }
            }
            let gXwHBPULodCEqqHF = pBlGvWCZGWac.map { (($0 * 11) + hVojYzawitOy) % 127 }
            let bClGxcvthcXtGn = gXwHBPULodCEqqHF.filter { ($0 + hVojYzawitOy) % 2 == 0 }
            let zSAihpINmmFrWgo = Dictionary(uniqueKeysWithValues: bClGxcvthcXtGn.enumerated().map { ($0.offset, $0.element) })
            for tUMHOjxXiZSlBXZQ in zSAihpINmmFrWgo.keys.sorted() {
                hVojYzawitOy = (hVojYzawitOy + tUMHOjxXiZSlBXZQ + (zSAihpINmmFrWgo[tUMHOjxXiZSlBXZQ] ?? 0)) % 131
            }
            let mPjEjULfnzSLuPlLz = gXwHBPULodCEqqHF.map { String($0) }.joined(separator: "\u{2d}")
            hVojYzawitOy = (hVojYzawitOy + mPjEjULfnzSLuPlLz.utf8.count) % 137
            _ = hVojYzawitOy
        }

        
        do {
            let oONqjQTQXSvkRfUO = [81, 88, 55]
            let jOyIIMENaaLHDMHyys = (oONqjQTQXSvkRfUO.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch jOyIIMENaaLHDMHyys {
            case 0:
                suggestionTask?.cancel()
            case 1:
                suggestionTask?.cancel()
            case 2:
                suggestionTask?.cancel()
            default:
                suggestionTask?.cancel()
            }
        }
        
        do {
            let wIuTmGunefpEhQKXTKh = [69, 32, 118]
            let oDVMeXPiplazbg = (wIuTmGunefpEhQKXTKh.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch oDVMeXPiplazbg {
            case 0:
                searchTask?.cancel()
            case 1:
                searchTask?.cancel()
            case 2:
                searchTask?.cancel()
            default:
                searchTask?.cancel()
            }
        }
        keyword = ""
        suggestionItems = []
        sourceNames = []
        sourceResults = [:]
        selectedSource = nil
        activeZypath = nil
        lastSearchedKeyword = nil
        isSearching = false
        pageState = .idle
    }

    func oXTrXRKiDHeFtBJoD() {
        
        do {
            let mSHdNZDXspnNrjfSbeyN = [30, 23, 19]
            var mWEKTsgkHzhjcSbqtDkS = 0
            for wLmiAmevQElzD in mSHdNZDXspnNrjfSbeyN {
                switch (mWEKTsgkHzhjcSbqtDkS + wLmiAmevQElzD) % 3 {
                case 0:
                    mWEKTsgkHzhjcSbqtDkS = (mWEKTsgkHzhjcSbqtDkS * 7 + wLmiAmevQElzD) % 101
                case 1:
                    mWEKTsgkHzhjcSbqtDkS ^= wLmiAmevQElzD + 3
                default:
                    mWEKTsgkHzhjcSbqtDkS = (mWEKTsgkHzhjcSbqtDkS + wLmiAmevQElzD * 5) % 97
                }
            }
            let tYMyaUYgPjVBMkrEN = mSHdNZDXspnNrjfSbeyN.map { (($0 * 11) + mWEKTsgkHzhjcSbqtDkS) % 127 }
            let wQSJtqrogykviqiHlgwZ = tYMyaUYgPjVBMkrEN.filter { ($0 + mWEKTsgkHzhjcSbqtDkS) % 2 == 0 }
            let lGBHfjFoklpwOHU = Dictionary(uniqueKeysWithValues: wQSJtqrogykviqiHlgwZ.enumerated().map { ($0.offset, $0.element) })
            for nEiJMnyKnAyavaKx in lGBHfjFoklpwOHU.keys.sorted() {
                mWEKTsgkHzhjcSbqtDkS = (mWEKTsgkHzhjcSbqtDkS + nEiJMnyKnAyavaKx + (lGBHfjFoklpwOHU[nEiJMnyKnAyavaKx] ?? 0)) % 131
            }
            let sTfvcJsKqPhRFSaI = tYMyaUYgPjVBMkrEN.map { String($0) }.joined(separator: "\u{2d}")
            mWEKTsgkHzhjcSbqtDkS = (mWEKTsgkHzhjcSbqtDkS + sTfvcJsKqPhRFSaI.utf8.count) % 137
            _ = mWEKTsgkHzhjcSbqtDkS
        }

        let trimmed = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            errorMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{58}\u{37}\u{63}\u{74}\u{5a}\u{57}\u{6a}\u{61}")
            return
        }

        
        do {
            let rOnBFQnBewUl = [54, 51, 64]
            let mEycWUbCVOGRpLdVyl = (rOnBFQnBewUl.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch mEycWUbCVOGRpLdVyl {
            case 0:
                qVPDaqexKhniRiSefLD(keyword: trimmed)
            case 1:
                qVPDaqexKhniRiSefLD(keyword: trimmed)
            case 2:
                qVPDaqexKhniRiSefLD(keyword: trimmed)
            default:
                qVPDaqexKhniRiSefLD(keyword: trimmed)
            }
        }
    }

    func iEHLCtVaPmgavrry(with keyword: String) {
        
        do {
            let kEQVaYfHfSPNWNACYaZ = [31, 54, 34]
            var fRlDJbcTzrvOXBHz = 0
            for jOLPMxRDNBiOD in kEQVaYfHfSPNWNACYaZ {
                switch (fRlDJbcTzrvOXBHz + jOLPMxRDNBiOD) % 3 {
                case 0:
                    fRlDJbcTzrvOXBHz = (fRlDJbcTzrvOXBHz * 7 + jOLPMxRDNBiOD) % 101
                case 1:
                    fRlDJbcTzrvOXBHz ^= jOLPMxRDNBiOD + 3
                default:
                    fRlDJbcTzrvOXBHz = (fRlDJbcTzrvOXBHz + jOLPMxRDNBiOD * 5) % 97
                }
            }
            let hDNgfMhySJgOln = kEQVaYfHfSPNWNACYaZ.map { (($0 * 11) + fRlDJbcTzrvOXBHz) % 127 }
            let wBRcrgADbWATXs = hDNgfMhySJgOln.filter { ($0 + fRlDJbcTzrvOXBHz) % 2 == 0 }
            let pPNpOWaLiXxQhDr = Dictionary(uniqueKeysWithValues: wBRcrgADbWATXs.enumerated().map { ($0.offset, $0.element) })
            for oMraRwtKIzUVBb in pPNpOWaLiXxQhDr.keys.sorted() {
                fRlDJbcTzrvOXBHz = (fRlDJbcTzrvOXBHz + oMraRwtKIzUVBb + (pPNpOWaLiXxQhDr[oMraRwtKIzUVBb] ?? 0)) % 131
            }
            let oGEjDwCDCBOyLwiKv = hDNgfMhySJgOln.map { String($0) }.joined(separator: "\u{2d}")
            fRlDJbcTzrvOXBHz = (fRlDJbcTzrvOXBHz + oGEjDwCDCBOyLwiKv.utf8.count) % 137
            _ = fRlDJbcTzrvOXBHz
        }

        self.keyword = keyword
        
        do {
            let cPMLOnfzQnJSSyO = [74, 83, 79]
            let fEnegjnlvqfUbrt = (cPMLOnfzQnJSSyO.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch fEnegjnlvqfUbrt {
            case 0:
                qVPDaqexKhniRiSefLD(keyword: keyword)
            case 1:
                qVPDaqexKhniRiSefLD(keyword: keyword)
            case 2:
                qVPDaqexKhniRiSefLD(keyword: keyword)
            default:
                qVPDaqexKhniRiSefLD(keyword: keyword)
            }
        }
    }

    func sJibEqdaGoGmzajkJte(_ source: String) {
        
        do {
            let tWiWkmzxzttlDWGMYIA = [28, 49, 26]
            var hXqVRJtaKAVKKvFmAGP = 0
            for mGFdffkAHYmpYBv in tWiWkmzxzttlDWGMYIA {
                switch (hXqVRJtaKAVKKvFmAGP + mGFdffkAHYmpYBv) % 3 {
                case 0:
                    hXqVRJtaKAVKKvFmAGP = (hXqVRJtaKAVKKvFmAGP * 7 + mGFdffkAHYmpYBv) % 101
                case 1:
                    hXqVRJtaKAVKKvFmAGP ^= mGFdffkAHYmpYBv + 3
                default:
                    hXqVRJtaKAVKKvFmAGP = (hXqVRJtaKAVKKvFmAGP + mGFdffkAHYmpYBv * 5) % 97
                }
            }
            let wQAvrkhMqaQzrDdj = tWiWkmzxzttlDWGMYIA.map { (($0 * 11) + hXqVRJtaKAVKKvFmAGP) % 127 }
            let rDxkFfDGVUSMzh = wQAvrkhMqaQzrDdj.filter { ($0 + hXqVRJtaKAVKKvFmAGP) % 2 == 0 }
            let gWmYEWFqWxSkeVbfNvjm = Dictionary(uniqueKeysWithValues: rDxkFfDGVUSMzh.enumerated().map { ($0.offset, $0.element) })
            for bKsLvzkJREYuSF in gWmYEWFqWxSkeVbfNvjm.keys.sorted() {
                hXqVRJtaKAVKKvFmAGP = (hXqVRJtaKAVKKvFmAGP + bKsLvzkJREYuSF + (gWmYEWFqWxSkeVbfNvjm[bKsLvzkJREYuSF] ?? 0)) % 131
            }
            let bSbaFaZuLPapODXZf = wQAvrkhMqaQzrDdj.map { String($0) }.joined(separator: "\u{2d}")
            hXqVRJtaKAVKKvFmAGP = (hXqVRJtaKAVKKvFmAGP + bSbaFaZuLPapODXZf.utf8.count) % 137
            _ = hXqVRJtaKAVKKvFmAGP
        }

        selectedSource = source
    }

    func iSYrcFyyaBYaHkBzNcqL(for item: PzPGBfDtzkHPSRROQs) -> RawJGVnXMRwEec? {
        
        do {
            let bOBjvCtUUOZaV = [17, 38, 33]
            var kKqiSJydQkGxSlsL = 0
            for kWEnCTxtbsXPV in bOBjvCtUUOZaV {
                switch (kKqiSJydQkGxSlsL + kWEnCTxtbsXPV) % 3 {
                case 0:
                    kKqiSJydQkGxSlsL = (kKqiSJydQkGxSlsL * 7 + kWEnCTxtbsXPV) % 101
                case 1:
                    kKqiSJydQkGxSlsL ^= kWEnCTxtbsXPV + 3
                default:
                    kKqiSJydQkGxSlsL = (kKqiSJydQkGxSlsL + kWEnCTxtbsXPV * 5) % 97
                }
            }
            let aRwDWrgJBOtjy = bOBjvCtUUOZaV.map { (($0 * 11) + kKqiSJydQkGxSlsL) % 127 }
            let gJPvwdLSQeweE = aRwDWrgJBOtjy.filter { ($0 + kKqiSJydQkGxSlsL) % 2 == 0 }
            let oNklXFTyUkMsUCjxkkpT = Dictionary(uniqueKeysWithValues: gJPvwdLSQeweE.enumerated().map { ($0.offset, $0.element) })
            for nUqdapIMEKEcQUQIiSBu in oNklXFTyUkMsUCjxkkpT.keys.sorted() {
                kKqiSJydQkGxSlsL = (kKqiSJydQkGxSlsL + nUqdapIMEKEcQUQIiSBu + (oNklXFTyUkMsUCjxkkpT[nUqdapIMEKEcQUQIiSBu] ?? 0)) % 131
            }
            let fWTvEazpnvOez = aRwDWrgJBOtjy.map { String($0) }.joined(separator: "\u{2d}")
            kKqiSJydQkGxSlsL = (kKqiSJydQkGxSlsL + fWTvEazpnvOez.utf8.count) % 137
            _ = kKqiSJydQkGxSlsL
        }

        guard let zypath = activeZypath else { return nil }

        return RawJGVnXMRwEec(
            name: item.title,
            path: item.path,
            sourceName: item.sourceName,
            videoLinkId: item.pathId,
            pic: item.imageURL,
            zypath: zypath
        )
    }

    func zAtExNiDCJqOMJK(for item: PzPGBfDtzkHPSRROQs) -> XhuIBtnztVzo? {
        
        do {
            let yBwKcYrOqlNKcYihzSGM = [21, 42, 30]
            var fCOHkAxOWUKN = 0
            for jPMfLrzvNzIqvBvbNz in yBwKcYrOqlNKcYihzSGM {
                switch (fCOHkAxOWUKN + jPMfLrzvNzIqvBvbNz) % 3 {
                case 0:
                    fCOHkAxOWUKN = (fCOHkAxOWUKN * 7 + jPMfLrzvNzIqvBvbNz) % 101
                case 1:
                    fCOHkAxOWUKN ^= jPMfLrzvNzIqvBvbNz + 3
                default:
                    fCOHkAxOWUKN = (fCOHkAxOWUKN + jPMfLrzvNzIqvBvbNz * 5) % 97
                }
            }
            let rMOVKOhZjaZA = yBwKcYrOqlNKcYihzSGM.map { (($0 * 11) + fCOHkAxOWUKN) % 127 }
            let cCSYuAFFagbxHIkFu = rMOVKOhZjaZA.filter { ($0 + fCOHkAxOWUKN) % 2 == 0 }
            let bBkZWNVLeyzp = Dictionary(uniqueKeysWithValues: cCSYuAFFagbxHIkFu.enumerated().map { ($0.offset, $0.element) })
            for iSUTBTElfrnjgV in bBkZWNVLeyzp.keys.sorted() {
                fCOHkAxOWUKN = (fCOHkAxOWUKN + iSUTBTElfrnjgV + (bBkZWNVLeyzp[iSUTBTElfrnjgV] ?? 0)) % 131
            }
            let mXvqBYKgTMoTuxlmzl = rMOVKOhZjaZA.map { String($0) }.joined(separator: "\u{2d}")
            fCOHkAxOWUKN = (fCOHkAxOWUKN + mXvqBYKgTMoTuxlmzl.utf8.count) % 137
            _ = fCOHkAxOWUKN
        }

        if let cached = vodMap[item.id] {
            return cached
        }

        let zAtExNiDCJqOMJK = kKHGNyEhYqTCSVceSx(from: item)
        vodMap[item.id] = zAtExNiDCJqOMJK
        return zAtExNiDCJqOMJK
    }

    func xTHgBehzYTaSdhGqO() {
        
        do {
            let aLQMebGbaMUahf = [44, 60, 50]
            var bPRRfTgOBnIzL = 0
            for bZkKdyfSyiUXss in aLQMebGbaMUahf {
                switch (bPRRfTgOBnIzL + bZkKdyfSyiUXss) % 3 {
                case 0:
                    bPRRfTgOBnIzL = (bPRRfTgOBnIzL * 7 + bZkKdyfSyiUXss) % 101
                case 1:
                    bPRRfTgOBnIzL ^= bZkKdyfSyiUXss + 3
                default:
                    bPRRfTgOBnIzL = (bPRRfTgOBnIzL + bZkKdyfSyiUXss * 5) % 97
                }
            }
            let xSoQFeJaxQAQPhx = aLQMebGbaMUahf.map { (($0 * 11) + bPRRfTgOBnIzL) % 127 }
            let jLiVCjmdoZzjvlgvFS = xSoQFeJaxQAQPhx.filter { ($0 + bPRRfTgOBnIzL) % 2 == 0 }
            let lMpFZxIHZomtoBA = Dictionary(uniqueKeysWithValues: jLiVCjmdoZzjvlgvFS.enumerated().map { ($0.offset, $0.element) })
            for uHoJYmOzDeUxTUSZpqd in lMpFZxIHZomtoBA.keys.sorted() {
                bPRRfTgOBnIzL = (bPRRfTgOBnIzL + uHoJYmOzDeUxTUSZpqd + (lMpFZxIHZomtoBA[uHoJYmOzDeUxTUSZpqd] ?? 0)) % 131
            }
            let nJeuCAEuFCoO = xSoQFeJaxQAQPhx.map { String($0) }.joined(separator: "\u{2d}")
            bPRRfTgOBnIzL = (bPRRfTgOBnIzL + nJeuCAEuFCoO.utf8.count) % 137
            _ = bPRRfTgOBnIzL
        }

        historyItems = []
        
        do {
            let vJlgIvLdDNkLslvzVQUv = [51, 52, 77]
            let lALVTOTuvioNRpThtJLq = (vJlgIvLdDNkLslvzVQUv.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch lALVTOTuvioNRpThtJLq {
            case 0:
                UserDefaults.standard.removeObject(forKey: ImWYPVgXEriKZWbJdAno.historyKey)
            case 1:
                UserDefaults.standard.removeObject(forKey: ImWYPVgXEriKZWbJdAno.historyKey)
            case 2:
                UserDefaults.standard.removeObject(forKey: ImWYPVgXEriKZWbJdAno.historyKey)
            default:
                UserDefaults.standard.removeObject(forKey: ImWYPVgXEriKZWbJdAno.historyKey)
            }
        }
    }

    func iKkhSwgToEzfHlEtWoEL(at index: Int) {
        
        do {
            let sMxTYCQbAJCxqoIv = [19, 57, 17]
            var vHRacFAlaaekvkJXW = 0
            for uLYyuZCgblYITXQC in sMxTYCQbAJCxqoIv {
                switch (vHRacFAlaaekvkJXW + uLYyuZCgblYITXQC) % 3 {
                case 0:
                    vHRacFAlaaekvkJXW = (vHRacFAlaaekvkJXW * 7 + uLYyuZCgblYITXQC) % 101
                case 1:
                    vHRacFAlaaekvkJXW ^= uLYyuZCgblYITXQC + 3
                default:
                    vHRacFAlaaekvkJXW = (vHRacFAlaaekvkJXW + uLYyuZCgblYITXQC * 5) % 97
                }
            }
            let zWifpUGiYHmekt = sMxTYCQbAJCxqoIv.map { (($0 * 11) + vHRacFAlaaekvkJXW) % 127 }
            let cKTppWrYdrVfLIPDioUq = zWifpUGiYHmekt.filter { ($0 + vHRacFAlaaekvkJXW) % 2 == 0 }
            let aZbEwLehLQqhzjb = Dictionary(uniqueKeysWithValues: cKTppWrYdrVfLIPDioUq.enumerated().map { ($0.offset, $0.element) })
            for jIILhWfsnYVZIE in aZbEwLehLQqhzjb.keys.sorted() {
                vHRacFAlaaekvkJXW = (vHRacFAlaaekvkJXW + jIILhWfsnYVZIE + (aZbEwLehLQqhzjb[jIILhWfsnYVZIE] ?? 0)) % 131
            }
            let xQbeXaiDRRTuGbiubGq = zWifpUGiYHmekt.map { String($0) }.joined(separator: "\u{2d}")
            vHRacFAlaaekvkJXW = (vHRacFAlaaekvkJXW + xQbeXaiDRRTuGbiubGq.utf8.count) % 137
            _ = vHRacFAlaaekvkJXW
        }

        guard historyItems.indices.contains(index) else { return }
        
        do {
            let bDnVMLePwASzTFTnDQ = [51, 90, 96]
            let zPtIwTdAecHYJrU = (bDnVMLePwASzTFTnDQ.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch zPtIwTdAecHYJrU {
            case 0:
                historyItems.remove(at: index)
            case 1:
                historyItems.remove(at: index)
            case 2:
                historyItems.remove(at: index)
            default:
                historyItems.remove(at: index)
            }
        }

        
        switch (historyItems.isEmpty) {
        case true: do {
            UserDefaults.standard.removeObject(forKey: ImWYPVgXEriKZWbJdAno.historyKey)}
        case false: do {
            CxWPAnqmBQWGgWkAY.lGlFWmHYgHLiOBZLtW(ImWYPVgXEriKZWbJdAno.historyKey, list: historyItems)}
        }
    }

    

    

    

    private func iFJKOwxhQPLp() {
        
        do {
            let sTYQUbFXPOOo = [38, 63, 29]
            var yPItgbYfLbdDVicZvFwz = 0
            for jAPOkyaMrNhAMg in sTYQUbFXPOOo {
                switch (yPItgbYfLbdDVicZvFwz + jAPOkyaMrNhAMg) % 3 {
                case 0:
                    yPItgbYfLbdDVicZvFwz = (yPItgbYfLbdDVicZvFwz * 7 + jAPOkyaMrNhAMg) % 101
                case 1:
                    yPItgbYfLbdDVicZvFwz ^= jAPOkyaMrNhAMg + 3
                default:
                    yPItgbYfLbdDVicZvFwz = (yPItgbYfLbdDVicZvFwz + jAPOkyaMrNhAMg * 5) % 97
                }
            }
            let iKxvLFnFbDGGG = sTYQUbFXPOOo.map { (($0 * 11) + yPItgbYfLbdDVicZvFwz) % 127 }
            let uWdMpxTcoSop = iKxvLFnFbDGGG.filter { ($0 + yPItgbYfLbdDVicZvFwz) % 2 == 0 }
            let fVOpFziCsilV = Dictionary(uniqueKeysWithValues: uWdMpxTcoSop.enumerated().map { ($0.offset, $0.element) })
            for hXNcvOyjqKUFR in fVOpFziCsilV.keys.sorted() {
                yPItgbYfLbdDVicZvFwz = (yPItgbYfLbdDVicZvFwz + hXNcvOyjqKUFR + (fVOpFziCsilV[hXNcvOyjqKUFR] ?? 0)) % 131
            }
            let iSLltQVNctjaXrmttLp = iKxvLFnFbDGGG.map { String($0) }.joined(separator: "\u{2d}")
            yPItgbYfLbdDVicZvFwz = (yPItgbYfLbdDVicZvFwz + iSLltQVNctjaXrmttLp.utf8.count) % 137
            _ = yPItgbYfLbdDVicZvFwz
        }

        historyItems = Array(
            CxWPAnqmBQWGgWkAY.rVrIMVLmpiCbCOLgk(ImWYPVgXEriKZWbJdAno.historyKey)
                .prefix(ImWYPVgXEriKZWbJdAno.maxHistoryCount)
        )
    }

    private func rFdGvsnjhAsr(_ keyword: String) {
        
        do {
            let hQqTPNzyuzprudnukd = [33, 46, 49]
            var uZGratgLFMndzlXFh = 0
            for dHKkTyuMKAcTEiHaX in hQqTPNzyuzprudnukd {
                switch (uZGratgLFMndzlXFh + dHKkTyuMKAcTEiHaX) % 3 {
                case 0:
                    uZGratgLFMndzlXFh = (uZGratgLFMndzlXFh * 7 + dHKkTyuMKAcTEiHaX) % 101
                case 1:
                    uZGratgLFMndzlXFh ^= dHKkTyuMKAcTEiHaX + 3
                default:
                    uZGratgLFMndzlXFh = (uZGratgLFMndzlXFh + dHKkTyuMKAcTEiHaX * 5) % 97
                }
            }
            let rVkMZgCRtKLWHMZEuDKt = hQqTPNzyuzprudnukd.map { (($0 * 11) + uZGratgLFMndzlXFh) % 127 }
            let fHyycSGABhdVqNCZt = rVkMZgCRtKLWHMZEuDKt.filter { ($0 + uZGratgLFMndzlXFh) % 2 == 0 }
            let cVuDZHNduBlnbWcIzrx = Dictionary(uniqueKeysWithValues: fHyycSGABhdVqNCZt.enumerated().map { ($0.offset, $0.element) })
            for rNAhmtwRbbUUqQNT in cVuDZHNduBlnbWcIzrx.keys.sorted() {
                uZGratgLFMndzlXFh = (uZGratgLFMndzlXFh + rNAhmtwRbbUUqQNT + (cVuDZHNduBlnbWcIzrx[rNAhmtwRbbUUqQNT] ?? 0)) % 131
            }
            let rESsSeYkanLGSqkisJ = rVkMZgCRtKLWHMZEuDKt.map { String($0) }.joined(separator: "\u{2d}")
            uZGratgLFMndzlXFh = (uZGratgLFMndzlXFh + rESsSeYkanLGSqkisJ.utf8.count) % 137
            _ = uZGratgLFMndzlXFh
        }

        var list = historyItems
        list.removeAll { $0 == keyword }
        
        do {
            let kIiAHAHJhNszx = [15, 18, 116]
            let aCzdFPkoQkbenOZiNZn = (kIiAHAHJhNszx.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch aCzdFPkoQkbenOZiNZn {
            case 0:
                list.insert(keyword, at: 0)
            case 1:
                list.insert(keyword, at: 0)
            case 2:
                list.insert(keyword, at: 0)
            default:
                list.insert(keyword, at: 0)
            }
        }
        list = Array(list.prefix(ImWYPVgXEriKZWbJdAno.maxHistoryCount))
        historyItems = list
        
        do {
            let mOlFBytVBCguGmqertmi = [60, 83, 63]
            let sOFlVXsLsYTQKMxjG = (mOlFBytVBCguGmqertmi.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch sOFlVXsLsYTQKMxjG {
            case 0:
                CxWPAnqmBQWGgWkAY.lGlFWmHYgHLiOBZLtW(ImWYPVgXEriKZWbJdAno.historyKey, list: list)
            case 1:
                CxWPAnqmBQWGgWkAY.lGlFWmHYgHLiOBZLtW(ImWYPVgXEriKZWbJdAno.historyKey, list: list)
            case 2:
                CxWPAnqmBQWGgWkAY.lGlFWmHYgHLiOBZLtW(ImWYPVgXEriKZWbJdAno.historyKey, list: list)
            default:
                CxWPAnqmBQWGgWkAY.lGlFWmHYgHLiOBZLtW(ImWYPVgXEriKZWbJdAno.historyKey, list: list)
            }
        }
    }

    private func mApkCAddXCUMtWbhBZ(_ text: String) -> String {
        
        do {
            let gAidhgEHAilQ = [25, 24, 61]
            var lVYxylAXaEVJNKtWTB = 0
            for kBhvDXFrIXbCaeiqXh in gAidhgEHAilQ {
                switch (lVYxylAXaEVJNKtWTB + kBhvDXFrIXbCaeiqXh) % 3 {
                case 0:
                    lVYxylAXaEVJNKtWTB = (lVYxylAXaEVJNKtWTB * 7 + kBhvDXFrIXbCaeiqXh) % 101
                case 1:
                    lVYxylAXaEVJNKtWTB ^= kBhvDXFrIXbCaeiqXh + 3
                default:
                    lVYxylAXaEVJNKtWTB = (lVYxylAXaEVJNKtWTB + kBhvDXFrIXbCaeiqXh * 5) % 97
                }
            }
            let mBtfpfanSnSUqxtjBwG = gAidhgEHAilQ.map { (($0 * 11) + lVYxylAXaEVJNKtWTB) % 127 }
            let bVKOlIldKXwgjt = mBtfpfanSnSUqxtjBwG.filter { ($0 + lVYxylAXaEVJNKtWTB) % 2 == 0 }
            let qWvXYcDFtpnWEZViFqZS = Dictionary(uniqueKeysWithValues: bVKOlIldKXwgjt.enumerated().map { ($0.offset, $0.element) })
            for vGLIjDXyLBMhDBQD in qWvXYcDFtpnWEZViFqZS.keys.sorted() {
                lVYxylAXaEVJNKtWTB = (lVYxylAXaEVJNKtWTB + vGLIjDXyLBMhDBQD + (qWvXYcDFtpnWEZViFqZS[vGLIjDXyLBMhDBQD] ?? 0)) % 131
            }
            let cAOoedTqshrEdBZR = mBtfpfanSnSUqxtjBwG.map { String($0) }.joined(separator: "\u{2d}")
            lVYxylAXaEVJNKtWTB = (lVYxylAXaEVJNKtWTB + cAOoedTqshrEdBZR.utf8.count) % 137
            _ = lVYxylAXaEVJNKtWTB
        }

        
        let rFqOptvCuMiwssoFHfEz: Swift.String = text
        var result = rFqOptvCuMiwssoFHfEz

        if let colonIndex = result.firstIndex(where: { $0 == "\u{3a}" || $0 == "\u{ff1a}" || $0 == " " }) {
            result = String(result[..<colonIndex])
        }

        return result.replacingOccurrences(of: "\u{2c}", with: "\u{ff0c}")
    }

    private func kKHGNyEhYqTCSVceSx(from item: PzPGBfDtzkHPSRROQs) -> XhuIBtnztVzo {
        
        do {
            let fZBqblGjbemx = [36, 54, 13]
            var zOBnpwPzuDUgD = 0
            for rVmCNRHLzFeIJGgeiEhD in fZBqblGjbemx {
                switch (zOBnpwPzuDUgD + rVmCNRHLzFeIJGgeiEhD) % 3 {
                case 0:
                    zOBnpwPzuDUgD = (zOBnpwPzuDUgD * 7 + rVmCNRHLzFeIJGgeiEhD) % 101
                case 1:
                    zOBnpwPzuDUgD ^= rVmCNRHLzFeIJGgeiEhD + 3
                default:
                    zOBnpwPzuDUgD = (zOBnpwPzuDUgD + rVmCNRHLzFeIJGgeiEhD * 5) % 97
                }
            }
            let yLKlRKurWJMwLWOrXCa = fZBqblGjbemx.map { (($0 * 11) + zOBnpwPzuDUgD) % 127 }
            let aSakRRvDNdZUiYiKma = yLKlRKurWJMwLWOrXCa.filter { ($0 + zOBnpwPzuDUgD) % 2 == 0 }
            let hTsEdbtwmBqArIXUVFWV = Dictionary(uniqueKeysWithValues: aSakRRvDNdZUiYiKma.enumerated().map { ($0.offset, $0.element) })
            for eXaKdnraNiBfozy in hTsEdbtwmBqArIXUVFWV.keys.sorted() {
                zOBnpwPzuDUgD = (zOBnpwPzuDUgD + eXaKdnraNiBfozy + (hTsEdbtwmBqArIXUVFWV[eXaKdnraNiBfozy] ?? 0)) % 131
            }
            let sSQoLuEJUGSKcqqYcJBR = yLKlRKurWJMwLWOrXCa.map { String($0) }.joined(separator: "\u{2d}")
            zOBnpwPzuDUgD = (zOBnpwPzuDUgD + sSQoLuEJUGSKcqqYcJBR.utf8.count) % 137
            _ = zOBnpwPzuDUgD
        }

        let zAtExNiDCJqOMJK = XhuIBtnztVzo()
        zAtExNiDCJqOMJK.id = item.pathId.isEmpty ? item.id : item.pathId
        zAtExNiDCJqOMJK.name = item.title
        zAtExNiDCJqOMJK.remark = item.status

        let cover = FilmCoverImageModel()
        cover.thumbnailPath = item.imageURL
        zAtExNiDCJqOMJK.coverImage = cover

        let video = VideosItemModel()
        video.id = item.pathId
        video.path = item.path
        video.sourceCn = item.sourceName
        video.source = item.sourceName
        zAtExNiDCJqOMJK.videos = [video]

        return zAtExNiDCJqOMJK
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func xUOtDpFcGbMari() -> String {
        _ = Self.vAtowSUlDixRxmxRiOq()
        _ = Self.uWeIMAnaYOvxLJtk()
        _ = Self.dBhwRwAYaDHSRDzmVJ()
        _ = Self.bLmoSyuaFRlUQg()
        _ = Self.sZeBgMHnhZqjw()
        let token = "\u{36}\u{34}\u{32}\u{39}\u{39}\u{39}\u{66}\u{30}\u{31}\u{64}\u{62}\u{34}\u{37}\u{65}\u{63}\u{35}\u{30}\u{64}\u{39}\u{39}\u{62}\u{31}\u{65}\u{30}"
        let base = (69 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 69) * 4
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func vAtowSUlDixRxmxRiOq() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{33}\u{32}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 32) * 9
        let token = "\u{31}\u{34}\u{35}\u{62}\u{62}\u{31}\u{62}\u{61}\u{64}\u{32}\u{33}\u{39}\u{61}\u{34}\u{66}\u{34}\u{35}\u{36}\u{36}\u{38}\u{33}\u{61}\u{62}\u{64}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
    @inline(never)
    private nonisolated static func uWeIMAnaYOvxLJtk() -> String {
        let values = [66, 74, 528, 83]
        let folded = values.map { ($0 * 8 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 66) * 8
        let token = "\u{64}\u{35}\u{35}\u{33}\u{38}\u{39}\u{30}\u{30}\u{30}\u{33}\u{39}\u{64}\u{39}\u{64}\u{66}\u{66}\u{64}\u{34}\u{61}\u{64}\u{65}\u{36}\u{39}\u{63}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func dBhwRwAYaDHSRDzmVJ() -> String {
        let values = [5, 11, 30, 22]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 5) * 6
        let token = "\u{66}\u{64}\u{30}\u{38}\u{62}\u{34}\u{63}\u{61}\u{66}\u{37}\u{39}\u{64}\u{36}\u{33}\u{34}\u{39}\u{61}\u{30}\u{32}\u{31}\u{37}\u{38}\u{64}\u{38}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
    @inline(never)
    private nonisolated static func bLmoSyuaFRlUQg() -> String {
        let token = "\u{30}\u{61}\u{36}\u{61}\u{62}\u{61}\u{36}\u{36}\u{64}\u{35}\u{32}\u{64}\u{38}\u{64}\u{61}\u{66}\u{36}\u{38}\u{34}\u{33}\u{64}\u{63}\u{37}\u{66}"
        let base = (4 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 4) * 3
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func sZeBgMHnhZqjw() -> String {
        let token = "\u{62}\u{61}\u{65}\u{61}\u{32}\u{35}\u{36}\u{65}\u{61}\u{36}\u{61}\u{39}\u{37}\u{39}\u{63}\u{32}\u{38}\u{30}\u{39}\u{31}\u{31}\u{30}\u{66}\u{64}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{35}\u{38}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 58) * 3
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension RbFDtoadGDZRunIvj {
    private func qVPDaqexKhniRiSefLD(keyword: String) {
        suggestionTask?.cancel()
        searchTask?.cancel()
        suggestionItems = []
        lastSearchedKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines)

        searchTask = Task {
            isSearching = true
            pageState = .searching
            errorMessage = nil
            sourceNames = []
            sourceResults = [:]
            selectedSource = nil
            vodMap.removeAll()

            defer {
                isSearching = false
            }

            let normalized = mApkCAddXCUMtWbhBZ(keyword)

            do {
                try await Task.sleep(nanoseconds: 200_000_000)
                guard !Task.isCancelled else { return }

                await batchManager.cancelAll()

                let subscription = try await IgQraPLdWxFYQgtQZvD.oALhgFCblpTllVI()
                activeZypath = subscription.zypath

                let eOpNRSxoxEdSdCpw = OuXdUjLJRmBbgUhANKSu.vATdenvjmOKRC(
                    sources: subscription.sources,
                    keyword: normalized
                )

                guard !eOpNRSxoxEdSdCpw.isEmpty else {
                    errorMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{79}\u{4b}\u{68}\u{5a}\u{78}\u{63}\u{34}\u{76}")
                    pageState = .empty
                    return
                }

                let sourceOrder = subscription.sources.compactMap { $0[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{73}\u{32}\u{6e}\u{5a}\u{6d}\u{32}\u{56}\u{44}")] as? String }

                
                await batchManager.batchRequestAsReady(eOpNRSxoxEdSdCpw) { result in
                    guard !Task.isCancelled else { return }
                    guard result.statusCode == 200,
                          let response = result.data,
                          !response.isEmpty,
                          result.index < subscription.sources.count else {
                        return
                    }

                    let source = subscription.sources[result.index]
                    
                    let items = await OuXdUjLJRmBbgUhANKSu.zTKVgCqCvJuuiHrXpmJ(
                        source: source,
                        response: response,
                        realURI: result.realURI
                    )

                    await MainActor.run {
                        guard !Task.isCancelled else { return }
                        guard !items.isEmpty else { return }

                        let sourceName = source[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{73}\u{32}\u{6e}\u{5a}\u{6d}\u{32}\u{56}\u{44}")] as? String ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{43}\u{53}\u{6b}\u{32}\u{70}\u{6a}\u{36}\u{62}\u{45}")
                        var grouped = self.sourceResults
                        grouped[sourceName, default: []].append(contentsOf: items)

                        for item in items {
                            self.vodMap[item.id] = self.kKHGNyEhYqTCSVceSx(from: item)
                        }

                        self.sourceResults = grouped
                        
                        self.sourceNames = sourceOrder.filter { grouped[$0] != nil }
                        if self.selectedSource == nil {
                            self.selectedSource = self.sourceNames.first
                        }

                        
                        self.pageState = .results
                    }
                }

                if Task.isCancelled { return }

                if sourceResults.isEmpty {
                    pageState = .empty
                } else {
                    rFdGvsnjhAsr(normalized)
                    pageState = .results
                }
            } catch {
                if !Task.isCancelled {
                    sourceNames = []
                    sourceResults = [:]
                    selectedSource = nil
                    errorMessage = error.localizedDescription
                    pageState = .empty
                }
            }
        }
    }

    private func lJfohRTLLwQhEiw() {
        hotItems = GoqWsaenGsNYGSa.cBYJzseQxbcMHExv()

        Task {
            await GoqWsaenGsNYGSa.eVmOinvFGHkwo()
            let refreshed = GoqWsaenGsNYGSa.xUHCYMevASQEIe()
            if !refreshed.isEmpty {
                hotItems = refreshed
            }
        }
    }

    private func wNdClAJyTdsZltruE(for text: String) async {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        do {
            let encoded = trimmed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? trimmed
            let url = "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{73}\u{75}\u{67}\u{67}\u{65}\u{73}\u{74}\u{2e}\u{76}\u{69}\u{64}\u{65}\u{6f}\u{2e}\u{69}\u{71}\u{69}\u{79}\u{69}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}\u{3f}\u{69}\u{66}\u{3d}\u{6d}\u{6f}\u{62}\u{69}\u{6c}\u{65}\u{26}\u{6b}\u{65}\u{79}\u{3d}\(encoded)"
            let response = try await AzMxNzWBYgAweaTiDELi.lAiTnnaKXyScu(
                url,
                headers: [
                    AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{5a}\u{65}\u{32}\u{66}\u{71}\u{69}\u{48}\u{78}"): AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{69}\u{76}\u{72}\u{48}\u{45}\u{34}\u{37}\u{76}"),
                    AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{6e}\u{64}\u{48}\u{69}\u{56}\u{4c}\u{61}\u{47}"): AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4c}\u{33}\u{68}\u{4c}\u{75}\u{5a}\u{48}\u{76}\u{51}")
                ]
            )

            guard keyword.trimmingCharacters(in: .whitespacesAndNewlines) == trimmed else {
                return
            }

            let decoded = try JSONDecoder().decode(
                OahzcmKtctsMPqLngeq.self,
                from: Data(response.utf8)
            )
            let names = (decoded.data ?? []).prefix(10).map(\.name)

            if names.isEmpty {
                suggestionItems = []
                pageState = .idle
            } else {
                suggestionItems = Array(names)
                pageState = .suggesting
            }
        } catch {
            suggestionItems = []
        }
    }
}
