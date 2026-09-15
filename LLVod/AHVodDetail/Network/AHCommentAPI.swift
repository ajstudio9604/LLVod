//
//  AHCommentAPI.swift
//  LLVod
//
//  评论 / 账号相关接口，统一处理 {code, message, data} 包装
//

import Foundation

enum AHCommentAPIError: LocalizedError {

    case invalidURL
    case invalidResponse
    case notLoggedIn
    case business(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return ""
        case .invalidResponse:
            return ""
        case .notLoggedIn:
            return ""
        case .business(let message):
            return message
        }
    }
}


enum AHCommentAuthTokenError: LocalizedError {

    case secretNotConfigured
    case encryptFailed(Error)

    var errorDescription: String? {
        switch self {
        case .secretNotConfigured:
            return ""

        case .encryptFailed(let error):
            return ""
        }
    }
}

enum AHCommentAPI {

    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 20
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: configuration)
    }()

    // MARK: - 评论

    static func comments(
        targetType: String,
        targetId: String,
        page: Int,
        pageSize: Int = 20
    ) async throws -> AHCommentPage {

        let data = try await send(
            path: "/comments",
            method: "GET",
            query: [
                URLQueryItem(name: "target_type", value: targetType),
                URLQueryItem(name: "target_id", value: targetId),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "page_size", value: String(pageSize))
            ]
        )

        let payload = AHCommentJSON.dictionary(data)
        let pagination = AHCommentJSON.dictionary(payload["pagination"])
        let list = AHCommentJSON.array(payload["list"]).compactMap(AHComment.init(json:))

        return AHCommentPage(
            list: list,
            notices: AHCommentJSON.array(payload["notices"]).compactMap(AHCommentNotice.init(json:)),
            total: AHCommentJSON.int(pagination["total"]) ?? list.count,
            hasMore: AHCommentJSON.bool(pagination["has_more"])
        )
    }

    static func replies(commentId: Int) async throws -> [AHComment] {
        let data = try await send(
            path: "/comments/\(commentId)/replies",
            method: "GET"
        )
        return AHCommentJSON.array(data).compactMap(AHComment.init(json:))
    }

    static func postComment(
        targetType: String,
        targetId: String,
        content: String,
        parentCommentId: Int?,
        targetMeta: [String: String],
        token: String
    ) async throws -> Int {

        guard !token.isEmpty else { throw AHCommentAPIError.notLoggedIn }

        var body: [String: Any] = [
            "target_type": targetType,
            "target_id": targetId,
            "content": content
        ]
        if let parentCommentId {
            body["parent_comment_id"] = parentCommentId
        }
        if !targetMeta.isEmpty {
            body["target_meta"] = targetMeta
        }

        let data = try await send(
            path: "/comments",
            method: "POST",
            body: body,
            token: token
        )

        return AHCommentJSON.int(AHCommentJSON.dictionary(data)["comment_id"]) ?? 0
    }

    static func deleteComment(id: Int, token: String) async throws {
        guard !token.isEmpty else { throw AHCommentAPIError.notLoggedIn }
        _ = try await send(path: "/comments/\(id)", method: "DELETE", token: token)
    }

    // MARK: - 账号

    struct AHCommentSession {
        let user: AHCommentUser
        let accessToken: String
        let refreshToken: String
    }

    static func login(account: String, password: String) async throws -> AHCommentSession {
        var body: [String: Any] = [
            "account": account,
            "password": password
        ]
        for (key, value) in try authFields() {
            body[key] = value
        }

        let data = try await send(path: "/auth/login", method: "POST", body: body)
        let payload = AHCommentJSON.dictionary(data)

        return AHCommentSession(
            user: AHCommentUser(json: AHCommentJSON.dictionary(payload["user"])),
            accessToken: AHCommentJSON.string(payload["access_token"]),
            refreshToken: AHCommentJSON.string(payload["refresh_token"])
        )
    }

    static private func authFields() throws -> [String: String] {
       

        let timestamp = String(Int(Date().timeIntervalSince1970))
        let plainText = "your-secret-app-auth-token|\(timestamp)"

        do {
            let encrypted = try CryptoUtil.aesEncryptBytes(
                Array(plainText.utf8),
                key: CryptoUtil.sha256Bytes("your-secret-app-auth-token"),
                iv: Array("0000000000000000".utf8),
                mode: "CBC",
                padding: "PKCS7"
            )

            return ["app_auth_token": encrypted, "ts": timestamp]
        } catch {
            throw AHCommentAuthTokenError.encryptFailed(error)
        }
    }
    
    static func register(
        account: String,
        password: String,
        nickname: String
    ) async throws -> AHCommentSession {

        var body: [String: Any] = [
            "account": account,
            "password": password
        ]
        if !nickname.isEmpty {
            body["nickname"] = nickname
        }
        for (key, value) in try authFields() {
            body[key] = value
        }

        _ = try await send(path: "/auth/register", method: "POST", body: body)
        return try await login(account: account, password: password)
    }

    static func refresh(refreshToken: String) async throws -> (accessToken: String, refreshToken: String) {
        let data = try await send(
            path: "/auth/refresh",
            method: "POST",
            body: ["refresh_token": refreshToken]
        )
        let payload = AHCommentJSON.dictionary(data)

        return (
            AHCommentJSON.string(payload["access_token"]),
            AHCommentJSON.string(payload["refresh_token"])
        )
    }

    // MARK: - 用户资料

    static func fetchUser(token: String) async throws -> AHCommentUser {
        guard !token.isEmpty else { throw AHCommentAPIError.notLoggedIn }
        let data = try await send(path: "/user", method: "GET", token: token)
        return AHCommentUser(json: AHCommentJSON.dictionary(data))
    }

    static func updateNickname(_ nickname: String, token: String) async throws {
        guard !token.isEmpty else { throw AHCommentAPIError.notLoggedIn }
        _ = try await send(
            path: "/user/nickname",
            method: "PATCH",
            body: ["nickname": nickname],
            token: token
        )
    }

    static func updateAvatar(_ avatarURL: String, token: String) async throws {
        guard !token.isEmpty else { throw AHCommentAPIError.notLoggedIn }
        _ = try await send(
            path: "/user/avatar",
            method: "PATCH",
            body: ["avatar_url": avatarURL],
            token: token
        )
    }

    static func updateBio(_ bio: String, token: String) async throws {
        guard !token.isEmpty else { throw AHCommentAPIError.notLoggedIn }
        _ = try await send(
            path: "/user/bio",
            method: "PATCH",
            body: ["bio": bio],
            token: token
        )
    }

    static func updatePassword(oldPassword: String, newPassword: String, token: String) async throws {
        guard !token.isEmpty else { throw AHCommentAPIError.notLoggedIn }
        _ = try await send(
            path: "/user/password",
            method: "PATCH",
            body: [
                "old_password": oldPassword,
                "new_password": newPassword
            ],
            token: token
        )
    }

    static func uploadAvatar(imageData: Data, fileName: String = "avatar.jpg", token: String) async throws -> String {
        guard !token.isEmpty else { throw AHCommentAPIError.notLoggedIn }

        let homeURL = URL(string: "https://img.binmt.cc/")!
        var homeRequest = URLRequest(url: homeURL)
        homeRequest.httpMethod = "GET"
        let (homeData, homeResponse) = try await session.data(for: homeRequest)
        let html = String(data: homeData, encoding: .utf8) ?? ""

        guard let csrfToken = extractCSRFToken(from: html), !csrfToken.isEmpty else {
            throw AHCommentAPIError.business("获取图床令牌失败")
        }

        var cookieHeader = ""
        if let http = homeResponse as? HTTPURLResponse {
            let fields = http.allHeaderFields.reduce(into: [String: String]()) { result, pair in
                if let key = pair.key as? String, let value = pair.value as? String {
                    result[key] = value
                }
            }
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: homeURL)
            cookieHeader = cookies.map { "\($0.name)=\($0.value)" }.joined(separator: "; ")
        }

        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()
        func append(_ text: String) {
            if let data = text.data(using: .utf8) { body.append(data) }
        }

        append("--\(boundary)\r\n")
        append("Content-Disposition: form-data; name=\"strategy_id\"\r\n\r\n")
        append("2\r\n")
        append("--\(boundary)\r\n")
        append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n")
        append("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        append("\r\n")
        append("--\(boundary)--\r\n")

        var uploadRequest = URLRequest(url: URL(string: "https://img.binmt.cc/upload")!)
        uploadRequest.httpMethod = "POST"
        uploadRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        uploadRequest.setValue(csrfToken, forHTTPHeaderField: "X-CSRF-TOKEN")
        uploadRequest.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        uploadRequest.setValue("https://img.binmt.cc/", forHTTPHeaderField: "Referer")
        uploadRequest.setValue("https://img.binmt.cc", forHTTPHeaderField: "Origin")
        uploadRequest.setValue("application/json, text/javascript, */*; q=0.01", forHTTPHeaderField: "Accept")
        if !cookieHeader.isEmpty {
            uploadRequest.setValue(cookieHeader, forHTTPHeaderField: "Cookie")
        }
        uploadRequest.httpBody = body

        let (uploadData, _) = try await session.data(for: uploadRequest)
        guard let map = try? JSONSerialization.jsonObject(with: uploadData) as? [String: Any] else {
            throw AHCommentAPIError.invalidResponse
        }
        guard map["status"] as? Bool == true else {
            let message = AHCommentJSON.string(map["message"])
            throw AHCommentAPIError.business(message.isEmpty ? "图床上传失败" : message)
        }

        let links = AHCommentJSON.dictionary(AHCommentJSON.dictionary(map["data"])["links"])
        let url = AHCommentJSON.string(links["url"])
        guard !url.isEmpty else {
            throw AHCommentAPIError.business("上传失败，未返回图片地址")
        }

        try await updateAvatar(url, token: token)
        return url
    }

    private static func extractCSRFToken(from html: String) -> String? {
        guard let regex = try? NSRegularExpression(
            pattern: #"name=["']csrf-token["'] content=["']([^"']+)["']"#,
            options: [.caseInsensitive]
        ) else { return nil }

        let range = NSRange(html.startIndex..<html.endIndex, in: html)
        guard
            let match = regex.firstMatch(in: html, options: [], range: range),
            match.numberOfRanges > 1,
            let tokenRange = Range(match.range(at: 1), in: html)
        else { return nil }

        return String(html[tokenRange])
    }

    // MARK: - 通用请求

    @discardableResult
    private static func send(
        path: String,
        method: String,
        query: [URLQueryItem] = [],
        body: [String: Any]? = nil,
        token: String? = nil
    ) async throws -> Any? {

        guard var components = URLComponents(string: "https://login.yiys07.com/api" + path) else {
            throw AHCommentAPIError.invalidURL
        }
        if !query.isEmpty {
            components.queryItems = query
        }
        guard let url = components.url else {
            throw AHCommentAPIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")

        if let token, !token.isEmpty {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        if let body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }

        let (data, _) = try await session.data(for: request)

        // 业务错误也带 4xx 状态码，统一按响应体里的 code 判断
        guard let envelope = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw AHCommentAPIError.invalidResponse
        }

        let code = AHCommentJSON.int(envelope["code"]) ?? -1
        guard code == 0 else {
            let message = AHCommentJSON.string(envelope["message"])
            throw AHCommentAPIError.business(message.isEmpty ? "请求失败（\(code)）" : message)
        }

        return envelope["data"]
    }
}
