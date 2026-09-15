//
//  AHCommentAuthStore.swift
//  LLVod
//
//  评论模块的登录态，独立于主工程的 UserInstance
//

import Foundation
import Combine

@MainActor
final class AHCommentAuthStore: ObservableObject {

    static let shared = AHCommentAuthStore()

    @Published private(set) var user: AHCommentUser?
    @Published private(set) var accessToken = ""

    private let defaults = UserDefaults.standard

    private enum Key {
        static let user = "ah_comment_user_v1"
        static let accessToken = "ah_comment_access_token_v1"
        static let refreshToken = "ah_comment_refresh_token_v1"

        // Flutter legacy mmkv keys（云同步 / 个人中心依赖）
        static let zhcache = "zhcache"
        static let loginState = "user新登录状态cache"
        static let userToken = "UserToken"
        static let userId = "用户idcache"
        static let nickname = "昵称cache"
        static let avatar = "头像cache"
        static let title = "称号cache"
        static let vip = "会员cache"
    }

    private init() {
        accessToken = defaults.string(forKey: Key.accessToken) ?? ""

        if let data = defaults.data(forKey: Key.user) {
            user = try? JSONDecoder().decode(AHCommentUser.self, from: data)
        }

        // 旧版本只存了 token / user，补写 zhcache 供云同步使用
        if isLoggedIn, let account = user?.account, !account.isEmpty {
            syncLegacyLoginCache(account: account, user: user)
        }
    }

    var isLoggedIn: Bool {
        !accessToken.isEmpty && user != nil
    }

    func login(account: String, password: String) async throws {
        let session = try await AHCommentAPI.login(account: account, password: password)
        save(session)
        await afterLogin()
    }

    func register(account: String, password: String, nickname: String) async throws {
        let session = try await AHCommentAPI.register(
            account: account,
            password: password,
            nickname: nickname
        )
        save(session)
        await afterLogin()
    }

    func logout() {
        user = nil
        accessToken = ""
        defaults.removeObject(forKey: Key.user)
        defaults.removeObject(forKey: Key.accessToken)
        defaults.removeObject(forKey: Key.refreshToken)
        clearLegacyLoginCache()
    }

    func refreshProfile() async {
        guard !accessToken.isEmpty else { return }
        do {
            let remote = try await AHCommentAPI.fetchUser(token: accessToken)
            persistUser(remote)
        } catch { }
    }

    func updateNickname(_ nickname: String) async throws {
        let trimmed = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        try await AHCommentAPI.updateNickname(trimmed, token: accessToken)
        guard let user else { return }
        persistUser(user.updating(nickname: trimmed))
    }

    func updateAvatar(_ avatarURL: String) async throws {
        let trimmed = avatarURL.trimmingCharacters(in: .whitespacesAndNewlines)
        try await AHCommentAPI.updateAvatar(trimmed, token: accessToken)
        guard let user else { return }
        persistUser(user.updating(avatarURL: trimmed))
    }

    func updateBio(_ bio: String) async throws {
        let trimmed = bio.trimmingCharacters(in: .whitespacesAndNewlines)
        try await AHCommentAPI.updateBio(trimmed, token: accessToken)
        guard let user else { return }
        persistUser(user.updating(bio: trimmed))
    }

    func updatePassword(oldPassword: String, newPassword: String) async throws {
        try await AHCommentAPI.updatePassword(
            oldPassword: oldPassword,
            newPassword: newPassword,
            token: accessToken
        )
    }

    func uploadAvatar(imageData: Data, fileName: String = "avatar.jpg") async throws {
        let url = try await AHCommentAPI.uploadAvatar(
            imageData: imageData,
            fileName: fileName,
            token: accessToken
        )
        guard let user else { return }
        persistUser(user.updating(avatarURL: url))
    }

    // MARK: - Private

    private func afterLogin() async {
        await refreshProfile()
        await AHYunCloudService.pullAndMerge()
        await MainActor.run {
            NotificationCenter.default.post(name: .ahYunCloudDidMerge, object: nil)
        }
    }

    private func save(_ session: AHCommentAPI.AHCommentSession) {
        accessToken = session.accessToken
        defaults.set(session.accessToken, forKey: Key.accessToken)
        defaults.set(session.refreshToken, forKey: Key.refreshToken)
        persistUser(session.user)
    }

    private func persistUser(_ user: AHCommentUser) {
        self.user = user
        if let data = try? JSONEncoder().encode(user) {
            defaults.set(data, forKey: Key.user)
        }
        syncLegacyLoginCache(account: user.account, user: user)
    }

    private func syncLegacyLoginCache(account: String?, user: AHCommentUser?) {
        guard let account, !account.isEmpty, let user else { return }
        defaults.set(true, forKey: Key.loginState)
        defaults.set(account, forKey: Key.zhcache)
        defaults.set(accessToken, forKey: Key.userToken)
        defaults.set(String(user.id), forKey: Key.userId)
        defaults.set(user.nickname, forKey: Key.nickname)
        defaults.set(user.avatarURL, forKey: Key.avatar)
        defaults.set(user.title, forKey: Key.title)
        defaults.set(user.vip, forKey: Key.vip)
    }

    private func clearLegacyLoginCache() {
        defaults.removeObject(forKey: Key.loginState)
        defaults.removeObject(forKey: Key.zhcache)
        defaults.removeObject(forKey: Key.userToken)
        defaults.removeObject(forKey: Key.userId)
        defaults.removeObject(forKey: Key.nickname)
        defaults.removeObject(forKey: Key.avatar)
        defaults.removeObject(forKey: Key.title)
        defaults.removeObject(forKey: Key.vip)
    }
}
