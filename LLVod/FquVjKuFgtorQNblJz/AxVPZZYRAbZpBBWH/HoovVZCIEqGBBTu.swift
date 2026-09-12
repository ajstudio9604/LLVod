






import SwiftUI
import Kingfisher

struct MsnWYgNQvCobBfvI: View {

    @EnvironmentObject private var themeManager: CbyiPVoRONUJO
    @State private var showClearCacheConfirm = false
    @State private var toast: String?

    var body: some View {
        
        dIdfaXruKFwBLGgiKh()
    }

    

    

    
    @ViewBuilder
    @inline(never)
    private func dIdfaXruKFwBLGgiKh() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.uMVEzpCrsDykI()

        yOVnGWQbdhCqmLGV
    }

    @ViewBuilder
    private var yOVnGWQbdhCqmLGV: some View {
        List {
            nCEPOZyGwncw

            Section(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{77}\u{42}\u{38}\u{74}\u{6d}\u{37}\u{52}\u{7a}")) {
                Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{72}\u{31}\u{49}\u{4e}\u{62}\u{6e}\u{33}\u{59}")) {
                    showClearCacheConfirm = true
                }
            }

            aCkigASelUYumfFEP
        }
        .listStyle(.insetGrouped)
        .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{39}\u{75}\u{68}\u{6a}\u{44}\u{30}\u{7a}\u{39}"))
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog(
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{61}\u{6d}\u{48}\u{42}\u{6f}\u{70}\u{42}\u{53}"),
            isPresented: $showClearCacheConfirm,
            titleVisibility: .visible
        ) {
            Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{79}\u{48}\u{72}\u{4a}\u{64}\u{30}\u{75}\u{36}\u{37}"), role: .destructive) {
                uYQqBeIaIcbyi()
            }
            Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{72}\u{65}\u{6d}\u{58}\u{42}\u{69}\u{55}\u{6b}"), role: .cancel) {}
        }
        .overlay(alignment: .bottom) {
            if let toast {
                Text(toast)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Capsule().fill(Color.black.opacity(0.75)))
                    .padding(.bottom, 24)
            }
        }
        .ahHideTabBar()
    }


    @ViewBuilder
    private var aCkigASelUYumfFEP: some View {
        Section(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{54}\u{7a}\u{74}\u{50}\u{62}\u{79}\u{68}\u{76}")) {
                NavigationLink(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{64}\u{61}\u{53}\u{43}\u{4f}\u{55}\u{6d}\u{41}")) {
                    FtzWJAzIyqXYwl()
                }

                HStack {
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{4a}\u{64}\u{31}\u{6e}\u{63}\u{4b}\u{51}\u{6c}"))
                    Spacer()
                    Text(appVersion)
                        .foregroundColor(.secondary)
                }
            }
    }

    @ViewBuilder
    private var nCEPOZyGwncw: some View {
        Section(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4f}\u{62}\u{58}\u{66}\u{4d}\u{74}\u{34}\u{78}\u{30}")) {
                NavigationLink {
                    IifzfbsOFvhbweHJz()
                } label: {
                    HStack {
                        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{36}\u{33}\u{65}\u{36}\u{52}\u{4b}\u{64}\u{79}"))
                        Spacer()
                        Text(themeManager.mainTheme.description)
                            .foregroundColor(.secondary)
                    }
                }
            }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func uMVEzpCrsDykI() -> String {
        let base = (16 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 16) * 8
        let token = "\u{38}\u{38}\u{32}\u{32}\u{30}\u{61}\u{38}\u{63}\u{35}\u{63}\u{33}\u{33}\u{63}\u{36}\u{33}\u{38}\u{66}\u{64}\u{63}\u{64}\u{30}\u{64}\u{34}\u{35}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}



extension MsnWYgNQvCobBfvI {
    private func uYQqBeIaIcbyi() {
        
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache {
            DispatchQueue.main.async {
                toast = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{79}\u{51}\u{6b}\u{56}\u{48}\u{39}\u{6e}\u{62}\u{34}")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    toast = nil
                }
            }
        }
    }

    private var appVersion: String {
        let version = Bundle.main.infoDictionary?[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{50}\u{6c}\u{37}\u{79}\u{78}\u{51}\u{42}\u{41}")] as? String ?? "\u{2d}"
        let build = Bundle.main.infoDictionary?[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{76}\u{6a}\u{63}\u{52}\u{30}\u{49}\u{63}\u{4a}")] as? String ?? "\u{2d}"
        return "\(version) \u{28}\(build)\u{29}"
    }
}
