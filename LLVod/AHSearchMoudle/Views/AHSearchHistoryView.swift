//
//  AHSearchHistoryView.swift
//  LLVod
//

import SwiftUI

struct AHSearchHistoryView: View {

    let items: [String]
    var onSelect: (String) -> Void
    var onDeleteAll: () -> Void
    var onDeleteItem: (Int) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("历史记录")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.red)
                    .padding(.leading, 15)

                Spacer()

                Button(action: onDeleteAll) {
                    Image(systemName: "trash")
                        .font(.system(size: 18))
                        .foregroundColor(.red)
                }
                .padding(.trailing, 7)
            }
            .padding(.top, 5)

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 72), spacing: 10)],
                alignment: .leading,
                spacing: 10
            ) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    Button {
                        onSelect(item)
                    } label: {
                        Text(item)
                            .font(.system(size: 12.5, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 9)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color(.secondarySystemBackground))
                            )
                    }
                    .buttonStyle(.plain)
                    .contextMenu {
                        Button(role: .destructive) {
                            onDeleteItem(index)
                        } label: {
                            Text("删除")
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
            
            
            // 信息流广告
            TakuNativeAdView(postion: 2)
                .padding()
                .padding(.bottom, 20)
        }
    }
}
