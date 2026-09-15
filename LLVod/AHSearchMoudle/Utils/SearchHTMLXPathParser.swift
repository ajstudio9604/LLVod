//
//  SearchHTMLXPathParser.swift
//  LLVod
//
//  对应 Flutter JXDocument.sel / _parseSearchHtml
//

import Foundation
import libxml2

enum SearchHTMLXPathParser {

    static func select(html: String, xpath: String) -> [String] {
        guard !html.isEmpty, !xpath.isEmpty else { return [] }
        return evaluate(html: html, xpath: normalizeXPath(xpath))
    }

    static func normalizeXPath(_ xpath: String) -> String {
        let trimmed = xpath.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.contains("position()"),
              !trimmed.hasPrefix("(//"),
              trimmed.hasPrefix("//") else {
            return trimmed
        }

        let pattern = #"^//([a-zA-Z*][\w:.-]*)\[([^\]]*position\(\)[^\]]*)\](.*)$"#
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(
                in: trimmed,
                range: NSRange(trimmed.startIndex..<trimmed.endIndex, in: trimmed)
              ),
              let nodeRange = Range(match.range(at: 1), in: trimmed),
              let predRange = Range(match.range(at: 2), in: trimmed),
              let suffixRange = Range(match.range(at: 3), in: trimmed) else {
            return trimmed
        }

        let node = String(trimmed[nodeRange])
        let predicate = String(trimmed[predRange])
        let suffix = String(trimmed[suffixRange])
        return "(//\(node))[\(predicate)]\(suffix)"
    }

    private static func evaluate(html: String, xpath: String) -> [String] {
        var results: [String] = []

        html.withCString { htmlPointer in
            let length = Int32(strlen(htmlPointer))
            let options = Int32(
                HTML_PARSE_RECOVER.rawValue
                    | HTML_PARSE_NOERROR.rawValue
                    | HTML_PARSE_NOWARNING.rawValue
            )

            guard let document = htmlReadMemory(htmlPointer, length, nil, nil, options) else {
                return
            }
            defer { xmlFreeDoc(document) }

            guard let context = xmlXPathNewContext(document) else { return }
            defer { xmlXPathFreeContext(context) }

            xpath.withCString { xpathPointer in
                guard let object = xmlXPathEvalExpression(xpathPointer, context) else { return }
                defer { xmlXPathFreeObject(object) }

                guard let nodeSet = object.pointee.nodesetval else { return }
                let count = Int(nodeSet.pointee.nodeNr)

                for index in 0..<count {
                    guard let node = nodeSet.pointee.nodeTab[index] else { continue }
                    if let value = extractValue(from: node), !value.isEmpty {
                        results.append(value)
                    }
                }
            }
        }

        return results
    }

    static func selectNodeHTMLList(html: String, xpath: String) -> [String] {
        guard !html.isEmpty, !xpath.isEmpty else { return [] }
        let normalized = normalizeXPath(xpath)
        var results: [String] = []

        html.withCString { htmlPointer in
            let length = Int32(strlen(htmlPointer))
            let options = Int32(
                HTML_PARSE_RECOVER.rawValue
                    | HTML_PARSE_NOERROR.rawValue
                    | HTML_PARSE_NOWARNING.rawValue
            )

            guard let document = htmlReadMemory(htmlPointer, length, nil, nil, options) else {
                return
            }
            defer { xmlFreeDoc(document) }

            guard let context = xmlXPathNewContext(document) else { return }
            defer { xmlXPathFreeContext(context) }

            normalized.withCString { xpathPointer in
                guard let object = xmlXPathEvalExpression(xpathPointer, context) else { return }
                defer { xmlXPathFreeObject(object) }

                guard let nodeSet = object.pointee.nodesetval else { return }
                let count = Int(nodeSet.pointee.nodeNr)

                for index in 0..<count {
                    guard let node = nodeSet.pointee.nodeTab[index] else { continue }
                    guard let buffer = xmlBufferCreate() else { continue }
                    defer { xmlBufferFree(buffer) }
                    xmlNodeDump(buffer, document, node, 0, 1)
                    if let content = buffer.pointee.content {
                        let htmlFragment = String(cString: content)
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                        if !htmlFragment.isEmpty {
                            results.append(htmlFragment)
                        }
                    }
                }
            }
        }

        return results
    }

    private static func extractValue(from node: xmlNodePtr) -> String? {
        // 属性节点优先取属性值，避免部分 libxml 版本对 ATTR 的 GetContent 为空
        if node.pointee.type == XML_ATTRIBUTE_NODE {
            if let children = node.pointee.children, let content = children.pointee.content {
                let value = String(cString: content)
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                if !value.isEmpty { return value }
            }
        }

        if let content = xmlNodeGetContent(node) {
            defer { xmlFree(content) }
            let value = String(cString: content)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            if !value.isEmpty {
                return value
            }
        }

        if let content = node.pointee.content {
            let value = String(cString: content)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            if !value.isEmpty {
                return value
            }
        }

        return nil
    }
}
