//
//  AHCommentStyle.swift
//  LLVod
//
//  评论模块共用的配色与头像占位
//

import SwiftUI

enum AHCommentPalette {
    static let accent = Color(red: 18 / 255, green: 183 / 255, blue: 106 / 255)
    static let accentSoft = Color(red: 18 / 255, green: 183 / 255, blue: 106 / 255).opacity(0.14)
    static let divider = Color(.separator).opacity(0.5)
}

struct AHCommentAvatarView: View {

    let url: String
    var size: CGFloat = 30

    var body: some View {
        Group {
            if let imageURL = URL(string: url), !url.isEmpty {
                CachedAsyncImageView(url: imageURL)
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .foregroundColor(Color(.tertiaryLabel))
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}
