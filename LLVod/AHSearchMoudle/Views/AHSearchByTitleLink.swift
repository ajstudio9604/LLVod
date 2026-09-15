//
//  AHSearchByTitleLink.swift
//  LLVod
//

import SwiftUI

struct AHSearchByTitleLink<Label: View>: View {

    private let title: String
    private let label: Label

    init(title: String, @ViewBuilder label: () -> Label) {
        self.title = title
        self.label = label()
    }

    var body: some View {
        NavigationLink {
            AHSearchView(initialKeyword: title)
        } label: {
            label
        }
        .buttonStyle(.plain)
        .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
}
