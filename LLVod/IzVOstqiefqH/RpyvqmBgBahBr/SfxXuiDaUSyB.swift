




import Foundation
import SwiftUI

extension View {

    func ahFullscreen<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        // source-obfuscator:padding:v1
        _ = Self.yCJAcOmPmjMyJQI()

        return self.modifier(SxPCiMsPMnltyvFB(isPresented: isPresented, dRghEEsxZZNCy: content))
    }

    func ahFullscreen<Item: Identifiable, Content: View>(
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        self.modifier(OedVuVvMCqlR(item: item, dRghEEsxZZNCy: content))
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func yCJAcOmPmjMyJQI() -> String {
        let source = "\u{35}\u{36}\u{65}\u{38}\u{63}\u{62}\u{34}\u{62}\u{66}\u{34}\u{66}\u{65}\u{36}\u{30}\u{66}\u{32}\u{39}\u{34}\u{30}\u{37}\u{36}\u{31}\u{65}\u{65}\u{2d}\u{36}\u{32}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 62) * 2
        let token = "\u{35}\u{36}\u{65}\u{38}\u{63}\u{62}\u{34}\u{62}\u{66}\u{34}\u{66}\u{65}\u{36}\u{30}\u{66}\u{32}\u{39}\u{34}\u{30}\u{37}\u{36}\u{31}\u{65}\u{65}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}

struct SxPCiMsPMnltyvFB<FullscreenContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let dRghEEsxZZNCy: () -> FullscreenContent

    @State private var isRotating = false
    @State private var showBlackMask = false

    func body(content: Content) -> some View {
        content
            .overlay(
                Group { if showBlackMask { Color.black.ignoresSafeArea() } }
            )
            .animation(.linear(duration: 0.1), value: showBlackMask)
            .onChange(of: isPresented) { presenting in
                OnPrpbuxpZZkoVt.cHGkDEZpmsFAUfeQklUV(
                    presenting: presenting,
                    isRotating: $isRotating,
                    showBlackMask: $showBlackMask
                )
            }
            .fullScreenCover(isPresented: $isPresented, content: dRghEEsxZZNCy)
    }
}

struct OedVuVvMCqlR<Item: Identifiable, FullscreenContent: View>: ViewModifier {
    @Binding var item: Item?
    let dRghEEsxZZNCy: (Item) -> FullscreenContent

    @State private var isRotating = false
    @State private var showBlackMask = false

    func body(content: Content) -> some View {
        content
            .overlay(
                Group { if showBlackMask { Color.black.ignoresSafeArea() } }
            )
            .animation(.linear(duration: 0.1), value: showBlackMask)
            .onChange(of: item != nil) { presenting in
                OnPrpbuxpZZkoVt.cHGkDEZpmsFAUfeQklUV(
                    presenting: presenting,
                    isRotating: $isRotating,
                    showBlackMask: $showBlackMask
                )
            }
            .fullScreenCover(item: $item, content: dRghEEsxZZNCy)
    }
}

enum OnPrpbuxpZZkoVt {

    static var orientation = UIInterfaceOrientationMask.all
    
    static func cHGkDEZpmsFAUfeQklUV(
        presenting: Bool,
        isRotating: Binding<Bool>,
        showBlackMask: Binding<Bool>
    ) {
        // source-obfuscator:padding:v1
        _ = Self.qHVlCGTCGDUadiTZXcY()

        guard !isRotating.wrappedValue else { return }
        isRotating.wrappedValue = true

        let targetLock: UIInterfaceOrientationMask = presenting ? .landscape : .portrait
        let targetOrientation: UIInterfaceOrientation = presenting ? .landscapeRight : .portrait

        let currentOrientation: UIInterfaceOrientation = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.interfaceOrientation ?? .unknown
        let bVjfGTaPpAqbmZMp: Bool = {
            if presenting {
                return !(currentOrientation == .landscapeLeft || currentOrientation == .landscapeRight)
            } else {
                return !(currentOrientation == .portrait || currentOrientation == .portraitUpsideDown)
            }
        }()

        showBlackMask.wrappedValue = true

        orientation = targetLock

        guard bVjfGTaPpAqbmZMp else {
            showBlackMask.wrappedValue = false
            isRotating.wrappedValue = false
            return
        }

        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        UIDevice.current.setValue(targetOrientation.rawValue, forKey: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{4b}\u{4f}\u{39}\u{31}\u{31}\u{56}\u{4c}\u{63}"))
        UIViewController.attemptRotationToDeviceOrientation()
        CATransaction.commit()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            UIView.setAnimationsEnabled(true)
            showBlackMask.wrappedValue = false
            isRotating.wrappedValue = false
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qHVlCGTCGDUadiTZXcY() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 95, "\u{65}\u{61}\u{73}\u{74}": 99, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 380]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 95) * 4
        let token = "\u{36}\u{62}\u{38}\u{31}\u{39}\u{35}\u{37}\u{65}\u{66}\u{37}\u{38}\u{33}\u{62}\u{30}\u{30}\u{65}\u{62}\u{32}\u{62}\u{39}\u{63}\u{32}\u{63}\u{66}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}

