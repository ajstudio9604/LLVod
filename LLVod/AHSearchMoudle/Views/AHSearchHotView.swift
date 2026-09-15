//
//  AHSearchHotView.swift
//  LLVod
//

import SwiftUI

struct AHSearchHotView: View {

    let items: [AHSearchHotItem]
    var onSelect: (String) -> Void

    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("最近热搜")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.red)
                .padding(.leading, 15)
                .padding(.top, 10)

            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    Button {
                        onSelect(item.title)
                    } label: {
                        HStack(spacing: 8) {
                            Text("\(index + 1)")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(rankColor(for: index))
                                .frame(width: 20, alignment: .leading)
                                .padding(.leading, 7)

                            Text(item.title)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.primary)
                                .lineLimit(1)

                            Spacer(minLength: 0)
                        }
                        .frame(height: 40)
                        .padding(.horizontal, 8)
                    }
                    .buttonStyle(.plain)
                }
            }
           
        }
    }

    private func rankColor(for index: Int) -> Color {
        switch index {
        case 0:
            return Color(red: 0xF7 / 255, green: 0x39 / 255, blue: 0x3B / 255)
        case 1:
            return Color(red: 0xEF / 255, green: 0x99 / 255, blue: 0x2A / 255)
        case 2:
            return Color(red: 0x52 / 255, green: 0x91 / 255, blue: 0xFF / 255)
        default:
            return .primary
        }
    }
}
