//
//  SearchTextHighlight.swift
//  LLVod
//

import SwiftUI

enum SearchTextHighlight {

    static func segments(
        text: String,
        searchContent: String,
        highlightColor: Color = Color(red: 0xF7 / 255, green: 0x39 / 255, blue: 0x3B / 255)
    ) -> [Segment] {
        guard !searchContent.isEmpty, text.contains(searchContent) else {
            return [Segment(text: text, isHighlighted: false)]
        }

        var segments: [Segment] = []
        var remaining = text

        while remaining.contains(searchContent) {
            guard let range = remaining.range(of: searchContent) else { break }

            let prefix = String(remaining[..<range.lowerBound])
            if !prefix.isEmpty {
                segments.append(Segment(text: prefix, isHighlighted: false))
            }

            segments.append(
                Segment(text: searchContent, isHighlighted: true, color: highlightColor)
            )

            remaining = String(remaining[range.upperBound...])
        }

        if !remaining.isEmpty {
            segments.append(Segment(text: remaining, isHighlighted: false))
        }

        return segments
    }

    struct Segment: Identifiable {
        let id = UUID()
        let text: String
        let isHighlighted: Bool
        var color: Color?

        init(text: String, isHighlighted: Bool, color: Color? = nil) {
            self.text = text
            self.isHighlighted = isHighlighted
            self.color = color
        }
    }
}

struct SearchHighlightedText: View {

    let text: String
    let searchContent: String

    var body: some View {
        let segments = SearchTextHighlight.segments(
            text: text,
            searchContent: searchContent
        )

        Text(buildAttributed(segments))
            .lineLimit(1)
    }

    private func buildAttributed(_ segments: [SearchTextHighlight.Segment]) -> AttributedString {
        var result = AttributedString()

        for segment in segments {
            var part = AttributedString(segment.text)
            part.font = .system(size: 14, weight: .bold)

            if segment.isHighlighted {
                part.foregroundColor = segment.color ?? .red
            } else {
                part.foregroundColor = .primary
            }

            result.append(part)
        }

        return result
    }
}
