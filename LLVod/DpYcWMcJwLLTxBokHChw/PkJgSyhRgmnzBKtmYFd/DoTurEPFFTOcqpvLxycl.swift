import Foundation

struct YfUSSijIbiZRZMywHI: Decodable {
    let subjectCollectionItems: [YbfRUDRMWBvXF]
    let total: Int?
    let subjectCollection: RwxvTSHANrTeJWJ?

    private enum CodingKeys: String, CodingKey {
        case total
        case subjectCollectionItems = "\u{73}\u{75}\u{62}\u{6a}\u{65}\u{63}\u{74}\u{5f}\u{63}\u{6f}\u{6c}\u{6c}\u{65}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{5f}\u{69}\u{74}\u{65}\u{6d}\u{73}"
        case subjectCollection = "\u{73}\u{75}\u{62}\u{6a}\u{65}\u{63}\u{74}\u{5f}\u{63}\u{6f}\u{6c}\u{6c}\u{65}\u{63}\u{74}\u{69}\u{6f}\u{6e}"
    }

    init(from decoder: Decoder) throws {
        // source-obfuscator:padding:v1
        _ = Self.aZBbpuFkMZRjadwX()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        subjectCollectionItems = (try? container.decode([YbfRUDRMWBvXF].self, forKey: .subjectCollectionItems)) ?? []
        total = try? container.decode(Int.self, forKey: .total)
        subjectCollection = try? container.decode(RwxvTSHANrTeJWJ.self, forKey: .subjectCollection)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func aZBbpuFkMZRjadwX() -> String {
        let base = (66 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 66) * 4
        let token = "\u{39}\u{63}\u{37}\u{32}\u{61}\u{61}\u{30}\u{63}\u{30}\u{61}\u{33}\u{37}\u{39}\u{36}\u{61}\u{31}\u{63}\u{32}\u{36}\u{38}\u{37}\u{62}\u{35}\u{61}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}

struct YbfRUDRMWBvXF: Decodable, Identifiable {
    let id: String
    let title: String
    let cardSubtitle: String
    let comment: String
    let description: String
    let year: String
    let photos: [String]
    let posterURL: String
    let ratingValue: Double
    let starCount: Double
    let tags: [String]
    let type: String

    private enum CodingKeys: String, CodingKey {
        case id, title, year, photos, type, description, tags, comment, pic, rating
        case cardSubtitle = "\u{63}\u{61}\u{72}\u{64}\u{5f}\u{73}\u{75}\u{62}\u{74}\u{69}\u{74}\u{6c}\u{65}"
        case coverURL = "\u{63}\u{6f}\u{76}\u{65}\u{72}\u{5f}\u{75}\u{72}\u{6c}"
    }

    init(from decoder: Decoder) throws {
        // source-obfuscator:padding:v1
        _ = Self.xPnQgLnkephtLgQ()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decode(String.self, forKey: .id)) ?? (try? container.decode(Int.self, forKey: .id)).map(String.init) ?? UUID().uuidString
        title = (try? container.decode(String.self, forKey: .title)) ?? ""
        cardSubtitle = (try? container.decode(String.self, forKey: .cardSubtitle)) ?? ""
        comment = (try? container.decode(String.self, forKey: .comment)) ?? ""
        description = (try? container.decode(String.self, forKey: .description)) ?? ""
        year = (try? container.decode(String.self, forKey: .year)) ?? ""
        photos = (try? container.decode([String].self, forKey: .photos)) ?? []
        type = (try? container.decode(String.self, forKey: .type)) ?? ""
        tags = (try? container.decode([String].self, forKey: .tags)) ?? []
        let pic = try? container.decode(IdWDLlfZIROB.self, forKey: .pic)
        let cover = (try? container.decode(String.self, forKey: .coverURL)) ?? ""
        posterURL = !cover.isEmpty ? cover : (pic?.bestURL ?? "")
        let rating = try? container.decode(JnzwAEcMyjBa.self, forKey: .rating)
        ratingValue = rating?.value ?? 0
        starCount = rating?.starCount ?? 0
    }

    var blurb: String { !comment.isEmpty ? comment : description }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func xPnQgLnkephtLgQ() -> String {
        let token = "\u{32}\u{34}\u{37}\u{32}\u{37}\u{64}\u{33}\u{33}\u{31}\u{63}\u{63}\u{33}\u{33}\u{63}\u{37}\u{65}\u{33}\u{30}\u{33}\u{38}\u{32}\u{36}\u{39}\u{37}"
        let values = [93, 99, 558, 110]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 93) * 6
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

struct IdWDLlfZIROB: Decodable {
    let normal: String?
    let large: String?
    var bestURL: String {
        // source-obfuscator:padding:v1
        _ = Self.pLeMsAFFlPPd()
 return (large?.isEmpty == false ? large : normal) ?? "" }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func pLeMsAFFlPPd() -> String {
        let token = "\u{66}\u{62}\u{64}\u{66}\u{30}\u{30}\u{32}\u{35}\u{33}\u{39}\u{63}\u{36}\u{64}\u{30}\u{34}\u{33}\u{36}\u{31}\u{62}\u{38}\u{36}\u{66}\u{66}\u{63}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{38}\u{32}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 82) * 6
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

struct JnzwAEcMyjBa: Decodable {
    let value: Double
    let starCount: Double

    private enum CodingKeys: String, CodingKey {
        case value
        case starCount = "\u{73}\u{74}\u{61}\u{72}\u{5f}\u{63}\u{6f}\u{75}\u{6e}\u{74}"
    }

    init(from decoder: Decoder) throws {
        // source-obfuscator:padding:v1
        _ = Self.xRRZcgTnXdgILAAwgOLj()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = (try? container.decode(Double.self, forKey: .value)) ?? Double((try? container.decode(Int.self, forKey: .value)) ?? 0)
        starCount = (try? container.decode(Double.self, forKey: .starCount)) ?? Double((try? container.decode(Int.self, forKey: .starCount)) ?? 0)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func xRRZcgTnXdgILAAwgOLj() -> String {
        let token = "\u{32}\u{63}\u{33}\u{35}\u{34}\u{65}\u{35}\u{62}\u{31}\u{34}\u{61}\u{35}\u{37}\u{35}\u{64}\u{35}\u{38}\u{30}\u{36}\u{65}\u{38}\u{61}\u{37}\u{62}"
        let values = [93, 98, 465, 110]
        let folded = values.map { ($0 * 5 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 93) * 5
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

