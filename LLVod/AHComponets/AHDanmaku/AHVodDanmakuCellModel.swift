//
//  AHVodDanmakuCellModel.swift
//  LLVod
//

import Foundation

protocol AHVodDanmakuCellModel {

    var isPause: Bool { get set }

    var displayTime: Double { get set }

    var offsetTime: TimeInterval { get set }

    func calculateSize()

}

extension AHVodDanmakuCellModel {
    func calculateSize() {}
}
