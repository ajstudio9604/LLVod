






import SwiftUI

struct IifzfbsOFvhbweHJz: View {

    @EnvironmentObject private var themeManager: CbyiPVoRONUJO

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.qDVXiNEXJPyu()

        List {
            Section {
                ForEach(NwfHDzttAeECjwqGItY.allCases) { theme in
                    Button {
                        themeManager.gUdDZmJFdTHOR(theme)
                    } label: {
                        HStack {
                            Text(theme.description)
                                .foregroundColor(.primary)

                            Spacer()

                            if themeManager.mainTheme == theme {
                                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{76}\u{76}\u{6e}\u{6a}\u{39}\u{61}\u{53}\u{33}"))
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(themeManager.mainTheme.primary)
                            }
                        }
                    }
                }
            } footer: {
                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{5a}\u{43}\u{70}\u{78}\u{4c}\u{6c}\u{30}\u{66}"))
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{36}\u{33}\u{65}\u{36}\u{52}\u{4b}\u{64}\u{79}"))
        .navigationBarTitleDisplayMode(.inline)
        .ahHideTabBar()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qDVXiNEXJPyu() -> String {
        let base = (75 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 75) * 9
        let token = "\u{39}\u{38}\u{61}\u{64}\u{33}\u{39}\u{65}\u{33}\u{31}\u{32}\u{33}\u{61}\u{38}\u{61}\u{39}\u{61}\u{34}\u{31}\u{36}\u{30}\u{65}\u{61}\u{36}\u{61}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}

