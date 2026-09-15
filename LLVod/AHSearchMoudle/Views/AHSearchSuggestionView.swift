//
//  AHSearchSuggestionView.swift
//  LLVod
//

import SwiftUI

struct AHSearchSuggestionView: View {

    let items: [String]
    let keyword: String
    var onSelect: (String) -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(items, id: \.self) { item in
                    Button {
                        onSelect(item)
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 18))
                                .foregroundColor(.primary)

                            SearchHighlightedText(
                                text: item,
                                searchContent: keyword
                            )

                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 15)
                        .frame(height: 45)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)

                    Divider()
                        .padding(.leading, 41)
                }
            }
        }
        .background(Color(.systemBackground))
        .ahDismissKeyboardOnScroll()
    }
}
