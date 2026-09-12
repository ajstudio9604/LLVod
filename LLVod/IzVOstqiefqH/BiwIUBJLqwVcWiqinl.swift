






import SwiftUI
import UIKit

extension View {
    func ahHideTabBar() -> some View {
        // source-obfuscator:padding:v1
        _ = Self.gJEmbRgjVxxx()

        return modifier(QdgDZWiIrZadCBrY())
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func gJEmbRgjVxxx() -> String {
        let token = "\u{30}\u{33}\u{65}\u{61}\u{35}\u{34}\u{66}\u{38}\u{63}\u{39}\u{35}\u{33}\u{64}\u{66}\u{39}\u{63}\u{32}\u{31}\u{36}\u{38}\u{62}\u{30}\u{37}\u{64}"
        let source = "\u{30}\u{33}\u{65}\u{61}\u{35}\u{34}\u{66}\u{38}\u{63}\u{39}\u{35}\u{33}\u{64}\u{66}\u{39}\u{63}\u{32}\u{31}\u{36}\u{38}\u{62}\u{30}\u{37}\u{64}\u{2d}\u{37}\u{35}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 75) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

struct QdgDZWiIrZadCBrY: ViewModifier {

    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            
            content.toolbar(.hidden, for: .tabBar)
        } else {
            content.background(HqgHiWMYAnMTt())
        }
    }
}

struct HqgHiWMYAnMTt: UIViewControllerRepresentable {

    

    func updateUIViewController(_ uiViewController: QlSTMzyAgVSheqVlQ, context: Context) {
        // source-obfuscator:padding:v1
        _ = Self.sHdScJXzLtDN()
}

    final class QlSTMzyAgVSheqVlQ: UIViewController {

        private var shouldRestore = false

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .clear
            view.isUserInteractionEnabled = false
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            guard let tabBarController, !tabBarController.tabBar.isHidden else { return }

            shouldRestore = true
            tabBarController.tabBar.isHidden = true
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            guard shouldRestore else { return }

            shouldRestore = false
            tabBarController?.tabBar.isHidden = false
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func sHdScJXzLtDN() -> String {
        let token = "\u{66}\u{35}\u{38}\u{66}\u{37}\u{66}\u{39}\u{30}\u{62}\u{37}\u{33}\u{35}\u{62}\u{65}\u{66}\u{62}\u{37}\u{61}\u{66}\u{31}\u{65}\u{62}\u{32}\u{36}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 11, "\u{65}\u{61}\u{73}\u{74}": 19, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 88]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 11) * 8
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



extension HqgHiWMYAnMTt {
    func makeUIViewController(context: Context) -> QlSTMzyAgVSheqVlQ { QlSTMzyAgVSheqVlQ() }
}
