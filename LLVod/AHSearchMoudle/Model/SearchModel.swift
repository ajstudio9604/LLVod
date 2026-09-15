//
//  SearchModel.swift
//  LLVod
//

import Foundation

enum AHSearchPageState: Equatable {
    case idle
    case suggesting
    case searching
    case results
    case empty
}

struct AHSearchRequestParams {
    let url: String
    let method: String
    let data: String?
    let headers: [String: String]
    let sourceIndex: Int?

    init(
        url: String,
        method: String = "GET",
        data: String? = nil,
        headers: [String: String] = [:],
        sourceIndex: Int? = nil
    ) {
        self.url = url
        self.method = method
        self.data = data
        self.headers = headers
        self.sourceIndex = sourceIndex
    }
}

struct AHSearchRequestResult {
    let index: Int
    let data: String?
    let statusCode: Int?
    let errorMessage: String?
    let realURI: String
}

struct AHSearchResultItem: Identifiable, Hashable {
    let id: String
    let title: String
    let sourceName: String
    let status: String
    let imageURL: String
    let pathId: String
    let path: String
}

struct AHSearchHotItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
}

struct IQiyiSuggestResponse: Decodable {
    let data: [IQiyiSuggestItem]?
}

struct IQiyiSuggestItem: Decodable {
    let name: String
}

enum AHSearchStorage {
    static let historyKey = "搜索历史cache"
    static let hotCacheKey = "最近热搜cache"
    static let maxHistoryCount = 15
}
