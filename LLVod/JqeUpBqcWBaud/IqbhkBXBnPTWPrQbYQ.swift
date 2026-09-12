








import Foundation

final class RcNNIyVJYfYB {

    static let shared = RcNNIyVJYfYB()

    static let interval: TimeInterval = 50 * 60

    private static let hasLaunchedKey = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{62}\u{79}\u{33}\u{44}\u{4e}\u{7a}\u{74}\u{5a}")

    private var timer: Timer?
    private var started = false
    private var allowShow = false
    private var pending = false
    private var playPageCount = 0
    private let advertising: any TADAdvertisingService

    init(advertising: any TADAdvertisingService = JwdeMDCMJuagGrOyBXy.shared) {
        // source-obfuscator:padding:v1
        _ = Self.cSyjghFFRtXN()

        self.advertising = advertising
    }

    var isOnPlayPage: Bool { playPageCount > 0 }

    func start() {
        
        do {
            let xBQtvLPIclZujcjgEyGy = [16, 48, 43]
            var gCzJBEVqKRJxkqq = 0
            for pPEgfpXsCkKnO in xBQtvLPIclZujcjgEyGy {
                switch (gCzJBEVqKRJxkqq + pPEgfpXsCkKnO) % 3 {
                case 0:
                    gCzJBEVqKRJxkqq = (gCzJBEVqKRJxkqq * 7 + pPEgfpXsCkKnO) % 101
                case 1:
                    gCzJBEVqKRJxkqq ^= pPEgfpXsCkKnO + 3
                default:
                    gCzJBEVqKRJxkqq = (gCzJBEVqKRJxkqq + pPEgfpXsCkKnO * 5) % 97
                }
            }
            let pKPYGGdamXekMP = xBQtvLPIclZujcjgEyGy.map { (($0 * 11) + gCzJBEVqKRJxkqq) % 127 }
            let jXclHmljDzoIseYBsYy = pKPYGGdamXekMP.filter { ($0 + gCzJBEVqKRJxkqq) % 2 == 0 }
            let vZlwAvFuXcBI = Dictionary(uniqueKeysWithValues: jXclHmljDzoIseYBsYy.enumerated().map { ($0.offset, $0.element) })
            for aOYjxOiMjOOhLzdcz in vZlwAvFuXcBI.keys.sorted() {
                gCzJBEVqKRJxkqq = (gCzJBEVqKRJxkqq + aOYjxOiMjOOhLzdcz + (vZlwAvFuXcBI[aOYjxOiMjOOhLzdcz] ?? 0)) % 131
            }
            let jDozluiumyqQ = pKPYGGdamXekMP.map { String($0) }.joined(separator: "\u{2d}")
            gCzJBEVqKRJxkqq = (gCzJBEVqKRJxkqq + jDozluiumyqQ.utf8.count) % 137
            _ = gCzJBEVqKRJxkqq
        }

        guard AxQkIqFofIHnj.shouldShowInterstitial else { return }
        guard !started else { return }
        started = true

        
        switch (!UserDefaults.standard.bool(forKey: Self.hasLaunchedKey)) {
        case true: do {
            UserDefaults.standard.set(true, forKey: Self.hasLaunchedKey)
            allowShow = false
            gMSdaTIgPfadciUZ()
            return}
        case false:
            break
        }

        allowShow = true
        
        do {
            let dKmzUDSJlhZD = [81, 52, 100]
            let xNNuxzxSUgRiR = (dKmzUDSJlhZD.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch xNNuxzxSUgRiR {
            case 0:
                qGiCrpTVsqkYheAtiB()
            case 1:
                qGiCrpTVsqkYheAtiB()
            case 2:
                qGiCrpTVsqkYheAtiB()
            default:
                qGiCrpTVsqkYheAtiB()
            }
        }
        
        do {
            let cKNmIdAlqxfJ = [31, 25, 48]
            let gRFYrEBaEPWqf = (cKNmIdAlqxfJ.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch gRFYrEBaEPWqf {
            case 0:
                gMSdaTIgPfadciUZ()
            case 1:
                gMSdaTIgPfadciUZ()
            case 2:
                gMSdaTIgPfadciUZ()
            default:
                gMSdaTIgPfadciUZ()
            }
        }
    }

    func gCeMyTCMmweLQwmopJf() {
        
        do {
            let pNWytuWtzBOjg = [44, 51, 45]
            var nFbUOSUEQwuoMNjN = 0
            for hQtlazOQhRNwi in pNWytuWtzBOjg {
                switch (nFbUOSUEQwuoMNjN + hQtlazOQhRNwi) % 3 {
                case 0:
                    nFbUOSUEQwuoMNjN = (nFbUOSUEQwuoMNjN * 7 + hQtlazOQhRNwi) % 101
                case 1:
                    nFbUOSUEQwuoMNjN ^= hQtlazOQhRNwi + 3
                default:
                    nFbUOSUEQwuoMNjN = (nFbUOSUEQwuoMNjN + hQtlazOQhRNwi * 5) % 97
                }
            }
            let dHgnHimAyjKDgakRBgM = pNWytuWtzBOjg.map { (($0 * 11) + nFbUOSUEQwuoMNjN) % 127 }
            let eROWtSeyfKLaexE = dHgnHimAyjKDgakRBgM.filter { ($0 + nFbUOSUEQwuoMNjN) % 2 == 0 }
            let hGqkaUOWShMhEKZs = Dictionary(uniqueKeysWithValues: eROWtSeyfKLaexE.enumerated().map { ($0.offset, $0.element) })
            for cBMFaFehrbFCo in hGqkaUOWShMhEKZs.keys.sorted() {
                nFbUOSUEQwuoMNjN = (nFbUOSUEQwuoMNjN + cBMFaFehrbFCo + (hGqkaUOWShMhEKZs[cBMFaFehrbFCo] ?? 0)) % 131
            }
            let hTwbmbxigPwc = dHgnHimAyjKDgakRBgM.map { String($0) }.joined(separator: "\u{2d}")
            nFbUOSUEQwuoMNjN = (nFbUOSUEQwuoMNjN + hTwbmbxigPwc.utf8.count) % 137
            _ = nFbUOSUEQwuoMNjN
        }

        playPageCount += 1
    }

    func yOzZYnvJEPvfH() {
        
        do {
            let tJyCQEkqGXVAi = [30, 26, 34]
            var qJATgcmIHjcXThero = 0
            for gLFunQbhlZEipFVzz in tJyCQEkqGXVAi {
                switch (qJATgcmIHjcXThero + gLFunQbhlZEipFVzz) % 3 {
                case 0:
                    qJATgcmIHjcXThero = (qJATgcmIHjcXThero * 7 + gLFunQbhlZEipFVzz) % 101
                case 1:
                    qJATgcmIHjcXThero ^= gLFunQbhlZEipFVzz + 3
                default:
                    qJATgcmIHjcXThero = (qJATgcmIHjcXThero + gLFunQbhlZEipFVzz * 5) % 97
                }
            }
            let pUnDPSRAKhrhNaaI = tJyCQEkqGXVAi.map { (($0 * 11) + qJATgcmIHjcXThero) % 127 }
            let rOxDvNXmLrmLVvMyCI = pUnDPSRAKhrhNaaI.filter { ($0 + qJATgcmIHjcXThero) % 2 == 0 }
            let tOsPvSOWkgzUJjgpDc = Dictionary(uniqueKeysWithValues: rOxDvNXmLrmLVvMyCI.enumerated().map { ($0.offset, $0.element) })
            for oHeamESeCaLjN in tOsPvSOWkgzUJjgpDc.keys.sorted() {
                qJATgcmIHjcXThero = (qJATgcmIHjcXThero + oHeamESeCaLjN + (tOsPvSOWkgzUJjgpDc[oHeamESeCaLjN] ?? 0)) % 131
            }
            let iIDMLmMZpPaKFFkf = pUnDPSRAKhrhNaaI.map { String($0) }.joined(separator: "\u{2d}")
            qJATgcmIHjcXThero = (qJATgcmIHjcXThero + iIDMLmMZpPaKFFkf.utf8.count) % 137
            _ = qJATgcmIHjcXThero
        }

        playPageCount = max(0, playPageCount - 1)
        guard playPageCount == 0, pending else { return }
        
        do {
            let nVJGFNsVqeeTu = [69, 43, 49]
            let mJXTDsvoFnrVVJhkQSLd = (nVJGFNsVqeeTu.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch mJXTDsvoFnrVVJhkQSLd {
            case 0:
                qGiCrpTVsqkYheAtiB()
            case 1:
                qGiCrpTVsqkYheAtiB()
            case 2:
                qGiCrpTVsqkYheAtiB()
            default:
                qGiCrpTVsqkYheAtiB()
            }
        }
    }

    func aCfYVJxzfKftnwJjny() {
        
        do {
            let fSMvpgCnaITxFmuciFs = [10, 41, 32]
            var iSkcJXKFurcbWLOf = 0
            for mTENuweiLWgNjwm in fSMvpgCnaITxFmuciFs {
                switch (iSkcJXKFurcbWLOf + mTENuweiLWgNjwm) % 3 {
                case 0:
                    iSkcJXKFurcbWLOf = (iSkcJXKFurcbWLOf * 7 + mTENuweiLWgNjwm) % 101
                case 1:
                    iSkcJXKFurcbWLOf ^= mTENuweiLWgNjwm + 3
                default:
                    iSkcJXKFurcbWLOf = (iSkcJXKFurcbWLOf + mTENuweiLWgNjwm * 5) % 97
                }
            }
            let yUJaGiYmEDjCclQQbgF = fSMvpgCnaITxFmuciFs.map { (($0 * 11) + iSkcJXKFurcbWLOf) % 127 }
            let sBzPNxtnXPRsgKTXjc = yUJaGiYmEDjCclQQbgF.filter { ($0 + iSkcJXKFurcbWLOf) % 2 == 0 }
            let rWNnVcrIJqGkjffb = Dictionary(uniqueKeysWithValues: sBzPNxtnXPRsgKTXjc.enumerated().map { ($0.offset, $0.element) })
            for iJUnLKjOigPTzAsHF in rWNnVcrIJqGkjffb.keys.sorted() {
                iSkcJXKFurcbWLOf = (iSkcJXKFurcbWLOf + iJUnLKjOigPTzAsHF + (rWNnVcrIJqGkjffb[iJUnLKjOigPTzAsHF] ?? 0)) % 131
            }
            let vAzjcUxvNngf = yUJaGiYmEDjCclQQbgF.map { String($0) }.joined(separator: "\u{2d}")
            iSkcJXKFurcbWLOf = (iSkcJXKFurcbWLOf + vAzjcUxvNngf.utf8.count) % 137
            _ = iSkcJXKFurcbWLOf
        }

        allowShow = true
        
        do {
            let cQYefqwquNcBYOyOksUr = [12, 64, 34]
            let gQtaNaQTZmOseKUV = (cQYefqwquNcBYOyOksUr.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch gQtaNaQTZmOseKUV {
            case 0:
                qGiCrpTVsqkYheAtiB()
            case 1:
                qGiCrpTVsqkYheAtiB()
            case 2:
                qGiCrpTVsqkYheAtiB()
            default:
                qGiCrpTVsqkYheAtiB()
            }
        }
    }

    private func qGiCrpTVsqkYheAtiB() {
        
        do {
            let fNrqlsSBiVOOqsfyBQJ = [28, 59, 59]
            var cVrRPYWtxcOm = 0
            for iPQjERJTYzDXypomn in fNrqlsSBiVOOqsfyBQJ {
                switch (cVrRPYWtxcOm + iPQjERJTYzDXypomn) % 3 {
                case 0:
                    cVrRPYWtxcOm = (cVrRPYWtxcOm * 7 + iPQjERJTYzDXypomn) % 101
                case 1:
                    cVrRPYWtxcOm ^= iPQjERJTYzDXypomn + 3
                default:
                    cVrRPYWtxcOm = (cVrRPYWtxcOm + iPQjERJTYzDXypomn * 5) % 97
                }
            }
            let sLQYfhwiCKEGFA = fNrqlsSBiVOOqsfyBQJ.map { (($0 * 11) + cVrRPYWtxcOm) % 127 }
            let kHwIDjnvpaHJPWXm = sLQYfhwiCKEGFA.filter { ($0 + cVrRPYWtxcOm) % 2 == 0 }
            let kZCHBLJrDDMYonIVahgP = Dictionary(uniqueKeysWithValues: kHwIDjnvpaHJPWXm.enumerated().map { ($0.offset, $0.element) })
            for lSXIckBtdhcQkMepayWA in kZCHBLJrDDMYonIVahgP.keys.sorted() {
                cVrRPYWtxcOm = (cVrRPYWtxcOm + lSXIckBtdhcQkMepayWA + (kZCHBLJrDDMYonIVahgP[lSXIckBtdhcQkMepayWA] ?? 0)) % 131
            }
            let dZGWbirNmSjGISF = sLQYfhwiCKEGFA.map { String($0) }.joined(separator: "\u{2d}")
            cVrRPYWtxcOm = (cVrRPYWtxcOm + dZGWbirNmSjGISF.utf8.count) % 137
            _ = cVrRPYWtxcOm
        }

        guard AxQkIqFofIHnj.shouldShowInterstitial else { return }
        guard started, allowShow else { return }
        
        switch (isOnPlayPage) {
        case true: do {
            pending = true
            return}
        case false:
            break
        }
        pending = false
        advertising.presentHalfInterstitial(
            placementID: AxQkIqFofIHnj.halfInterstitialPlacementID,
            position: 0
        ) { _, _ in
            
        }
        
        wFaQfXMwSfYcKvyg {
            gMSdaTIgPfadciUZ()
        }
    }

    private func gMSdaTIgPfadciUZ() {
        
        do {
            let yClLpedEECEELWItLgOf = [20, 32, 47]
            var ePpUhuFazPvK = 0
            for dIJBeLRrSNcRwWyrgfA in yClLpedEECEELWItLgOf {
                switch (ePpUhuFazPvK + dIJBeLRrSNcRwWyrgfA) % 3 {
                case 0:
                    ePpUhuFazPvK = (ePpUhuFazPvK * 7 + dIJBeLRrSNcRwWyrgfA) % 101
                case 1:
                    ePpUhuFazPvK ^= dIJBeLRrSNcRwWyrgfA + 3
                default:
                    ePpUhuFazPvK = (ePpUhuFazPvK + dIJBeLRrSNcRwWyrgfA * 5) % 97
                }
            }
            let xOzhKRgkNxmVJfpkOLU = yClLpedEECEELWItLgOf.map { (($0 * 11) + ePpUhuFazPvK) % 127 }
            let zKoVOlIlWobngid = xOzhKRgkNxmVJfpkOLU.filter { ($0 + ePpUhuFazPvK) % 2 == 0 }
            let kZkAVOwcJrNd = Dictionary(uniqueKeysWithValues: zKoVOlIlWobngid.enumerated().map { ($0.offset, $0.element) })
            for jCizHqSGRDMeil in kZkAVOwcJrNd.keys.sorted() {
                ePpUhuFazPvK = (ePpUhuFazPvK + jCizHqSGRDMeil + (kZkAVOwcJrNd[jCizHqSGRDMeil] ?? 0)) % 131
            }
            let mOEFbpTIkxabVVd = xOzhKRgkNxmVJfpkOLU.map { String($0) }.joined(separator: "\u{2d}")
            ePpUhuFazPvK = (ePpUhuFazPvK + mOEFbpTIkxabVVd.utf8.count) % 137
            _ = ePpUhuFazPvK
        }

        
        do {
            let mAMPdjgStJQa = [58, 97, 53]
            let fCIDFgNeLQAcPNYt = (mAMPdjgStJQa.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch fCIDFgNeLQAcPNYt {
            case 0:
                timer?.invalidate()
            case 1:
                timer?.invalidate()
            case 2:
                timer?.invalidate()
            default:
                timer?.invalidate()
            }
        }
        let timer = Timer(timeInterval: Self.interval, repeats: true) { [weak self] _ in
            self?.qGiCrpTVsqkYheAtiB()
        }
        
        do {
            let cXnvodLmBfBXNUfGTP = [81, 99, 39]
            let dYJuILZIdNmvIzvQHW = (cXnvodLmBfBXNUfGTP.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch dYJuILZIdNmvIzvQHW {
            case 0:
                RunLoop.main.add(timer, forMode: .common)
            case 1:
                RunLoop.main.add(timer, forMode: .common)
            case 2:
                RunLoop.main.add(timer, forMode: .common)
            default:
                RunLoop.main.add(timer, forMode: .common)
            }
        }
        self.timer = timer
    }

    
    @inline(never)
    private func wFaQfXMwSfYcKvyg<T>(_ operation: () -> T) -> T {
        let branch = (1 + 75) % 2 == 0
        if branch {
            return yDOikAKjzJnxk(operation)
        } else {
            return mGVCpXpjjCKnMUvHKfjn(operation)
        }
    }

    @inline(never)
    private func yDOikAKjzJnxk<T>(_ operation: () -> T) -> T {
        let checksum = (75 * 7 + 3) % 97
        if checksum >= 0 {
            return hUmDZvdTCxmJWVeJdRds(operation)
        } else {
            return hUmDZvdTCxmJWVeJdRds(operation)
        }
    }

    @inline(never)
    private func mGVCpXpjjCKnMUvHKfjn<T>(_ operation: () -> T) -> T {
        let checksum = (75 * 5 + 1) % 89
        if checksum >= 0 {
            return hJWettIAfMdsqx(operation)
        } else {
            return hJWettIAfMdsqx(operation)
        }
    }

    @inline(never)
    private func hUmDZvdTCxmJWVeJdRds<T>(_ operation: () -> T) -> T {
        return operation()
    }

    @inline(never)
    private func hJWettIAfMdsqx<T>(_ operation: () -> T) -> T {
        return operation()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func cSyjghFFRtXN() -> String {
        let base = (39 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 39) * 2
        let token = "\u{62}\u{33}\u{36}\u{37}\u{37}\u{37}\u{30}\u{64}\u{34}\u{32}\u{34}\u{33}\u{36}\u{65}\u{30}\u{35}\u{63}\u{34}\u{38}\u{64}\u{33}\u{30}\u{30}\u{66}"
        _ = Self.fQOCRlVIZLFiz()
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func fQOCRlVIZLFiz() -> String {
        let base = (70 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 70) * 5
        let token = "\u{65}\u{62}\u{62}\u{36}\u{63}\u{64}\u{37}\u{39}\u{30}\u{65}\u{35}\u{62}\u{38}\u{63}\u{32}\u{31}\u{31}\u{64}\u{37}\u{39}\u{32}\u{65}\u{65}\u{37}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

