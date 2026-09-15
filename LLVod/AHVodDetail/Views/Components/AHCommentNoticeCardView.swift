//
//  AHCommentNoticeCardView.swift
//  LLVod
//
//  评论区顶部公告卡片，配色由后台 bg_color / text_color 下发
//

import SwiftUI

struct AHCommentNoticeCardView: View {

    let notice: AHCommentNotice

    @Environment(\.openURL) private var openURL

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: iconName)
                .font(.system(size: 17))
                .foregroundColor(AHCommentPalette.accent)
                .frame(width: 38, height: 38)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.12))
                )

            VStack(alignment: .leading, spacing: 4) {
                if !notice.title.isEmpty {
                    Text(notice.title)
                        .font(.system(size: 15, weight: .bold))
                }

                if !notice.content.isEmpty {
                    Text(notice.content)
                        .font(.system(size: 13))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .foregroundColor(notice.textColor)

            Spacer(minLength: 0)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(notice.backgroundColor)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            guard let url = URL(string: notice.linkURL), notice.linkURL.hasPrefix("http") else {
                return
            }
            openURL(url)
        }
    }

    private var iconName: String {
        guard !notice.icon.isEmpty, UIImage(systemName: notice.icon) != nil else {
            return "megaphone.fill"
        }
        return notice.icon
    }
}
