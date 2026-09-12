






import SwiftUI

struct FrGWBtqbQRvXdl: View {
    
    @EnvironmentObject var themeManager: CbyiPVoRONUJO
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject private var appConfig = KxKjCCiFrdtCTwJh.shared
    @State private var didReportLaunch = false
    
    @State private var skipNextForeground = true

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.iYHLOEPpNQRCTDzdHE()

        PsdtSIiEwfhxR()
            .preferredColorScheme(themeManager.mainTheme.colorScheme)
            .onAppear {
                
                themeManager.mBJhUAeLJMRjyQkL()
                
                guard !didReportLaunch else { return }
                didReportLaunch = true
                RcNNIyVJYfYB.shared.start()
                Task.detached(priority: .utility) {
                    await GrdkfZtnBgNnsjhkN.nPTzYuePVncWIoR()
                }
                Task {
                    await QoHoDspsGYUdeDIUYRh.zBMRnbLmKJgTfUQtw()
                }
            }
            .onChange(of: scenePhase) { phase in
                guard phase == .active else { return }
                if skipNextForeground {
                    skipNextForeground = false
                    return
                }
                RcNNIyVJYfYB.shared.aCfYVJxzfKftnwJjny()
                Task.detached(priority: .utility) {
                    await GrdkfZtnBgNnsjhkN.tDRzbvSsXUvvg()
                }
                Task {
                    await QoHoDspsGYUdeDIUYRh.zBMRnbLmKJgTfUQtw()
                }
            }
            .overlay {
                if let notice = appConfig.pendingNotice {
                    DwChOYcaotVZnACLRh(
                        info: notice,
                        eJUpagJkvjWJwD: {
                            appConfig.yWqSEwAfYMlZ(neverShowAgain: false)
                        },
                        mPZrHsJtAgry: {
                            appConfig.yWqSEwAfYMlZ(neverShowAgain: true)
                        }
                    )
                    .environmentObject(themeManager)
                    .transition(.opacity)
                    .zIndex(2)
                } else if let update = appConfig.pendingUpdate {
                    RfadHHbYkHmQHUVgeNU(
                        info: update,
                        jSLorqXgbbAiOQV: {
                            appConfig.cTfrIcfhkhggMd()
                        },
                        sTSemucQBxbCBqjMdNBi: {
                            appConfig.yCMnEXodGwuc()
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

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func iYHLOEPpNQRCTDzdHE() -> String {
        let token = "\u{38}\u{32}\u{64}\u{33}\u{33}\u{64}\u{31}\u{34}\u{31}\u{30}\u{34}\u{32}\u{33}\u{34}\u{61}\u{64}\u{33}\u{38}\u{38}\u{38}\u{37}\u{33}\u{37}\u{36}"
        let values = [90, 97, 630, 107]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 90) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

