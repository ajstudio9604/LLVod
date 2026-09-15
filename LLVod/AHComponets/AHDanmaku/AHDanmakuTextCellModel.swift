//
//  AHDanmakuTextCellModel.swift
//  LLVod
//

import Foundation
import DanmakuKit

class AHDanmakuTextCellModel: DanmakuCellModel, AHVodDanmakuCellModel, Equatable {

    var identifier = ""

    var text = ""

    var font = UIFont.systemFont(ofSize: 20)

    var offsetTime: TimeInterval = 0

    var cellClass: DanmakuCell.Type {
        return AHDanmakuTextCell.self
    }

    var size: CGSize = .zero

    var track: UInt?

    var displayTime: Double = 8

    var type: DanmakuCellType = .floating

    var isPause = false

    var haveShoot = false

    var color: UIColor = .white

    func calculateSize() {
        size = NSString(string: text).boundingRect(
            with: CGSize(width: CGFloat(Float.infinity), height: 20),
            options: [.usesFontLeading, .usesLineFragmentOrigin],
            attributes: [.font: font],
            context: nil
        ).size
    }

    static func == (lhs: AHDanmakuTextCellModel, rhs: AHDanmakuTextCellModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func isEqual(to cellModel: DanmakuCellModel) -> Bool {
        return identifier == cellModel.identifier
    }
}
