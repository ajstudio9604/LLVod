//
//  DouBanFilmListModel.swift
//  LLVod
//
//  片单专辑页（对应 Flutter hometab/Film.dart）的接口模型。
//  片单 id 是纯数字时走豆列 /doulist/{id}/posts，影片包在 content.subject 里；
//  其余走合集 /subject_collection/{id}/items，影片就在顶层
//

import Foundation

struct DoubanFilmListResponse: Decodable {

    let total: Int?
    let subjects: [DoubanFilmSubject]

    private enum CodingKeys: String, CodingKey {
        case total
        case items
        case subjectCollectionItems = "subject_collection_items"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total = try? container.decode(Int.self, forKey: .total)

        if let collection = try? container.decode(
            [DoubanFilmSubject].self,
            forKey: .subjectCollectionItems
        ), !collection.isEmpty {
            subjects = collection
            return
        }

        // 豆列的 items 每条是一次「收藏」，影片在 content.subject 下面；
        // 也有片单直接把影片平铺在 items 里，所以两种形状都试一遍
        let posts = (try? container.decode([DoubanFilmListPost].self, forKey: .items)) ?? []
        let wrapped = posts.compactMap(\.content?.subject)

        if !wrapped.isEmpty {
            subjects = wrapped
            return
        }

        subjects = (try? container.decode([DoubanFilmSubject].self, forKey: .items)) ?? []
    }
}

struct DoubanFilmListPost: Decodable {
    let content: DoubanFilmListContent?
}

struct DoubanFilmListContent: Decodable {
    let subject: DoubanFilmSubject?
}

struct DoubanFilmSubject: Decodable {

    let title: String?
    let cardSubtitle: String?
    let coverURL: String?
    let pic: DoubanRecommendPic?
    let pubdate: [String]?

    private enum CodingKeys: String, CodingKey {
        case title
        case pic
        case pubdate
        case cardSubtitle = "card_subtitle"
        case coverURL = "cover_url"
    }

    var posterURL: String {
        if let coverURL, !coverURL.isEmpty { return coverURL }
        return pic?.bestURL ?? ""
    }

    var displaySubtitle: String {
        if let cardSubtitle, !cardSubtitle.isEmpty { return cardSubtitle }
        return pubdate?.first ?? ""
    }
}
