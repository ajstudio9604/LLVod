//
//  AHVodDetailTab.swift
//  LLVod
//
//  详情页顶部分页标签模型
//

import Foundation

struct AHVodDetailTab: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let index: Int

    static func == (lhs: AHVodDetailTab, rhs: AHVodDetailTab) -> Bool {
        lhs.id == rhs.id && lhs.text == rhs.text && lhs.index == rhs.index
    }
}
