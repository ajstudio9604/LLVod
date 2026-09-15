//
//  AHDanmakuController.swift
//  LLVod
//

import DanmakuKit
import SwiftUI

final class AHDanmakuController {

    private var views = AHWeakViewStack<DanmakuView>()

    private var isPlaying = false

    var danmakuView: DanmakuView? { views.top }

    var danmakuFontSize: CGFloat = 18 {
        didSet {
            danmakuView?.trackHeight = Self.trackHeight(for: danmakuFontSize)
        }
    }

    var isEnabled = true {
        didSet {
            danmakuView?.isHidden = !isEnabled
        }
    }

    var danmakuArea: Double = 0.3 {
        didSet {
            danmakuView?.displayArea = danmakuArea
        }
    }
    var danmakuOpacity: Double = 0.8 {
        didSet {
            danmakuView?.alpha = danmakuOpacity
        }
    }
    var danmakuSpeed: Double = 0 {
        didSet {
            danmakuView?.playingSpeed = Float(danmakuSpeed * 2 + 1)
        }
    }

    func attach(view: DanmakuView) {
        views.push(view)
        activateTopView()
    }

    func detach(view: DanmakuView) {
        views.remove(view)
        activateTopView()
    }

    func ensureActive(view: DanmakuView) {
        guard danmakuView != nil else {
            attach(view: view)
            return
        }

        guard danmakuView === view else { return }
        activateTopView()
    }

    private func activateTopView() {
        guard let view = danmakuView else { return }

        view.displayArea = danmakuArea
        view.alpha = danmakuOpacity
        view.playingSpeed = Float(danmakuSpeed * 2 + 1)
        view.trackHeight = Self.trackHeight(for: danmakuFontSize)
        view.isHidden = !isEnabled

        if isPlaying {
            view.play()
        }
    }

    private static func trackHeight(for fontSize: CGFloat) -> CGFloat {
        fontSize + 6
    }

    func reset() {
        pause()
        danmakuView?.clean()
    }

    func pause() {
        isPlaying = false
        danmakuView?.pause()
    }

    func play() {
        isPlaying = true
        danmakuView?.play()
    }

    func send(_ item: AHDanmakuItem) {
        let cellModel = AHDanmakuTextCellModel()
        cellModel.type = Self.cellType(for: item.type)
        // 顶部/底部弹幕是原地停留，8 秒太久，按常见播放器给 5 秒
        cellModel.displayTime = cellModel.type == .floating ? 8 : 5
        cellModel.text = item.text
        cellModel.color = UIColor(item.color)
        cellModel.identifier = String(arc4random())
        cellModel.font = UIFont.systemFont(ofSize: danmakuFontSize)
        cellModel.calculateSize()

        danmakuView?.shoot(danmaku: cellModel)
    }

    private static func cellType(for type: AHDanmakuItem.DanmakuType) -> DanmakuCellType {
        switch type {
        case .scroll: return .floating
        case .top: return .top
        case .bottom: return .bottom
        }
    }
}
