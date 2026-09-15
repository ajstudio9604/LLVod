//
//  DouBanCategoryModel.swift
//  LLVod
//

import Foundation

struct AHDouBanTabItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let category: String
}

struct AHDouBanPlaylistItem: Identifiable, Hashable {
    let id: String
    let title: String
    let coverURL: String
    let headerBgImage: String
    let itemsCount: Int
}

struct DoubanPlaylistResponse: Decodable {
    let data: [DoubanPlaylistSection]
}

struct DoubanPlaylistSection: Decodable {
    let items: [DoubanPlaylistRawItem]?
}

struct DoubanPlaylistRawItem: Decodable {
    let title: String
    let id: String
    let coverURL: String?
    let headerBgImage: String?
    let itemsCount: Int?

    enum CodingKeys: String, CodingKey {
        case title
        case id
        case coverURL = "cover_url"
        case headerBgImage = "header_bg_image"
        case itemsCount = "items_count"
    }
}
