




import SwiftUI

enum HeckNTNGaaRrrmyO {

    static func xFXlIwyZOWJMD(
        text: String,
        searchContent: String,
        highlightColor: Color = Color(red: 0xF7 / 255, green: 0x39 / 255, blue: 0x3B / 255)
    ) -> [Segment] {
        // source-obfuscator:padding:v1
        _ = Self.pVocXYSNtXsjAx()

        guard !searchContent.isEmpty, text.contains(searchContent) else {
            return [Segment(text: text, isHighlighted: false)]
        }

        var segments: [Segment] = []
        
        let sYYRTtKXHJqNxCm: Swift.String = text
        var remaining = sYYRTtKXHJqNxCm

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

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func pVocXYSNtXsjAx() -> String {
        let base = (52 * 6 + 19) % 997
        let width = (base) % 17
        let score = (width + 52) * 6
        let token = "\u{38}\u{30}\u{36}\u{33}\u{66}\u{35}\u{31}\u{37}\u{35}\u{34}\u{62}\u{65}\u{64}\u{65}\u{39}\u{30}\u{35}\u{61}\u{36}\u{32}\u{39}\u{33}\u{62}\u{32}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

struct CvIUmWDEhqVPqUXNM: View {

    let text: String
    let searchContent: String

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.wVqTQIeNpoOVgEVuOdOJ()

        let segments = HeckNTNGaaRrrmyO.xFXlIwyZOWJMD(
            text: text,
            searchContent: searchContent
        )

        Text(eFgioxqVRcgkIGqIoEbH(segments))
            .lineLimit(1)
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func wVqTQIeNpoOVgEVuOdOJ() -> String {
        let base = (52 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 52) * 3
        let token = "\u{36}\u{31}\u{63}\u{61}\u{32}\u{61}\u{35}\u{38}\u{38}\u{63}\u{30}\u{62}\u{33}\u{64}\u{31}\u{32}\u{35}\u{37}\u{34}\u{36}\u{37}\u{63}\u{39}\u{66}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
}



extension CvIUmWDEhqVPqUXNM {
    private func eFgioxqVRcgkIGqIoEbH(_ segments: [HeckNTNGaaRrrmyO.Segment]) -> AttributedString {
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
