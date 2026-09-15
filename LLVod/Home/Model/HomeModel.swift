//
//  HomeAPI.swift
//  LLVod
//
//  Created by minusapple on 2026/7/13.
//

import Foundation

// 首页顶部 tab 数据模型
struct AHHomeTabItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let mode: Int
}


struct HotMediaItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageURL: String
}

struct DoubanCollectionResponse: Decodable {
    let subjectCollectionItems: [DoubanCollectionItem]

    enum CodingKeys: String, CodingKey {
        case subjectCollectionItems = "subject_collection_items"
    }
}

struct DoubanCollectionItem: Decodable {
    let title: String
    let cardSubtitle: String?
    let pic: DoubanPicture?

    enum CodingKeys: String, CodingKey {
        case title
        case cardSubtitle = "card_subtitle"
        case pic
    }
}

struct DoubanPicture: Decodable {
    let normal: String?
}

struct DoubanAnimeResponse: Decodable {
    let data: [DoubanAnimeItem]
}

struct DoubanAnimeItem: Decodable {
    let title: String
    let cover: String?
    let rate: String?
}

enum NetworkError2: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case emptyData
    case requestFailed(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return ""
        case .invalidResponse:
            return ""
        case .httpError(let statusCode):
            return ""
        case .emptyData:
            return ""
        case .requestFailed(let message):
            return message
        }
    }
}
