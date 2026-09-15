//
//  AHDouBanFrodoClient.swift
//  LLVod
//
//  豆瓣 Frodo GET + HMAC `_sig`，与 AHDouBan* 签名规则一致
//

import Foundation

enum AHDouBanFrodoClient {

    private static let host = "https://frodo.douban.com"
    private static let apikey = "0dad551ec0f84ed02907ff5c42e8ec70"
    private static let signSecret = "bf7dddc7c9cfe6f7"

    private static let unreservedCharacters = CharacterSet(
        charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.!~*'()"
    )

    static func get(
        path: String,
        extraQuery: [URLQueryItem] = [],
        session: URLSession = .shared
    ) async throws -> Data {
        let time = Int(Date().timeIntervalSince1970)
        let udid = generateUdid()
        let endpoint = host + path

        let arg1 = path.replacingOccurrences(of: "/", with: "%2F")
        let signInput = "GET&\(arg1)&\(time)"
        let sig = try CryptoUtil.hmacSha1(signInput, secret: signSecret, outputBase64: true)

        guard var components = URLComponents(string: endpoint) else {
            throw NetworkError2.invalidURL
        }

        var items: [URLQueryItem] = [
            URLQueryItem(name: "udid", value: udid),
            URLQueryItem(name: "uuid", value: udid),
            URLQueryItem(name: "rom", value: "android"),
            URLQueryItem(name: "apikey", value: apikey),
            URLQueryItem(name: "s", value: "rexxar_new"),
            URLQueryItem(name: "channel", value: "Yingyongbao_Market"),
            URLQueryItem(name: "timezone", value: "Asia/Shanghai"),
            URLQueryItem(name: "device_id", value: udid),
            URLQueryItem(name: "os_rom", value: "android"),
            URLQueryItem(name: "apple", value: "c52fbb99b908be4d026954cc4374f16d"),
            URLQueryItem(name: "mooncake", value: "0f607264fc6318a92b9e13c65db7cd3c"),
            URLQueryItem(name: "sugar", value: "0"),
            URLQueryItem(name: "loc_id", value: "0"),
            URLQueryItem(name: "_ts", value: String(time))
        ]
        items.append(contentsOf: extraQuery)
        components.queryItems = items

        components.percentEncodedQuery = [
            components.percentEncodedQuery,
            "_sig=\(escaped(sig))"
        ]
        .compactMap { $0 }
        .joined(separator: "&")

        guard let url = components.url else {
            throw NetworkError2.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        request.setValue(
            """
            Rexxar-Core/0.1.3 api-client/1 com.douban.frodo/7.9.0(216) \
            Android/28 product/Xiaomi11 rom/android network/wifi udid/\(udid) \
            platform/mobile com.douban.frodo/7.9.0(216) Rexxar/1.2.151 \
            platform/mobile 1.2.151
            """,
            forHTTPHeaderField: "User-Agent"
        )

        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError2.invalidResponse
        }
        guard 200...299 ~= http.statusCode else {
            throw NetworkError2.httpError(http.statusCode)
        }
        return data
    }

    private static func escaped(_ value: String) -> String {
        value.addingPercentEncoding(withAllowedCharacters: unreservedCharacters) ?? value
    }

    private static func generateUdid() -> String {
        let chars = Array("abcdefghijklmnopqrstuvwxyz0123456789")
        return String((0..<40).map { _ in chars.randomElement()! })
    }
}
