//
//  AHCommentViewModel.swift
//  LLVod
//
//  对齐 Flutter comment_tab.dart：
//  GET /comments 的 list 会混入回复；界面只渲染 parent_comment_id 为空的顶层评论，
//  回复按 root_comment_id 挂到对应根评论下，不再单独占一条顶层。
//

import Foundation
import Combine

@MainActor
final class AHCommentViewModel: ObservableObject {

    @Published private(set) var allComments: [AHComment] = []
    @Published private(set) var notices: [AHCommentNotice] = []
    @Published private(set) var total = 0

    @Published private(set) var isLoading = false
    @Published private(set) var isLoadingMore = false
    @Published private(set) var isSending = false
    @Published private(set) var hasMore = false

    @Published var errorMessage: String?
    @Published var toast: String?
    @Published var draft = ""
    @Published var replyTarget: AHComment?
    @Published var requiresLogin = false

    let targetType: String
    let targetId: String
    let targetMeta: [String: String]

    private var page = 1

    init(
        targetId: String,
        targetType: String = "video",
        targetMeta: [String: String] = [:]
    ) {
        self.targetId = targetId
        self.targetType = targetType
        self.targetMeta = targetMeta
    }

    var comments: [AHComment] {
        allComments.filter(\.isRoot)
    }

    var inputPlaceholder: String {
        guard let replyTarget else { return "留下你的友善评论吧" }
        return "回复 \(replyTarget.displayName)..."
    }

    var canSend: Bool {
        !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isSending
    }

    func replies(ofRootId rootId: Int) -> [AHComment] {
        allComments
            .filter { comment in
                guard !comment.isRoot else { return false }
                if let root = comment.rootCommentId, root == rootId { return true }
                if let parent = comment.parentCommentId, parent == rootId { return true }
                return false
            }
            .sorted { $0.createdAt < $1.createdAt }
    }

    // MARK: - 加载

    func refresh() async {
        await loadFirstPage(showsLoadingSpinner: false)
    }

    func loadFirstPage(showsLoadingSpinner: Bool? = nil) async {
        guard !targetId.isEmpty else { return }

        let showSpinner = showsLoadingSpinner ?? allComments.isEmpty
        if showSpinner { isLoading = true }
        defer { isLoading = false }

        do {
            let result = try await AHCommentAPI.comments(
                targetType: targetType,
                targetId: targetId,
                page: 1
            )

            // 请求已成功就写入；勿因 refreshable 任务收尾取消而丢掉最新数据
            page = 1
            allComments = result.list
            notices = result.notices
            total = result.total
            hasMore = result.hasMore
        } catch {
            report(error)
        }
    }

    func loadMore() async {
        guard hasMore, !isLoadingMore, !isLoading else { return }

        isLoadingMore = true
        defer { isLoadingMore = false }

        do {
            let result = try await AHCommentAPI.comments(
                targetType: targetType,
                targetId: targetId,
                page: page + 1
            )
            guard !Task.isCancelled else { return }

            page += 1
            let existing = Set(allComments.map(\.id))
            allComments.append(contentsOf: result.list.filter { !existing.contains($0.id) })
            total = result.total
            hasMore = result.hasMore
        } catch {
            report(error)
        }
    }

    func loadReplies(forRootId id: Int, force: Bool = false) async {
        let local = replies(ofRootId: id)
        if !force, !local.isEmpty { return }

        guard let remote = try? await AHCommentAPI.replies(commentId: id), !remote.isEmpty else {
            return
        }

        var merged = allComments
        let existing = Set(merged.map(\.id))
        for item in remote where !existing.contains(item.id) {
            merged.append(item)
        }
        allComments = merged
    }

    // MARK: - 回复

    func beginReply(to comment: AHComment) {
        replyTarget = comment
    }

    func cancelReply() {
        replyTarget = nil
    }

    // MARK: - 发送

    func send() async {
        let content = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !content.isEmpty, !isSending else { return }

        let token = AHCommentAuthStore.shared.accessToken
        guard AHCommentAuthStore.shared.isLoggedIn, !token.isEmpty else {
            requiresLogin = true
            return
        }

        isSending = true
        defer { isSending = false }

        do {
            _ = try await AHCommentAPI.postComment(
                targetType: targetType,
                targetId: targetId,
                content: content,
                parentCommentId: replyTarget?.id,
                targetMeta: targetMeta,
                token: token
            )

            draft = ""
            replyTarget = nil
            await loadFirstPage()

            // 命中审核关键词的评论会先进入待审核，不会立刻出现在列表里
            toast = "已发表，若未显示可能正在审核"
        } catch {
            report(error)
        }
    }

    func delete(_ comment: AHComment) async {
        let token = AHCommentAuthStore.shared.accessToken
        guard !token.isEmpty else {
            requiresLogin = true
            return
        }

        do {
            try await AHCommentAPI.deleteComment(id: comment.id, token: token)
            await loadFirstPage()
        } catch {
            report(error)
        }
    }

    func isMine(_ comment: AHComment) -> Bool {
        guard let user = AHCommentAuthStore.shared.user else { return false }
        return user.id == comment.userId
    }

    private func report(_ error: Error) {
        guard !isCancellation(error) else { return }
        errorMessage = error.localizedDescription
    }

    private func isCancellation(_ error: Error) -> Bool {
        if error is CancellationError { return true }
        if let urlError = error as? URLError, urlError.code == .cancelled { return true }
        return false
    }
}
