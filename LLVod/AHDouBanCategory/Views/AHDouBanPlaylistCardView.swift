//
//  AHDouBanPlaylistCardView.swift
//  LLVod
//

import SwiftUI

private struct TextBlockHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct AHDouBanPlaylistCardView: View {

    let item: AHDouBanPlaylistItem
    var itemWidth: CGFloat? = nil
    var onTap: (() -> Void)?

    @State private var textBlockHeight: CGFloat = 0

    private let horizontalPadding: CGFloat = 8
    private let titleBarMinHeight: CGFloat = 52

    private var cardWidth: CGFloat {
        itemWidth ?? 171
    }

    var body: some View {
        if let onTap {
            Button(action: onTap) {
                card
            }
            .buttonStyle(.plain)
        } else {
            // 外面包了 NavigationLink 的场合不再自己套一层 Button，
            // 按钮套按钮点击事件会被内层吃掉
            card
        }
    }

    private var card: some View {
        cardContent
            .frame(width: cardWidth, height: cardWidth)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.secondarySystemBackground))
            )
    }

    private var cardContent: some View {
        VStack(spacing: 0) {
            topImageSection
                .layoutPriority(0)

            bottomTitleSection
                .layoutPriority(1)
        }
    }

    private var topImageSection: some View {
        ZStack(alignment: .topLeading) {
            backgroundLayer

            Text("豆")
                .font(.system(size: 9, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 3))
                .padding(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
    }

    @ViewBuilder
    private var backgroundLayer: some View {
        if !item.headerBgImage.isEmpty {
            CachedAsyncImageView(url: URL(string: item.headerBgImage))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

            LinearGradient(
                colors: [.clear, Color.black.opacity(0.75)],
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            Color(.secondarySystemBackground)
        }
    }

    private var bottomTitleSection: some View {
        HStack(alignment: .top, spacing: 8) {
            if !item.coverURL.isEmpty {
                CachedAsyncImageView(url: URL(string: item.coverURL))
                    .frame(width: coverSide, height: coverSide)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }

            textColumn
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, horizontalPadding)
        .frame(minWidth: cardWidth, maxWidth: cardWidth, minHeight: titleBarMinHeight, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemBackground))
        )
    }

    private var textColumn: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(item.title)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("共\(item.itemsCount)部")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.secondary)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(
            GeometryReader { proxy in
                Color.clear.preference(
                    key: TextBlockHeightKey.self,
                    value: proxy.size.height
                )
            }
        )
        .onPreferenceChange(TextBlockHeightKey.self) { height in
            textBlockHeight = height
        }
    }

    private var coverSide: CGFloat {
        let effectiveTextHeight = textBlockHeight > 0
            ? textBlockHeight
            : estimatedTextBlockHeight

        let maxCoverByText = effectiveTextHeight
        let maxCoverByCard = cardWidth * 0.32
        return min(maxCoverByText, maxCoverByCard)
    }

    private var estimatedTextBlockHeight: CGFloat {
        // 13pt 标题 + 10pt 副标题 + spacing
        28
    }
}
