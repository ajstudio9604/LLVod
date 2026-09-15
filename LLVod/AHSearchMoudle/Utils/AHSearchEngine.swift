//
//  AHSearchEngine.swift
//  LLVod
//
//  对应 Flutter view.dart 中 ss() 的请求构建与解析
//

import Foundation

enum AHSearchEngine {

    static func buildRequestParams(
        sources: [[String: Any]],
        keyword: String
    ) async -> [AHSearchRequestParams] {
        var params: [AHSearchRequestParams] = []
        for (index, factory) in makeRequestParamFactories(sources: sources, keyword: keyword).enumerated() {
            if let built = await factory() {
                params.append(
                    AHSearchRequestParams(
                        url: built.url,
                        method: built.method,
                        data: built.data,
                        headers: built.headers,
                        sourceIndex: built.sourceIndex ?? index
                    )
                )
            }
        }
        return params
    }

    static func makeRequestParamFactories(
        sources: [[String: Any]],
        keyword: String
    ) -> [() async -> AHSearchRequestParams?] {
        sources.enumerated().map { index, source in
            {
                await Self.buildParams(source: source, keyword: keyword, sourceIndex: index)
            }
        }
    }

    private static func buildParams(
        source: [String: Any],
        keyword: String,
        sourceIndex: Int
    ) async -> AHSearchRequestParams? {
        let built: AHSearchRequestParams?
        if isCustomSource(source) {
            built = await buildCustomParams(source: source, keyword: keyword)
        } else if (source["源类型"] as? String) == "网站" {
            built = buildWebsiteParams(source: source, keyword: keyword)
        } else {
            built = buildJSONParams(source: source, keyword: keyword)
        }
        guard let built else { return nil }
        return AHSearchRequestParams(
            url: built.url,
            method: built.method,
            data: built.data,
            headers: built.headers,
            sourceIndex: sourceIndex
        )
    }

    static func parseResponse(
        source: [String: Any],
        response: String,
        realURI: String
    ) async -> [AHSearchResultItem] {
        if isCustomSource(source) {
            return await parseCustomResponse(source: source, response: response)
        }

        let sourceType = source["源类型"] as? String ?? ""

        if sourceType == "网站" {
            return parseWebsiteResponse(source: source, response: response, realURI: realURI)
        }

        return parseJSONResponse(source: source, response: response, realURI: realURI)
    }

    // MARK: - Request builders

    private static func buildCustomParams(
        source: [String: Any],
        keyword: String
    ) async -> AHSearchRequestParams? {
        guard let rule = source["规则"] as? String,
              let baseURL = source["请求链接"] as? String else {
            return nil
        }

        return await SearchJsRuleEngine.makeSearchRequest(
            rule: rule,
            baseURL: baseURL,
            keyword: keyword
        )
    }

    private static func buildWebsiteParams(
        source: [String: Any],
        keyword: String
    ) -> AHSearchRequestParams? {
        let searchAPI = source["搜索API"] as? String ?? ""

        if searchAPI.isEmpty {
            // GET：URL 需要编码；POST body：对齐 Flutter 原样塞中文（charset=utf-8）
            let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? keyword
            let searchURL = (source["搜索URL"] as? String ?? "")
                .replacingOccurrences(of: "{name}", with: encodedKeyword)
            let postBody = source["POST参数"] as? String

            var headers: [String: String] = [
                "Content-Type": "application/x-www-form-urlencoded;charset=utf-8",
                "Content-Encoding": "gzip",
                "User-Agent": SearchUserAgent.generate()
            ]

            if let referer = source["拦截器Referer"] as? String, !referer.isEmpty {
                headers["Referer"] = referer
            }

            if postBody?.isEmpty ?? true {
                return AHSearchRequestParams(
                    url: searchURL,
                    method: "GET",
                    headers: headers
                )
            }

            return AHSearchRequestParams(
                url: source["搜索URL"] as? String ?? searchURL,
                method: "POST",
                data: postBody?.replacingOccurrences(of: "{name}", with: keyword),
                headers: headers
            )
        }

        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? keyword
        let url = searchAPI + "/index.php/ajax/suggest?mid=1&wd=" + encodedKeyword
        return AHSearchRequestParams(
            url: url,
            method: "GET",
            headers: [
                "Content-Type": "application/x-www-form-urlencoded;charset=utf-8",
                "Content-Encoding": "gzip",
                "User-Agent": SearchUserAgent.generate()
            ]
        )
    }

    private static func buildJSONParams(
        source: [String: Any],
        keyword: String
    ) -> AHSearchRequestParams? {
        let baseURL = (source["请求链接"] as? String ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        guard !baseURL.isEmpty else { return nil }

        let url = buildJSONSearchURL(baseURL: baseURL, keyword: keyword)
        var headers: [String: String] = [:]

        if let searchUA = source["搜索UA"] as? String, !searchUA.isEmpty {
            headers = AHParserUtils.parseHeaders(searchUA)
        }

        return AHSearchRequestParams(url: url, method: "GET", headers: headers)
    }

    private static func buildJSONSearchURL(baseURL: String, keyword: String) -> String {
        let encoded = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? keyword

        if baseURL.contains("api.php/app") {
            return "\(baseURL)/search?pg=1&text=\(encoded)"
        }
        if baseURL.contains("php/provide/vod") {
            return "\(baseURL)?ac=videolist&wd=\(encoded)"
        }
        if baseURL.contains("iptv") {
            return "\(baseURL)/search?pg=1&text=\(encoded)"
        }
        if baseURL.contains("xgapp.php/v1") || baseURL.contains("xgapp.php/v2") {
            return "\(baseURL)/search?pg=1&text=\(encoded)"
        }
        if baseURL.contains("php/v1.vod") || baseURL.contains("php/m2.vod") {
            return "\(baseURL)?wd=\(encoded)"
        }
        if baseURL.contains(",") {
            let parts = baseURL.split(separator: ",", maxSplits: 1).map(String.init)
            if let first = parts.first {
                return first.replacingOccurrences(of: "{name}", with: encoded)
            }
        }
        return "\(baseURL)/search?pg=1&text=\(encoded)"
    }

    // MARK: - Response parsers

    private static func parseCustomResponse(
        source: [String: Any],
        response: String
    ) async -> [AHSearchResultItem] {
        guard let rule = source["规则"] as? String else { return [] }

        let sourceName = source["源名字"] as? String ?? "搜索结果"
        let requestURL = source["请求链接"] as? String ?? ""
        let rows = await SearchJsRuleEngine.parseSearchList(rule: rule, response: response)

        return rows.compactMap { row in
            guard row.count >= 4 else { return nil }

            let title = row[0]
            guard !title.isEmpty else { return nil }

            var status = row[1]
            if status.isEmpty { status = "N/A" }

            let imageRaw = row[2]
            let imageURL = SearchBackgroundImageParser.extractURL(from: imageRaw) ?? imageRaw
            let pathId = row[3]

            return AHSearchResultItem(
                id: "\(sourceName)-\(pathId)-\(title)",
                title: title,
                sourceName: sourceName,
                status: status,
                imageURL: imageURL,
                pathId: pathId,
                path: requestURL
            )
        }
    }

    private static func parseWebsiteResponse(
        source: [String: Any],
        response: String,
        realURI: String
    ) -> [AHSearchResultItem] {
        let searchAPI = source["搜索API"] as? String ?? ""
        let matchURL = searchAPI.isEmpty
            ? (source["搜索URL"] as? String ?? "")
            : searchAPI

        guard domainMatches(url: matchURL, realURI: realURI) else {
            return []
        }

        if searchAPI.isEmpty {
            return parseWebsiteHTML(source: source, response: response)
        }

        guard let data = response.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return []
        }

        if (json["msg"] as? String) == "联想搜索功能关闭中" {
            return []
        }

        guard let list = json["list"] as? [[String: Any]] else {
            return []
        }

        let sourceName = source["源名字"] as? String ?? "搜索结果"
        let pageLinkTemplate = source["网页选集链接"] as? String ?? ""

        return list.compactMap { item in
            let title = item["name"] as? String ?? ""
            let webID = item["id"]
            let webIDText = webID.map { String(describing: $0) } ?? ""
            let pic = item["pic"] as? String ?? ""
            let imageURL = SearchBackgroundImageParser.extractURL(from: pic) ?? pic
            let detailURL = pageLinkTemplate.replacingOccurrences(of: "{id}", with: webIDText)

            guard !title.isEmpty else { return nil }

            return AHSearchResultItem(
                id: "\(sourceName)-\(webIDText)-\(title)",
                title: title,
                sourceName: sourceName,
                status: "N/A",
                imageURL: imageURL,
                pathId: webIDText,
                path: detailURL
            )
        }
    }

    private static func parseWebsiteHTML(
        source: [String: Any],
        response: String
    ) -> [AHSearchResultItem] {
        guard let posterRule = source["海报规则"] as? String,
              let linkRule = source["详情页链接规则"] as? String,
              let nameRule = source["影片名规则"] as? String,
              let statusRule = source["影片状态规则"] as? String else {
            return []
        }

        let images = SearchHTMLXPathParser.select(html: response, xpath: posterRule)
        let links = SearchHTMLXPathParser.select(html: response, xpath: linkRule)
        let names = SearchHTMLXPathParser.select(html: response, xpath: nameRule)
        let statuses = SearchHTMLXPathParser.select(html: response, xpath: statusRule)

        guard !links.isEmpty else { return [] }

        let sourceName = source["源名字"] as? String ?? "搜索结果"
        let searchURL = source["搜索URL"] as? String ?? ""
        var items: [AHSearchResultItem] = []

        for index in 0..<links.count {
            // 对齐 Flutter：有详情链接就收录；片名 XPath 没命中时用占位，不能整源丢掉
            var title = index < names.count ? names[index] : ""
            if title.isEmpty {
                title = "未知"
            }

            var status = index < statuses.count ? statuses[index] : "N/A"
            if status.isEmpty { status = "N/A" }

            var imageURL = index < images.count ? images[index] : ""
            imageURL = SearchBackgroundImageParser.extractURL(from: imageURL) ?? imageURL
            imageURL = resolveImageURL(imageURL, searchURL: searchURL)

            let detailURL = resolveDetailURL(links[index], searchURL: searchURL)

            items.append(
                AHSearchResultItem(
                    id: "\(sourceName)-\(detailURL)-\(title)",
                    title: title,
                    sourceName: sourceName,
                    status: status,
                    imageURL: imageURL,
                    pathId: "",
                    path: detailURL
                )
            )
        }

        return items
    }

    private static func parseJSONResponse(
        source: [String: Any],
        response: String,
        realURI: String
    ) -> [AHSearchResultItem] {
        let requestURL = source["请求链接"] as? String ?? ""
        guard domainMatches(url: requestURL, realURI: realURI) else {
            return []
        }

        let sourceName = source["源名字"] as? String ?? "搜索结果"
        let jsonObject = decodeSearchJSON(response: response, requestURL: requestURL)
        guard let jsjx = jsonObject else { return [] }

        let webpageSourceCode = (try? String(data: JSONSerialization.data(withJSONObject: jsjx), encoding: .utf8)) ?? ""
        let jxlist: [[String: Any]]

        if webpageSourceCode.contains("videoName") && webpageSourceCode.contains("starName"),
           let data = jsjx["data"] as? [[String: Any]] {
            jxlist = data
        } else if webpageSourceCode.contains("data") && webpageSourceCode.contains("list"),
                  let data = jsjx["data"] as? [String: Any],
                  let list = data["list"] as? [[String: Any]] {
            jxlist = list
        } else if let data = jsjx["data"] as? [[String: Any]] {
            jxlist = data
        } else if let list = jsjx["list"] as? [[String: Any]] {
            jxlist = list
        } else {
            return []
        }

        if jxlist.isEmpty { return [] }

        return jxlist.compactMap { item in
            let title = (item["vod_name"] ?? item["videoName"]).map { String(describing: $0) } ?? ""
            let imageRaw = (item["vod_pic"] ?? item["videoCover"]).map { String(describing: $0) } ?? ""
            let imageURL = SearchBackgroundImageParser.extractURL(from: imageRaw) ?? imageRaw
            var status = (item["vod_remarks"] ?? item["msg"]).map { String(describing: $0) } ?? "N/A"
            if status.isEmpty { status = "N/A" }

            let pathId = (item["vod_id"] ?? item["id"]).map { String(describing: $0) } ?? ""
            let path = requestURL

            guard !title.isEmpty else { return nil }

            return AHSearchResultItem(
                id: "\(sourceName)-\(pathId)-\(title)",
                title: title,
                sourceName: sourceName,
                status: status,
                imageURL: imageURL,
                pathId: pathId,
                path: path
            )
        }
    }

    // MARK: - Helpers

    private static func resolveImageURL(_ image: String, searchURL: String) -> String {
        if image.contains("="),
           let regex = try? NSRegularExpression(pattern: #"=(.*)"#),
           let match = regex.firstMatch(
               in: image,
               range: NSRange(image.startIndex..<image.endIndex, in: image)
           ),
           let range = Range(match.range(at: 1), in: image) {
            return String(image[range])
        }

        if image.contains("http") {
            return image
        }

        guard let protocolPart = extractPart(searchURL, pattern: #"http(.*)//"#),
              let domainPart = extractPart(searchURL, pattern: #"//(.*?)/"#) else {
            return image
        }

        return "http\(protocolPart)//\(domainPart)\(image)"
    }

    private static func resolveDetailURL(_ detailURL: String, searchURL: String) -> String {
        if detailURL.hasPrefix("http") {
            return detailURL
        }

        let isHTTPS = searchURL.hasPrefix("https")
        let protocolPrefix = isHTTPS ? "https://" : "http://"

        guard let schemeRange = searchURL.range(of: "://"),
              let slashRange = searchURL[schemeRange.upperBound...].firstIndex(of: "/") else {
            return detailURL
        }

        let domain = String(searchURL[schemeRange.upperBound..<slashRange])
        return "\(protocolPrefix)\(domain)\(detailURL)"
    }

    private static func extractPart(_ text: String, pattern: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(
                in: text,
                range: NSRange(text.startIndex..<text.endIndex, in: text)
              ),
              let range = Range(match.range(at: 1), in: text) else {
            return nil
        }
        return String(text[range])
    }

    private static func decodeSearchJSON(
        response: String,
        requestURL: String
    ) -> [String: Any]? {
        if let domain = extractDomain(from: requestURL), domain.contains("2233") {
            if let decrypted = AHParserUtils.tryAesDecryptJSON(response) {
                return decrypted
            }
        }

        return AHParserUtils.plainJSON(response)
    }

    private static func domainMatches(url: String, realURI: String) -> Bool {
        guard let domain = extractDomain(from: url), !domain.isEmpty else {
            return false
        }
        return realURI.contains(domain)
    }

    private static func extractDomain(from url: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: "//(.*?)/"),
              let match = regex.firstMatch(
                in: url,
                range: NSRange(url.startIndex..<url.endIndex, in: url)
              ),
              let range = Range(match.range(at: 1), in: url) else {
            return nil
        }
        return String(url[range])
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
