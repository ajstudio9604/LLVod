//
//  AHDanmakuModels.swift
//  LLVod
//

import Foundation
import SwiftUI

struct AHDanmakuItem: Identifiable {
    let id = UUID()
    let time: Double        // 出现时间（秒）
    let text: String        // 弹幕内容
    let color: Color        // 颜色
    let type: DanmakuType   // 类型
    let fontSize: CGFloat   // 字体大小

    enum DanmakuType: Int {
        case scroll = 1     // 滚动弹幕（从右到左）
        case bottom = 4     // 底部弹幕
        case top = 5        // 顶部弹幕

        static func from(mode: Int) -> DanmakuType {
            switch mode {
            case 4: return .bottom
            case 5: return .top
            default: return .scroll
            }
        }
    }
}

struct AHDanmakuRawItem {
    let time: Double
    let text: String
    let colorHex: String
    let type: Int

    init(time: Double, text: String, colorHex: String = "#FFFFFF", type: Int = 1) {
        self.time = time
        self.text = text
        self.colorHex = colorHex
        self.type = type
    }
}

struct AHDanmakuRequest {
    let vodName: String
    let episode: Int
    let playURL: String
}

struct AHDanmakuSendRequest {
    let vodName: String
    let episode: Int
    let text: String
    let colorHex: String
    let time: Double
}

enum AHDanmakuSendResult {
    case success
    case rejected(String?)
    case failed
}

enum AHDanmakuSource {

    static var provider: ((AHDanmakuRequest, @escaping ([AHDanmakuRawItem]) -> Void) -> Void)?

    static var sender: ((AHDanmakuSendRequest, @escaping (AHDanmakuSendResult) -> Void) -> Void)?
}

enum AHDanmakuPalette {
    static var colors: [String] = [
        "#FFFFFF", "#FE0302", "#FF7204", "#FFAA02",
        "#FFD302", "#A0EE00", "#00CD00", "#019899",
        "#4266BE", "#89D5FF", "#CC0273", "#222222"
    ]
}
