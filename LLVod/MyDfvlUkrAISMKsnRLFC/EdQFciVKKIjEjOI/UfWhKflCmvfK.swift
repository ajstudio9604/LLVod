import Foundation

enum GsxneZnqWwtGcuOkvg: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case emptyData
    case emptyResponseText
    case invalidJSON

    var errorDescription: String? {
        // source-obfuscator:padding:v1
        _ = Self.nZmZwUeVBDHL()

        switch self {
        case .invalidURL:
            return ""

        case .invalidResponse:
            return ""

        case .httpError:
            return ""

        case .emptyData:
            return ""

        case .emptyResponseText:
            return ""

        case .invalidJSON:
            return ""
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func nZmZwUeVBDHL() -> String {
        let source = "\u{33}\u{35}\u{34}\u{36}\u{33}\u{34}\u{38}\u{63}\u{39}\u{64}\u{30}\u{30}\u{35}\u{62}\u{39}\u{62}\u{38}\u{65}\u{63}\u{30}\u{62}\u{38}\u{34}\u{31}\u{2d}\u{36}\u{36}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 66) * 4
        let token = "\u{33}\u{35}\u{34}\u{36}\u{33}\u{34}\u{38}\u{63}\u{39}\u{64}\u{30}\u{30}\u{35}\u{62}\u{39}\u{62}\u{38}\u{65}\u{63}\u{30}\u{62}\u{38}\u{34}\u{31}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}

