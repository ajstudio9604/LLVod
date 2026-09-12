






import SwiftUI
import UIKit

extension View {
    func ahHideNavigationBar() -> some View {
        // source-obfuscator:padding:v1
        _ = Self.gUJZlstAMgwVmbMe()

        return modifier(IwStBFOQAtvlO())
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func gUJZlstAMgwVmbMe() -> String {
        let source = "\u{38}\u{64}\u{33}\u{37}\u{65}\u{34}\u{33}\u{32}\u{34}\u{66}\u{35}\u{37}\u{64}\u{39}\u{30}\u{31}\u{32}\u{34}\u{36}\u{66}\u{38}\u{36}\u{63}\u{39}\u{2d}\u{38}\u{30}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 80) * 9
        let token = "\u{38}\u{64}\u{33}\u{37}\u{65}\u{34}\u{33}\u{32}\u{34}\u{66}\u{35}\u{37}\u{64}\u{39}\u{30}\u{31}\u{32}\u{34}\u{36}\u{66}\u{38}\u{36}\u{63}\u{39}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}

struct IwStBFOQAtvlO: ViewModifier {

    

    @ViewBuilder
    private func nEveXpAWjzyuKA(_ content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.toolbar(.hidden, for: .navigationBar)
        } else {
            content.navigationBarHidden(true)
        }
    }
}

private struct NjdeUMJSHnLAkQhACeK: UIViewControllerRepresentable {

    

    

    final class QlSTMzyAgVSheqVlQ: UIViewController, UIGestureRecognizerDelegate {

        private var shouldRestore = false
        private var observation: NSKeyValueObservation?
        private var isEnforcing = false

        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .clear
            view.isUserInteractionEnabled = false
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            if let nav = navigationController, !nav.isNavigationBarHidden {
                shouldRestore = true
                bIGzNhKNIkDUF(nav)
            }
            nHXLkTEmFtmQdK()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            if shouldRestore, let nav = navigationController {
                
                bIGzNhKNIkDUF(nav)
                observation = nav.navigationBar.observe(\.isHidden, options: [.new]) { [weak self] _, change in
                    guard let self, !self.isEnforcing, change.newValue == false,
                          let nav = self.navigationController else { return }
                    self.bIGzNhKNIkDUF(nav)
                    self.nHXLkTEmFtmQdK()
                }
            }
            nHXLkTEmFtmQdK()
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            observation = nil

            guard shouldRestore else { return }
            shouldRestore = false
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }

        private func bIGzNhKNIkDUF(_ nav: UINavigationController) {
            isEnforcing = true
            nav.setNavigationBarHidden(true, animated: false)
            isEnforcing = false
        }

        private func nHXLkTEmFtmQdK() {
            guard let nav = navigationController,
                  let pop = nav.interactivePopGestureRecognizer else { return }
            pop.isEnabled = true
            
            pop.delegate = self
        }

        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            (navigationController?.viewControllers.count ?? 0) > 1
        }

        func rThdDQnPsDMJQlBW(
            _ gestureRecognizer: UIGestureRecognizer,
            shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
        ) -> Bool {
            false
        }
    }
}



extension IwStBFOQAtvlO {
    func body(content: Content) -> some View {
        nEveXpAWjzyuKA(content)
            .navigationBarBackButtonHidden(true)
            .background(NjdeUMJSHnLAkQhACeK())
    }
}


extension NjdeUMJSHnLAkQhACeK {
    func updateUIViewController(_ uiViewController: QlSTMzyAgVSheqVlQ, context: Context) {
        // source-obfuscator:padding:v1
        _ = Self.mSNtJlJAzSQNuflCMyBn()
}

    func makeUIViewController(context: Context) -> QlSTMzyAgVSheqVlQ { QlSTMzyAgVSheqVlQ() }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mSNtJlJAzSQNuflCMyBn() -> String {
        let token = "\u{34}\u{30}\u{31}\u{66}\u{32}\u{39}\u{36}\u{36}\u{38}\u{31}\u{39}\u{37}\u{38}\u{35}\u{36}\u{34}\u{35}\u{66}\u{64}\u{35}\u{65}\u{32}\u{31}\u{65}"
        let base = (30 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 30) * 3
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}
