






import Foundation
import AnyThinkSDK

class NepFemLVtyAveDwJi: UIView, ATAdLoadingDelegate, ATRewardedVideoDelegate {
  
    
    
    private var retryAttempt: Int = 0
    private var rewardedId: String!
    private var transId: String = ""
    var jMviUkSCdCGS:((_ type: BndqBgFZaslilqbS, _ transId: String, _ placementId: String)->Void)?
    
    func jQzSywpUSCPKVaF(adId: String) {
        // source-obfuscator:padding:v1
        _ = Self.tCHQKrfAFABzfk()

        
        do {
            let qVQLhGPHCcJPFpjdXWT = [41, 24, 16]
            var iVurybAGIPFTQlhEZxTC = 0
            for rWhHsscjGQIQlgjeLuL in qVQLhGPHCcJPFpjdXWT {
                switch (iVurybAGIPFTQlhEZxTC + rWhHsscjGQIQlgjeLuL) % 3 {
                case 0:
                    iVurybAGIPFTQlhEZxTC = (iVurybAGIPFTQlhEZxTC * 7 + rWhHsscjGQIQlgjeLuL) % 101
                case 1:
                    iVurybAGIPFTQlhEZxTC ^= rWhHsscjGQIQlgjeLuL + 3
                default:
                    iVurybAGIPFTQlhEZxTC = (iVurybAGIPFTQlhEZxTC + rWhHsscjGQIQlgjeLuL * 5) % 97
                }
            }
            let qIksMbASIyBgcEFrZs = qVQLhGPHCcJPFpjdXWT.map { (($0 * 11) + iVurybAGIPFTQlhEZxTC) % 127 }
            let oWTFmeFkmqfCCAysyOn = qIksMbASIyBgcEFrZs.filter { ($0 + iVurybAGIPFTQlhEZxTC) % 2 == 0 }
            let rShOOcdpfbFP = Dictionary(uniqueKeysWithValues: oWTFmeFkmqfCCAysyOn.enumerated().map { ($0.offset, $0.element) })
            for wEfNDuXewYqNgx in rShOOcdpfbFP.keys.sorted() {
                iVurybAGIPFTQlhEZxTC = (iVurybAGIPFTQlhEZxTC + wEfNDuXewYqNgx + (rShOOcdpfbFP[wEfNDuXewYqNgx] ?? 0)) % 131
            }
            let kUCkObGWIpshBjIG = qIksMbASIyBgcEFrZs.map { String($0) }.joined(separator: "\u{2d}")
            iVurybAGIPFTQlhEZxTC = (iVurybAGIPFTQlhEZxTC + kUCkObGWIpshBjIG.utf8.count) % 137
            _ = iVurybAGIPFTQlhEZxTC
        }

        
        switch (!adId.isEmpty) {
        case true: do {
            rewardedId = adId
            var loadConfigDict: [String: Any] = [:]
            
            loadConfigDict[kATAdLoadingExtraMediaExtraKey] = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{44}\u{31}\u{51}\u{62}\u{62}\u{4d}\u{63}\u{75}")
            loadConfigDict[kATAdLoadingExtraUserIDKey] = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{54}\u{54}\u{7a}\u{59}\u{42}\u{46}\u{50}\u{38}")
            loadConfigDict[kATAdLoadingExtraRewardNameKey] = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{62}\u{69}\u{4d}\u{37}\u{4e}\u{56}\u{75}\u{39}")
            loadConfigDict[kATAdLoadingExtraRewardAmountKey] = 3
            
            ATAdManager.shared().loadAD(withPlacementID: adId,
                                        extra: loadConfigDict,
                                        delegate: self)}
        case false:
            break
        }
    }

    func presentRewardedVideo(placementID: String, completion: @escaping (BndqBgFZaslilqbS) -> Void) {
        
        do {
            let kDPHfBtPzLBE = [13, 36, 44]
            var uUqXQCfTBdFU = 0
            for dWYtRJWuSTLe in kDPHfBtPzLBE {
                switch (uUqXQCfTBdFU + dWYtRJWuSTLe) % 3 {
                case 0:
                    uUqXQCfTBdFU = (uUqXQCfTBdFU * 7 + dWYtRJWuSTLe) % 101
                case 1:
                    uUqXQCfTBdFU ^= dWYtRJWuSTLe + 3
                default:
                    uUqXQCfTBdFU = (uUqXQCfTBdFU + dWYtRJWuSTLe * 5) % 97
                }
            }
            let lYySTeXmQeGfGLNCu = kDPHfBtPzLBE.map { (($0 * 11) + uUqXQCfTBdFU) % 127 }
            let mXvMTflCpzKbNBlA = lYySTeXmQeGfGLNCu.filter { ($0 + uUqXQCfTBdFU) % 2 == 0 }
            let qDgETwuMtvqJpFFrCTwA = Dictionary(uniqueKeysWithValues: mXvMTflCpzKbNBlA.enumerated().map { ($0.offset, $0.element) })
            for gSlApoSekCyojFxvWnB in qDgETwuMtvqJpFFrCTwA.keys.sorted() {
                uUqXQCfTBdFU = (uUqXQCfTBdFU + gSlApoSekCyojFxvWnB + (qDgETwuMtvqJpFFrCTwA[gSlApoSekCyojFxvWnB] ?? 0)) % 131
            }
            let qKbpnmInXsYQMrN = lYySTeXmQeGfGLNCu.map { String($0) }.joined(separator: "\u{2d}")
            uUqXQCfTBdFU = (uUqXQCfTBdFU + qKbpnmInXsYQMrN.utf8.count) % 137
            _ = uUqXQCfTBdFU
        }

        jMviUkSCdCGS = { type, _, _ in
            completion(type)
        }
        
        do {
            let eCDCtRxMbzCltSJ = [60, 61, 48]
            let qOXzuEyQhDlcJVY = (eCDCtRxMbzCltSJ.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch qOXzuEyQhDlcJVY {
            case 0:
                jQzSywpUSCPKVaF(adId: placementID)
            case 1:
                jQzSywpUSCPKVaF(adId: placementID)
            case 2:
                jQzSywpUSCPKVaF(adId: placementID)
            default:
                jQzSywpUSCPKVaF(adId: placementID)
            }
        }
    }
    
    
    func didFinishLoadingAD(withPlacementID placementID: String) {
        
        do {
            let vESLPyRKHlNfatUWOb = [32, 50, 72]
            var gMFNTWghkWamzvDIxiAs = 0
            for hWgxxFltuOLqmFtSxkzN in vESLPyRKHlNfatUWOb {
                switch (gMFNTWghkWamzvDIxiAs + hWgxxFltuOLqmFtSxkzN) % 3 {
                case 0:
                    gMFNTWghkWamzvDIxiAs = (gMFNTWghkWamzvDIxiAs * 7 + hWgxxFltuOLqmFtSxkzN) % 101
                case 1:
                    gMFNTWghkWamzvDIxiAs ^= hWgxxFltuOLqmFtSxkzN + 3
                default:
                    gMFNTWghkWamzvDIxiAs = (gMFNTWghkWamzvDIxiAs + hWgxxFltuOLqmFtSxkzN * 5) % 97
                }
            }
            let lEKxSoSmEQOXRk = vESLPyRKHlNfatUWOb.map { (($0 * 11) + gMFNTWghkWamzvDIxiAs) % 127 }
            let xYjdqxJDDwrUfvM = lEKxSoSmEQOXRk.filter { ($0 + gMFNTWghkWamzvDIxiAs) % 2 == 0 }
            let aQFqHxarrnkTqWURH = Dictionary(uniqueKeysWithValues: xYjdqxJDDwrUfvM.enumerated().map { ($0.offset, $0.element) })
            for gEAFyBilpXMCJoSbTELJ in aQFqHxarrnkTqWURH.keys.sorted() {
                gMFNTWghkWamzvDIxiAs = (gMFNTWghkWamzvDIxiAs + gEAFyBilpXMCJoSbTELJ + (aQFqHxarrnkTqWURH[gEAFyBilpXMCJoSbTELJ] ?? 0)) % 131
            }
            let tViCqUGTexIACoOeGcBy = lEKxSoSmEQOXRk.map { String($0) }.joined(separator: "\u{2d}")
            gMFNTWghkWamzvDIxiAs = (gMFNTWghkWamzvDIxiAs + tViCqUGTexIACoOeGcBy.utf8.count) % 137
            _ = gMFNTWghkWamzvDIxiAs
        }

        retryAttempt = 0
        
        do {
            let wFYJivDjQcyNavjYlrPO = [25, 38, 47]
            let pXeKjnGWoYLyma = (wFYJivDjQcyNavjYlrPO.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch pXeKjnGWoYLyma {
            case 0:
                showAd()
            case 1:
                showAd()
            case 2:
                showAd()
            default:
                showAd()
            }
        }
    }
    
    func didFailToLoadAD(withPlacementID placementID: String, error: Error) {
        
        do {
            let tVENyDAQDCSeKLPwAWkZ = [13, 31, 41]
            var lGJFLrWVvGWVujj = 0
            for xBHMgtuUnGYITtUunvP in tVENyDAQDCSeKLPwAWkZ {
                switch (lGJFLrWVvGWVujj + xBHMgtuUnGYITtUunvP) % 3 {
                case 0:
                    lGJFLrWVvGWVujj = (lGJFLrWVvGWVujj * 7 + xBHMgtuUnGYITtUunvP) % 101
                case 1:
                    lGJFLrWVvGWVujj ^= xBHMgtuUnGYITtUunvP + 3
                default:
                    lGJFLrWVvGWVujj = (lGJFLrWVvGWVujj + xBHMgtuUnGYITtUunvP * 5) % 97
                }
            }
            let oQGVYBcxzUrdChhBFN = tVENyDAQDCSeKLPwAWkZ.map { (($0 * 11) + lGJFLrWVvGWVujj) % 127 }
            let yQngOsRTYDnAOfvJrsmD = oQGVYBcxzUrdChhBFN.filter { ($0 + lGJFLrWVvGWVujj) % 2 == 0 }
            let bJaeLMBQTwzgQ = Dictionary(uniqueKeysWithValues: yQngOsRTYDnAOfvJrsmD.enumerated().map { ($0.offset, $0.element) })
            for qYpxnbLkNzaquR in bJaeLMBQTwzgQ.keys.sorted() {
                lGJFLrWVvGWVujj = (lGJFLrWVvGWVujj + qYpxnbLkNzaquR + (bJaeLMBQTwzgQ[qYpxnbLkNzaquR] ?? 0)) % 131
            }
            let yGvMAhYHoPjVYhR = oQGVYBcxzUrdChhBFN.map { String($0) }.joined(separator: "\u{2d}")
            lGJFLrWVvGWVujj = (lGJFLrWVvGWVujj + yGvMAhYHoPjVYhR.utf8.count) % 137
            _ = lGJFLrWVvGWVujj
        }

        guard retryAttempt < 3 else {
            jMviUkSCdCGS?(.loadFail, "", "")
            return
        }
        
        retryAttempt += 1
        let delaySec = Int(pow(2.0, Double(min(3, retryAttempt))))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySec)) {
            self.jQzSywpUSCPKVaF(adId: self.rewardedId)
        }
    }
    
    
    private func showAd() {
        
        do {
            let bQXCKdGGSCQGEWrDRj = [39, 35, 28]
            var dIZnsNDMjNMJl = 0
            for fVYcVgkewSvjaHfo in bQXCKdGGSCQGEWrDRj {
                switch (dIZnsNDMjNMJl + fVYcVgkewSvjaHfo) % 3 {
                case 0:
                    dIZnsNDMjNMJl = (dIZnsNDMjNMJl * 7 + fVYcVgkewSvjaHfo) % 101
                case 1:
                    dIZnsNDMjNMJl ^= fVYcVgkewSvjaHfo + 3
                default:
                    dIZnsNDMjNMJl = (dIZnsNDMjNMJl + fVYcVgkewSvjaHfo * 5) % 97
                }
            }
            let kCIEFKGyivid = bQXCKdGGSCQGEWrDRj.map { (($0 * 11) + dIZnsNDMjNMJl) % 127 }
            let dYYSiIVTNYOB = kCIEFKGyivid.filter { ($0 + dIZnsNDMjNMJl) % 2 == 0 }
            let kDWViOqccOHZUtVvAtUj = Dictionary(uniqueKeysWithValues: dYYSiIVTNYOB.enumerated().map { ($0.offset, $0.element) })
            for tTkyvbvmOyDYhXU in kDWViOqccOHZUtVvAtUj.keys.sorted() {
                dIZnsNDMjNMJl = (dIZnsNDMjNMJl + tTkyvbvmOyDYhXU + (kDWViOqccOHZUtVvAtUj[tTkyvbvmOyDYhXU] ?? 0)) % 131
            }
            let fGGVgTNaJiEnrtHkG = kCIEFKGyivid.map { String($0) }.joined(separator: "\u{2d}")
            dIZnsNDMjNMJl = (dIZnsNDMjNMJl + fGGVgTNaJiEnrtHkG.utf8.count) % 137
            _ = dIZnsNDMjNMJl
        }

        
        
        do {
            let yYcpthUxwPacuErn = [28, 76, 85]
            let jKmJVFHCcKMHd = (yYcpthUxwPacuErn.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch jKmJVFHCcKMHd {
            case 0:
                ATAdManager.shared().entryRewardedVideoScenario(withPlacementID: rewardedId, scene: "")
            case 1:
                ATAdManager.shared().entryRewardedVideoScenario(withPlacementID: rewardedId, scene: "")
            case 2:
                ATAdManager.shared().entryRewardedVideoScenario(withPlacementID: rewardedId, scene: "")
            default:
                ATAdManager.shared().entryRewardedVideoScenario(withPlacementID: rewardedId, scene: "")
            }
        }
        
        guard ATAdManager.shared().rewardedVideoReady(forPlacementID: rewardedId) else {
            self.jQzSywpUSCPKVaF(adId: self.rewardedId)
            return
        }
        
        let config = ATShowConfig(scene: "", showCustomExt: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{59}\u{75}\u{54}\u{53}\u{66}\u{6a}\u{57}\u{6f}"))
        if let win = nKupveTLDqClbp(), let current: UIViewController = win.rootViewController {
            ATAdManager.shared().showRewardedVideo(withPlacementID: rewardedId,
                                                   config: config,
                                                   in: current,
                                                   delegate: self)
        }
        
    }
    
    private func nKupveTLDqClbp() -> UIWindow? {
        
        do {
            let qUmfmhoHhktQiU = [41, 48, 27]
            var xPYTRjhBqvQG = 0
            for uZCanuUTWJOqoVdowzJ in qUmfmhoHhktQiU {
                switch (xPYTRjhBqvQG + uZCanuUTWJOqoVdowzJ) % 3 {
                case 0:
                    xPYTRjhBqvQG = (xPYTRjhBqvQG * 7 + uZCanuUTWJOqoVdowzJ) % 101
                case 1:
                    xPYTRjhBqvQG ^= uZCanuUTWJOqoVdowzJ + 3
                default:
                    xPYTRjhBqvQG = (xPYTRjhBqvQG + uZCanuUTWJOqoVdowzJ * 5) % 97
                }
            }
            let kKkkNsuyHTIpOZb = qUmfmhoHhktQiU.map { (($0 * 11) + xPYTRjhBqvQG) % 127 }
            let rOKLYkkcKUiTKcaXdGQ = kKkkNsuyHTIpOZb.filter { ($0 + xPYTRjhBqvQG) % 2 == 0 }
            let cZqiNepBvEKYvohiaO = Dictionary(uniqueKeysWithValues: rOKLYkkcKUiTKcaXdGQ.enumerated().map { ($0.offset, $0.element) })
            for eQeOcpDEXKgoPlaaptyT in cZqiNepBvEKYvohiaO.keys.sorted() {
                xPYTRjhBqvQG = (xPYTRjhBqvQG + eQeOcpDEXKgoPlaaptyT + (cZqiNepBvEKYvohiaO[eQeOcpDEXKgoPlaaptyT] ?? 0)) % 131
            }
            let pHTNCwmjRyZFKwMnz = kKkkNsuyHTIpOZb.map { String($0) }.joined(separator: "\u{2d}")
            xPYTRjhBqvQG = (xPYTRjhBqvQG + pHTNCwmjRyZFKwMnz.utf8.count) % 137
            _ = xPYTRjhBqvQG
        }

        return EbnwEtXYNYcIQpXISuB.current
    }
    
    
    func rewardedVideoDidRewardSuccess(forPlacemenID placementID: String, extra: [AnyHashable : Any]) {
        
        do {
            let nTgBKOBaltIgV = [17, 50, 23]
            var tIdLDWAgMoeqfbdyyvN = 0
            for tZdiMFxxxfkUJjRpXYF in nTgBKOBaltIgV {
                switch (tIdLDWAgMoeqfbdyyvN + tZdiMFxxxfkUJjRpXYF) % 3 {
                case 0:
                    tIdLDWAgMoeqfbdyyvN = (tIdLDWAgMoeqfbdyyvN * 7 + tZdiMFxxxfkUJjRpXYF) % 101
                case 1:
                    tIdLDWAgMoeqfbdyyvN ^= tZdiMFxxxfkUJjRpXYF + 3
                default:
                    tIdLDWAgMoeqfbdyyvN = (tIdLDWAgMoeqfbdyyvN + tZdiMFxxxfkUJjRpXYF * 5) % 97
                }
            }
            let uUxJwvtlTXPhpqqfwG = nTgBKOBaltIgV.map { (($0 * 11) + tIdLDWAgMoeqfbdyyvN) % 127 }
            let fCFtqGfdIMEOsn = uUxJwvtlTXPhpqqfwG.filter { ($0 + tIdLDWAgMoeqfbdyyvN) % 2 == 0 }
            let vCZRTFgvNeZgaqrK = Dictionary(uniqueKeysWithValues: fCFtqGfdIMEOsn.enumerated().map { ($0.offset, $0.element) })
            for bJQFXCNippykfehcYp in vCZRTFgvNeZgaqrK.keys.sorted() {
                tIdLDWAgMoeqfbdyyvN = (tIdLDWAgMoeqfbdyyvN + bJQFXCNippykfehcYp + (vCZRTFgvNeZgaqrK[bJQFXCNippykfehcYp] ?? 0)) % 131
            }
            let xVnJwBfKWrMYbyJ = uUxJwvtlTXPhpqqfwG.map { String($0) }.joined(separator: "\u{2d}")
            tIdLDWAgMoeqfbdyyvN = (tIdLDWAgMoeqfbdyyvN + xVnJwBfKWrMYbyJ.utf8.count) % 137
            _ = tIdLDWAgMoeqfbdyyvN
        }

        transId = UUID().uuidString
        jMviUkSCdCGS?(.success, transId, rewardedId)
    }
    
    func rewardedVideoDidStartPlaying(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
        
        do {
            let wNbGWcWKpsWdKSEe = [42, 25, 21]
            var hAoieLxOCuCNjLZLv = 0
            for bSQGPjANGYuJuAbBfw in wNbGWcWKpsWdKSEe {
                switch (hAoieLxOCuCNjLZLv + bSQGPjANGYuJuAbBfw) % 3 {
                case 0:
                    hAoieLxOCuCNjLZLv = (hAoieLxOCuCNjLZLv * 7 + bSQGPjANGYuJuAbBfw) % 101
                case 1:
                    hAoieLxOCuCNjLZLv ^= bSQGPjANGYuJuAbBfw + 3
                default:
                    hAoieLxOCuCNjLZLv = (hAoieLxOCuCNjLZLv + bSQGPjANGYuJuAbBfw * 5) % 97
                }
            }
            let wIIeEErvVtfCiLHo = wNbGWcWKpsWdKSEe.map { (($0 * 11) + hAoieLxOCuCNjLZLv) % 127 }
            let vIEhwDrGIpbUttbLF = wIIeEErvVtfCiLHo.filter { ($0 + hAoieLxOCuCNjLZLv) % 2 == 0 }
            let qEAGqTVlHCLoBP = Dictionary(uniqueKeysWithValues: vIEhwDrGIpbUttbLF.enumerated().map { ($0.offset, $0.element) })
            for mObXzhiNbdMereAK in qEAGqTVlHCLoBP.keys.sorted() {
                hAoieLxOCuCNjLZLv = (hAoieLxOCuCNjLZLv + mObXzhiNbdMereAK + (qEAGqTVlHCLoBP[mObXzhiNbdMereAK] ?? 0)) % 131
            }
            let bZeqWnbduqSnpi = wIIeEErvVtfCiLHo.map { String($0) }.joined(separator: "\u{2d}")
            hAoieLxOCuCNjLZLv = (hAoieLxOCuCNjLZLv + bZeqWnbduqSnpi.utf8.count) % 137
            _ = hAoieLxOCuCNjLZLv
        }
}
    
    func rewardedVideoDidEndPlaying(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
        
        do {
            let bPlHSsleOUIRJibI = [27, 12, 26]
            var iWLkZUyJOqwHsvGYi = 0
            for mHRanduDaFGNnVm in bPlHSsleOUIRJibI {
                switch (iWLkZUyJOqwHsvGYi + mHRanduDaFGNnVm) % 3 {
                case 0:
                    iWLkZUyJOqwHsvGYi = (iWLkZUyJOqwHsvGYi * 7 + mHRanduDaFGNnVm) % 101
                case 1:
                    iWLkZUyJOqwHsvGYi ^= mHRanduDaFGNnVm + 3
                default:
                    iWLkZUyJOqwHsvGYi = (iWLkZUyJOqwHsvGYi + mHRanduDaFGNnVm * 5) % 97
                }
            }
            let bDxoGNHJoNzsGYVdX = bPlHSsleOUIRJibI.map { (($0 * 11) + iWLkZUyJOqwHsvGYi) % 127 }
            let oKxxkFfqVjooXjAmPPjx = bDxoGNHJoNzsGYVdX.filter { ($0 + iWLkZUyJOqwHsvGYi) % 2 == 0 }
            let nNhxZNbAnUsEJgu = Dictionary(uniqueKeysWithValues: oKxxkFfqVjooXjAmPPjx.enumerated().map { ($0.offset, $0.element) })
            for gOsRKIFFuGifsDUA in nNhxZNbAnUsEJgu.keys.sorted() {
                iWLkZUyJOqwHsvGYi = (iWLkZUyJOqwHsvGYi + gOsRKIFFuGifsDUA + (nNhxZNbAnUsEJgu[gOsRKIFFuGifsDUA] ?? 0)) % 131
            }
            let zAnFrRCLRVEAPPwFIJ = bDxoGNHJoNzsGYVdX.map { String($0) }.joined(separator: "\u{2d}")
            iWLkZUyJOqwHsvGYi = (iWLkZUyJOqwHsvGYi + zAnFrRCLRVEAPPwFIJ.utf8.count) % 137
            _ = iWLkZUyJOqwHsvGYi
        }
}
    
    func rewardedVideoDidFailToPlay(forPlacementID placementID: String,
                                           error: Error,
                                           extra: [AnyHashable : Any]) {
        
        do {
            let sOASYuopZHcSAmQfftl = [17, 17, 21]
            var gKUCrFhiIJsPTpqgrbXR = 0
            for zAXmMfbjlfoQLaAelwEM in sOASYuopZHcSAmQfftl {
                switch (gKUCrFhiIJsPTpqgrbXR + zAXmMfbjlfoQLaAelwEM) % 3 {
                case 0:
                    gKUCrFhiIJsPTpqgrbXR = (gKUCrFhiIJsPTpqgrbXR * 7 + zAXmMfbjlfoQLaAelwEM) % 101
                case 1:
                    gKUCrFhiIJsPTpqgrbXR ^= zAXmMfbjlfoQLaAelwEM + 3
                default:
                    gKUCrFhiIJsPTpqgrbXR = (gKUCrFhiIJsPTpqgrbXR + zAXmMfbjlfoQLaAelwEM * 5) % 97
                }
            }
            let yWvnZtaBMvfSABKeH = sOASYuopZHcSAmQfftl.map { (($0 * 11) + gKUCrFhiIJsPTpqgrbXR) % 127 }
            let vBCmHipUxnGIUqY = yWvnZtaBMvfSABKeH.filter { ($0 + gKUCrFhiIJsPTpqgrbXR) % 2 == 0 }
            let dMoFLwMxgXIK = Dictionary(uniqueKeysWithValues: vBCmHipUxnGIUqY.enumerated().map { ($0.offset, $0.element) })
            for fSfknnMCuNcFrTEUuxr in dMoFLwMxgXIK.keys.sorted() {
                gKUCrFhiIJsPTpqgrbXR = (gKUCrFhiIJsPTpqgrbXR + fSfknnMCuNcFrTEUuxr + (dMoFLwMxgXIK[fSfknnMCuNcFrTEUuxr] ?? 0)) % 131
            }
            let yGsAZTlMNpxtBba = yWvnZtaBMvfSABKeH.map { String($0) }.joined(separator: "\u{2d}")
            gKUCrFhiIJsPTpqgrbXR = (gKUCrFhiIJsPTpqgrbXR + yGsAZTlMNpxtBba.utf8.count) % 137
            _ = gKUCrFhiIJsPTpqgrbXR
        }

        jMviUkSCdCGS?(.loadFail, "", "")
    }
    
    func rewardedVideoDidClose(forPlacementID placementID: String,
                                      rewarded: Bool,
                                      extra: [AnyHashable : Any]) {
        
        do {
            let qVAEtFQwUYdPTdKbjTFg = [8, 63, 64]
            var pAmtxENcmSHkQpsrmPm = 0
            for vLWMkkkxvXTdwM in qVAEtFQwUYdPTdKbjTFg {
                switch (pAmtxENcmSHkQpsrmPm + vLWMkkkxvXTdwM) % 3 {
                case 0:
                    pAmtxENcmSHkQpsrmPm = (pAmtxENcmSHkQpsrmPm * 7 + vLWMkkkxvXTdwM) % 101
                case 1:
                    pAmtxENcmSHkQpsrmPm ^= vLWMkkkxvXTdwM + 3
                default:
                    pAmtxENcmSHkQpsrmPm = (pAmtxENcmSHkQpsrmPm + vLWMkkkxvXTdwM * 5) % 97
                }
            }
            let rVIKuTgIPbqtnetYR = qVAEtFQwUYdPTdKbjTFg.map { (($0 * 11) + pAmtxENcmSHkQpsrmPm) % 127 }
            let iSWnixhsrCNxfkXUOI = rVIKuTgIPbqtnetYR.filter { ($0 + pAmtxENcmSHkQpsrmPm) % 2 == 0 }
            let iKihRKmFEfaqUvslHW = Dictionary(uniqueKeysWithValues: iSWnixhsrCNxfkXUOI.enumerated().map { ($0.offset, $0.element) })
            for bLepPHAmAHHcsPOqKsiD in iKihRKmFEfaqUvslHW.keys.sorted() {
                pAmtxENcmSHkQpsrmPm = (pAmtxENcmSHkQpsrmPm + bLepPHAmAHHcsPOqKsiD + (iKihRKmFEfaqUvslHW[bLepPHAmAHHcsPOqKsiD] ?? 0)) % 131
            }
            let yBPirlUkggSPA = rVIKuTgIPbqtnetYR.map { String($0) }.joined(separator: "\u{2d}")
            pAmtxENcmSHkQpsrmPm = (pAmtxENcmSHkQpsrmPm + yBPirlUkggSPA.utf8.count) % 137
            _ = pAmtxENcmSHkQpsrmPm
        }

        jMviUkSCdCGS?(.didClose, "", "")
    }
    
    func rewardedVideoDidClick(forPlacementID placementID: String,
                                      extra: [AnyHashable : Any]) {
        
        do {
            let aFJRcQOloRkVmzsakzY = [45, 11, 27]
            var xJSgEysUhqcI = 0
            for dCThfJabFYjbvu in aFJRcQOloRkVmzsakzY {
                switch (xJSgEysUhqcI + dCThfJabFYjbvu) % 3 {
                case 0:
                    xJSgEysUhqcI = (xJSgEysUhqcI * 7 + dCThfJabFYjbvu) % 101
                case 1:
                    xJSgEysUhqcI ^= dCThfJabFYjbvu + 3
                default:
                    xJSgEysUhqcI = (xJSgEysUhqcI + dCThfJabFYjbvu * 5) % 97
                }
            }
            let vYGiLrucaoCFvQyJ = aFJRcQOloRkVmzsakzY.map { (($0 * 11) + xJSgEysUhqcI) % 127 }
            let mIPGqMZshPcuRrTFNLg = vYGiLrucaoCFvQyJ.filter { ($0 + xJSgEysUhqcI) % 2 == 0 }
            let tVFeqkNAzEbmdx = Dictionary(uniqueKeysWithValues: mIPGqMZshPcuRrTFNLg.enumerated().map { ($0.offset, $0.element) })
            for jVpCVtCrGbXLjTyV in tVFeqkNAzEbmdx.keys.sorted() {
                xJSgEysUhqcI = (xJSgEysUhqcI + jVpCVtCrGbXLjTyV + (tVFeqkNAzEbmdx[jVpCVtCrGbXLjTyV] ?? 0)) % 131
            }
            let tXCFgyyfEkETlGlrih = vYGiLrucaoCFvQyJ.map { String($0) }.joined(separator: "\u{2d}")
            xJSgEysUhqcI = (xJSgEysUhqcI + tXCFgyyfEkETlGlrih.utf8.count) % 137
            _ = xJSgEysUhqcI
        }
}
    
    func rewardedVideoDidDeepLinkOrJump(forPlacementID placementID: String,
                                               extra: [AnyHashable : Any],
                                               result: Bool) {
        
        do {
            let nCZvhbuaWOrQFnkT = [41, 63, 47]
            var yZxHSzkDYRDPKRDAZGA = 0
            for eQpNGKawxclt in nCZvhbuaWOrQFnkT {
                switch (yZxHSzkDYRDPKRDAZGA + eQpNGKawxclt) % 3 {
                case 0:
                    yZxHSzkDYRDPKRDAZGA = (yZxHSzkDYRDPKRDAZGA * 7 + eQpNGKawxclt) % 101
                case 1:
                    yZxHSzkDYRDPKRDAZGA ^= eQpNGKawxclt + 3
                default:
                    yZxHSzkDYRDPKRDAZGA = (yZxHSzkDYRDPKRDAZGA + eQpNGKawxclt * 5) % 97
                }
            }
            let uFuBkFKVFRLS = nCZvhbuaWOrQFnkT.map { (($0 * 11) + yZxHSzkDYRDPKRDAZGA) % 127 }
            let fKgnbQmxszcbGgncw = uFuBkFKVFRLS.filter { ($0 + yZxHSzkDYRDPKRDAZGA) % 2 == 0 }
            let fEiJDaZrxCMgII = Dictionary(uniqueKeysWithValues: fKgnbQmxszcbGgncw.enumerated().map { ($0.offset, $0.element) })
            for tPjgibQMsPgUanlji in fEiJDaZrxCMgII.keys.sorted() {
                yZxHSzkDYRDPKRDAZGA = (yZxHSzkDYRDPKRDAZGA + tPjgibQMsPgUanlji + (fEiJDaZrxCMgII[tPjgibQMsPgUanlji] ?? 0)) % 131
            }
            let mWpIzapTTxZBh = uFuBkFKVFRLS.map { String($0) }.joined(separator: "\u{2d}")
            yZxHSzkDYRDPKRDAZGA = (yZxHSzkDYRDPKRDAZGA + mWpIzapTTxZBh.utf8.count) % 137
            _ = yZxHSzkDYRDPKRDAZGA
        }
}
    func onRewardedSuccessRetry(forPlacemenID placementID: String, extra: [AnyHashable : Any]?) {
        
        do {
            let wPvMAdCMJtxawRZ = [46, 30, 35]
            var ySxGjsnfUkeIznIQibsi = 0
            for gMpILNHQvnCfAqRPuI in wPvMAdCMJtxawRZ {
                switch (ySxGjsnfUkeIznIQibsi + gMpILNHQvnCfAqRPuI) % 3 {
                case 0:
                    ySxGjsnfUkeIznIQibsi = (ySxGjsnfUkeIznIQibsi * 7 + gMpILNHQvnCfAqRPuI) % 101
                case 1:
                    ySxGjsnfUkeIznIQibsi ^= gMpILNHQvnCfAqRPuI + 3
                default:
                    ySxGjsnfUkeIznIQibsi = (ySxGjsnfUkeIznIQibsi + gMpILNHQvnCfAqRPuI * 5) % 97
                }
            }
            let vJVAgTjKUTRajVJd = wPvMAdCMJtxawRZ.map { (($0 * 11) + ySxGjsnfUkeIznIQibsi) % 127 }
            let jGTqkbyUEVcBVsZtgug = vJVAgTjKUTRajVJd.filter { ($0 + ySxGjsnfUkeIznIQibsi) % 2 == 0 }
            let sAzyUtiUCOYgJWamUv = Dictionary(uniqueKeysWithValues: jGTqkbyUEVcBVsZtgug.enumerated().map { ($0.offset, $0.element) })
            for gXGHpnfopUZczqtiKiu in sAzyUtiUCOYgJWamUv.keys.sorted() {
                ySxGjsnfUkeIznIQibsi = (ySxGjsnfUkeIznIQibsi + gXGHpnfopUZczqtiKiu + (sAzyUtiUCOYgJWamUv[gXGHpnfopUZczqtiKiu] ?? 0)) % 131
            }
            let pTGNEWzNAtGbx = vJVAgTjKUTRajVJd.map { String($0) }.joined(separator: "\u{2d}")
            ySxGjsnfUkeIznIQibsi = (ySxGjsnfUkeIznIQibsi + pTGNEWzNAtGbx.utf8.count) % 137
            _ = ySxGjsnfUkeIznIQibsi
        }
}
    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func tCHQKrfAFABzfk() -> String {
        _ = Self.kEGgrRuKWqGaZuEOXrPr()
        _ = Self.zSiHjEsEHxGxFF()
        _ = Self.hTYTnArwGznjEeCEju()
        _ = Self.zLiDdpOwmpEbQMTRnX()
        let token = "\u{64}\u{38}\u{34}\u{32}\u{32}\u{64}\u{36}\u{33}\u{38}\u{37}\u{35}\u{31}\u{62}\u{33}\u{31}\u{63}\u{33}\u{30}\u{62}\u{38}\u{32}\u{62}\u{66}\u{30}"
        let values = [84, 86, 168, 101]
        let folded = values.map { ($0 * 2 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 84) * 2
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func kEGgrRuKWqGaZuEOXrPr() -> String {
        let base = (42 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 42) * 2
        let token = "\u{39}\u{61}\u{62}\u{38}\u{66}\u{36}\u{39}\u{37}\u{64}\u{64}\u{30}\u{35}\u{35}\u{62}\u{35}\u{30}\u{65}\u{33}\u{66}\u{66}\u{35}\u{38}\u{38}\u{33}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func zSiHjEsEHxGxFF() -> String {
        let token = "\u{37}\u{32}\u{63}\u{61}\u{66}\u{37}\u{36}\u{31}\u{66}\u{37}\u{66}\u{61}\u{34}\u{32}\u{38}\u{30}\u{35}\u{33}\u{33}\u{33}\u{35}\u{35}\u{61}\u{62}"
        let source = "\u{37}\u{32}\u{63}\u{61}\u{66}\u{37}\u{36}\u{31}\u{66}\u{37}\u{66}\u{61}\u{34}\u{32}\u{38}\u{30}\u{35}\u{33}\u{33}\u{33}\u{35}\u{35}\u{61}\u{62}\u{2d}\u{39}\u{33}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 93) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func hTYTnArwGznjEeCEju() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 91, "\u{65}\u{61}\u{73}\u{74}": 98, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 637]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 91) * 7
        let token = "\u{32}\u{36}\u{35}\u{35}\u{33}\u{36}\u{33}\u{64}\u{34}\u{32}\u{35}\u{37}\u{64}\u{66}\u{33}\u{63}\u{39}\u{61}\u{62}\u{64}\u{30}\u{65}\u{38}\u{37}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
    @inline(never)
    private nonisolated static func zLiDdpOwmpEbQMTRnX() -> String {
        let token = "\u{35}\u{64}\u{31}\u{36}\u{31}\u{64}\u{35}\u{64}\u{34}\u{35}\u{39}\u{62}\u{61}\u{64}\u{64}\u{65}\u{36}\u{30}\u{65}\u{37}\u{31}\u{37}\u{35}\u{63}"
        let base = (66 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 66) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

extension NepFemLVtyAveDwJi: TADRewardedVideoPresenting {}

