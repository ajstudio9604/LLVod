//
//  AHFilterMediaCardView.swift
//  LLVod
//

import SwiftUI

struct AHFilterMediaCardView: View {

    let item: AHFilterMediaItem
    var itemWidth: CGFloat

    private var itemHeight: CGFloat {
        itemWidth / 0.6
    }

    var body: some View {
        AHSearchByTitleLink(title: item.title) {
            VStack(alignment: .leading, spacing: 8) {
                CachedAsyncImageView(url: URL(string: item.imageURL))
                    .frame(width: itemWidth, height: itemHeight - 44)
                    .background(Color.gray.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .clipped()

                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                if !item.subtitle.isEmpty {
                    Text(item.subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(width: itemWidth, alignment: .leading)
        }
    }
}
