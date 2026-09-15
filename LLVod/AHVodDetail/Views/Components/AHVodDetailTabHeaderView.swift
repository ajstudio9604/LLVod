//
//  AHVodDetailTabHeaderView.swift
//  LLVod
//
//  详情页顶部「视频 / 评论」分页标签栏
//

import SwiftUI

struct AHVodDetailTabHeaderView: View {

    let tabs: [AHVodDetailTab]
    @Binding var selectedIndex: Int
    let onSelect: (Int) -> Void

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(Array(tabs.enumerated()), id: \.element.id) { index, tab in
                        Button {
                            withAnimation(.easeInOut) {
                                selectedIndex = index
                                onSelect(index)
                                proxy.scrollTo(tab.id, anchor: .center)
                            }
                        } label: {
                            VStack {
                                Text(tab.text)
                                    .font(.system(
                                        size: selectedIndex == index ? 18 : 16,
                                        weight: selectedIndex == index ? .bold : .regular
                                    ))
                                    .foregroundColor(
                                        selectedIndex == index ? .red : .gray
                                    )
                            }
                        }
                        .id(tab.id)
                    }
                }
                .padding(.horizontal, 16)
            }
            .onAppear {
                DispatchQueue.main.async {
                    if selectedIndex < tabs.count {
                        proxy.scrollTo(tabs[selectedIndex].id, anchor: .center)
                    }
                }
            }
        }
    }
}
