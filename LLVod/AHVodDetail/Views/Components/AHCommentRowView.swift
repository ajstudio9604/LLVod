//
//  AHCommentRowView.swift
//  LLVod
//
//  一条根评论及其回复
//

import SwiftUI

struct AHCommentRowView: View {

    @ObservedObject var viewModel: AHCommentViewModel
    let comment: AHComment
    let onReply: () -> Void

    @State private var isExpanded = false

    private let collapsedReplyLimit = 2

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                AHCommentAvatarView(url: comment.avatarURL, size: 30)

                Text(comment.displayName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Spacer(minLength: 0)
            }

            Text(comment.content)
                .font(.system(size: 14))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Text(comment.relativeTime)
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)

                Spacer(minLength: 0)

                replyButton(for: comment, showsIcon: true)
            }

            if !replyList.isEmpty {
                repliesSection
            }
        }
        .contextMenu {
            deleteButton(for: comment)
        }
        .task {
            // 列表里已有回复时不必再请求；仅 reply_count>0 且本地还没有时补拉
            guard comment.replyCount > 0, replyList.isEmpty else { return }
            await viewModel.loadReplies(forRootId: comment.id)
        }
    }

    private var replyList: [AHComment] {
        viewModel.replies(ofRootId: comment.id)
    }

    private var repliesSection: some View {
        let list = replyList
        let visible = isExpanded ? list : Array(list.prefix(collapsedReplyLimit))

        return VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(visible.enumerated()), id: \.element.id) { index, reply in
                replyRow(reply)
                    .padding(.vertical, 10)

                if index < visible.count - 1 {
                    Divider()
                        .background(AHCommentPalette.divider)
                }
            }

            if list.count > collapsedReplyLimit {
                Button {
                    withAnimation(.easeInOut) { isExpanded.toggle() }
                } label: {
                    Text(isExpanded ? "收起回复" : "查看全部 \(list.count) 条回复")
                        .font(.system(size: 12))
                        .foregroundColor(AHCommentPalette.accent)
                }
                .buttonStyle(.plain)
                .padding(.bottom, 8)
            }
        }
        .padding(.leading, 14)
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(AHCommentPalette.divider)
                .frame(width: 2)
        }
    }

    private func replyRow(_ reply: AHComment) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                AHCommentAvatarView(url: reply.avatarURL, size: 26)

                Text(reply.displayName)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Spacer(minLength: 0)

                replyButton(for: reply, showsIcon: false)
            }

            // 只有回复「回复」时才需要标出被回复的人
            if let parentName = reply.parentUserNickname, reply.parentCommentId != comment.id {
                Text("回复 @\(parentName)")
                    .font(.system(size: 12))
                    .foregroundColor(AHCommentPalette.accent)
            }

            Text(reply.content)
                .font(.system(size: 13))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(reply.relativeTime)
                .font(.system(size: 11))
                .foregroundColor(.secondary)
        }
        .contextMenu {
            deleteButton(for: reply)
        }
    }

    private func replyButton(for target: AHComment, showsIcon: Bool) -> some View {
        Button {
            viewModel.beginReply(to: target)
            onReply()
        } label: {
            HStack(spacing: 4) {
                if showsIcon {
                    Image(systemName: "bubble.left")
                        .font(.system(size: 12))
                }

                Text("回复")
                    .font(.system(size: 12))
            }
            .foregroundColor(.secondary)
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private func deleteButton(for target: AHComment) -> some View {
        if viewModel.isMine(target) {
            Button(role: .destructive) {
                Task { await viewModel.delete(target) }
            } label: {
                Label("删除", systemImage: "trash")
            }
        }
    }
}
