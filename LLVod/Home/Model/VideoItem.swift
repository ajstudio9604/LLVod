//
//  VideoItem.swift
//  LLVod
//
//  Created by minusapple on 2026/7/13.
//

import Foundation

struct VideoItem: Identifiable, Hashable {
    let id: String
    let name: String
    let pictureURL: String
    let remarks: String
    let extraValue: String

    let videoID: String
}

struct BannerAPIResponse: Decodable {
    let list: [VideoCategory]
}

struct VideoCategory: Decodable {
    let typeID: Int
    let videoList: [VideoAPIItem]

    enum CodingKeys: String, CodingKey {
        case typeID = "type_id"
        case videoList = "vlist"
    }
}

struct VideoAPIItem: Decodable {
    let videoName: String?
    let videoPicture: String?
    let videoRemarks: String?
    let videoTimeAdd: FlexibleString?
    let visibility: FlexibleString?
    let videoID: FlexibleString?

    enum CodingKeys: String, CodingKey {
        case videoName = "vod_name"
        case videoPicture = "vod_pic"
        case videoRemarks = "vod_remarks"
        case videoTimeAdd = "vod_time_add"
        case visibility = "vis"
        case videoID = "vod_id"
    }
}

enum FlexibleString: Decodable, Hashable {
    case string(String)
    case integer(Int)
    case double(Double)
    case boolean(Bool)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(String.self) {
            self = .string(value)
            return
        }

        if let value = try? container.decode(Int.self) {
            self = .integer(value)
            return
        }

        if let value = try? container.decode(Double.self) {
            self = .double(value)
            return
        }

        if let value = try? container.decode(Bool.self) {
            self = .boolean(value)
            return
        }

        throw DecodingError.typeMismatch(
            FlexibleString.self,
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "无法将字段转换为字符串"
            )
        )
    }

    var stringValue: String {
        switch self {
        case .string(let value):
            return value

        case .integer(let value):
            return String(value)

        case .double(let value):
            return String(value)

        case .boolean(let value):
            return value ? "true" : "false"
        }
    }
}


enum BannerRequestError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case emptyData
    case emptyResponseText
    case invalidJSON

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

        case .emptyResponseText:
            return ""

        case .invalidJSON:
            return ""
        }
    }
}
