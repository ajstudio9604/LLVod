//
//  SearchJsRuleEngine.swift
//  LLVod
//
//  对应 Flutter JsRuleEngine 的规则调用层，运行时与桥接在 AHJsRuntime
//
//  这里的方法全部是异步的：规则函数可能是 async function（内置订阅里的「360看」就是），
//  返回 Promise 时必须等它 resolve，否则拿到的是个 Promise 对象，解析必然失败。
//

import Foundation

@MainActor
enum SearchJsRuleEngine {

    // MARK: - 搜索

    static func makeSearchRequest(
        rule: String,
        baseURL: String,
        keyword: String
    ) async -> AHSearchRequestParams? {
        guard let runtime = AHJsRuntimeCache.runtime(for: rule),
              let urlArray = try? await runtime.callList(
                "getSearchurl",
                args: [baseURL, keyword]
              ),
              urlArray.count >= 2,
              let url = AHParserUtils.stringValue(urlArray[1]),
              !url.isEmpty else {
            return nil
        }

        let method = (AHParserUtils.stringValue(urlArray[0]) ?? "get").uppercased()
        let body = urlArray.count > 2 ? AHParserUtils.stringValue(urlArray[2]) : nil
        let headers = await headerFields(runtime: runtime, function: "getSearchUA")

        return AHSearchRequestParams(
            url: url,
            method: method,
            data: body,
            headers: headers
        )
    }

    static func parseSearchList(rule: String, response: String) async -> [[String]] {
        guard let runtime = AHJsRuntimeCache.runtime(for: rule),
              let rows = try? await runtime.callList("getSearchlist", args: [response]) else {
            return []
        }

        return rows.compactMap { row in
            guard let values = row as? [Any] else { return nil }
            return values.map { AHParserUtils.stringValue($0) ?? "" }
        }
    }

    // MARK: - 详情

    static func makeDetailRequest(
        rule: String,
        baseURL: String,
        videoLinkId: String
    ) async -> AHSearchRequestParams? {
        guard let runtime = AHJsRuntimeCache.runtime(for: rule),
              let urlArray = try? await runtime.callList(
                "getdetailsurl",
                args: [baseURL, videoLinkId]
              ),
              urlArray.count >= 2,
              let url = AHParserUtils.stringValue(urlArray[1]),
              !url.isEmpty else {
            return nil
        }

        let method = (AHParserUtils.stringValue(urlArray[0]) ?? "get").uppercased()
        let body = urlArray.count > 2 ? AHParserUtils.stringValue(urlArray[2]) : nil
        let headers = await headerFields(runtime: runtime, function: "getdetailsUA")

        return AHSearchRequestParams(
            url: url,
            method: method,
            data: body,
            headers: headers
        )
    }

    struct DetailMeta {
        let actor: String
        let status: String
        let intro: String
    }

    struct DetailLine {
        let name: String
        let detail: Any?
        let sourceTag: String
    }

    static func parseDetailList(
        rule: String,
        response: String
    ) async -> (meta: DetailMeta, lines: [DetailLine])? {
        guard let runtime = AHJsRuntimeCache.runtime(for: rule),
              let data = try? await runtime.callList("getdetailslist", args: [response]),
              !data.isEmpty else {
            return nil
        }

        var actor = "N/A"
        var status = "N/A"
        var intro = "N/A"

        if let metaRows = data[0] as? [Any] {
            // 兼容 [[演员, 状态, 简介]] 和 [演员, 状态, 简介] 两种包法
            let fields = (metaRows.first as? [Any]) ?? metaRows
            if fields.count > 0 { actor = AHParserUtils.stringValue(fields[0]) ?? "N/A" }
            if fields.count > 1 { status = AHParserUtils.stringValue(fields[1]) ?? "N/A" }
            if fields.count > 2 { intro = AHParserUtils.stringValue(fields[2]) ?? "N/A" }
        }

        guard data.count > 1, let lineRows = data[1] as? [Any], !lineRows.isEmpty else {
            return nil
        }

        // 行结构是 [线路名, 详情, 集数, 源标识名]，自定义规则不带自带解析
        let lines: [DetailLine] = lineRows.compactMap { row in
            guard let values = row as? [Any], values.count >= 2 else { return nil }

            return DetailLine(
                name: AHParserUtils.stringValue(values[0]) ?? "",
                detail: values[1],
                sourceTag: values.count > 3 ? (AHParserUtils.stringValue(values[3]) ?? "") : ""
            )
        }

        guard !lines.isEmpty else { return nil }

        return (DetailMeta(actor: actor, status: status, intro: intro), lines)
    }

    // MARK: - 解析

    struct JxRequest {
        let method: String
        let url: String
        let body: String?
        let headers: [String: String]
    }

    static func makeJxRequest(
        rule: String,
        episodeURL: String,
        sourceTag: String
    ) async -> JxRequest? {
        guard let runtime = AHJsRuntimeCache.runtime(for: rule),
              let urlArray = try? await runtime.callList(
                "getjx",
                args: [episodeURL, sourceTag]
              ),
              urlArray.count >= 2 else {
            return nil
        }

        let method = AHParserUtils.stringValue(urlArray[0]) ?? "get"
        let body = urlArray.count > 2 ? AHParserUtils.stringValue(urlArray[2]) : nil

        // 第 2 位是 "jxurl=...,Referer=..." 这种混装串，jxurl 是地址，其余是请求头
        let fields = AHParserUtils.parseHeaders(AHParserUtils.stringValue(urlArray[1]) ?? "")
        var headers = fields
        let url = headers.removeValue(forKey: "jxurl") ?? ""

        guard !url.isEmpty else { return nil }

        return JxRequest(method: method, url: url, body: body, headers: headers)
    }

    static func parseJxResponse(
        rule: String,
        response: String,
        sourceTag: String
    ) async -> String? {
        guard let runtime = AHJsRuntimeCache.runtime(for: rule),
              let result = try? await runtime.callString(
                "getjxParser",
                args: [response, sourceTag]
              ),
              !result.isEmpty else {
            return nil
        }
        return result
    }

    static func parsePlayerHeaders(rule: String) async -> [String: String] {
        guard let runtime = AHJsRuntimeCache.runtime(for: rule) else {
            return ["User-Agent": SearchUserAgent.generate()]
        }

        let headers = await headerFields(runtime: runtime, function: "getplayerUA")
        return headers.isEmpty ? ["User-Agent": SearchUserAgent.generate()] : headers
    }

    // MARK: - 工具

    private static func headerFields(
        runtime: AHJsRuntime,
        function: String
    ) async -> [String: String] {
        guard let raw = try? await runtime.callString(function), !raw.isEmpty else {
            return [:]
        }
        return AHParserUtils.parseHeaders(raw)
    }
}
