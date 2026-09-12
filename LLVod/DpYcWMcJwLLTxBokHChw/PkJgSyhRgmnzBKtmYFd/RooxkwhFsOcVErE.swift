import Foundation

struct PikKJcTaoCEJw: Decodable {
    let title: String?
    let sharingURL: String?
    let groups: [ZnFQWJLdOofeNNtTaBL]

    private enum CodingKeys: String, CodingKey {
        case title, groups
        case sharingURL = "\u{73}\u{68}\u{61}\u{72}\u{69}\u{6e}\u{67}\u{5f}\u{75}\u{72}\u{6c}"
    }
}

struct ZnFQWJLdOofeNNtTaBL: Decodable, Identifiable {
    var id: String { "\(type)\u{2d}\(title)" }
    let title: String
    let type: String
    let tabs: [SiWvtvcRnfCnlXxQdJX]
    let selectedCollections: [RwxvTSHANrTeJWJ]

    private enum CodingKeys: String, CodingKey {
        case title, type, tabs
        case selectedCollections = "\u{73}\u{65}\u{6c}\u{65}\u{63}\u{74}\u{65}\u{64}\u{5f}\u{63}\u{6f}\u{6c}\u{6c}\u{65}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{73}"
    }

    init(from decoder: Decoder) throws {
        // source-obfuscator:padding:v1
        _ = Self.mAYvquTnJyCpXXSJy()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = (try? container.decode(String.self, forKey: .title)) ?? ""
        type = (try? container.decode(String.self, forKey: .type)) ?? ""
        tabs = (try? container.decode([SiWvtvcRnfCnlXxQdJX].self, forKey: .tabs)) ?? []
        selectedCollections = (try? container.decode([RwxvTSHANrTeJWJ].self, forKey: .selectedCollections)) ?? []
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mAYvquTnJyCpXXSJy() -> String {
        let token = "\u{32}\u{30}\u{65}\u{65}\u{65}\u{33}\u{64}\u{34}\u{65}\u{39}\u{32}\u{65}\u{35}\u{62}\u{30}\u{39}\u{62}\u{36}\u{65}\u{31}\u{38}\u{66}\u{65}\u{35}"
        let source = "\u{32}\u{30}\u{65}\u{65}\u{65}\u{33}\u{64}\u{34}\u{65}\u{39}\u{32}\u{65}\u{35}\u{62}\u{30}\u{39}\u{62}\u{36}\u{65}\u{31}\u{38}\u{66}\u{65}\u{35}\u{2d}\u{33}\u{35}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 35) * 7
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

struct SiWvtvcRnfCnlXxQdJX: Decodable, Identifiable, Hashable {
    var id: String { key }
    let key: String
    let title: String

    init(from decoder: Decoder) throws {
        // source-obfuscator:padding:v1
        _ = Self.mSpceOMyPnfMuYPKhNy()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        key = (try? container.decode(String.self, forKey: .key)) ?? ""
        title = (try? container.decode(String.self, forKey: .title)) ?? key
    }

    private enum CodingKeys: String, CodingKey { case key, title }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mSpceOMyPnfMuYPKhNy() -> String {
        let token = "\u{36}\u{36}\u{63}\u{36}\u{62}\u{36}\u{36}\u{38}\u{66}\u{62}\u{39}\u{39}\u{36}\u{63}\u{34}\u{32}\u{34}\u{36}\u{62}\u{61}\u{35}\u{31}\u{36}\u{65}"
        let base = (65 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 65) * 7
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

struct GsUIobuTSMMM: Decodable { let groups: [ZnFQWJLdOofeNNtTaBL] }

struct JiGAfdsKZedtA: Decodable {
    let selectedCollections: [RwxvTSHANrTeJWJ]
    let start: Int?
    let count: Int?
    let total: Int?

    private enum CodingKeys: String, CodingKey {
        case start, count, total
        case selectedCollections = "\u{73}\u{65}\u{6c}\u{65}\u{63}\u{74}\u{65}\u{64}\u{5f}\u{63}\u{6f}\u{6c}\u{6c}\u{65}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{73}"
    }

    init(from decoder: Decoder) throws {
        // source-obfuscator:padding:v1
        _ = Self.pNzhMInaZaqUfgWWGQR()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        selectedCollections = (try? container.decode([RwxvTSHANrTeJWJ].self, forKey: .selectedCollections)) ?? []
        start = try? container.decode(Int.self, forKey: .start)
        count = try? container.decode(Int.self, forKey: .count)
        total = try? container.decode(Int.self, forKey: .total)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func pNzhMInaZaqUfgWWGQR() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{32}\u{39}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 29) * 2
        let token = "\u{62}\u{63}\u{37}\u{66}\u{35}\u{32}\u{63}\u{33}\u{64}\u{32}\u{36}\u{61}\u{36}\u{37}\u{36}\u{64}\u{35}\u{39}\u{65}\u{62}\u{62}\u{30}\u{37}\u{35}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}

