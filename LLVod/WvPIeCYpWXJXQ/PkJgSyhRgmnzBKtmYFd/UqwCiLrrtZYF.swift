








import Foundation

struct OwccvjpSDejUHjnyOJL: Decodable {

    let total: Int?
    let subjects: [QykjQLeFBqEnZSB]

    private enum CodingKeys: String, CodingKey {
        case total
        case items
        case subjectCollectionItems = "\u{73}\u{75}\u{62}\u{6a}\u{65}\u{63}\u{74}\u{5f}\u{63}\u{6f}\u{6c}\u{6c}\u{65}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{5f}\u{69}\u{74}\u{65}\u{6d}\u{73}"
    }

    init(from decoder: Decoder) throws {
        // source-obfuscator:padding:v1
        _ = Self.xCmbLNUaygTgbDtzLD()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        total = try? container.decode(Int.self, forKey: .total)

        if let collection = try? container.decode(
            [QykjQLeFBqEnZSB].self,
            forKey: .subjectCollectionItems
        ), !collection.isEmpty {
            subjects = collection
            return
        }

        
        
        let posts = (try? container.decode([YwiavixiktkFeDCR].self, forKey: .items)) ?? []
        let wrapped = posts.compactMap(\.content?.subject)

        if !wrapped.isEmpty {
            subjects = wrapped
            return
        }

        subjects = (try? container.decode([QykjQLeFBqEnZSB].self, forKey: .items)) ?? []
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func xCmbLNUaygTgbDtzLD() -> String {
        let token = "\u{30}\u{63}\u{65}\u{39}\u{30}\u{66}\u{33}\u{65}\u{38}\u{64}\u{30}\u{33}\u{31}\u{62}\u{36}\u{39}\u{61}\u{38}\u{33}\u{35}\u{63}\u{34}\u{39}\u{61}"
        let source = "\u{30}\u{63}\u{65}\u{39}\u{30}\u{66}\u{33}\u{65}\u{38}\u{64}\u{30}\u{33}\u{31}\u{62}\u{36}\u{39}\u{61}\u{38}\u{33}\u{35}\u{63}\u{34}\u{39}\u{61}\u{2d}\u{36}\u{36}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 66) * 6
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

struct YwiavixiktkFeDCR: Decodable {
    let content: ApcCCnLDNzTvkMEHn?
}

struct ApcCCnLDNzTvkMEHn: Decodable {
    let subject: QykjQLeFBqEnZSB?
}

struct QykjQLeFBqEnZSB: Decodable {

    let title: String?
    let cardSubtitle: String?
    let coverURL: String?
    let pic: EfUFRNfVXUPjmS?
    let pubdate: [String]?

    private enum CodingKeys: String, CodingKey {
        case title
        case pic
        case pubdate
        case cardSubtitle = "\u{63}\u{61}\u{72}\u{64}\u{5f}\u{73}\u{75}\u{62}\u{74}\u{69}\u{74}\u{6c}\u{65}"
        case coverURL = "\u{63}\u{6f}\u{76}\u{65}\u{72}\u{5f}\u{75}\u{72}\u{6c}"
    }

    var posterURL: String {
        // source-obfuscator:padding:v1
        _ = Self.kAHKsTubGHCfgfR()

        if let coverURL, !coverURL.isEmpty { return coverURL }
        return pic?.bestURL ?? ""
    }

    var displaySubtitle: String {
        if let cardSubtitle, !cardSubtitle.isEmpty { return cardSubtitle }
        return pubdate?.first ?? ""
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func kAHKsTubGHCfgfR() -> String {
        let token = "\u{37}\u{63}\u{39}\u{37}\u{38}\u{65}\u{61}\u{62}\u{64}\u{65}\u{37}\u{38}\u{31}\u{37}\u{35}\u{39}\u{32}\u{36}\u{33}\u{66}\u{31}\u{61}\u{64}\u{62}"
        let source = "\u{37}\u{63}\u{39}\u{37}\u{38}\u{65}\u{61}\u{62}\u{64}\u{65}\u{37}\u{38}\u{31}\u{37}\u{35}\u{39}\u{32}\u{36}\u{33}\u{66}\u{31}\u{61}\u{64}\u{62}\u{2d}\u{37}\u{32}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 72) * 5
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

