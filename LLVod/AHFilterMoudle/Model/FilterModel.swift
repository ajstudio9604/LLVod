//
//  FilterModel.swift
//  LLVod
//

import Foundation

enum AHFilterRow: CaseIterable, Identifiable {
    case mediaType
    case genre
    case region
    case year
    case sort

    var id: String { String(describing: self) }
}

struct AHFilterMediaItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageURL: String
}

struct DoubanRecommendResponse: Decodable {
    let items: [DoubanRecommendItem]?
}

struct DoubanRecommendItem: Decodable {
    let title: String
    let pic: DoubanRecommendPic?
    let rating: DoubanRecommendRating?
    let cardSubtitle: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case title
        case pic
        case rating
        case type
        case cardSubtitle = "card_subtitle"
    }
}

struct DoubanRecommendPic: Decodable {
    let normal: String?
    let large: String?
    let url: String?

    var bestURL: String {
        normal ?? large ?? url ?? ""
    }
}

struct DoubanRecommendRating: Decodable {
    let value: Double?

    enum CodingKeys: String, CodingKey {
        case value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let doubleValue = try? container.decode(Double.self, forKey: .value) {
            value = doubleValue
        } else if let intValue = try? container.decode(Int.self, forKey: .value) {
            value = Double(intValue)
        } else if let stringValue = try? container.decode(String.self, forKey: .value),
                  let parsed = Double(stringValue) {
            value = parsed
        } else {
            value = nil
        }
    }

    var displayValue: String {
        guard let value, value > 0 else { return "" }
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", value)
        }
        return String(format: "%.1f", value)
    }
}

enum AHFilterOptions {

    static let mediaTypes = ["电视剧", "电影", "动漫", "综艺", "纪录片"]

    static let genres = [
        "全部", "剧情", "喜剧", "动作", "爱情", "玄幻", "科幻",
        "悬疑", "惊悚", "恐怖", "犯罪", "传记", "历史", "战争"
    ]

    static let regions = [
        "全部", "大陆", "美国", "香港", "台湾", "日本", "韩国",
        "英国", "法国", "德国", "意大利", "西班牙", "印度", "泰国", "俄罗斯"
    ]

    static let sortOptions = ["全部", "热门", "热度", "评分"]

    static func yearOptions() -> [String] {
        var years = ["全部"]
        let currentYear = Calendar.current.component(.year, from: Date())

        for year in stride(from: currentYear, through: 2010, by: -1) {
            years.append(String(year))
        }

        years.append(contentsOf: ["2000年代", "90年代", "80年代", "70年代"])
        return years
    }
}
