






import Foundation


struct OvbYNtlJVsci: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let mode: Int
}


struct DcLpvWsALmUOoRftmSn: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageURL: String
}

struct TlFImSfiQjytkLqnZiPj: Decodable {
    let subjectCollectionItems: [UwBnBgWqwtfPtptR]

    enum CodingKeys: String, CodingKey {
        case subjectCollectionItems = "\u{73}\u{75}\u{62}\u{6a}\u{65}\u{63}\u{74}\u{5f}\u{63}\u{6f}\u{6c}\u{6c}\u{65}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{5f}\u{69}\u{74}\u{65}\u{6d}\u{73}"
    }
}

struct UwBnBgWqwtfPtptR: Decodable {
    let title: String
    let cardSubtitle: String?
    let pic: GpGmGChUdyluEFDH?

    enum CodingKeys: String, CodingKey {
        case title
        case cardSubtitle = "\u{63}\u{61}\u{72}\u{64}\u{5f}\u{73}\u{75}\u{62}\u{74}\u{69}\u{74}\u{6c}\u{65}"
        case pic
    }
}

struct GpGmGChUdyluEFDH: Decodable {
    let normal: String?
}

struct EfOmFTEnBTxyRIlmedkD: Decodable {
    let data: [LthdPMzaEcHB]
}

struct LthdPMzaEcHB: Decodable {
    let title: String
    let cover: String?
    let rate: String?
}

enum IrxblUEoPFOBtF: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case emptyData
    case requestFailed(String)

    var errorDescription: String? {
        // source-obfuscator:padding:v1
        _ = Self.dMCvHgqJAqSSdg()

        switch self {
        case .invalidURL:
            return ""
        case .invalidResponse:
            return ""
        case .httpError(let statusCode):
            return ""
        case .emptyData:
            return ""
        case .requestFailed(let message):
            return message
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func dMCvHgqJAqSSdg() -> String {
        let base = (30 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 30) * 9
        let token = "\u{35}\u{33}\u{32}\u{63}\u{30}\u{64}\u{65}\u{33}\u{34}\u{66}\u{62}\u{66}\u{33}\u{66}\u{30}\u{35}\u{39}\u{36}\u{38}\u{65}\u{34}\u{66}\u{63}\u{32}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

