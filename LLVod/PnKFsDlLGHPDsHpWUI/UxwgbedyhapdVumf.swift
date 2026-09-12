import SwiftUI
import UIKit

enum EbnwEtXYNYcIQpXISuB {
    
    static var current: UIWindow? {
        // source-obfuscator:padding:v1
        _ = Self.oOMavLdCCJofY()

        if let window = (UIApplication.shared.delegate as? AppDelegate)?.window {
            return window
        }

        let windows = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)

        return windows.first(where: \.isKeyWindow) ?? windows.first
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func oOMavLdCCJofY() -> String {
        let token = "\u{33}\u{33}\u{35}\u{64}\u{32}\u{63}\u{30}\u{32}\u{30}\u{64}\u{62}\u{39}\u{34}\u{64}\u{63}\u{30}\u{66}\u{37}\u{66}\u{32}\u{63}\u{32}\u{30}\u{63}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{31}\u{38}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 18) * 9
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

struct BscyIwBACbmNs: UIViewRepresentable {
    

    

    private final class MynRwvFjrVDyAG: UIView {
        override func didMoveToWindow() {
            super.didMoveToWindow()
            vWDrLeTQMNXD()
        }

        func vWDrLeTQMNXD() {
            guard let window else { return }
            window.backgroundColor = .white
            (UIApplication.shared.delegate as? AppDelegate)?.window = window
        }
    }
}



extension BscyIwBACbmNs {
    func updateUIView(_ uiView: UIView, context: Context) {
        // source-obfuscator:padding:v1
        _ = Self.mWOncRNqCHGavWE()

        (uiView as? MynRwvFjrVDyAG)?.vWDrLeTQMNXD()
    }

    func makeUIView(context: Context) -> UIView {
        let view = MynRwvFjrVDyAG()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .clear
        return view
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mWOncRNqCHGavWE() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 34, "\u{65}\u{61}\u{73}\u{74}": 38, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 136]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 34) * 4
        let token = "\u{36}\u{66}\u{36}\u{62}\u{63}\u{66}\u{66}\u{37}\u{64}\u{33}\u{31}\u{39}\u{66}\u{36}\u{65}\u{35}\u{39}\u{33}\u{62}\u{62}\u{63}\u{30}\u{63}\u{66}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}
