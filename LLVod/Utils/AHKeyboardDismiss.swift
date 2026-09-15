//
//  AHKeyboardDismiss.swift
//  LLVod
//

import SwiftUI

extension View {
    @ViewBuilder
    func ahDismissKeyboardOnScroll() -> some View {
        if #available(iOS 16.0, *) {
            scrollDismissesKeyboard(.immediately)
        } else {
            self
        }
    }
}
