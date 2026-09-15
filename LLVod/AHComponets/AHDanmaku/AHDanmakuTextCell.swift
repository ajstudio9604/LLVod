//
//  AHDanmakuTextCell.swift
//  LLVod
//

import UIKit
import DanmakuKit

class AHDanmakuTextCell: DanmakuCell {

    required init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func willDisplay() {
    }

    override func displaying(_ context: CGContext, _ size: CGSize, _ isCancelled: Bool) {
        guard let model = model as? AHDanmakuTextCellModel else { return }
        let text = NSString(string: model.text)
        context.setLineWidth(1)
        context.setLineJoin(.round)
        context.setStrokeColor(UIColor.black.cgColor)
        context.saveGState()

        let attributes: [NSAttributedString.Key: Any] = [.font: model.font, .foregroundColor: model.color]
        text.draw(at: .zero, withAttributes: attributes)
        context.restoreGState()

        context.setTextDrawingMode(.fill)
        text.draw(at: .zero, withAttributes: attributes)
    }

    override func didDisplay(_ finished: Bool) {
    }

    // 取消点击事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
