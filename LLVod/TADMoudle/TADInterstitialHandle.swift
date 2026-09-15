//
//  TADInterstitialHandle.swift
//  LittleVod
//
//  Created by minusapple on 2025/12/20.
//

import UIKit
import AnyThinkSDK

class TADInterstitialHandle: UIView, ATAdLoadingDelegate, ATInterstitialDelegate {
    
    private var retryAttempt: Int = 0
    var interstitialHalfCompleted:((_ position: Int, _ type: TADResultType)->Void)?
    private var ifadId: String!
    var positionType: Int = 0
    
    func showInterstitialHalf(adId: String, position: Int = 0) {
        guard TADConfigHandler.shouldShowInterstitial else {
            interstitialHalfCompleted?(position, .didClose)
            return
        }
        if !adId.isEmpty {
            positionType = position
            ifadId = adId
            var loadConfigDict: [String: Any] = [:]
            loadConfigDict[kATAdLoadingExtraMediaExtraKey] = "media_val_InterstitialVC"
            
            ATAdManager.shared().loadAD(withPlacementID: adId,
                                        extra: loadConfigDict,
                                        delegate: self)
        }
    }
    
    // MARK: - Show Ad
    func showAd() {
        // 场景统计
        ATAdManager.shared().entryInterstitialScenario(withPlacementID: ifadId, scene: "")
        
        guard ATAdManager.shared().interstitialReady(forPlacementID: ifadId) else {
            showInterstitialHalf(adId: ifadId, position: positionType)
            return
        }
        
        let config = ATShowConfig(scene: "", showCustomExt: "testShowCustomExt")
        if let win = currentWindow(), let current: UIViewController = win.rootViewController {
            ATAdManager.shared().showInterstitial(withPlacementID: ifadId,
                                                  showConfig: config,
                                                  in: current,
                                                  delegate: self,
                                                  nativeMixViewBlock: nil)
        }
        
    }
    
    private func currentWindow() -> UIWindow? {
        return AppWindow.current
    }
    
    // MARK: - ATAdLoadingDelegate
    func didFinishLoadingAD(withPlacementID placementID: String) {
        retryAttempt = 0
        showAd()
    }
    
    func didFailToLoadAD(withPlacementID placementID: String, error: Error) {
        guard retryAttempt < 3 else {
            interstitialHalfCompleted?(positionType, .loadFail)
            return
        }
        
        retryAttempt += 1
        let delaySec = Int(pow(2.0, Double(min(3, retryAttempt))))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySec)) { [weak self] in
            guard let self  = self else {return}
            self.showInterstitialHalf(adId: ifadId, position: positionType)
        }
    }
    
    // MARK: - ATInterstitialDelegate
    func didRevenue(forPlacementID placementID: String, extra: [AnyHashable : Any]) {}
    
    func interstitialDidShow(forPlacementID placementID: String, extra: [AnyHashable : Any]) {}
    
    public func interstitialFailedToShow(forPlacementID placementID: String,
                                         error: Error,
                                         extra: [AnyHashable : Any]) {
        interstitialHalfCompleted?(positionType, .loadFail)
    }
    
    func interstitialDidFailToPlayVideo(forPlacementID placementID: String,
                                               error: Error,
                                               extra: [AnyHashable : Any]) {
        interstitialHalfCompleted?(positionType, .loadFail)
    }
    
    func interstitialDidStartPlayingVideo(forPlacementID placementID: String,
                                                 extra: [AnyHashable : Any]) {}
    
    func interstitialDidEndPlayingVideo(forPlacementID placementID: String,
                                               extra: [AnyHashable : Any]) {
    }
    
    func interstitialDidClose(forPlacementID placementID: String,
                                     extra: [AnyHashable : Any]) {
        interstitialHalfCompleted?(positionType, .didClose)
    }
    
    func interstitialDidClick(forPlacementID placementID: String,
                                     extra: [AnyHashable : Any]) {
        interstitialHalfCompleted?(positionType, .loadFail)
    }
}

