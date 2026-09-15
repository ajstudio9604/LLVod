//
//  SearchHTTPClient.swift
//  LLVod
//
//  对应 Flutter EvalHttp / bfqxj Dio 的原生 HTTP（搜索批请求、详情、播链）
//

import Foundation

enum SearchHTTPClient {

    private static let defaultSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10
        return URLSession(configuration: config)
    }()

    private static let batchSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10
        return URLSession(configuration: config)
    }()

    struct Response {
        let body: String
        let statusCode: Int
        let realURI: String
    }

    static func get(
        _ urlString: String,
        headers: [String: String] = [:],
        timeout: TimeInterval = 10,
        requireSuccessStatus: Bool = true,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    ) async throws -> String {
        try await perform(
            method: "GET",
            urlString: urlString,
            body: nil,
            bodyIsBase64: false,
            headers: headers,
            timeout: timeout,
            responseAsBase64: false,
            requireSuccessStatus: requireSuccessStatus,
            cachePolicy: cachePolicy
        ).body
    }

    static func post(
        _ urlString: String,
        body: String? = nil,
        headers: [String: String] = [:],
        timeout: TimeInterval = 10,
        requireSuccessStatus: Bool = true
    ) async throws -> String {
        try await perform(
            method: "POST",
            urlString: urlString,
            body: body,
            bodyIsBase64: false,
            headers: headers,
            timeout: timeout,
            responseAsBase64: false,
            requireSuccessStatus: requireSuccessStatus
        ).body
    }

    static func postRaw(
        _ urlString: String,
        base64Body: String? = nil,
        headers: [String: String] = [:],
        timeout: TimeInterval = 10,
        requireSuccessStatus: Bool = true
    ) async throws -> String {
        try await perform(
            method: "POST",
            urlString: urlString,
            body: base64Body,
            bodyIsBase64: true,
            headers: headers,
            timeout: timeout,
            responseAsBase64: true,
            requireSuccessStatus: requireSuccessStatus
        ).body
    }

    static func batchRequest(
        method: String,
        urlString: String,
        body: String? = nil,
        headers: [String: String] = [:]
    ) async -> (response: Response, errorMessage: String?) {
        do {
            let response = try await perform(
                method: method,
                urlString: urlString,
                body: body,
                bodyIsBase64: false,
                headers: headers,
                timeout: 10,
                responseAsBase64: false,
                requireSuccessStatus: false,
                session: batchSession
            )
            return (response, nil)
        } catch {
            return (
                Response(body: "", statusCode: -1, realURI: urlString),
                error.localizedDescription
            )
        }
    }

    // MARK: - Core

    private static func perform(
        method: String,
        urlString: String,
        body: String?,
        bodyIsBase64: Bool,
        headers: [String: String],
        timeout: TimeInterval,
        responseAsBase64: Bool,
        requireSuccessStatus: Bool,
        session: URLSession? = nil,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    ) async throws -> Response {
        guard let url = makeURL(from: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = timeout
        request.cachePolicy = cachePolicy
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        if let body, !body.isEmpty {
            if bodyIsBase64 {
                request.httpBody = Data(base64Encoded: body) ?? Data(body.utf8)
            } else {
                request.httpBody = Data(body.utf8)
            }
        }

        let activeSession: URLSession
        if let session {
            activeSession = session
        } else if timeout <= 5.1 {
            activeSession = batchSession
        } else {
            activeSession = defaultSession
        }

        let (data, response) = try await activeSession.data(for: request)
        let http = response as? HTTPURLResponse
        let status = http?.statusCode ?? -1
        let realURI = http?.url?.absoluteString ?? urlString

        if let http {
            AHJsTimeSync.ingest(httpResponse: http)
        }

        if requireSuccessStatus, !(200...299).contains(status) {
            throw URLError(.badServerResponse)
        }

        let text: String
        if responseAsBase64 {
            text = data.base64EncodedString()
        } else if let utf8 = String(data: data, encoding: .utf8) {
            text = utf8
        } else {
            // 对齐 EvalHttp.get：非 UTF-8 回退 Base64（POST 以前会变空串）
            text = data.base64EncodedString()
        }

        return Response(body: text, statusCode: status, realURI: realURI)
    }

    private static func makeURL(from raw: String) -> URL? {
        if let url = URL(string: raw) {
            return url
        }

        var allowed = CharacterSet.urlFragmentAllowed
        allowed.insert(charactersIn: ":/?#[]@!$&'()*+,;=%")
        guard let encoded = raw.addingPercentEncoding(withAllowedCharacters: allowed) else {
            return nil
        }
        return URL(string: encoded)
    }
}
