//
//  TADConfigHandle.swift
//  LittleVod
//
//  Created by minusapple on 2025/12/20.
//

import Foundation
import AnyThinkSDK
import UIKit

enum TADResultType: Int {
    case loadFail = 0
    case didClose
    case success
}

struct TADConfigHandler {

    static let selfRenderFeedPlacementID = "b6a7c5ada7e1e3"
    static let templateFeedPlacementID = "b6a7c49676cac4"
    static let halfInterstitialPlacementID = "b6a7c453a5c754"
    static let rewardPlacementID = "b6a7c453b05f33"

    static var shouldShowInterstitial: Bool {
        UIDevice.current.userInterfaceIdiom != .pad
    }
    
    static let feedFlowAdProvider: TADFeedFlowHandle = TADFeedFlowHandle()
    static let fullAdProvider: TADFullScreenHandle = TADFullScreenHandle()
    static let halfAdProvider: TADInterstitialHandle = TADInterstitialHandle()
    static let rewardADProvider: TADRewardingHandle = TADRewardingHandle()

    private static var observers: [NSObjectProtocol] = []
    private static var didRegisterObservers = false
    
    private static func setup(appid: String, appkey: String,_ completed: @escaping (Bool) -> Void) {
        if !appid.isEmpty && !appkey.isEmpty {
            ATAPI.setLogEnabled(false)
            ATAPI.integrationChecking()
            do {
                try ATAPI.sharedInstance().start(withAppID: appid, appKey: appkey)
                completed(true)
            } catch {
                completed(false)
            }
        }
    }
    
    static func config() {
        guard !didRegisterObservers else { return }
        didRegisterObservers = true
        
        // 初始化 ADSDK
        observers.append(
            NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TxAdInitliazeRequest"), object: nil, queue: .main) { notification in
                if let userInfo = notification.userInfo, let appId = userInfo["AppId"] as? String, let AppKey = userInfo["AppKey"] as? String {
                    setup(appid: appId, appkey: AppKey) { isSuccess in
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdInitliazeReponse"), object: nil, userInfo: [
                            "isSuccess": isSuccess
                        ])
                    }
                }
            }
        )
        
        fullAdProvider.fullScreenCompleted = { type in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdFullInterstitialResponse"), object: nil, userInfo: [
                "type": type.rawValue
            ])
        }
        
        observers.append(
            NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TxAdFullInterstitialRequest"), object: nil, queue: .main) { notification in
                if let userInfo = notification.userInfo, let adId = userInfo["adId"] as? String {
                    self.fullAdProvider.showFullScreen(adId: adId)
                }
            }
        )
        
        halfAdProvider.interstitialHalfCompleted = { position, type in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdInterstHalfResponse"), object: nil, userInfo: [
                "type": type.rawValue,
                "position": position
            ])
        }
        
        observers.append(
            NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TxAdInterstHalfRequest"), object: nil, queue: .main) { notification in
                guard Self.shouldShowInterstitial else { return }
                if let userInfo = notification.userInfo, let adId = userInfo["adId"] as? String, let position = userInfo["position"] as? Int   {
                    self.halfAdProvider.showInterstitialHalf(adId: adId, position: position)
                }
            }
        )

        feedFlowAdProvider.feedFlowCompleted = { position, type, adView in
            if type == .success,let view: UIView = adView {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdFeedFlowResponse"), object: nil, userInfo: [
                    "type": type.rawValue,
                    "view": view,
                    "position": position
                ])
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdFeedFlowResponse"), object: nil, userInfo: [
                    "type": type.rawValue,
                    "view": "",
                    "position": position
                ])
            }
        }
        
        observers.append(
            NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TxAdFeedFlowRequest"), object: nil, queue: .main) { notification in
                if let userInfo = notification.userInfo, let adId = userInfo["adId"] as? String, let position = userInfo["position"] as? Int {
                    self.feedFlowAdProvider.showFeedFlow(adId: adId, position: position)
                }
            }
        )
        
        rewardADProvider.rewardCompleted = { type, transId, placementId in
            if type == .success {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdRewardResponse"), object: nil, userInfo: [
                    "type": type.rawValue,
                    "transId": transId,
                    "placementId": placementId
                ])
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdRewardResponse"), object: nil, userInfo: [
                    "type": type.rawValue,
                    "transId": "",
                    "placementId": ""
                ])
            }
        }
        
        observers.append(
            NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TxAdRewardRequest"), object: nil, queue: .main) { notification in
                if let userInfo = notification.userInfo, let adId = userInfo["adId"] as? String {
                    self.rewardADProvider.showReward(adId: adId)
                }
            }
        )
        
    }
    
}
