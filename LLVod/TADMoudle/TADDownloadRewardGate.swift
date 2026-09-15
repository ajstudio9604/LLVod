//
//  TADDownloadRewardGate.swift
//  LLVod
//
//  下载需看激励视频，解锁 24 小时。通过 TxAdRewardRequest / TxAdRewardResponse 通知触发。
//

import Foundation

final class TADDownloadRewardGate {

    static let shared = TADDownloadRewardGate()

    static let unlockDuration: TimeInterval = 24 * 60 * 60
    private static let unlockUntilKey = "tad.download.reward.unlockUntil"

    private var observer: NSObjectProtocol?
    private var waiting = false
    private var completion: ((Bool) -> Void)?

    private init() {
        observer = NotificationCenter.default.addObserver(
            forName: Notification.Name(rawValue: "TxAdRewardResponse"),
            object: nil,
            queue: .main
        ) { [weak self] notification in
            self?.handleResponse(notification)
        }
    }

    var isUnlocked: Bool {
        Date().timeIntervalSince1970 < UserDefaults.standard.double(forKey: Self.unlockUntilKey)
    }

    func authorize(_ completion: @escaping (Bool) -> Void) {
        if isUnlocked {
            completion(true)
            return
        }
        guard !waiting else { return }
        waiting = true
        self.completion = completion
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "TxAdRewardRequest"),
            object: nil,
            userInfo: ["adId": TADConfigHandler.rewardPlacementID]
        )
    }

    private func handleResponse(_ notification: Notification) {
        guard waiting else { return }
        let raw = notification.userInfo?["type"] as? Int
        let type = raw.flatMap(TADResultType.init(rawValue:))

        switch type {
        case .success:
            let until = Date().timeIntervalSince1970 + Self.unlockDuration
            UserDefaults.standard.set(until, forKey: Self.unlockUntilKey)
            finish(granted: true)
        case .loadFail, .didClose:
            finish(granted: false)
        case .none:
            finish(granted: false)
        }
    }

    private func finish(granted: Bool) {
        waiting = false
        let callback = completion
        completion = nil
        callback?(granted)
    }
}
