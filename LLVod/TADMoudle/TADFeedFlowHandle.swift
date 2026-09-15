//
//  TADFeedFlowHandle.swift
//  LittleVod
//
//  Created by minusapple on 2025/12/20.
//

import UIKit
import AnyThinkSDK

class TADFeedFlowHandle: UIView, ATNativeADDelegate {
    
    var positionType: Int = 0
    private var feedFlowAd: ATNativeADView?
    var feedFlowCompleted:((_ position: Int, _ type: TADResultType, _ view: UIView?)->Void)?
    private var retryAttempt: Int = 0
    private var ffadId: String!
    
    func showFeedFlow(adId: String, position: Int = 0) {
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
     
    // MARK: - ATNativeADDelegate
    func didFinishLoadingAD(withPlacementID placementID: String) {
        retryAttempt = 0
        showAd()
    }
    
    func didFailToLoadAD(withPlacementID placementID: String, error: Error) {
        guard retryAttempt < 3 else {
            feedFlowCompleted?(positionType, .loadFail, nil)
            return
        }
        
        retryAttempt += 1
        let delaySec = Int(pow(2.0, Double(min(3, retryAttempt))))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySec)) { [weak self] in
            guard let self = self else {return}
            self.showFeedFlow(adId: self.ffadId, position: self.positionType)
        }
    }
    
    func showAd() {
        ATAdManager.shared().entryNativeScenario(withPlacementID: ffadId, scene: "")
        guard ATAdManager.shared().nativeAdReady(forPlacementID: ffadId) else {
            showFeedFlow(adId: ffadId, position: positionType)
            return
        }
        
        let config = ATNativeADConfiguration()
        config.adFrame = CGRect(x: 0,
                                y: 0,
                                width: UIScreen.main.bounds.width,
                                height: 200)
        config.delegate = self
        if let win = currentWindow(), let current: UIViewController = win.rootViewController {
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
        feedFlowCompleted?(positionType, .success, feedFlowAd)
    }
    
    private func currentWindow() -> UIWindow? {
        return AppWindow.current
    }
    
    // MARK: - Delegate callbacks
    func didRevenue(forPlacementID placementID: String, extra: [AnyHashable : Any]) {}
    
    func didShowNativeAd(in adView: ATNativeADView,
                                placementID: String,
                                extra: [AnyHashable : Any]) {}
    
    func didTapCloseButton(in adView: ATNativeADView,
                                  placementID: String,
                                  extra: [AnyHashable : Any]) {
        feedFlowCompleted?(positionType, .didClose, nil)
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
}


