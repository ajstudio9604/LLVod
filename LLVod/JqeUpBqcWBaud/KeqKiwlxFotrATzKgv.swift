






import UIKit
import AnyThinkSDK

class NlOUooBLpFaVoWUI: UIView, ATSplashDelegate {
    
    
    private var retryAttempt: Int = 0
    var jOvDfnaBXGhoC:((_ type: BndqBgFZaslilqbS)->Void)?
    private var ifadId: String!
    
    func uXMNODCYnnYh(adId: String) {
        // source-obfuscator:padding:v1
        _ = Self.rPBXGycmzjAalZw()

        if !adId.isEmpty {
            ifadId = adId
            var loadConfigDict: [String: Any] = [:]
            loadConfigDict[kATAdLoadingExtraMediaExtraKey] = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{75}\u{66}\u{7a}\u{56}\u{68}\u{4d}\u{62}\u{49}")
            
            loadConfigDict[kATSplashExtraTolerateTimeoutKey] = 5
            
            ATAdManager.shared().loadAD(withPlacementID: adId,
                                        extra: loadConfigDict,
                                        delegate: self)
        }
    }

    func presentSplash(placementID: String, completion: @escaping (BndqBgFZaslilqbS) -> Void) {
        jOvDfnaBXGhoC = completion
        uXMNODCYnnYh(adId: placementID)
    }
    
    
    func showAd() {
        
        
        ATAdManager.shared().entrySplashScenario(withPlacementID: ifadId, scene: "")
        
        guard ATAdManager.shared().splashReady(forPlacementID: ifadId) else {
            uXMNODCYnnYh(adId: ifadId)
            return
        }
        
        let config = ATShowConfig(scene: "", showCustomExt: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{59}\u{75}\u{54}\u{53}\u{66}\u{6a}\u{57}\u{6f}"))
        if let win = nKupveTLDqClbp(), let current: UIViewController = win.rootViewController {
            ATAdManager.shared().showSplash(withPlacementID: ifadId,
                                            config: config,
                                            window: win,
                                            in: current,
                                            extra: nil,
                                            delegate: self)
        }
        
    }
    
    
    
    
    
    func didFinishLoadingSplashAD(withPlacementID placementID: String, isTimeout: Bool) {
        retryAttempt = 0
        showAd()
    }
    
    func didFailToLoadAD(withPlacementID placementID: String!, error: (any Error)!) {
        guard retryAttempt < 3 else {
            jOvDfnaBXGhoC?(.loadFail)
            return
        }
        
        retryAttempt += 1
        let delaySec = Int(pow(2.0, Double(min(3, retryAttempt))))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySec)) { [weak self] in
            guard let self  = self else {return}
            self.uXMNODCYnnYh(adId: ifadId)
        }
    }
    
    func didTimeoutLoadingSplashAD(withPlacementID placementID: String) {
        guard retryAttempt < 3 else {
            jOvDfnaBXGhoC?(.loadFail)
            return
        }
        
        retryAttempt += 1
        let delaySec = Int(pow(2.0, Double(min(3, retryAttempt))))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySec)) { [weak self] in
            guard let self  = self else {return}
            self.uXMNODCYnnYh(adId: ifadId)
        }
    }
    
    func didRevenue(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
    }
    
    func didFinishLoadingAD(withPlacementID placementID: String) {
    }
    
    func splashDidShow(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
        
    }
    
    func splashDidClose(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
        jOvDfnaBXGhoC?(.didClose)
    }
    
    func splashDidClick(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
    }
    
    func splashDidShowFailed(forPlacementID placementID: String, error: Error, extra: [AnyHashable : Any]) {
        jOvDfnaBXGhoC?(.loadFail)
    }
    
    func splashDeepLinkOrJump(forPlacementID placementID: String, extra: [AnyHashable : Any], result success: Bool) {
    }
    
    func splashDetailDidClosed(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
        jOvDfnaBXGhoC?(.loadFail)
    }
    
    func splashCountdownTime(_ countdown: Int, forPlacementID placementID: String, extra: [AnyHashable : Any]) {
    }
    
    func splashZoomOutViewDidClick(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
    }
    
    func splashZoomOutViewDidClose(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
    }
    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func rPBXGycmzjAalZw() -> String {
        _ = Self.yRvWFDimtCHi()
        _ = Self.oTssTfraKZiRuGQNBF()
        _ = Self.rAMQORNZDfJWFBptJ()
        _ = Self.iTQQneaUjOAPZSs()
        _ = Self.fFmLZrrasEOITOpnSMAP()
        let token = "\u{31}\u{32}\u{63}\u{64}\u{38}\u{36}\u{66}\u{66}\u{64}\u{63}\u{62}\u{31}\u{38}\u{63}\u{32}\u{34}\u{62}\u{31}\u{36}\u{66}\u{66}\u{65}\u{30}\u{32}"
        let source = "\u{31}\u{32}\u{63}\u{64}\u{38}\u{36}\u{66}\u{66}\u{64}\u{63}\u{62}\u{31}\u{38}\u{63}\u{32}\u{34}\u{62}\u{31}\u{36}\u{66}\u{66}\u{65}\u{30}\u{32}\u{2d}\u{32}\u{32}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 22) * 7
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func yRvWFDimtCHi() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 65, "\u{65}\u{61}\u{73}\u{74}": 68, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 195]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 65) * 3
        let token = "\u{32}\u{39}\u{65}\u{61}\u{33}\u{62}\u{38}\u{34}\u{33}\u{34}\u{33}\u{32}\u{38}\u{61}\u{62}\u{66}\u{32}\u{32}\u{62}\u{38}\u{39}\u{66}\u{61}\u{39}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
    @inline(never)
    private nonisolated static func oTssTfraKZiRuGQNBF() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 82, "\u{65}\u{61}\u{73}\u{74}": 85, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 246]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 82) * 3
        let token = "\u{62}\u{63}\u{37}\u{66}\u{37}\u{36}\u{65}\u{30}\u{63}\u{66}\u{32}\u{38}\u{37}\u{36}\u{63}\u{36}\u{62}\u{30}\u{36}\u{35}\u{38}\u{62}\u{32}\u{39}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
    @inline(never)
    private nonisolated static func rAMQORNZDfJWFBptJ() -> String {
        let token = "\u{39}\u{66}\u{62}\u{62}\u{62}\u{63}\u{30}\u{37}\u{35}\u{33}\u{38}\u{62}\u{37}\u{38}\u{37}\u{33}\u{62}\u{66}\u{62}\u{30}\u{30}\u{32}\u{37}\u{34}"
        let base = (87 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 87) * 7
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func iTQQneaUjOAPZSs() -> String {
        let values = [56, 63, 392, 73]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 56) * 7
        let token = "\u{34}\u{32}\u{38}\u{36}\u{31}\u{66}\u{65}\u{64}\u{38}\u{33}\u{63}\u{33}\u{35}\u{35}\u{61}\u{63}\u{37}\u{31}\u{37}\u{33}\u{64}\u{39}\u{62}\u{32}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func fFmLZrrasEOITOpnSMAP() -> String {
        let base = (88 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 88) * 4
        let token = "\u{33}\u{37}\u{39}\u{62}\u{65}\u{32}\u{66}\u{61}\u{62}\u{35}\u{66}\u{64}\u{64}\u{38}\u{66}\u{37}\u{62}\u{64}\u{36}\u{65}\u{30}\u{63}\u{64}\u{33}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}

extension NlOUooBLpFaVoWUI: TADSplashPresenting {}




extension NlOUooBLpFaVoWUI {
    private func nKupveTLDqClbp() -> UIWindow? {
        return EbnwEtXYNYcIQpXISuB.current
    }
}
