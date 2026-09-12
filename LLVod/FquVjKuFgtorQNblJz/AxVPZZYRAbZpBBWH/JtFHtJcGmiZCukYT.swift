






import SwiftUI

struct MfNftjWZkgXxeMIE: View {

    @ObservedObject private var appConfig = KxKjCCiFrdtCTwJh.shared
    @Environment(\.dismiss) private var dismiss
    @State private var openFailedHint: String?
    @State private var failedLink: (url: String, name: String)?
    @State private var isOpening = false

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.oBJDmsBBHgHECNsaSd()

        NavigationView {
            List {
                if !appConfig.qqGroupURL.isEmpty {
                    Button {
                        gPnwbPvSUobZIyvHwK(appConfig.qqGroupURL, name: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{62}\u{58}\u{57}\u{30}\u{48}\u{41}\u{72}\u{4c}"))
                    } label: {
                        Label(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{79}\u{36}\u{35}\u{38}\u{55}\u{65}\u{44}\u{6c}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{64}\u{63}\u{68}\u{61}\u{68}\u{74}\u{53}\u{66}"))
                    }
                }

                if !appConfig.tgGroupURL.isEmpty {
                    Button {
                        gPnwbPvSUobZIyvHwK(appConfig.tgGroupURL, name: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{64}\u{77}\u{42}\u{46}\u{77}\u{71}\u{70}\u{57}"))
                    } label: {
                        Label(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{69}\u{67}\u{52}\u{30}\u{30}\u{58}\u{79}\u{37}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{41}\u{35}\u{69}\u{41}\u{78}\u{72}\u{5a}\u{31}"))
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{66}\u{4b}\u{73}\u{6a}\u{34}\u{41}\u{49}\u{59}\u{66}"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{6a}\u{77}\u{42}\u{70}\u{64}\u{77}\u{6c}\u{70}")) { dismiss() }
                }
            }
            .ahInlineError(message: openFailedHint, isLoading: isOpening) {
                hItdkkyIZPkFlHXZtFtl()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func oBJDmsBBHgHECNsaSd() -> String {
        let token = "\u{33}\u{31}\u{39}\u{62}\u{32}\u{39}\u{35}\u{34}\u{38}\u{38}\u{33}\u{63}\u{63}\u{66}\u{37}\u{61}\u{36}\u{33}\u{37}\u{32}\u{34}\u{36}\u{66}\u{34}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{38}\u{30}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 80) * 3
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension MfNftjWZkgXxeMIE {
    private func hItdkkyIZPkFlHXZtFtl() {
        guard let failedLink else { return }
        gPnwbPvSUobZIyvHwK(failedLink.url, name: failedLink.name)
    }

    private func gPnwbPvSUobZIyvHwK(_ raw: String, name: String) {
        guard let url = URL(string: raw), !raw.isEmpty else {
            openFailedHint = "\(name)\u{94fe}\u{63a5}\u{65e0}\u{6548}"
            failedLink = nil
            return
        }

        openFailedHint = nil
        failedLink = nil
        isOpening = true
        UIApplication.shared.open(url, options: [:]) { success in
            DispatchQueue.main.async {
                isOpening = false
                if !success {
                    failedLink = (raw, name)
                    openFailedHint = "\u{65e0}\u{6cd5}\u{6253}\u{5f00}\(name)\u{94fe}\u{63a5}"
                } else {
                    dismiss()
                }
            }
        }
    }
}
