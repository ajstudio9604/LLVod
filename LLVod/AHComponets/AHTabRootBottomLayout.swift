//
//  AHTabRootBottomLayout.swift
//  LLVod
//
//  Tab 根页面底部：内容延伸进透明 TabBar，再用 bottomInset
//  把列表末尾顶到可读区域（各 iOS / iPadOS 版本同一套）。
//

import SwiftUI

enum AHTabRootBottomLayout {

    static func contentBottomInset(measuredSafeAreaBottom: CGFloat) -> CGFloat {
        max(measuredSafeAreaBottom, 16)
    }
}

extension View {

    func ahTabRootIgnoreBottomSafeAreaIfNeeded() -> some View {
        ignoresSafeArea(.container, edges: .bottom)
    }

    func ahTabRootBottomInsetProbe(_ bottomInset: Binding<CGFloat>) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .allowsHitTesting(false)
                    .onAppear {
                        bottomInset.wrappedValue = proxy.safeAreaInsets.bottom
                    }
                    .onChange(of: proxy.safeAreaInsets.bottom) { newValue in
                        bottomInset.wrappedValue = newValue
                    }
            }
            .allowsHitTesting(false)
        )
    }
}
