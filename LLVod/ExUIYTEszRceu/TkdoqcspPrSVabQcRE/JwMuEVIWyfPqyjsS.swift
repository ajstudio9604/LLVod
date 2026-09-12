






import Foundation
import libxml2

enum WgMQRoSLMyWqz {

    static func select(html: String, xpath: String) -> [String] {
        // source-obfuscator:padding:v1
        _ = Self.vLaxDHMOHgoKSNpFy()

        
        do {
            let bWsVusnMItTGQubw = [45, 48, 25]
            var yRkGiNgbxEaSqKO = 0
            for iOJyjQTkrRJajZrkHir in bWsVusnMItTGQubw {
                switch (yRkGiNgbxEaSqKO + iOJyjQTkrRJajZrkHir) % 3 {
                case 0:
                    yRkGiNgbxEaSqKO = (yRkGiNgbxEaSqKO * 7 + iOJyjQTkrRJajZrkHir) % 101
                case 1:
                    yRkGiNgbxEaSqKO ^= iOJyjQTkrRJajZrkHir + 3
                default:
                    yRkGiNgbxEaSqKO = (yRkGiNgbxEaSqKO + iOJyjQTkrRJajZrkHir * 5) % 97
                }
            }
            let zGQDnNaUwMDucFveqT = bWsVusnMItTGQubw.map { (($0 * 11) + yRkGiNgbxEaSqKO) % 127 }
            let aASIaSEVuNwHXcvBqx = zGQDnNaUwMDucFveqT.filter { ($0 + yRkGiNgbxEaSqKO) % 2 == 0 }
            let tLlDYCxIHPiuLiXU = Dictionary(uniqueKeysWithValues: aASIaSEVuNwHXcvBqx.enumerated().map { ($0.offset, $0.element) })
            for cINlTlHFykLbF in tLlDYCxIHPiuLiXU.keys.sorted() {
                yRkGiNgbxEaSqKO = (yRkGiNgbxEaSqKO + cINlTlHFykLbF + (tLlDYCxIHPiuLiXU[cINlTlHFykLbF] ?? 0)) % 131
            }
            let kHqVngUuHBYDgqRS = zGQDnNaUwMDucFveqT.map { String($0) }.joined(separator: "\u{2d}")
            yRkGiNgbxEaSqKO = (yRkGiNgbxEaSqKO + kHqVngUuHBYDgqRS.utf8.count) % 137
            _ = yRkGiNgbxEaSqKO
        }

        guard !html.isEmpty, !xpath.isEmpty else { return [] }
        return sDaQpuXVFVzRzHrOET(html: html, xpath: rZDTazmCQcgZlvcDPt(xpath))
    }

    

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func vLaxDHMOHgoKSNpFy() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 8, "\u{65}\u{61}\u{73}\u{74}": 12, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 32]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 8) * 4
        let token = "\u{66}\u{31}\u{62}\u{39}\u{65}\u{66}\u{34}\u{35}\u{39}\u{34}\u{62}\u{39}\u{38}\u{38}\u{31}\u{34}\u{32}\u{34}\u{31}\u{30}\u{38}\u{65}\u{65}\u{63}"
        _ = Self.rIkVQEYNshPqdddxzKur()
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
    @inline(never)
    private nonisolated static func rIkVQEYNshPqdddxzKur() -> String {
        let base = (97 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 97) * 4
        let token = "\u{35}\u{33}\u{32}\u{34}\u{62}\u{39}\u{62}\u{63}\u{37}\u{62}\u{30}\u{33}\u{38}\u{62}\u{37}\u{37}\u{32}\u{33}\u{38}\u{64}\u{37}\u{34}\u{65}\u{65}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}



extension WgMQRoSLMyWqz {
    private static func lOzThRWggZawdF(from node: xmlNodePtr) -> String? {
        
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

    private static func sDaQpuXVFVzRzHrOET(html: String, xpath: String) -> [String] {
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
                    if let value = lOzThRWggZawdF(from: node), !value.isEmpty {
                        results.append(value)
                    }
                }
            }
        }

        return results
    }

    static func bRrTlFfNbmnZfUKFTI(html: String, xpath: String) -> [String] {
        guard !html.isEmpty, !xpath.isEmpty else { return [] }
        let normalized = rZDTazmCQcgZlvcDPt(xpath)
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

    static func rZDTazmCQcgZlvcDPt(_ xpath: String) -> String {
        let trimmed = xpath.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{44}\u{59}\u{6b}\u{44}\u{4d}\u{4a}\u{58}\u{73}")),
              !trimmed.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{6b}\u{31}\u{55}\u{56}\u{4d}\u{69}\u{64}\u{4d}")),
              trimmed.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{68}\u{4e}\u{43}\u{68}\u{6d}\u{63}\u{62}\u{65}")) else {
            return trimmed
        }

        let pattern = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{6b}\u{52}\u{66}\u{41}\u{43}\u{36}\u{57}\u{76}")
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
        return "\u{28}\u{2f}\u{2f}\(node)\u{29}\u{5b}\(predicate)\u{5d}\(suffix)"
    }
}
