






import UIKit
import AnyThinkSDK

class VuBlmrLsyYCTSwGnSNM: UIView, ATAdLoadingDelegate, ATInterstitialDelegate {
    
    private var retryAttempt: Int = 0
    var sYDVElOeKyqK:((_ position: Int, _ type: BndqBgFZaslilqbS)->Void)?
    private var ifadId: String!
    var positionType: Int = 0
    
    func sWdDHaVPxEVbEp(adId: String, position: Int = 0) {
        // source-obfuscator:padding:v1
        _ = Self.xPTQiVMtSdqOhOvl()

        guard AxQkIqFofIHnj.shouldShowInterstitial else {
            sYDVElOeKyqK?(position, .didClose)
            return
        }
        if !adId.isEmpty {
            positionType = position
            ifadId = adId
            var loadConfigDict: [String: Any] = [:]
            loadConfigDict[kATAdLoadingExtraMediaExtraKey] = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{78}\u{58}\u{55}\u{67}\u{6c}\u{6f}\u{67}\u{61}")
            
            ATAdManager.shared().loadAD(withPlacementID: adId,
                                        extra: loadConfigDict,
                                        delegate: self)
        }
    }

    func presentHalfInterstitial(
        placementID: String,
        position: Int,
        completion: @escaping (Int, BndqBgFZaslilqbS) -> Void
    ) {
        sYDVElOeKyqK = completion
        sWdDHaVPxEVbEp(adId: placementID, position: position)
    }
    
    
    func showAd() {
        
        ATAdManager.shared().entryInterstitialScenario(withPlacementID: ifadId, scene: "")
        
        guard ATAdManager.shared().interstitialReady(forPlacementID: ifadId) else {
            sWdDHaVPxEVbEp(adId: ifadId, position: positionType)
            return
        }
        
        let config = ATShowConfig(scene: "", showCustomExt: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{79}\u{68}\u{69}\u{55}\u{32}\u{43}\u{61}\u{64}"))
        if let win = nKupveTLDqClbp(), let current: UIViewController = win.rootViewController {
            ATAdManager.shared().showInterstitial(withPlacementID: ifadId,
                                                  showConfig: config,
                                                  in: current,
                                                  delegate: self,
                                                  nativeMixViewBlock: nil)
        }
        
    }
    
    
    
    
    func didFinishLoadingAD(withPlacementID placementID: String) {
        retryAttempt = 0
        showAd()
    }
    
    func didFailToLoadAD(withPlacementID placementID: String, error: Error) {
        guard retryAttempt < 3 else {
            sYDVElOeKyqK?(positionType, .loadFail)
            return
        }
        
        retryAttempt += 1
        let delaySec = Int(pow(2.0, Double(min(3, retryAttempt))))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySec)) { [weak self] in
            guard let self  = self else {return}
            self.sWdDHaVPxEVbEp(adId: ifadId, position: positionType)
        }
    }
    
    
    func didRevenue(forPlacementID placementID: String, extra: [AnyHashable : Any]) {}
    
    func interstitialDidShow(forPlacementID placementID: String, extra: [AnyHashable : Any]) {}
    
    public func interstitialFailedToShow(forPlacementID placementID: String,
                                         error: Error,
                                         extra: [AnyHashable : Any]) {
        sYDVElOeKyqK?(positionType, .loadFail)
    }
    
    func interstitialDidFailToPlayVideo(forPlacementID placementID: String,
                                               error: Error,
                                               extra: [AnyHashable : Any]) {
        sYDVElOeKyqK?(positionType, .loadFail)
    }
    
    func interstitialDidStartPlayingVideo(forPlacementID placementID: String,
                                                 extra: [AnyHashable : Any]) {}
    
    func interstitialDidEndPlayingVideo(forPlacementID placementID: String,
                                               extra: [AnyHashable : Any]) {
    }
    
    func interstitialDidClose(forPlacementID placementID: String,
                                     extra: [AnyHashable : Any]) {
        sYDVElOeKyqK?(positionType, .didClose)
    }
    
    func interstitialDidClick(forPlacementID placementID: String,
                                     extra: [AnyHashable : Any]) {
        sYDVElOeKyqK?(positionType, .loadFail)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func xPTQiVMtSdqOhOvl() -> String {
        _ = Self.qPymWSVFuwSWkCMd()
        _ = Self.eZglNNXrDRqWq()
        _ = Self.uAVkCmOzogLqfS()
        let base = (44 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 44) * 8
        let token = "\u{61}\u{33}\u{38}\u{65}\u{64}\u{66}\u{39}\u{34}\u{62}\u{33}\u{61}\u{31}\u{33}\u{32}\u{32}\u{63}\u{64}\u{65}\u{35}\u{37}\u{62}\u{36}\u{34}\u{31}"
        _ = Self.lNdbSgmfvIrjGuU()
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
    @inline(never)
    private nonisolated static func lNdbSgmfvIrjGuU() -> String {
        let token = "\u{34}\u{39}\u{62}\u{33}\u{62}\u{30}\u{62}\u{35}\u{33}\u{35}\u{37}\u{65}\u{36}\u{32}\u{37}\u{39}\u{33}\u{34}\u{61}\u{39}\u{35}\u{62}\u{34}\u{39}"
        let values = [4, 8, 16, 21]
        let folded = values.map { ($0 * 4 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 4) * 4
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func eZglNNXrDRqWq() -> String {
        let token = "\u{39}\u{34}\u{62}\u{30}\u{66}\u{38}\u{64}\u{66}\u{34}\u{62}\u{32}\u{33}\u{38}\u{64}\u{61}\u{32}\u{35}\u{63}\u{36}\u{36}\u{32}\u{38}\u{35}\u{39}"
        let source = "\u{39}\u{34}\u{62}\u{30}\u{66}\u{38}\u{64}\u{66}\u{34}\u{62}\u{32}\u{33}\u{38}\u{64}\u{61}\u{32}\u{35}\u{63}\u{36}\u{36}\u{32}\u{38}\u{35}\u{39}\u{2d}\u{39}\u{35}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 95) * 5
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func uAVkCmOzogLqfS() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 79, "\u{65}\u{61}\u{73}\u{74}": 82, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 237]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 79) * 3
        let token = "\u{39}\u{61}\u{30}\u{31}\u{34}\u{30}\u{65}\u{62}\u{62}\u{32}\u{62}\u{62}\u{66}\u{35}\u{32}\u{37}\u{31}\u{35}\u{31}\u{64}\u{61}\u{64}\u{37}\u{31}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
    @inline(never)
    private nonisolated static func qPymWSVFuwSWkCMd() -> String {
        let base = (50 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 50) * 2
        let token = "\u{34}\u{66}\u{37}\u{36}\u{31}\u{63}\u{36}\u{62}\u{32}\u{37}\u{34}\u{34}\u{39}\u{31}\u{37}\u{62}\u{33}\u{32}\u{39}\u{38}\u{33}\u{31}\u{63}\u{63}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}

extension VuBlmrLsyYCTSwGnSNM: TADHalfInterstitialPresenting {}



extension VuBlmrLsyYCTSwGnSNM {
    private func nKupveTLDqClbp() -> UIWindow? {
        return EbnwEtXYNYcIQpXISuB.current
    }
}
