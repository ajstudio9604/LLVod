




import SwiftUI
import UIKit

extension View {
    func ahFixLayoutAfterRotation() -> some View {
        // source-obfuscator:padding:v1
        _ = Self.wHlmIIRtDDIPu()

        return modifier(GrEKrQhbynISeQuU())
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func wHlmIIRtDDIPu() -> String {
        let token = "\u{64}\u{32}\u{61}\u{35}\u{35}\u{39}\u{30}\u{62}\u{63}\u{35}\u{63}\u{39}\u{65}\u{34}\u{65}\u{32}\u{62}\u{65}\u{33}\u{39}\u{30}\u{34}\u{31}\u{63}"
        let values = [11, 16, 55, 28]
        let folded = values.map { ($0 * 5 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 11) * 5
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

private struct GrEKrQhbynISeQuU: ViewModifier {

    
}

enum SmQcnorSlgWUthpsLgK {

    private static var pendingRefresh: DispatchWorkItem?

    

    static func qIMTOmYbDUeqeqjmB() {
        // source-obfuscator:padding:v1
        _ = Self.kUFtOmUVgFpZTuvZDJUI()

        guard let window = activeWindow else { return }

        window.setNeedsLayout()
        window.layoutIfNeeded()

        if let root = window.rootViewController {
            nGiVAbwYgAAnjB(root)
        }
    }

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func kUFtOmUVgFpZTuvZDJUI() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 68, "\u{65}\u{61}\u{73}\u{74}": 73, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 340]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 68) * 5
        let token = "\u{36}\u{31}\u{34}\u{38}\u{64}\u{38}\u{35}\u{35}\u{37}\u{39}\u{65}\u{62}\u{34}\u{63}\u{61}\u{35}\u{32}\u{38}\u{36}\u{65}\u{36}\u{63}\u{35}\u{32}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}



extension GrEKrQhbynISeQuU {
    func body(content: Content) -> some View {
        content
            .onAppear {
                SmQcnorSlgWUthpsLgK.rGmvUQTzoxrB()
            }
            .onReceive(
                NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            ) { _ in
                SmQcnorSlgWUthpsLgK.rGmvUQTzoxrB()
            }
    }
}


extension SmQcnorSlgWUthpsLgK {
    private static var activeWindow: UIWindow? {
        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        guard let scene = scenes.first(where: { $0.activationState == .foregroundActive }) ?? scenes.first else {
            return nil
        }
        return scene.windows.first { $0.isKeyWindow } ?? scene.windows.first
    }

    static func rGmvUQTzoxrB() {
        pendingRefresh?.cancel()

        let work = DispatchWorkItem { qIMTOmYbDUeqeqjmB() }
        pendingRefresh = work
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: work)
    }

    private static func nGiVAbwYgAAnjB(_ controller: UIViewController) {
        controller.view.setNeedsLayout()
        controller.view.layoutIfNeeded()
        controller.children.forEach(nGiVAbwYgAAnjB)
        if let presented = controller.presentedViewController {
            nGiVAbwYgAAnjB(presented)
        }
    }
}
