//
//  SearchBackgroundImageParser.swift
//  LLVod
//

import Foundation

enum SearchBackgroundImageParser {

    static func extractURL(from input: String) -> String? {
        let pattern = #"url\(['"]?(.*?)['"]?\)"#
        guard let regex = try? NSRegularExpression(
            pattern: pattern,
            options: [.caseInsensitive]
        ) else {
            return nil
        }

        let range = NSRange(input.startIndex..<input.endIndex, in: input)
        guard let match = regex.firstMatch(in: input, range: range),
              let urlRange = Range(match.range(at: 1), in: input) else {
            return nil
        }

        let url = String(input[urlRange]).trimmingCharacters(in: .whitespacesAndNewlines)
        return url.isEmpty ? nil : url
    }
}
