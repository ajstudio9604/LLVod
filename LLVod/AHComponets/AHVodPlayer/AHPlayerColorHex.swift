//
//  AHPlayerColorHex.swift
//  LLVod
//
//  模块内十六进制色值转换，避免依赖外部 String 扩展
//

import UIKit

enum AHPlayerColorHex {

    static func uiColor(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var value: UInt64 = 0xFFFFFF
        var text = hex.trimmingCharacters(in: .whitespacesAndNewlines)

        if text.hasPrefix("#") {
            text = String(text.dropFirst())
        }
        if text.hasPrefix("0x") || text.hasPrefix("0X") {
            text = String(text.dropFirst(2))
        }

        Scanner(string: text).scanHexInt64(&value)

        return UIColor(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
