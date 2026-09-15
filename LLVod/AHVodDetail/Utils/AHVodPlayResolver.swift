//
//  AHVodPlayResolver.swift
//  LLVod
//
//  对应 Flutter bfqxj.dart djan / zdqhjx
//

import Foundation

enum AHVodPlayResolver {

    static func resolve(
        episodeURL: String,
        detailPath: String,
        sourceConfig: [String: Any],
        sourceLine: AHVodSourceLine,
        zypath: String,
        preferredParserIndex: Int = 0
    ) async throws -> AHVodPlayResolveResult {
        // 用户在解析途中退出就别往下跑了：底下每一步都可能起 WebView 或发请求
        try Task.checkCancellation()

        let normalizedEpisode = normalizeEpisodeURL(
            episodeURL: episodeURL,
            detailPath: detailPath,
            sourceConfig: sourceConfig
        )

        if isDirectMediaURL(normalizedEpisode) {
            return AHVodPlayResolveResult(
                url: normalizedEpisode,
                playerHeaders: playerHeaders(from: sourceConfig),
                usedParserName: "直链"
            )
        }

        if sourceConfig["源类型"] as? String == "网站" {
            let referer = sourceConfig["拦截器Referer"] as? String ?? ""
            var headers = ["User-Agent": SearchUserAgent.generate()]
            if !referer.isEmpty {
                headers["Referer"] = referer
            }

            if let sniffed = try await sniffPage(
                url: normalizedEpisode,
                headers: headers,
                whitelist: sourceConfig["嗅探白名单"] as? String ?? "",
                blacklist: sourceConfig["嗅探黑名单"] as? String ?? ""
            ) {
                return AHVodPlayResolveResult(
                    url: sniffed,
                    playerHeaders: headers,
                    usedParserName: "网页嗅探"
                )
            }
        }

        if isCustomSource(sourceConfig), let rule = sourceConfig["规则"] as? String {
            if let custom = try await resolveCustomRule(
                rule: rule,
                episodeURL: normalizedEpisode,
                sourceTag: sourceLine.sourceTag
            ) {
                return custom
            }
        }

        let keyword = AHVodJxPathLoader.resolveKeyword(
            sourceTag: sourceLine.sourceTag,
            episodeURL: normalizedEpisode
        )
        let jxpath = AHVodJxPathLoader.load(zypath: zypath)
        let options = AHVodJxPathLoader.buildJxOptions(
            jxpath: jxpath,
            keyword: keyword,
            builtInParseURL: sourceLine.parseURL
        )

        guard !options.isEmpty else {
            if isDirectMediaURL(normalizedEpisode) {
                return AHVodPlayResolveResult(
                    url: normalizedEpisode,
                    playerHeaders: playerHeaders(from: sourceConfig),
                    usedParserName: "直链"
                )
            }
            throw AHVodPlayResolverError.unableToResolve
        }

        let startIndex = min(max(preferredParserIndex, 0), options.count - 1)
        var indices = Array(startIndex..<options.count)
        if startIndex > 0 {
            indices.append(contentsOf: 0..<startIndex)
        }

        for index in indices {
            // 单个解析器失败会吞掉错误继续试下一个，取消也会被一起吞掉，
            // 所以每轮开头单独查一次，否则退出页面后还会把剩下的解析器全跑完
            try Task.checkCancellation()

            let option = options[index]
            if let result = try await resolve(option: option, episodeURL: normalizedEpisode) {
                return result
            }
        }

        throw AHVodPlayResolverError.unableToResolve
    }

    private static func resolve(
        option: AHVodJxOption,
        episodeURL: String
    ) async throws -> AHVodPlayResolveResult? {
        if option.type == "嗅探" {
            return try await resolveSniff(option: option, episodeURL: episodeURL)
        }

        return try await resolveJSONParser(option: option, episodeURL: episodeURL)
    }

    private static func resolveSniff(
        option: AHVodJxOption,
        episodeURL: String
    ) async throws -> AHVodPlayResolveResult? {
        let targetURL = option.api + episodeURL
        let headers = requestHeaders(from: option.userAgent)

        let html: String
        do {
            html = try await SearchHTTPClient.get(targetURL, headers: headers)
        } catch {
            return nil
        }

        if isDirectMediaURL(html) {
            return nil
        }

        if let sniffed = sniffMediaURL(
            html: html,
            whitelist: option.sniffWhitelist,
            blacklist: option.sniffBlacklist
        ) {
            return AHVodPlayResolveResult(
                url: sniffed,
                playerHeaders: headers,
                usedParserName: option.name
            )
        }

        // 嗅探型解析接口用自己的黑白名单再跑一遍 WebView
        if let sniffed = await sniffWithWebView(
            url: targetURL,
            headers: headers,
            whitelist: option.sniffWhitelist,
            blacklist: option.sniffBlacklist
        ) {
            return AHVodPlayResolveResult(
                url: sniffed,
                playerHeaders: headers,
                usedParserName: option.name
            )
        }

        return nil
    }

    private static func resolveJSONParser(
        option: AHVodJxOption,
        episodeURL: String
    ) async throws -> AHVodPlayResolveResult? {
        let targetURL = option.api + episodeURL
        let headers = requestHeaders(from: option.userAgent)

        let response: String
        do {
            response = try await SearchHTTPClient.get(targetURL, headers: headers)
        } catch {
            return nil
        }

        if AHParserUtils.isHTMLResponse(response) {
            if let sniffed = sniffMediaURL(
                html: response,
                whitelist: option.sniffWhitelist,
                blacklist: option.sniffBlacklist
            ) {
                return AHVodPlayResolveResult(
                    url: sniffed,
                    playerHeaders: headers,
                    usedParserName: option.name
                )
            }
            return nil
        }

        guard let url = extractPlayURL(from: response, api: option.api) else {
            return nil
        }

        return AHVodPlayResolveResult(
            url: url,
            playerHeaders: headers,
            usedParserName: option.name
        )
    }

    private static func resolveCustomRule(
        rule: String,
        episodeURL: String,
        sourceTag: String
    ) async throws -> AHVodPlayResolveResult? {
        guard let request = await SearchJsRuleEngine.makeJxRequest(
            rule: rule,
            episodeURL: episodeURL,
            sourceTag: sourceTag
        ), !request.url.isEmpty else {
            return nil
        }

        let response: String
        do {
            if request.method.lowercased() == "get" {
                response = try await SearchHTTPClient.get(
                    request.url,
                    headers: request.headers
                )
            } else {
                // 对齐 bfqxj：protobuf / octet-stream 走二进制 Base64 往返
                let contentType = request.headers.first(where: {
                    $0.key.lowercased() == "content-type"
                })?.value.lowercased() ?? ""
                let isBinary = contentType.contains("protobuf")
                    || contentType.contains("octet-stream")

                if isBinary {
                    response = try await SearchHTTPClient.postRaw(
                        request.url,
                        base64Body: request.body,
                        headers: request.headers
                    )
                } else {
                    response = try await SearchHTTPClient.post(
                        request.url,
                        body: request.body,
                        headers: request.headers
                    )
                }
            }
        } catch {
            return nil
        }

        let playerHeaders = await SearchJsRuleEngine.parsePlayerHeaders(rule: rule)

        // 对齐 Flutter：HTML 响应走嗅探，而不是直接失败
        if AHParserUtils.isHTMLResponse(response) {
            if let sniffed = try await sniffPage(
                url: episodeURL,
                headers: playerHeaders,
                whitelist: "",
                blacklist: ""
            ) {
                return AHVodPlayResolveResult(
                    url: sniffed,
                    playerHeaders: playerHeaders,
                    usedParserName: "自定义规则嗅探"
                )
            }
            return nil
        }

        let cleaned = AHParserUtils.filterNewlines(
            response.replacingOccurrences(of: "\n", with: "")
        )

        guard let playURL = await SearchJsRuleEngine.parseJxResponse(
            rule: rule,
            response: cleaned,
            sourceTag: sourceTag
        ), !playURL.isEmpty else {
            return nil
        }

        return AHVodPlayResolveResult(
            url: playURL,
            playerHeaders: playerHeaders,
            usedParserName: "自定义规则"
        )
    }

    private static func extractPlayURL(from response: String, api: String) -> String? {
        let cleaned = AHParserUtils.filterNewlines(response)

        // 对齐 bfqxj：订阅 jx 对 2233 允许明文 JSON fallback
        if let url = AHParserUtils.extractVideoURL(
            from: cleaned,
            isEncrypted: api.contains("2233"),
            fallbackToPlainJson: true
        ) {
            return url
        }

        // 有些解析接口直接返回裸地址而不是 JSON
        let trimmed = cleaned.trimmingCharacters(in: .whitespaces)
        if trimmed.hasPrefix("http"),
           !trimmed.contains(where: \.isWhitespace),
           isDirectMediaURL(trimmed) {
            return trimmed
        }

        return nil
    }

    private static func sniffPage(
        url: String,
        headers: [String: String],
        whitelist: String,
        blacklist: String
    ) async throws -> String? {
        // 先用静态 HTML 正则，命中就省掉一次 WebView
        if let html = try? await SearchHTTPClient.get(url, headers: headers),
           let sniffed = sniffMediaURL(html: html, whitelist: whitelist, blacklist: blacklist) {
            return sniffed
        }

        return await sniffWithWebView(
            url: url,
            headers: headers,
            whitelist: whitelist,
            blacklist: blacklist
        )
    }

    private static func sniffWithWebView(
        url: String,
        headers: [String: String],
        whitelist: String,
        blacklist: String
    ) async -> String? {
        await AHWebSniffer.sniff(
            url: url,
            whitelist: whitelist,
            blacklist: blacklist,
            userAgent: headers["User-Agent"] ?? "",
            referer: headers["Referer"] ?? ""
        )
    }

    private static func sniffMediaURL(
        html: String,
        whitelist: String,
        blacklist: String
    ) -> String? {
        let pattern = #"https?://[^\s"'<>\\]+(?:\.m3u8|\.mp4|\.flv|\.mkv|/m3u8[^\s"'<>\\]*)[^\s"'<>\\]*"#
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }

        let range = NSRange(html.startIndex..<html.endIndex, in: html)
        let matches = regex.matches(in: html, range: range)

        for match in matches {
            guard let urlRange = Range(match.range, in: html) else { continue }
            let candidate = String(html[urlRange])
                .replacingOccurrences(of: "\\/", with: "/")

            if !matchesSniffRules(
                url: candidate,
                whitelist: whitelist,
                blacklist: blacklist
            ) {
                continue
            }

            return candidate
        }

        return nil
    }

    private static func matchesSniffRules(
        url: String,
        whitelist: String,
        blacklist: String
    ) -> Bool {
        let whiteParts = whitelist
            .split(separator: ",")
            .map { String($0).trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        let blackParts = blacklist
            .split(separator: ",")
            .map { String($0).trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        if !whiteParts.isEmpty,
           !whiteParts.contains(where: { url.localizedCaseInsensitiveContains($0) }) {
            return false
        }

        if blackParts.contains(where: { url.localizedCaseInsensitiveContains($0) }) {
            return false
        }

        return true
    }

    private static func normalizeEpisodeURL(
        episodeURL: String,
        detailPath: String,
        sourceConfig: [String: Any]
    ) -> String {
        if episodeURL.hasPrefix("http") {
            return episodeURL
        }

        let sourceType = sourceConfig["源类型"] as? String ?? ""
        if sourceType == "网站" {
            if let protocolPart = AHParserUtils.extractPart(detailPath, pattern: #"http(.*?)//"#),
               let domainPart = AHParserUtils.extractPart(detailPath, pattern: #"//(.*?)/"#) {
                return "http\(protocolPart)//\(domainPart)\(episodeURL)"
            }
        }

        return episodeURL
    }

    private static func isDirectMediaURL(_ value: String) -> Bool {
        let lower = value.lowercased()
        return lower.contains("m3u8")
            || lower.contains(".mp4")
            || lower.contains(".flv")
            || lower.contains(".mkv")
    }

    private static func requestHeaders(from raw: String) -> [String: String] {
        AHParserUtils.headersOrDefault(raw)
    }

    private static func playerHeaders(from source: [String: Any]) -> [String: String] {
        AHParserUtils.headersOrDefault(source["播放UA"] as? String ?? "")
    }

    private static func isCustomSource(_ source: [String: Any]) -> Bool {
        if source["源类型"] as? String == "自定义规则源" {
            return true
        }
        if let enabled = source["自定义"] as? Bool {
            return enabled
        }
        if let enabled = source["自定义"] as? String {
            return enabled == "true"
        }
        return false
    }
}
