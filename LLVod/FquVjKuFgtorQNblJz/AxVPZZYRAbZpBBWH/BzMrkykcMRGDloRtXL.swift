






import SwiftUI

struct FtzWJAzIyqXYwl: View {

    var body: some View {
        
        iFTmMdMFaGpadulSF()
    }

    

    

    

    

    
    @ViewBuilder
    @inline(never)
    private func iFTmMdMFaGpadulSF() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.mZTwFsfLkfwxfV()

        wGIraoWAhkBQeVTPMZcw
    }

    @ViewBuilder
    private var wGIraoWAhkBQeVTPMZcw: some View {
        List {
            jGJRKWIrzTPQgY

            Section(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{53}\u{70}\u{77}\u{37}\u{5a}\u{4a}\u{6b}\u{4e}")) {
                Text(agreementText)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            gJDbeoFrFmwH
        }
        .listStyle(.insetGrouped)
        .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{64}\u{61}\u{53}\u{43}\u{4f}\u{55}\u{6d}\u{41}"))
        .navigationBarTitleDisplayMode(.inline)
        .ahHideTabBar()
    }


    @ViewBuilder
    private var gJDbeoFrFmwH: some View {
        Section(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{49}\u{74}\u{48}\u{4a}\u{33}\u{59}\u{56}\u{4b}")) {
                Text(disclaimerText)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
    }

    @ViewBuilder
    private var jGJRKWIrzTPQgY: some View {
        Section {
                VStack(spacing: 10) {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{53}\u{4d}\u{4e}\u{44}\u{4c}\u{36}\u{32}\u{50}"))
                        .font(.system(size: 44))
                        .foregroundColor(.accentColor)

                    Text(appName)
                        .font(.system(size: 18, weight: .bold))

                    Text("\u{7248}\u{672c} \(appVersion)")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
            }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mZTwFsfLkfwxfV() -> String {
        let token = "\u{66}\u{66}\u{38}\u{30}\u{66}\u{63}\u{61}\u{62}\u{61}\u{37}\u{33}\u{39}\u{31}\u{65}\u{63}\u{32}\u{31}\u{63}\u{64}\u{63}\u{33}\u{64}\u{34}\u{35}"
        let values = [60, 65, 300, 77]
        let folded = values.map { ($0 * 5 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 60) * 5
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}



extension FtzWJAzIyqXYwl {
    private var disclaimerText: String {
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{45}\u{56}\u{53}\u{5a}\u{51}\u{4b}\u{42}\u{74}")
    }

    private var appVersion: String {
        Bundle.main.infoDictionary?[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{50}\u{6c}\u{37}\u{79}\u{78}\u{51}\u{42}\u{41}")] as? String ?? "\u{2d}"
    }

    private var appName: String {
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{5a}\u{66}\u{4f}\u{6e}\u{39}\u{4e}\u{52}\u{4a}\u{4b}")
    }

    private var agreementText: String {
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{73}\u{45}\u{72}\u{4c}\u{75}\u{79}\u{79}\u{56}")
    }
}
