//
//  SearchUserAgent.swift
//  LLVod
//

import Foundation

enum SearchUserAgent {

    static func generate() -> String {
        let version = ProcessInfo.processInfo.operatingSystemVersion
        let osVersion = "\(version.majorVersion)_\(version.minorVersion)"
        return """
        Mozilla/5.0 (iPhone; CPU iPhone OS \(osVersion) like Mac OS X) \
        AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1
        """
        .replacingOccurrences(of: "\n", with: " ")
        .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
