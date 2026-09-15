//
//  VodDetailModel.swift
//  LLVod
//

import Foundation

struct AHVodDetailRoute: Hashable, Identifiable {
    var id: String { "\(sourceName)-\(videoLinkId)-\(path)-\(name)" }

    let name: String
    let path: String
    let sourceName: String
    let videoLinkId: String
    let pic: String
    let zypath: String
}

struct AHVodEpisode: Identifiable, Hashable {
    let id: Int
    let title: String
    let path: String
}

struct AHVodSourceLine: Identifiable, Hashable {
    let id: String
    let name: String
    let episodes: [AHVodEpisode]
    let parseURL: String
    let sourceTag: String
}

struct AHVodDetailPayload {
    let title: String
    let pic: String
    let actor: String
    let status: String
    let intro: String
    let sourceLines: [AHVodSourceLine]
    let sourceConfig: [String: Any]
}

struct AHVodJxOption: Identifiable, Hashable {
    let id: String
    let name: String
    let type: String
    let api: String
    let userAgent: String
    let sniffWhitelist: String
    let sniffBlacklist: String
}

struct AHVodPlayResolveResult {
    let url: String
    let playerHeaders: [String: String]
    let usedParserName: String
}

enum AHVodPlayResolverError: LocalizedError {
    case unableToResolve

    var errorDescription: String? {
        ""
    }
}

enum VodDetailEpisodeParser {

    static func parseHashEpisodes(_ detail: String) -> [AHVodEpisode] {
        AHParserUtils.parseEpisodes(detail)
    }

    static func parseWebsiteEpisodes(
        fragment: String,
        nameRule: String,
        linkRule: String,
        reverse: Bool = false
    ) -> [AHVodEpisode] {
        var names = SearchHTMLXPathParser.select(html: fragment, xpath: nameRule)
        var links = SearchHTMLXPathParser.select(html: fragment, xpath: linkRule)

        // 常见 MacCMS module 皮肤：配置规则没命中时用 class 兜底
        if links.isEmpty {
            links = SearchHTMLXPathParser.select(
                html: fragment,
                xpath: #"//a[contains(@class,"module-play-list-link")]/@href"#
            )
        }
        if names.isEmpty, !links.isEmpty {
            names = SearchHTMLXPathParser.select(
                html: fragment,
                xpath: #"//a[contains(@class,"module-play-list-link")]/span/text()"#
            )
        }

        if reverse {
            names.reverse()
            links.reverse()
        }

        // 有链接即可；片名缺失时用序号占位（避免整条线路被丢掉）
        guard !links.isEmpty else { return [] }

        return links.enumerated().map { index, link in
            let title: String
            if index < names.count, !names[index].isEmpty {
                title = names[index]
            } else {
                title = "\(index + 1)"
            }
            return AHVodEpisode(id: index + 1, title: title, path: link)
        }
    }
}
