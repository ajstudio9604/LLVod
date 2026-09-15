//
//  AHRankModels.swift
//  LLVod
//
//  豆瓣榜单：rank_list / year_ranks / category_ranks / subject_collection items
//

import Foundation

// MARK: - Shell

struct AHRankListResponse: Decodable {
    let title: String?
    let sharingURL: String?
    let groups: [AHRankGroup]

    private enum CodingKeys: String, CodingKey {
        case title
        case groups
        case sharingURL = "sharing_url"
    }
}

struct AHRankGroup: Decodable, Identifiable {
    var id: String { "\(type)-\(title)" }

    let title: String
    let type: String
    let tabs: [AHRankTab]
    let selectedCollections: [AHRankCollection]

    private enum CodingKeys: String, CodingKey {
        case title, type, tabs
        case selectedCollections = "selected_collections"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        title = (try? c.decode(String.self, forKey: .title)) ?? ""
        type = (try? c.decode(String.self, forKey: .type)) ?? ""
        tabs = (try? c.decode([AHRankTab].self, forKey: .tabs)) ?? []
        selectedCollections = (try? c.decode([AHRankCollection].self, forKey: .selectedCollections)) ?? []
    }
}

struct AHRankTab: Decodable, Identifiable, Hashable {
    var id: String { key }
    let key: String
    let title: String

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        key = (try? c.decode(String.self, forKey: .key)) ?? ""
        title = (try? c.decode(String.self, forKey: .title)) ?? key
    }

    private enum CodingKeys: String, CodingKey {
        case key, title
    }
}

struct AHRankCollection: Decodable, Identifiable, Equatable {
    let id: String
    let title: String
    let name: String
    let shortName: String
    let mediumName: String
    let description: String
    let headerBgImage: String
    let coverURL: String
    let updatedAt: String
    let doneCount: Int
    let itemsCount: Int
    let subjectCount: Int
    let total: Int
    let followersCount: Int
    let showRank: Bool
    let sharingURL: String
    let subjectType: String

    private enum CodingKeys: String, CodingKey {
        case id, title, name, description, total
        case shortName = "short_name"
        case mediumName = "medium_name"
        case headerBgImage = "header_bg_image"
        case coverURL = "cover_url"
        case updatedAt = "updated_at"
        case doneCount = "done_count"
        case itemsCount = "items_count"
        case subjectCount = "subject_count"
        case followersCount = "followers_count"
        case showRank = "show_rank"
        case sharingURL = "sharing_url"
        case subjectType = "subject_type"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? c.decode(String.self, forKey: .id)) ?? ""
        title = (try? c.decode(String.self, forKey: .title)) ?? ""
        name = (try? c.decode(String.self, forKey: .name)) ?? title
        shortName = (try? c.decode(String.self, forKey: .shortName)) ?? ""
        mediumName = (try? c.decode(String.self, forKey: .mediumName)) ?? ""
        description = (try? c.decode(String.self, forKey: .description)) ?? ""
        headerBgImage = (try? c.decode(String.self, forKey: .headerBgImage)) ?? ""
        coverURL = (try? c.decode(String.self, forKey: .coverURL)) ?? ""
        updatedAt = (try? c.decode(String.self, forKey: .updatedAt)) ?? ""
        doneCount = (try? c.decode(Int.self, forKey: .doneCount)) ?? 0
        itemsCount = (try? c.decode(Int.self, forKey: .itemsCount)) ?? 0
        subjectCount = (try? c.decode(Int.self, forKey: .subjectCount)) ?? 0
        total = (try? c.decode(Int.self, forKey: .total)) ?? 0
        followersCount = (try? c.decode(Int.self, forKey: .followersCount)) ?? 0
        showRank = (try? c.decode(Bool.self, forKey: .showRank)) ?? true
        sharingURL = (try? c.decode(String.self, forKey: .sharingURL)) ?? ""
        subjectType = (try? c.decode(String.self, forKey: .subjectType)) ?? ""
    }

    var displayTitle: String {
        if !title.isEmpty { return title }
        if !name.isEmpty { return name }
        return mediumName
    }

    var headerImageURL: String {
        if !headerBgImage.isEmpty { return headerBgImage }
        return coverURL
    }

    var listTotal: Int {
        if itemsCount > 0 { return itemsCount }
        if subjectCount > 0 { return subjectCount }
        if total > 0 { return total }
        return 0
    }

    var sidebarLabel: String {
        switch id {
        case "movie_weekly_best":
            return "电影"
        case "tv_chinese_best_weekly":
            return "华语剧集"
        case "tv_global_best_weekly":
            return "全球剧集"
        case "show_chinese_best_weekly":
            return "国内综艺"
        case "show_global_best_weekly":
            return "国外综艺"
        default:
            break
        }

        var text = shortName.isEmpty ? mediumName : shortName
        if text.isEmpty { text = title }
        text = text.replacingOccurrences(of: "口碑", with: "")
        if text.hasSuffix("榜") {
            text = String(text.dropLast())
        }
        return text.isEmpty ? "榜单" : text
    }

    var updatedDisplay: String {
        // "2026-04-15 16:29:58" → "04-15 更新"
        let parts = updatedAt.split(separator: " ")
        guard let date = parts.first else { return "更新" }
        let comps = date.split(separator: "-")
        if comps.count >= 3 {
            return "\(comps[1])-\(comps[2]) 更新"
        }
        return "\(date) 更新"
    }
}

struct AHRankYearResponse: Decodable {
    let groups: [AHRankGroup]
}

struct AHRankCategoryResponse: Decodable {
    let selectedCollections: [AHRankCollection]
    let start: Int?
    let count: Int?
    let total: Int?

    private enum CodingKeys: String, CodingKey {
        case start, count, total
        case selectedCollections = "selected_collections"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        selectedCollections = (try? c.decode([AHRankCollection].self, forKey: .selectedCollections)) ?? []
        start = try? c.decode(Int.self, forKey: .start)
        count = try? c.decode(Int.self, forKey: .count)
        total = try? c.decode(Int.self, forKey: .total)
    }
}

// MARK: - Items

struct AHRankItemsResponse: Decodable {
    let subjectCollectionItems: [AHRankItem]
    let total: Int?
    let subjectCollection: AHRankCollection?

    private enum CodingKeys: String, CodingKey {
        case total
        case subjectCollectionItems = "subject_collection_items"
        case subjectCollection = "subject_collection"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        subjectCollectionItems = (try? c.decode([AHRankItem].self, forKey: .subjectCollectionItems)) ?? []
        total = try? c.decode(Int.self, forKey: .total)
        subjectCollection = try? c.decode(AHRankCollection.self, forKey: .subjectCollection)
    }
}

struct AHRankItem: Decodable, Identifiable {
    let id: String
    let title: String
    let cardSubtitle: String
    let comment: String
    let description: String
    let year: String
    let photos: [String]
    let posterURL: String
    let ratingValue: Double
    let starCount: Double
    let tags: [String]
    let type: String

    private enum CodingKeys: String, CodingKey {
        case id, title, year, photos, type, description, tags
        case cardSubtitle = "card_subtitle"
        case comment
        case pic
        case coverURL = "cover_url"
        case rating
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? c.decode(String.self, forKey: .id))
            ?? (try? c.decode(Int.self, forKey: .id)).map(String.init)
            ?? UUID().uuidString
        title = (try? c.decode(String.self, forKey: .title)) ?? ""
        cardSubtitle = (try? c.decode(String.self, forKey: .cardSubtitle)) ?? ""
        comment = (try? c.decode(String.self, forKey: .comment)) ?? ""
        description = (try? c.decode(String.self, forKey: .description)) ?? ""
        year = (try? c.decode(String.self, forKey: .year)) ?? ""
        photos = (try? c.decode([String].self, forKey: .photos)) ?? []
        type = (try? c.decode(String.self, forKey: .type)) ?? ""
        tags = (try? c.decode([String].self, forKey: .tags)) ?? []

        let pic = try? c.decode(AHRankPic.self, forKey: .pic)
        let cover = (try? c.decode(String.self, forKey: .coverURL)) ?? ""
        if !cover.isEmpty {
            posterURL = cover
        } else {
            posterURL = pic?.bestURL ?? ""
        }

        if let rating = try? c.decode(AHRankRating.self, forKey: .rating) {
            ratingValue = rating.value
            starCount = rating.starCount
        } else {
            ratingValue = 0
            starCount = 0
        }
    }

    var blurb: String {
        if !comment.isEmpty { return comment }
        return description
    }
}

struct AHRankPic: Decodable {
    let normal: String?
    let large: String?

    var bestURL: String {
        if let large, !large.isEmpty { return large }
        return normal ?? ""
    }
}

struct AHRankRating: Decodable {
    let value: Double
    let starCount: Double

    private enum CodingKeys: String, CodingKey {
        case value
        case starCount = "star_count"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        if let v = try? c.decode(Double.self, forKey: .value) {
            value = v
        } else if let v = try? c.decode(Int.self, forKey: .value) {
            value = Double(v)
        } else {
            value = 0
        }

        if let s = try? c.decode(Double.self, forKey: .starCount) {
            starCount = s
        } else if let s = try? c.decode(Int.self, forKey: .starCount) {
            starCount = Double(s)
        } else {
            starCount = 0
        }
    }
}
