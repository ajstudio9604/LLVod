






import UIKit
import AnyThinkSDK

class CuzGbbVgtuqcwNtCnREc: UIView, ATNativeADDelegate {
    
    var positionType: Int = 0
    private var feedFlowAd: ATNativeADView?
    var wPuUVilgZuUijSZZKhJ:((_ position: Int, _ type: BndqBgFZaslilqbS, _ view: UIView?)->Void)?
    private var retryAttempt: Int = 0
    private var ffadId: String!
    
    func eAAQYidEhWdN(adId: String, position: Int = 0) {
        // source-obfuscator:padding:v1
        _ = Self.qYGMeucJXSprPiNpm()

        if !adId.isEmpty {
            ffadId = adId
            positionType = position
            var loadConfigDict: [String: Any] = [:]
            loadConfigDict[kATExtraInfoNativeAdSizeKey] =
            NSValue(cgSize: CGSize(width: UIScreen.main.bounds.width, height: 200))
            
            ATAdManager.shared().loadAD(withPlacementID: adId,
                                        extra: loadConfigDict,
                                        delegate: self)
        }
    }

    func loadFeedFlow(
        placementID: String,
        position: Int,
        completion: @escaping (Int, BndqBgFZaslilqbS, UIView?) -> Void
    ) {
        wPuUVilgZuUijSZZKhJ = completion
        eAAQYidEhWdN(adId: placementID, position: position)
    }
     
    
    func didFinishLoadingAD(withPlacementID placementID: String) {
        retryAttempt = 0
        showAd()
    }
    
    func didFailToLoadAD(withPlacementID placementID: String, error: Error) {
        guard retryAttempt < 3 else {
            wPuUVilgZuUijSZZKhJ?(positionType, .loadFail, nil)
            return
        }
        
        retryAttempt += 1
        let delaySec = Int(pow(2.0, Double(min(3, retryAttempt))))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySec)) { [weak self] in
            guard let self = self else {return}
            self.eAAQYidEhWdN(adId: self.ffadId, position: self.positionType)
        }
    }
    
    func showAd() {
        ATAdManager.shared().entryNativeScenario(withPlacementID: ffadId, scene: "")
        guard ATAdManager.shared().nativeAdReady(forPlacementID: ffadId) else {
            eAAQYidEhWdN(adId: ffadId, position: positionType)
            return
        }
        
        let config = ATNativeADConfiguration()
        config.adFrame = CGRect(x: 0,
                                y: 0,
                                width: UIScreen.main.bounds.width,
                                height: 200)
        config.delegate = self
        if let win = nKupveTLDqClbp(), let current: UIViewController = win.rootViewController {
            config.rootViewController = current
        }
        config.sizeToFit = true
        let offer: ATNativeAdOffer = ATAdManager.shared().getNativeAdOffer(withPlacementID: ffadId, scene: "")!
        let nativeADView = ATNativeADView(configuration: config,
                                          currentOffer: offer,
                                          placementID: ffadId)
        
        offer.renderer(with: config,
                        selfRenderView: nil,
                        nativeADView: nativeADView)
        
        feedFlowAd = nativeADView
        wPuUVilgZuUijSZZKhJ?(positionType, .success, feedFlowAd)
    }
    
    
    
    
    func didRevenue(forPlacementID placementID: String, extra: [AnyHashable : Any]) {}
    
    func didShowNativeAd(in adView: ATNativeADView,
                                placementID: String,
                                extra: [AnyHashable : Any]) {}
    
    func didTapCloseButton(in adView: ATNativeADView,
                                  placementID: String,
                                  extra: [AnyHashable : Any]) {
        wPuUVilgZuUijSZZKhJ?(positionType, .didClose, nil)
    }
    
    func didStartPlayingVideo(in adView: ATNativeADView,
                                     placementID: String,
                                     extra: [AnyHashable : Any]) {}
    
    func didEndPlayingVideo(in adView: ATNativeADView,
                                   placementID: String,
                                   extra: [AnyHashable : Any]) {}
    
    func didClickNativeAd(in adView: ATNativeADView,
                                 placementID: String,
                                 extra: [AnyHashable : Any]) {}
    
    func didDeepLinkOrJump(in adView: ATNativeADView,
                                  placementID: String,
                                  extra: [AnyHashable : Any],
                                  result: Bool) {}
    
    func didEnterFullScreenVideo(in adView: ATNativeADView,
                                        placementID: String,
                                        extra: [AnyHashable : Any]) {}
    
    func didExitFullScreenVideo(in adView: ATNativeADView,
                                       placementID: String,
                                       extra: [AnyHashable : Any]) {}
    
    func didCloseDetail(in adView: ATNativeADView,
                               placementID: String,
                               extra: [AnyHashable : Any]) {}

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qYGMeucJXSprPiNpm() -> String {
        _ = Self.pLUasEBYdpcLGEPHNgJ()
        _ = Self.yNHWjlnpAmAnrgLuMp()
        _ = Self.fCSpneEwSToZ()
        _ = Self.gTHSkoGriGVj()
        let token = "\u{36}\u{31}\u{39}\u{30}\u{33}\u{66}\u{32}\u{34}\u{36}\u{34}\u{32}\u{65}\u{33}\u{35}\u{38}\u{31}\u{37}\u{32}\u{36}\u{64}\u{30}\u{34}\u{35}\u{63}"
        let values = [20, 29, 180, 37]
        let folded = values.map { ($0 * 9 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 20) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func pLUasEBYdpcLGEPHNgJ() -> String {
        let token = "\u{31}\u{62}\u{37}\u{63}\u{64}\u{32}\u{62}\u{64}\u{62}\u{61}\u{34}\u{32}\u{32}\u{31}\u{39}\u{64}\u{31}\u{33}\u{30}\u{64}\u{30}\u{35}\u{35}\u{64}"
        let base = (3 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 3) * 2
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func yNHWjlnpAmAnrgLuMp() -> String {
        let token = "\u{62}\u{66}\u{31}\u{38}\u{65}\u{32}\u{35}\u{64}\u{63}\u{61}\u{33}\u{35}\u{35}\u{65}\u{65}\u{39}\u{61}\u{38}\u{64}\u{62}\u{65}\u{61}\u{38}\u{62}"
        let source = "\u{62}\u{66}\u{31}\u{38}\u{65}\u{32}\u{35}\u{64}\u{63}\u{61}\u{33}\u{35}\u{35}\u{65}\u{65}\u{39}\u{61}\u{38}\u{64}\u{62}\u{65}\u{61}\u{38}\u{62}\u{2d}\u{33}\u{35}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 35) * 6
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func fCSpneEwSToZ() -> String {
        let values = [51, 57, 306, 68]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 51) * 6
        let token = "\u{31}\u{34}\u{35}\u{66}\u{37}\u{62}\u{63}\u{61}\u{35}\u{39}\u{61}\u{36}\u{36}\u{66}\u{61}\u{64}\u{39}\u{34}\u{31}\u{63}\u{34}\u{66}\u{33}\u{65}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func gTHSkoGriGVj() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{38}\u{30}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 80) * 2
        let token = "\u{61}\u{34}\u{39}\u{63}\u{35}\u{61}\u{66}\u{36}\u{30}\u{32}\u{33}\u{35}\u{32}\u{31}\u{37}\u{34}\u{32}\u{32}\u{36}\u{36}\u{34}\u{34}\u{38}\u{65}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}

extension CuzGbbVgtuqcwNtCnREc: TADFeedFlowLoading {}




extension CuzGbbVgtuqcwNtCnREc {
    private func nKupveTLDqClbp() -> UIWindow? {
        return EbnwEtXYNYcIQpXISuB.current
    }
}
