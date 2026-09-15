//
//  AHDanmakuHostView.swift
//  LLVod
//
//  DanmakuKit 的 DanmakuView 只在初始化和改 displayArea / trackHeight / padding 时
//  计算轨道，尺寸变了不会自己重算。SwiftUI 的 UIViewRepresentable 是先零尺寸创建、
//  之后才布局，所以轨道数会停在 0，shoot 全被丢掉：表现就是没弹幕，
//  而去设置里动一下显示区域（触发重算）弹幕又出来了。
//  这里套一层宿主视图，在布局后按实际尺寸补算轨道。
//

import UIKit
import DanmakuKit

final class AHDanmakuHostView: UIView {

    let danmakuView = DanmakuView()

    private var laidOutSize: CGSize = .zero

    override init(frame: CGRect) {
        super.init(frame: frame)

        isUserInteractionEnabled = false
        addSubview(danmakuView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        danmakuView.frame = bounds

        guard bounds.size != laidOutSize else { return }

        let isResize = laidOutSize != .zero
        laidOutSize = bounds.size

        // 在飞的弹幕位置是按旧尺寸算的，真正改尺寸时清掉，免得错位或半截留在屏幕上
        if isResize {
            danmakuView.clean()
        }

        danmakuView.recalculateTracks()
    }
}
