//
//  AHWeakViewStack.swift
//  LLVod
//
//  横竖屏切换时竖屏层和全屏层会同时存在，最后注册的那个才是屏幕上看得见的。
//  这里按注册顺序记录，顶上那个销毁后自动回到上一个；内部是弱引用，
//  视图被 SwiftUI 回收后不会留下野指针。
//

import Foundation

struct AHWeakViewStack<Element: AnyObject> {

    private final class Box {
        weak var value: Element?

        init(_ value: Element) {
            self.value = value
        }
    }

    private var boxes: [Box] = []

    var top: Element? {
        boxes.reversed().first { $0.value != nil }?.value
    }

    var count: Int {
        boxes.compactMap(\.value).count
    }

    mutating func push(_ element: Element) {
        prune(excluding: element)
        boxes.append(Box(element))
    }

    mutating func remove(_ element: Element) {
        prune(excluding: element)
    }

    private mutating func prune(excluding element: Element) {
        boxes.removeAll { box in
            guard let value = box.value else { return true }
            return value === element
        }
    }
}
