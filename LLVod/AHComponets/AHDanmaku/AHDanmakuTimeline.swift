//
//  AHDanmakuTimeline.swift
//  LLVod
//
//  弹幕时间轴游标：按播放进度决定每次要发哪些弹幕
//

import Foundation

struct AHDanmakuTimeline {

    struct Advance {
        var items: [AHDanmakuItem] = []
        var didJump = false
    }

    static let maxPerAdvance = 20

    static let maxCatchUpWindow: TimeInterval = 2

    private(set) var items: [AHDanmakuItem] = []

    private var cursor = 0

    private var lastTime: TimeInterval?

    var isEmpty: Bool { items.isEmpty }

    var currentTime: TimeInterval? { lastTime }

    mutating func replace(with items: [AHDanmakuItem], startAt: TimeInterval) {
        self.items = items.sorted { $0.time < $1.time }
        seek(to: startAt)
    }

    mutating func seek(to time: TimeInterval) {
        lastTime = time
        cursor = firstIndex(after: time)
    }

    mutating func advance(to time: TimeInterval) -> Advance {
        guard !items.isEmpty else {
            lastTime = time
            return Advance()
        }

        guard let last = lastTime else {
            seek(to: time)
            return Advance()
        }

        let delta = time - last
        // 快退、跳片头、切集这类跳转，直接把游标挪过去
        guard delta >= 0, delta <= Self.maxCatchUpWindow else {
            seek(to: time)
            return Advance(didJump: true)
        }
        guard delta > 0 else { return Advance() }

        var result: [AHDanmakuItem] = []
        while cursor < items.count, items[cursor].time <= time {
            if result.count < Self.maxPerAdvance {
                result.append(items[cursor])
            }
            cursor += 1
        }

        lastTime = time
        return Advance(items: result)
    }

    private func firstIndex(after time: TimeInterval) -> Int {
        var low = 0
        var high = items.count
        while low < high {
            let mid = (low + high) / 2
            if items[mid].time <= time {
                low = mid + 1
            } else {
                high = mid
            }
        }
        return low
    }
}
