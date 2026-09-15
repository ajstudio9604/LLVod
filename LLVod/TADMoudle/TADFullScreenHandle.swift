//
//  TADFullScreenHandle.swift
//  LittleVod
//
//  Created by minusapple on 2025/12/20.
//

import UIKit
import AnyThinkSDK

class TADFullScreenHandle: UIView, ATSplashDelegate {
    
    
    private var retryAttempt: Int = 0
    var fullScreenCompleted:((_ type: TADResultType)->Void)?
    private var ifadId: String!
    
    func showFullScreen(adId: String) {
        if !adId.isEmpty {
            ifadId = adId
            var loadConfigDict: [String: Any] = [:]
            loadConfigDict[kATAdLoadingExtraMediaExtraKey] = "media_val_SplashVC"
            // 设置超时时间
            loadConfigDict[kATSplashExtraTolerateTimeoutKey] = 5
            
            ATAdManager.shared().loadAD(withPlacementID: adId,
                                        extra: loadConfigDict,
                                        delegate: self)
        }
    }
    
    // MARK: - Show Ad
    func showAd() {
        // 场景统计
        // 进入展示场景（可选）
        ATAdManager.shared().entrySplashScenario(withPlacementID: ifadId, scene: "")
        // 检查是否准备好广告
        guard ATAdManager.shared().splashReady(forPlacementID: ifadId) else {
            showFullScreen(adId: ifadId)
            return
        }
        
        let config = ATShowConfig(scene: "", showCustomExt: "showCustomExt")
        if let win = currentWindow(), let current: UIViewController = win.rootViewController {
            ATAdManager.shared().showSplash(withPlacementID: ifadId,
                                            config: config,
                                            window: win,
                                            in: current,
                                            extra: nil,
                                            delegate: self)
        }
        
    }
    
    private func currentWindow() -> UIWindow? {
        return AppWindow.current
    }
    
    // MARK: - ATSplashDelegate 回调
    
    func didFinishLoadingSplashAD(withPlacementID placementID: String, isTimeout: Bool) {
        retryAttempt = 0
        showAd()
    }
    
    func didFailToLoadAD(withPlacementID placementID: String!, error: (any Error)!) {
        guard retryAttempt < 3 else {
            fullScreenCompleted?(.loadFail)
            return
        }
        
        retryAttempt += 1
        let delaySec = Int(pow(2.0, Double(min(3, retryAttempt))))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySec)) { [weak self] in
            guard let self  = self else {return}
            self.showFullScreen(adId: ifadId)
        }
    }
    
    func didTimeoutLoadingSplashAD(withPlacementID placementID: String) {
        guard retryAttempt < 3 else {
            fullScreenCompleted?(.loadFail)
            return
        }
        
        retryAttempt += 1
        let delaySec = Int(pow(2.0, Double(min(3, retryAttempt))))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySec)) { [weak self] in
            guard let self  = self else {return}
            self.showFullScreen(adId: ifadId)
        }
    }
    
    func didRevenue(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
    }
    
    func didFinishLoadingAD(withPlacementID placementID: String) {
    }
    
    func splashDidShow(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
        
    }
    
    func splashDidClose(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
        fullScreenCompleted?(.didClose)
    }
    
    func splashDidClick(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
    }
    
    func splashDidShowFailed(forPlacementID placementID: String, error: Error, extra: [AnyHashable : Any]) {
        fullScreenCompleted?(.loadFail)
    }
    
    func splashDeepLinkOrJump(forPlacementID placementID: String, extra: [AnyHashable : Any], result success: Bool) {
    }
    
    func splashDetailDidClosed(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
        fullScreenCompleted?(.loadFail)
    }
    
    func splashCountdownTime(_ countdown: Int, forPlacementID placementID: String, extra: [AnyHashable : Any]) {
    }
    
    func splashZoomOutViewDidClick(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
    }
    
    func splashZoomOutViewDidClose(forPlacementID placementID: String, extra: [AnyHashable : Any]) {
    }
    
}


