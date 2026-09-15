//
//  AHFullScreenWithRotationModifier.swift
//  LLVod
//

import Foundation
import SwiftUI

extension View {

    func ahFullscreen<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(AHFullScreenWithRotationModifier(isPresented: isPresented, fullscreenContent: content))
    }

    func ahFullscreen<Item: Identifiable, Content: View>(
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        self.modifier(AHFullScreenItemWithRotationModifier(item: item, fullscreenContent: content))
    }
}

struct AHFullScreenWithRotationModifier<FullscreenContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let fullscreenContent: () -> FullscreenContent

    @State private var isRotating = false
    @State private var showBlackMask = false

    func body(content: Content) -> some View {
        content
            .overlay(
                Group { if showBlackMask { Color.black.ignoresSafeArea() } }
            )
            .animation(.linear(duration: 0.1), value: showBlackMask)
            .onChange(of: isPresented) { presenting in
                AHFullscreenRotation.rotate(
                    presenting: presenting,
                    isRotating: $isRotating,
                    showBlackMask: $showBlackMask
                )
            }
            .fullScreenCover(isPresented: $isPresented, content: fullscreenContent)
    }
}

struct AHFullScreenItemWithRotationModifier<Item: Identifiable, FullscreenContent: View>: ViewModifier {
    @Binding var item: Item?
    let fullscreenContent: (Item) -> FullscreenContent

    @State private var isRotating = false
    @State private var showBlackMask = false

    func body(content: Content) -> some View {
        content
            .overlay(
                Group { if showBlackMask { Color.black.ignoresSafeArea() } }
            )
            .animation(.linear(duration: 0.1), value: showBlackMask)
            .onChange(of: item != nil) { presenting in
                AHFullscreenRotation.rotate(
                    presenting: presenting,
                    isRotating: $isRotating,
                    showBlackMask: $showBlackMask
                )
            }
            .fullScreenCover(item: $item, content: fullscreenContent)
    }
}

enum AHFullscreenRotation {

    static var orientation = UIInterfaceOrientationMask.all
    
    static func rotate(
        presenting: Bool,
        isRotating: Binding<Bool>,
        showBlackMask: Binding<Bool>
    ) {
        guard !isRotating.wrappedValue else { return }
        isRotating.wrappedValue = true

        let targetLock: UIInterfaceOrientationMask = presenting ? .landscape : .portrait
        let targetOrientation: UIInterfaceOrientation = presenting ? .landscapeRight : .portrait

        let currentOrientation: UIInterfaceOrientation = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.interfaceOrientation ?? .unknown
        let needRotate: Bool = {
            if presenting {
                return !(currentOrientation == .landscapeLeft || currentOrientation == .landscapeRight)
            } else {
                return !(currentOrientation == .portrait || currentOrientation == .portraitUpsideDown)
            }
        }()

        showBlackMask.wrappedValue = true

        orientation = targetLock

        guard needRotate else {
            showBlackMask.wrappedValue = false
            isRotating.wrappedValue = false
            return
        }

        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        UIDevice.current.setValue(targetOrientation.rawValue, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
        CATransaction.commit()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            UIView.setAnimationsEnabled(true)
            showBlackMask.wrappedValue = false
            isRotating.wrappedValue = false
        }
    }
}
