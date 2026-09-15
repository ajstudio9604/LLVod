//
//  AHVodDetailLoader.swift
//  LLVod
//
//  对应 Flutter bfqxj.dart getjs()
//

import Foundation

enum AHVodDetailLoaderError: LocalizedError {
    case sourceNotFound
    case emptyEpisodes
    case networkError

    var errorDescription: String? {
        switch self {
        case .sourceNotFound:
            return ""
        case .emptyEpisodes:
            return ""
        case .networkError:
            return ""
        }
    }
}

enum AHVodDetailLoader {

    static func load(route: AHVodDetailRoute) async throws -> AHVodDetailPayload {
        let sources = resolveSources(for: route.zypath)
        guard let source = sources.first(where: { ($0["源名字"] as? String) == route.sourceName }) else {
            throw AHVodDetailLoaderError.sourceNotFound
        }

        let sourceType = source["源类型"] as? String ?? ""
        let isCustom = isCustomSource(source)

        if sourceType == "网站" {
            return try await loadWebsite(route: route, source: source)
        }

        if isCustom {
            return try await loadCustom(route: route, source: source)
        }

        return try await loadJSON(route: route, source: source)
    }

    private static func resolveSources(for zypath: String) -> [[String: Any]] {
        if let subscription = AHSearchSubscriptionLoader.load(), subscription.zypath == zypath {
            return subscription.sources
        }
        return SearchStorage.rslzDictionaryList(zypath)
    }

    private static func loadWebsite(
        route: AHVodDetailRoute,
        source: [String: Any]
    ) async throws -> AHVodDetailPayload {
        let detailURL = route.path
        let referer = source["拦截器Referer"] as? String ?? ""

        let html: String
        do {
            html = try await SearchHTTPClient.get(
                detailURL,
                headers: [
                    "Referer": referer,
                    "User-Agent": SearchUserAgent.generate()
                ]
            )
        } catch {
            throw AHVodDetailLoaderError.networkError
        }

        let actorRule = source["演员获取规则"] as? String ?? ""
        let statusRule = source["详情影片状态规则"] as? String ?? ""
        let introRule = source["影片简介"] as? String ?? ""
        let listRule = source["列表规则"] as? String ?? ""
        let lineNameRule = source["线路名规则"] as? String ?? ""
        let episodeNameRule = source["集数名规则"] as? String ?? ""
        let episodeLinkRule = source["视频链接规则"] as? String ?? ""
        let reverse = source["逆转选集"] as? Bool ?? false

        // 配置 XPath 常因站点改版失效（如永乐55 的 #panel1），再走 MacCMS module 皮肤兜底
        var actor = firstValue(in: html, xpath: actorRule) ?? ""
        var status = firstValue(in: html, xpath: statusRule) ?? ""
        var intro = firstValue(in: html, xpath: introRule) ?? ""
        applyModuleInfoFallback(html: html, actor: &actor, status: &status, intro: &intro)
        if actor.isEmpty { actor = "N/A" }
        if status.isEmpty { status = route.name }
        if intro.isEmpty { intro = "N/A" }

        var fragments = SearchHTMLXPathParser.selectNodeHTMLList(html: html, xpath: listRule)
        var lineNames = SearchHTMLXPathParser.select(html: html, xpath: lineNameRule)

        if fragments.isEmpty {
            fragments = SearchHTMLXPathParser.selectNodeHTMLList(
                html: html,
                xpath: #"//div[@class="module-play-list"]"#
            )
            if lineNames.isEmpty {
                lineNames = SearchHTMLXPathParser.select(
                    html: html,
                    xpath: #"//div[contains(@class,"module-tab-item")]/span/text()"#
                )
            }
        }

        if lineNames.isEmpty {
            lineNames = fragments.indices.map { "线路\($0 + 1)" }
        }

        var sourceLines: [AHVodSourceLine] = []

        for (index, fragment) in fragments.enumerated() {
            let lineName = index < lineNames.count ? lineNames[index] : "线路\(index + 1)"
            let episodes = VodDetailEpisodeParser.parseWebsiteEpisodes(
                fragment: fragment,
                nameRule: episodeNameRule,
                linkRule: episodeLinkRule,
                reverse: reverse
            )

            guard !episodes.isEmpty else { continue }

            sourceLines.append(
                AHVodSourceLine(
                    id: "\(lineName)-\(index)",
                    name: lineName.trimmingCharacters(in: .whitespacesAndNewlines),
                    episodes: episodes.map { episode in
                        AHVodEpisode(
                            id: episode.id,
                            title: episode.title,
                            path: resolveWebsiteURL(episode.path, base: detailURL)
                        )
                    },
                    parseURL: "",
                    sourceTag: ""
                )
            )
        }

        guard !sourceLines.isEmpty else {
            throw AHVodDetailLoaderError.emptyEpisodes
        }

        return AHVodDetailPayload(
            title: route.name,
            pic: route.pic,
            actor: actor,
            status: status,
            intro: intro,
            sourceLines: sourceLines,
            sourceConfig: source
        )
    }

    private static func applyModuleInfoFallback(
        html: String,
        actor: inout String,
        status: inout String,
        intro: inout String
    ) {
        if intro.isEmpty || intro == "N/A" {
            if let text = firstValue(
                in: html,
                xpath: #"//div[contains(@class,"module-info-introduction")]//p/text()"#
            ), !text.isEmpty {
                intro = text
            }
        }

        if actor.isEmpty || actor == "N/A" {
            let actors = SearchHTMLXPathParser.select(
                html: html,
                xpath: #"//div[contains(@class,"module-info-item")][span[contains(normalize-space(.),"主演")]]//a/text()"#
            )
            if !actors.isEmpty {
                actor = actors.joined(separator: "/")
            }
        }

        if status.isEmpty || status == "N/A" {
            if let text = firstValue(
                in: html,
                xpath: #"//div[contains(@class,"module-info-item")][span[contains(normalize-space(.),"备注")]]//div[contains(@class,"module-info-item-content")]//text()"#
            ), !text.isEmpty {
                status = text
            } else if let text = firstValue(
                in: html,
                xpath: #"//div[contains(@class,"module-info-tag")]//a/text()"#
            ), !text.isEmpty {
                status = text
            }
        }
    }

    private static func resolveWebsiteURL(_ path: String, base: String) -> String {
        let trimmed = path.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.hasPrefix("http://") || trimmed.hasPrefix("https://") {
            return trimmed
        }
        guard let baseURL = URL(string: base),
              let resolved = URL(string: trimmed, relativeTo: baseURL)?.absoluteString else {
            return trimmed
        }
        return resolved
    }

    private static func loadCustom(
        route: AHVodDetailRoute,
        source: [String: Any]
    ) async throws -> AHVodDetailPayload {
        guard let rule = source["规则"] as? String else {
            throw AHVodDetailLoaderError.emptyEpisodes
        }

        let baseURL = source["请求链接"] as? String ?? route.path
        guard let request = await SearchJsRuleEngine.makeDetailRequest(
            rule: rule,
            baseURL: baseURL,
            videoLinkId: route.videoLinkId
        ) else {
            throw AHVodDetailLoaderError.emptyEpisodes
        }

        let response: String
        do {
            if request.method.uppercased() == "POST" {
                response = try await SearchHTTPClient.post(
                    request.url,
                    body: request.data,
                    headers: request.headers
                )
            } else {
                response = try await SearchHTTPClient.get(
                    request.url,
                    headers: request.headers
                )
            }
        } catch {
            throw AHVodDetailLoaderError.networkError
        }

        guard let parsed = await SearchJsRuleEngine.parseDetailList(
            rule: rule,
            response: response
        ) else {
            throw AHVodDetailLoaderError.emptyEpisodes
        }

        // 逆转选集只对「网站」类型的 xpath 源生效，自定义规则保持原始顺序
        // 大包剧集异步解析，避免主线程同步卡顿
        var sourceLines: [AHVodSourceLine] = []
        sourceLines.reserveCapacity(parsed.lines.count)
        for line in parsed.lines {
            let episodes = await AHParserUtils.parseEpisodesAsync(line.detail)
            guard !episodes.isEmpty else { continue }
            sourceLines.append(
                AHVodSourceLine(
                    id: line.name,
                    name: line.name,
                    episodes: episodes,
                    parseURL: "",
                    sourceTag: line.sourceTag
                )
            )
        }

        guard !sourceLines.isEmpty else {
            throw AHVodDetailLoaderError.emptyEpisodes
        }

        return AHVodDetailPayload(
            title: route.name,
            pic: route.pic,
            actor: parsed.meta.actor,
            status: parsed.meta.status,
            intro: parsed.meta.intro,
            sourceLines: sourceLines,
            sourceConfig: source
        )
    }

    private static func loadJSON(
        route: AHVodDetailRoute,
        source: [String: Any]
    ) async throws -> AHVodDetailPayload {
        var url = source["请求链接"] as? String ?? route.path
        let videoLinkId = route.videoLinkId

        url = buildDetailURL(baseURL: url, videoLinkId: videoLinkId)

        var headers: [String: String] = [:]
        if let searchUA = source["搜索UA"] as? String, !searchUA.isEmpty {
            headers = AHParserUtils.parseHeaders(searchUA)
        }

        let response: String
        do {
            response = try await SearchHTTPClient.get(url, headers: headers)
        } catch {
            throw AHVodDetailLoaderError.networkError
        }

        guard let json = decodeJSON(response: response, requestURL: url) else {
            throw AHVodDetailLoaderError.emptyEpisodes
        }

        let vodInfo = extractVodInfo(from: json)
        let actor = stringValue(vodInfo["vod_actor"]) ?? "N/A"
        let status = stringValue(vodInfo["vod_remarks"]) ?? "N/A"
        let intro = stringValue(vodInfo["vod_content"]) ?? stringValue(vodInfo["vod_blurb"]) ?? "N/A"

        var sourceLines: [AHVodSourceLine] = []

        if let playList = vodInfo["vod_play_list"] as? [[String: Any]] {
            for (index, item) in playList.enumerated() {
                let playerInfo = item["player_info"] as? [String: Any]
                let lineName = stringValue(playerInfo?["show"]) ?? stringValue(item["from"]) ?? "线路\(index + 1)"
                let playURL = stringValue(item["url"]) ?? ""
                let tag = stringValue(item["code"]) ?? stringValue(item["from"]) ?? lineName
                let episodes = VodDetailEpisodeParser.parseHashEpisodes(playURL)

                guard !episodes.isEmpty else { continue }

                sourceLines.append(
                    AHVodSourceLine(
                        id: "\(lineName)-\(index)",
                        name: lineName,
                        episodes: episodes,
                        parseURL: stringValue(playerInfo?["parse2"]) ?? stringValue(playerInfo?["parse"]) ?? "",
                        sourceTag: tag
                    )
                )
            }
        } else if let playURL = stringValue(vodInfo["vod_play_url"]),
                  let playFrom = stringValue(vodInfo["vod_play_from"]) {
            let urlGroups = playURL.components(separatedBy: "$$$")
            let nameGroups = playFrom.components(separatedBy: "$$$")

            for (index, group) in urlGroups.enumerated() {
                let lineName = index < nameGroups.count ? nameGroups[index] : "线路\(index + 1)"
                let episodes = VodDetailEpisodeParser.parseHashEpisodes(group)
                guard !episodes.isEmpty else { continue }

                sourceLines.append(
                    AHVodSourceLine(
                        id: "\(lineName)-\(index)",
                        name: lineName,
                        episodes: episodes,
                        parseURL: "",
                        sourceTag: lineName
                    )
                )
            }
        }

        guard !sourceLines.isEmpty else {
            throw AHVodDetailLoaderError.emptyEpisodes
        }

        return AHVodDetailPayload(
            title: route.name,
            pic: route.pic,
            actor: actor,
            status: status,
            intro: intro,
            sourceLines: sourceLines,
            sourceConfig: source
        )
    }

    private static func buildDetailURL(baseURL: String, videoLinkId: String) -> String {
        if baseURL.contains("api.php/app") {
            return "\(baseURL)video_detail?id=\(videoLinkId)"
        }
        if baseURL.contains("php/provide/vod") {
            return "\(baseURL)?ac=detail&ids=\(videoLinkId)"
        }
        if baseURL.contains("iptv") {
            return "\(baseURL)video_detail?id=\(videoLinkId)"
        }
        if baseURL.contains("xgapp.php/v1") || baseURL.contains("xgapp.php/v2") {
            return "\(baseURL)video_detail?id=\(videoLinkId)"
        }
        if baseURL.contains("php/v1.vod") || baseURL.contains("php/m2.vod") {
            return "\(baseURL)/detail?vod_id=\(videoLinkId)"
        }
        if baseURL.contains(",") {
            let parts = baseURL.split(separator: ",", maxSplits: 1).map(String.init)
            if parts.count > 1 {
                return parts[1].replacingOccurrences(of: "{id}", with: videoLinkId)
            }
        }
        return "\(baseURL)video_detail?id=\(videoLinkId)"
    }

    private static func decodeJSON(response: String, requestURL: String) -> [String: Any]? {
        if requestURL.contains("2233"),
           let decrypted = AHParserUtils.tryAesDecryptJSON(response) {
            return decrypted
        }
        return AHParserUtils.plainJSON(response)
    }

    private static func extractVodInfo(from json: [String: Any]) -> [String: Any] {
        let text = (try? String(data: JSONSerialization.data(withJSONObject: json), encoding: .utf8)) ?? ""

        if text.contains("vod_info"), let data = json["data"] as? [String: Any],
           let info = data["vod_info"] as? [String: Any] {
            return info
        }

        if let data = json["data"] as? [String: Any] {
            return data
        }

        if let list = json["list"] as? [[String: Any]], let first = list.first {
            return first
        }

        return json
    }

    private static func stringValue(_ value: Any?) -> String? {
        AHParserUtils.stringValue(value)
    }

    private static func firstValue(in html: String, xpath: String) -> String? {
        guard !xpath.isEmpty else { return nil }
        return SearchHTMLXPathParser.select(html: html, xpath: xpath).first
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
