//
//  AHRankItemCard.swift
//  LLVod
//
//  榜单条目：海报 + 剧照轮播 + 评分 / 简介（不含标签）
//

import SwiftUI

struct AHRankItemCard: View {

    let rank: Int
    let item: AHRankItem

    @State private var photoIndex = 0

    private let posterWidth: CGFloat = 96
    private let posterHeight: CGFloat = 134
    private let accent = Color(red: 0.93, green: 0.55, blue: 0.18)

    var body: some View {
        AHSearchByTitleLink(title: item.title) {
            VStack(alignment: .leading, spacing: 10) {
                mediaRow
                titleRow
                ratingRow
                if !item.cardSubtitle.isEmpty {
                    Text(item.cardSubtitle)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                if !item.blurb.isEmpty {
                    Text(item.blurb)
                        .font(.system(size: 12))
                        .foregroundColor(Color.primary.opacity(0.75))
                        .lineLimit(3)
                        .lineSpacing(2)
                }
            }
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
    }

    private var mediaRow: some View {
        HStack(alignment: .top, spacing: 8) {
            ZStack(alignment: .topLeading) {
                poster

                Text("\(rank)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 22, height: 22)
                    .background(rankBadgeColor)
                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                    .padding(4)
            }

            photoCarousel
                .frame(maxWidth: .infinity)
                .frame(height: posterHeight)
        }
    }

    private var poster: some View {
        Group {
            if let url = URL(string: item.posterURL), !item.posterURL.isEmpty {
                CachedAsyncImageView(url: url)
            } else {
                Color(.secondarySystemFill)
            }
        }
        .frame(width: posterWidth, height: posterHeight)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    @ViewBuilder
    private var photoCarousel: some View {
        let photos = item.photos.isEmpty ? [item.posterURL].filter { !$0.isEmpty } : item.photos

        if photos.isEmpty {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(.secondarySystemFill))
        } else {
            ZStack(alignment: .bottom) {
                TabView(selection: $photoIndex) {
                    ForEach(Array(photos.enumerated()), id: \.offset) { index, urlString in
                        Group {
                            if let url = URL(string: urlString) {
                                CachedAsyncImageView(url: url, contentMode: .fill)
                            } else {
                                Color(.secondarySystemFill)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                if photos.count > 1 {
                    HStack(spacing: 4) {
                        ForEach(0..<photos.count, id: \.self) { index in
                            Circle()
                                .fill(index == photoIndex ? Color.white : Color.white.opacity(0.45))
                                .frame(width: 5, height: 5)
                        }
                    }
                    .padding(.bottom, 8)
                }
            }
        }
    }

    private var titleRow: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(item.title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(1)

            Spacer(minLength: 0)

            Image(systemName: "heart")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: 0.95, green: 0.72, blue: 0.2))
        }
    }

    private var ratingRow: some View {
        HStack(spacing: 4) {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: starSymbol(for: index))
                    .font(.system(size: 11))
                    .foregroundColor(accent)
            }

            if item.ratingValue > 0 {
                Text(String(format: "%.1f", item.ratingValue))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(accent)
            } else {
                Text("暂无评分")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        }
    }

    private func starSymbol(for index: Int) -> String {
        let filled = item.starCount
        let threshold = Double(index) + 0.5
        if filled >= Double(index) + 1 {
            return "star.fill"
        }
        if filled >= threshold {
            return "star.leadinghalf.filled"
        }
        return "star"
    }

    private var rankBadgeColor: Color {
        switch rank {
        case 1:
            return Color(red: 0.93, green: 0.55, blue: 0.18)
        case 2:
            return Color(red: 0.72, green: 0.58, blue: 0.42)
        case 3:
            return Color(red: 0.78, green: 0.62, blue: 0.38)
        default:
            return Color(white: 0.55)
        }
    }
}
