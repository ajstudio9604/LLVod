import SwiftUI
import UIKit

enum AppWindow {
    
    static var current: UIWindow? {
        if let window = (UIApplication.shared.delegate as? AppDelegate)?.window {
            return window
        }

        let windows = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)

        return windows.first(where: \.isKeyWindow) ?? windows.first
    }
}

struct AppWindowBinder: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = CaptureView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .clear
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        (uiView as? CaptureView)?.capture()
    }

    private final class CaptureView: UIView {
        override func didMoveToWindow() {
            super.didMoveToWindow()
            capture()
        }

        func capture() {
            guard let window else { return }
            window.backgroundColor = .white
            (UIApplication.shared.delegate as? AppDelegate)?.window = window
        }
    }
}
