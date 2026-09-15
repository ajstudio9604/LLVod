//
//  AHFilterBarView.swift
//  LLVod
//

import SwiftUI

struct AHFilterBarView: View {

    let options: [String]
    let selectedIndex: Int
    let onSelect: (Int) -> Void

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                        Button {
                            onSelect(index)
                            withAnimation(.easeInOut) {
                                proxy.scrollTo(index, anchor: .center)
                            }
                        } label: {
                            Text(option)
                                .font(.system(
                                    size: selectedIndex == index ? 12.5 : 12,
                                    weight: .bold
                                ))
                                .foregroundColor(
                                    selectedIndex == index ? .red : .primary
                                )
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 7)
                                        .fill(
                                            selectedIndex == index
                                                ? Color.red.opacity(0.12)
                                                : Color.clear
                                        )
                                )
                        }
                        .id(index)
                    }
                }
                .padding(.leading, 12)
                .padding(.trailing, 8)
            }
            .onAppear {
                DispatchQueue.main.async {
                    proxy.scrollTo(selectedIndex, anchor: .center)
                }
            }
            .onChange(of: selectedIndex) { index in
                withAnimation(.easeInOut) {
                    proxy.scrollTo(index, anchor: .center)
                }
            }
        }
        .frame(height: 38)
    }
}
