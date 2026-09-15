//
//  AHCommentInputBarView.swift
//  LLVod
//
//  底部输入栏，回复状态下顶部会多一条回复提示
//

import SwiftUI

struct AHCommentInputBarView: View {

    @ObservedObject var viewModel: AHCommentViewModel
    @FocusState.Binding var isFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            if let target = viewModel.replyTarget {
                replyBanner(target)
            }

            Divider()

            HStack(spacing: 12) {
                TextField(viewModel.inputPlaceholder, text: $viewModel.draft)
                    .font(.system(size: 15))
                    .disableAutocorrection(true)
                    .focused($isFocused)
                    .submitLabel(.send)
                    .onSubmit(send)

                Button(action: send) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)
                        .background(
                            Circle().fill(
                                viewModel.canSend
                                    ? AHCommentPalette.accent
                                    : AHCommentPalette.accent.opacity(0.4)
                            )
                        )
                }
                .buttonStyle(.plain)
                .disabled(!viewModel.canSend)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .background(Color(.systemBackground))
    }

    private func replyBanner(_ target: AHComment) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "arrowshape.turn.up.left.fill")
                .font(.system(size: 12))

            Text("回复 \(target.displayName)")
                .font(.system(size: 13))
                .lineLimit(1)

            Spacer(minLength: 12)

            Button {
                viewModel.cancelReply()
            } label: {
                Text("取消")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.plain)
        }
        .foregroundColor(AHCommentPalette.accent)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(AHCommentPalette.accentSoft)
    }

    private func send() {
        Task { await viewModel.send() }
    }
}
