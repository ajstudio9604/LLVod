//
//  Home.swift
//  LLVod
//
//  Created by minusapple on 2026/9/1.
//

import SwiftUI

struct HomeApp: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject private var appConfig = AHAppConfig.shared
    @State private var didReportLaunch = false
    
    @State private var skipNextForeground = true

    var body: some View {
        MainTabView()
            .preferredColorScheme(themeManager.mainTheme.colorScheme)
            .onAppear {
                
                themeManager.reapplyInterfaceStyle()
                
                guard !didReportLaunch else { return }
                didReportLaunch = true
                TADHalfInterstitialScheduler.shared.start()
                Task.detached(priority: .utility) {
                    await AHChannelReportUtil.reportLaunch()
                }
                Task {
                    await AHYunCloudService.syncIfLoggedIn()
                }
            }
            .onChange(of: scenePhase) { phase in
                guard phase == .active else { return }
                if skipNextForeground {
                    skipNextForeground = false
                    return
                }
                Task.detached(priority: .utility) {
                    TADConfigHandler.config()
                    await AHChannelReportUtil.reportForeground()
                }
                Task {
                    await AHYunCloudService.syncIfLoggedIn()
                }
            }
            .overlay {
                if let notice = appConfig.pendingNotice {
                    AHAppNoticeDialog(
                        info: notice,
                        onConfirm: {
                            appConfig.dismissNotice(neverShowAgain: false)
                        },
                        onNeverShowAgain: {
                            appConfig.dismissNotice(neverShowAgain: true)
                        }
                    )
                    .environmentObject(themeManager)
                    .transition(.opacity)
                    .zIndex(2)
                } else if let update = appConfig.pendingUpdate {
                    AHAppUpdateDialog(
                        info: update,
                        onUpdate: {
                            appConfig.openUpdateURL()
                        },
                        onIgnore: {
                            appConfig.dismissUpdate()
                        }
                    )
                    .environmentObject(themeManager)
                    .transition(.opacity)
                    .zIndex(2)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: appConfig.pendingNotice?.id)
            .animation(.easeInOut(duration: 0.2), value: appConfig.pendingUpdate?.id)
    }
}
