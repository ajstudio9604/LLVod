//
//  TADRewardingHandle.swift
//  LittleVod
//
//  Created by minusapple on 2025/12/20.
//

import Foundation
import AnyThinkSDK

class TADRewardingHandle: UIView, ATAdLoadingDelegate, ATRewardedVideoDelegate {
  
    
    
    private var retryAttempt: Int = 0
    private var rewardedId: String!
    private var transId: String = ""
    var rewardCompleted:((_ type: TADResultType, _ transId: String, _ placementId: String)->Void)?
    
    func showReward(adId: String) {
        if !adId.isEmpty {
            rewardedId = adId
            var loadConfigDict: [String: Any] = [:]
            // 可选参数：服务端激励验证相关
            loadConfigDict[kATAdLoadingExtraMediaExtraKey] = "media_val_RewardedVC"
            loadConfigDict[kATAdLoadingExtraUserIDKey] = "rv_test_user_id"
            loadConfigDict[kATAdLoadingExtraRewardNameKey] = "reward_Name"
            loadConfigDict[kATAdLoadingExtraRewardAmountKey] = 3
            
            ATAdManager.shared().loadAD(withPlacementID: adId,
                                        extra: loadConfigDict,
                                        delegate: self)
        }
    }
    
    // MARK: - ATAdLoadingDelegate
    func didFinishLoadingAD(withPlacementID placementID: String) {
        retryAttempt = 0
        showAd()
    }
    
    func didFailToLoadAD(withPlacementID placementID: String, error: Error) {
        guard retryAttempt < 3 else {
            rewardCompleted?(.loadFail, "", "")
            return
        }
        
        retryAttempt += 1
        let delaySec = Int(pow(2.0, Double(min(3, retryAttempt))))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySec)) {
            self.showReward(adId: self.rewardedId)
        }
    }
    
    // MARK: - Show Ad
    private func showAd() {
        // 场景统计
        ATAdManager.shared().entryRewardedVideoScenario(withPlacementID: rewardedId, scene: "")
        
        guard ATAdManager.shared().rewardedVideoReady(forPlacementID: rewardedId) else {
            self.showReward(adId: self.rewardedId)
            return
        }
        
        let config = ATShowConfig(scene: "", showCustomExt: "showCustomExt")
        if let win = currentWindow(), let current: UIViewController = win.rootViewController {
            ATAdManager.shared().showRewardedVideo(withPlacementID: rewardedId,
                                                   config: config,
                                                   in: current,
                                                   delegate: self)
        }
        
    }
    
    private func currentWindow() -> UIWindow? {
        return AppWindow.current
    }
    
    // MARK: - ATRewardedVideoDelegate
    func rewardedVideoDidRewardSuccess(forPlacemenID placementID: String, extra: [AnyHashable : Any]) {
        transId = UUID().uuidString
        rewardCompleted?(.success, transId, rewardedId)
    }
    
    func rewardedVideoDidStartPlaying(forPlacementID placementID: String, extra: [AnyHashable : Any]) {}
    
    func rewardedVideoDidEndPlaying(forPlacementID placementID: String, extra: [AnyHashable : Any]) {}
    
    func rewardedVideoDidFailToPlay(forPlacementID placementID: String,
                                           error: Error,
                                           extra: [AnyHashable : Any]) {
        rewardCompleted?(.loadFail, "", "")
    }
    
    func rewardedVideoDidClose(forPlacementID placementID: String,
                                      rewarded: Bool,
                                      extra: [AnyHashable : Any]) {
        rewardCompleted?(.didClose, "", "")
    }
    
    func rewardedVideoDidClick(forPlacementID placementID: String,
                                      extra: [AnyHashable : Any]) {}
    
    func rewardedVideoDidDeepLinkOrJump(forPlacementID placementID: String,
                                               extra: [AnyHashable : Any],
                                               result: Bool) {}
    func onRewardedSuccessRetry(forPlacemenID placementID: String, extra: [AnyHashable : Any]?) {}
    
}

