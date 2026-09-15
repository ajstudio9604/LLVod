//
//  MTSplashPageController.swift
//  Pods
//
//  Created by minusapple on 2025/8/1.
//

import SwiftUI
import UIKit
import Combine

struct AppRootView: View {
    @StateObject private var flow = SplashFlow()

    var body: some View {
        if flow.didEnterMain {
            HomeApp()
                .environmentObject(ThemeManager.shared)
        } else {
            SplashPageView()
                .onAppear(perform: flow.start)
        }
    }
}

struct SplashPageView: View {
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            Image("rotationAll")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .controlSize(.large)

                Text("加载中…")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color.white.opacity(0.92))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 72)
            
        }
    }
}

final class SplashFlow: ObservableObject {
    
    @Published var didEnterMain = false

    private var observers: [NSObjectProtocol] = []
    private var didStart = false
    private var windowWaitCount = 0

    func start() {
        guard !didStart else { return }

        if AppWindow.current == nil, windowWaitCount < 30 {
            windowWaitCount += 1
            DispatchQueue.main.async { [weak self] in
                self?.start()
            }
            return
        }

        didStart = true

        Bundle.main.custom_setBundleIdentifier("com.jihaoAiPP.jihao")

        let initObserver = NotificationCenter.default.addObserver(
            forName: Notification.Name(rawValue: "TxAdInitliazeReponse"),
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.adLoadFinish(splashID: "b6a7c453952170")
        }
        let interstitialObserver = NotificationCenter.default.addObserver(
            forName: Notification.Name(rawValue: "TxAdFullInterstitialResponse"),
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.gotoMainPage()
        }
        observers = [initObserver, interstitialObserver]

        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "TxAdInitliazeRequest"),
            object: nil,
            userInfo: [
                "AppId": "a6a7c450fba1e2",
                "AppKey": "a8c8b1e544ce401ad1452ebf01fed49cb"
            ]
        )
    }

    private func gotoMainPage() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            self.observers.forEach { NotificationCenter.default.removeObserver($0) }
            self.observers.removeAll()
            self.didEnterMain = true

            ThemeManager.shared.reapplyInterfaceStyle()
            AHTabBarAppearance.update(theme: ThemeManager.shared.mainTheme)
        }
    }

    private func adLoadFinish(splashID: String) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "TxAdFullInterstitialRequest"),
            object: nil,
            userInfo: [
                "adId": splashID
            ]
        )
    }

    deinit {
        observers.forEach { NotificationCenter.default.removeObserver($0) }
    }
}
