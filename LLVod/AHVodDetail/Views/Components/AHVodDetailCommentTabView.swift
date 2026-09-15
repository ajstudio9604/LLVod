//
//  AHVodDetailCommentTabView.swift
//  LLVod
//
//  「评论」分页：公告 + 评论列表 + 底部输入栏
//

import SwiftUI

struct AHVodDetailCommentTabView: View {

    @StateObject private var viewModel: AHCommentViewModel
    @FocusState private var isInputFocused: Bool

    init(targetId: String, title: String = "", pic: String = "", sourceName: String = "") {
        var meta: [String: String] = [:]
        if !title.isEmpty { meta["title"] = title }
        if !pic.isEmpty { meta["cover"] = pic }
        if !sourceName.isEmpty { meta["source"] = sourceName }

        _viewModel = StateObject(
            wrappedValue: AHCommentViewModel(targetId: targetId, targetMeta: meta)
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            commentList

            AHCommentInputBarView(viewModel: viewModel, isFocused: $isInputFocused)
        }
        .background(Color(.systemBackground))
        .task {
            guard viewModel.allComments.isEmpty else { return }
            await viewModel.loadFirstPage()
        }
        .sheet(isPresented: $viewModel.requiresLogin) {
            AHCommentLoginSheet()
        }
        .alert(
            "提示",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )
        ) {
            Button("知道了") { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }

    private var commentList: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(viewModel.notices) { notice in
                        AHCommentNoticeCardView(notice: notice)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 12)
                    }

                    if viewModel.isLoading && viewModel.comments.isEmpty {
                        loadingPlaceholder
                    } else if viewModel.comments.isEmpty {
                        emptyPlaceholder
                    } else {
                        ForEach(viewModel.comments) { comment in
                            AHCommentRowView(viewModel: viewModel, comment: comment) {
                                isInputFocused = true
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)

                            Divider()
                                .background(AHCommentPalette.divider)
                                .padding(.leading, 16)
                        }

                        if viewModel.hasMore {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .task { await viewModel.loadMore() }
                        }
                    }
                }
                .padding(.top, 12)
                .padding(.bottom, 16)
                // 内容不足一屏时也要能下拉，对齐 Flutter RefreshIndicator + 可滚动列表
                .frame(maxWidth: .infinity, minHeight: proxy.size.height, alignment: .top)
            }
            .refreshable {
                await viewModel.refresh()
            }
            .background(AHCommentScrollBounceEnabler())
            .ahDismissKeyboardOnScroll()
        }
    }

    private var loadingPlaceholder: some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .padding(.vertical, 60)
    }

    private var emptyPlaceholder: some View {
        VStack(spacing: 10) {
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 34))
                .foregroundColor(.secondary)

            Text("还没有评论，来说两句吧")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}

// MARK: - 短列表也能下拉刷新

private struct AHCommentScrollBounceEnabler: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            uiView.ahEnclosingScrollView()?.alwaysBounceVertical = true
        }
    }
}

private extension UIView {
    func ahEnclosingScrollView() -> UIScrollView? {
        var current: UIView? = self
        while let view = current {
            if let scroll = view as? UIScrollView {
                return scroll
            }
            current = view.superview
        }
        return nil
    }
}
