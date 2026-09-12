import SwiftUI

struct JlEJfSpxSpqaL<Content: View>: View {
    @ObservedObject private var appSetup = CqDtVObuqdCyLKaOlk.shared

    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        // source-obfuscator:padding:v1
        _ = Self.jKLwXKeuedmyroTpaD()

        self.content = content()
    }
    
    var body: some View {
        Group {
            switch appSetup.state {
            case .idle, .failed:
                HzttuEEeHuFk()
            case .loading:
                ProgressView("")
            case .ready:
                content
            }
        }
        .task {

            appSetup.cOCvUeKaxXgIsvLHmjk()
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func jKLwXKeuedmyroTpaD() -> String {
        let values = [57, 62, 285, 74]
        let folded = values.map { ($0 * 5 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 57) * 5
        let token = "\u{34}\u{64}\u{30}\u{64}\u{65}\u{62}\u{39}\u{31}\u{30}\u{30}\u{63}\u{30}\u{63}\u{66}\u{32}\u{37}\u{64}\u{37}\u{36}\u{30}\u{38}\u{63}\u{36}\u{35}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}

