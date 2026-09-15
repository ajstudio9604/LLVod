//
//  TADHalfInterstitialScheduler.swift
//  LLVod
//
//  半插屏：首次安装进 App 不弹；再次冷启动 / 回前台才弹。
//  之后每 50 分钟弹一次。播放页不弹，离开播放页再补弹。
//  通过 TxAdInterstHalfRequest 通知触发，见 TADConfigHandler。
//

import Foundation
import UIKit

final class TADHalfInterstitialScheduler {

    static let shared = TADHalfInterstitialScheduler()

    static let interval: TimeInterval = 50 * 60

    private static let hasLaunchedKey = "tad.half.hasLaunchedOnce"

    private var timer: Timer?
    private var started = false
    private var allowShow = false
    private var pending = false
    private var playPageCount = 0
    private var foregroundObserver: NSObjectProtocol?

    private init() {}

    var isOnPlayPage: Bool { playPageCount > 0 }

    func start() {
        guard TADConfigHandler.shouldShowInterstitial else { return }
        guard !started else { return }
        started = true

        foregroundObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.handleForeground()
        }

        if !UserDefaults.standard.bool(forKey: Self.hasLaunchedKey) {
            UserDefaults.standard.set(true, forKey: Self.hasLaunchedKey)
            allowShow = false
            scheduleTimer()
            return
        }

        allowShow = true
        tryShow()
        scheduleTimer()
    }

    func enterPlayPage() {
        playPageCount += 1
    }

    func leavePlayPage() {
        playPageCount = max(0, playPageCount - 1)
        guard playPageCount == 0, pending else { return }
        tryShow()
    }

    private func handleForeground() {
        allowShow = true
        tryShow()
    }

    private func tryShow() {
        guard TADConfigHandler.shouldShowInterstitial else { return }
        guard started, allowShow else { return }
        if isOnPlayPage {
            pending = true
            return
        }
        pending = false
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "TxAdInterstHalfRequest"),
            object: nil,
            userInfo: [
                "adId": TADConfigHandler.halfInterstitialPlacementID,
                "position": 0
            ]
        )
        scheduleTimer()
    }

    private func scheduleTimer() {
        timer?.invalidate()
        let timer = Timer(timeInterval: Self.interval, repeats: true) { [weak self] _ in
            self?.tryShow()
        }
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }
}
