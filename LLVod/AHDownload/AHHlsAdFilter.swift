//
//  AHHlsAdFilter.swift
//  LLVod
//
//  m3u8 广告过滤，对应 Flutter HlsAdFilter / M3u8AdFilter（playerad.dart）
//
//  与 Flutter 的差异：主 m3u8 不再把每条 variant 写成本地文件，
//  而是直接递归取第一条 variant 的媒体播放列表，返回的内容里 ts 一律是绝对地址，
//  下载器和本地播放都能直接用。
//

import Foundation

enum AHHlsAdFilter {

    static let smartFilterFlag = "智能去广告"

    static let defaultAdRegex = #"#EXT-X-DISCONTINUITY\r*\n*#EXTINF:3,[\s\S]*?#EXT-X-DISCONTINUITY"#

    static func filteredPlaylist(
        playURL: String,
        zypath: String,
        headers: [String: String]
    ) async -> String? {
        let rules = SearchStorage.rslzDictionaryList("ad\(zypath)")
        guard !rules.isEmpty else { return nil }

        var matchedRule: String?
        for rule in rules {
            guard let keyword = rule["titlead"] as? String, !keyword.isEmpty else { continue }
            if playURL.contains(keyword) {
                matchedRule = rule["subtitlead"] as? String ?? ""
                break
            }
        }

        guard let matchedRule else { return nil }

        return await filter(
            m3u8URL: playURL,
            headers: headers,
            // 空规则用一个永不匹配的正则，只跑后面的清理和智能过滤
            adRegexPattern: matchedRule.isEmpty ? "(?!)" : matchedRule,
            useSmartFilter: matchedRule == smartFilterFlag
        )
    }

    static func filter(
        m3u8URL: String,
        headers: [String: String],
        adRegexPattern: String = defaultAdRegex,
        useSmartFilter: Bool = false,
        depth: Int = 0
    ) async -> String? {
        // 防御异常嵌套的主播放列表
        guard depth < 3 else { return nil }

        guard let content = try? await AHDownloadHTTP.text(m3u8URL, headers: headers) else {
            return nil
        }

        let unified = unifyLineBreaks(content)

        if unified.contains("#EXT-X-STREAM-INF") {
            guard let variant = firstVariantURL(content: unified, baseURL: m3u8URL) else {
                return nil
            }
            return await filter(
                m3u8URL: variant,
                headers: headers,
                adRegexPattern: adRegexPattern,
                useSmartFilter: useSmartFilter,
                depth: depth + 1
            )
        }

        return processMediaPlaylist(
            content: unified,
            baseURL: m3u8URL,
            adRegexPattern: adRegexPattern,
            useSmartFilter: useSmartFilter
        )
    }

    static func absolutePlaylist(content: String, baseURL: String) -> String {
        convertRelativeToAbsolute(content: unifyLineBreaks(content), baseURL: baseURL)
    }

    // MARK: - 播放列表处理

    private static func processMediaPlaylist(
        content: String,
        baseURL: String,
        adRegexPattern: String,
        useSmartFilter: Bool
    ) -> String {
        var filtered = content

        if let regex = try? NSRegularExpression(
            pattern: adRegexPattern,
            options: [.caseInsensitive, .anchorsMatchLines]
        ) {
            filtered = regex.stringByReplacingMatches(
                in: filtered,
                range: NSRange(filtered.startIndex..., in: filtered),
                withTemplate: ""
            )
        }

        if useSmartFilter {
            filtered = smartFilter(filtered)
        }

        filtered = cleanRedundant(filtered)
        filtered = fixSpec(filtered)
        return convertRelativeToAbsolute(content: filtered, baseURL: baseURL)
    }

    private static func smartFilter(_ content: String) -> String {
        var segments: [Segment] = []
        var duration: Double = 0
        var group = 0

        for rawLine in content.split(separator: "\n", omittingEmptySubsequences: false) {
            let line = rawLine.trimmingCharacters(in: .whitespaces)
            guard !line.isEmpty else { continue }

            if line.hasPrefix("#EXT-X-DISCONTINUITY") {
                group += 1
            } else if line.hasPrefix("#EXTINF:") {
                duration = parseDuration(line)
            } else if !line.hasPrefix("#") {
                segments.append(Segment(duration: duration, uri: line, group: group))
            }
        }

        guard !segments.isEmpty else { return content }

        let kept = filterAds(segments)
        guard !kept.isEmpty else { return content }

        let targetDuration = Int(kept.map(\.duration).max() ?? 0)
        let keptGroups = Set(kept.map(\.group))

        var output = [
            "#EXTM3U",
            "#EXT-X-VERSION:3",
            "#EXT-X-TARGETDURATION:\(targetDuration)"
        ]

        var currentGroup = 0
        duration = 0

        for rawLine in content.split(separator: "\n", omittingEmptySubsequences: false) {
            let line = rawLine.trimmingCharacters(in: .whitespaces)
            guard !line.isEmpty else { continue }

            if line.hasPrefix("#EXT-X-DISCONTINUITY") {
                currentGroup += 1
                if keptGroups.contains(currentGroup) {
                    output.append(line)
                }
            } else if line.hasPrefix("#EXTINF:") {
                duration = parseDuration(line)
            } else if !line.hasPrefix("#") {
                let isKept = kept.contains {
                    $0.uri == line && $0.duration == duration && $0.group == currentGroup
                }
                if isKept {
                    output.append("#EXTINF:\(duration),")
                    output.append(line)
                }
            } else if line.hasPrefix("#EXT-X-") {
                if !line.hasPrefix("#EXT-X-TARGETDURATION") && !line.hasPrefix("#EXT-X-VERSION") {
                    output.append(line)
                }
            }
        }

        output.append("#EXT-X-ENDLIST")
        return output.joined(separator: "\n")
    }

    private static func filterAds(_ segments: [Segment]) -> [Segment] {
        var groups: [Int: [Segment]] = [:]
        for segment in segments {
            groups[segment.group, default: []].append(segment)
        }

        guard groups.count > 1 else { return segments }

        let durations = groups.mapValues { $0.reduce(0) { $0 + $1.duration } }
        let maxDuration = durations.values.max() ?? 0
        let sortedKeys = groups.keys.sorted()

        var adGroups: Set<Int> = []
        for groupId in sortedKeys {
            let duration = durations[groupId] ?? 0
            if duration == maxDuration { continue }

            var isAd = false
            if duration < maxDuration * 0.3 { isAd = true }
            if (groupId == sortedKeys.first || groupId == sortedKeys.last) && duration < 30 { isAd = true }
            if duration < 10 { isAd = true }

            if isAd { adGroups.insert(groupId) }
        }

        return segments.filter { !adGroups.contains($0.group) }
    }

    // MARK: - 文本工具

    private static func unifyLineBreaks(_ content: String) -> String {
        content.replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\r", with: "\n")
    }

    private static func cleanRedundant(_ content: String) -> String {
        var result: [String] = []
        var lastLine: String?

        for rawLine in content.split(separator: "\n", omittingEmptySubsequences: false) {
            let line = rawLine.trimmingCharacters(in: .whitespaces)
            guard !line.isEmpty else { continue }

            // 连续的 DISCONTINUITY 只留一个
            if line == "#EXT-X-DISCONTINUITY" && lastLine == "#EXT-X-DISCONTINUITY" {
                continue
            }

            result.append(line)
            lastLine = line
        }

        return result.joined(separator: "\n")
    }

    private static func fixSpec(_ content: String) -> String {
        content.hasPrefix("#EXTM3U") ? content : "#EXTM3U\n\(content)"
    }

    private static func convertRelativeToAbsolute(content: String, baseURL: String) -> String {
        content
            .split(separator: "\n", omittingEmptySubsequences: false)
            .map { rawLine -> String in
                let line = rawLine.trimmingCharacters(in: .whitespaces)
                guard !line.isEmpty, !line.hasPrefix("#") else { return line }
                return joinURL(base: baseURL, relative: line)
            }
            .joined(separator: "\n")
    }

    private static func firstVariantURL(content: String, baseURL: String) -> String? {
        let lines = content
            .split(separator: "\n", omittingEmptySubsequences: false)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        for (index, line) in lines.enumerated() where line.hasPrefix("#EXT-X-STREAM-INF:") {
            guard lines.indices.contains(index + 1) else { break }
            return joinURL(base: baseURL, relative: lines[index + 1])
        }

        return nil
    }

    static func joinURL(base: String, relative: String) -> String {
        if relative.hasPrefix("http://") || relative.hasPrefix("https://") {
            return relative
        }
        guard let baseURL = URL(string: base),
              let resolved = URL(string: relative, relativeTo: baseURL) else {
            return relative
        }
        return resolved.absoluteString
    }

    private static func parseDuration(_ line: String) -> Double {
        let value = line
            .replacingOccurrences(of: "#EXTINF:", with: "")
            .split(separator: ",")
            .first
            .map(String.init) ?? ""
        return Double(value) ?? 0
    }

    private struct Segment {
        let duration: Double
        let uri: String
        let group: Int
    }
}
