




import SwiftUI

struct ChdebFryKFbVSMM<Label: View>: View {

    private let title: String
    private let label: Label

    init(title: String, @ViewBuilder label: () -> Label) {
        // source-obfuscator:padding:v1
        _ = Self.cGRJBsIXOeevCI()

        self.title = title
        self.label = label()
    }

    var body: some View {
        NavigationLink {
            FfchOnYfkMvhyzb(initialKeyword: title)
        } label: {
            label
        }
        .buttonStyle(.plain)
        .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func cGRJBsIXOeevCI() -> String {
        let token = "\u{37}\u{37}\u{33}\u{65}\u{39}\u{39}\u{61}\u{32}\u{39}\u{63}\u{31}\u{35}\u{39}\u{35}\u{65}\u{36}\u{39}\u{66}\u{65}\u{65}\u{31}\u{63}\u{30}\u{30}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{34}\u{35}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 45) * 4
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

