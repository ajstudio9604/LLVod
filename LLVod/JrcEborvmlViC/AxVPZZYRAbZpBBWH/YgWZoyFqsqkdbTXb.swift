






import SwiftUI

struct MqJtOaRZEIOVZ: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.pYSUfvpmvIOk()

        NavigationView {
            LlGgqVbCItHWtVdKDJJ()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{6a}\u{77}\u{42}\u{70}\u{64}\u{77}\u{6c}\u{70}")) { dismiss() }
                    }
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func pYSUfvpmvIOk() -> String {
        let token = "\u{38}\u{32}\u{31}\u{32}\u{34}\u{35}\u{65}\u{37}\u{30}\u{39}\u{34}\u{61}\u{37}\u{66}\u{38}\u{31}\u{66}\u{31}\u{61}\u{37}\u{62}\u{62}\u{38}\u{37}"
        let values = [10, 19, 90, 27]
        let folded = values.map { ($0 * 9 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 10) * 9
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

struct WslnzaAplxZpZ: Identifiable {
    let id = UUID()
    let url: URL
    var title: String = ""
    var episodeTitle: String = ""
}

