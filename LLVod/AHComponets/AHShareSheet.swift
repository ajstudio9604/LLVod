//
//  AHShareSheet.swift
//  LLVod
//
//  系统分享面板封装，对应 Flutter 的 share_plus
//

import SwiftUI
import UIKit

enum AHOfficialLinks {
    static let website = "https://yiyiyi.tv"
    static let comic = "https://www.xcqmh.com"
    static let music = "https://www.nm688.com"
    static let telegram = "https://t.me/yiystv"

    static func url(_ raw: String) -> URL? {
        var text = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return nil }
        if !text.contains("://") {
            text = "https://\(text)"
        }
        return URL(string: text)
    }

    static func open(_ raw: String) {
        guard let url = url(raw) else { return }
        UIApplication.shared.open(url)
    }
}

struct AHShareItem: Identifiable {
    let id = UUID()
    let text: String
    let url: URL?

    var activityItems: [Any] {
        var items: [Any] = [text]
        if let url {
            items.append(url)
        }
        return items
    }

    static func website(extraText: String = "") -> AHShareItem {
        let site = AHOfficialLinks.website
        let text = extraText.isEmpty ? site : "\(extraText)\n\(site)"
        return AHShareItem(text: text, url: AHOfficialLinks.url(site))
    }
}

struct AHShareSheet: UIViewControllerRepresentable {
    let item: AHShareItem

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: item.activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ controller: UIActivityViewController, context: Context) {}
}
