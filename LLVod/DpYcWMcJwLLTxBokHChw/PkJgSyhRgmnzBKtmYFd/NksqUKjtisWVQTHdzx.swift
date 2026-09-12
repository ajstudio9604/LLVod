import Foundation

struct RwxvTSHANrTeJWJ: Decodable, Identifiable, Equatable {
    let id: String
    let title: String
    let name: String
    let shortName: String
    let mediumName: String
    let description: String
    let headerBgImage: String
    let coverURL: String
    let updatedAt: String
    let doneCount: Int
    let itemsCount: Int
    let subjectCount: Int
    let total: Int
    let followersCount: Int
    let showRank: Bool
    let sharingURL: String
    let subjectType: String

    private enum CodingKeys: String, CodingKey {
        case id, title, name, description, total
        case shortName = "\u{73}\u{68}\u{6f}\u{72}\u{74}\u{5f}\u{6e}\u{61}\u{6d}\u{65}"
        case mediumName = "\u{6d}\u{65}\u{64}\u{69}\u{75}\u{6d}\u{5f}\u{6e}\u{61}\u{6d}\u{65}"
        case headerBgImage = "\u{68}\u{65}\u{61}\u{64}\u{65}\u{72}\u{5f}\u{62}\u{67}\u{5f}\u{69}\u{6d}\u{61}\u{67}\u{65}"
        case coverURL = "\u{63}\u{6f}\u{76}\u{65}\u{72}\u{5f}\u{75}\u{72}\u{6c}"
        case updatedAt = "\u{75}\u{70}\u{64}\u{61}\u{74}\u{65}\u{64}\u{5f}\u{61}\u{74}"
        case doneCount = "\u{64}\u{6f}\u{6e}\u{65}\u{5f}\u{63}\u{6f}\u{75}\u{6e}\u{74}"
        case itemsCount = "\u{69}\u{74}\u{65}\u{6d}\u{73}\u{5f}\u{63}\u{6f}\u{75}\u{6e}\u{74}"
        case subjectCount = "\u{73}\u{75}\u{62}\u{6a}\u{65}\u{63}\u{74}\u{5f}\u{63}\u{6f}\u{75}\u{6e}\u{74}"
        case followersCount = "\u{66}\u{6f}\u{6c}\u{6c}\u{6f}\u{77}\u{65}\u{72}\u{73}\u{5f}\u{63}\u{6f}\u{75}\u{6e}\u{74}"
        case showRank = "\u{73}\u{68}\u{6f}\u{77}\u{5f}\u{72}\u{61}\u{6e}\u{6b}"
        case sharingURL = "\u{73}\u{68}\u{61}\u{72}\u{69}\u{6e}\u{67}\u{5f}\u{75}\u{72}\u{6c}"
        case subjectType = "\u{73}\u{75}\u{62}\u{6a}\u{65}\u{63}\u{74}\u{5f}\u{74}\u{79}\u{70}\u{65}"
    }

    init(from decoder: Decoder) throws {
        // source-obfuscator:padding:v1
        _ = Self.pQNoPagpgsUiubol()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decode(String.self, forKey: .id)) ?? ""
        title = (try? container.decode(String.self, forKey: .title)) ?? ""
        name = (try? container.decode(String.self, forKey: .name)) ?? title
        shortName = (try? container.decode(String.self, forKey: .shortName)) ?? ""
        mediumName = (try? container.decode(String.self, forKey: .mediumName)) ?? ""
        description = (try? container.decode(String.self, forKey: .description)) ?? ""
        headerBgImage = (try? container.decode(String.self, forKey: .headerBgImage)) ?? ""
        coverURL = (try? container.decode(String.self, forKey: .coverURL)) ?? ""
        updatedAt = (try? container.decode(String.self, forKey: .updatedAt)) ?? ""
        doneCount = (try? container.decode(Int.self, forKey: .doneCount)) ?? 0
        itemsCount = (try? container.decode(Int.self, forKey: .itemsCount)) ?? 0
        subjectCount = (try? container.decode(Int.self, forKey: .subjectCount)) ?? 0
        total = (try? container.decode(Int.self, forKey: .total)) ?? 0
        followersCount = (try? container.decode(Int.self, forKey: .followersCount)) ?? 0
        showRank = (try? container.decode(Bool.self, forKey: .showRank)) ?? true
        sharingURL = (try? container.decode(String.self, forKey: .sharingURL)) ?? ""
        subjectType = (try? container.decode(String.self, forKey: .subjectType)) ?? ""
    }

    var displayTitle: String { !title.isEmpty ? title : (!name.isEmpty ? name : mediumName) }
    var headerImageURL: String { !headerBgImage.isEmpty ? headerBgImage : coverURL }
    var listTotal: Int {
        if itemsCount > 0 { return itemsCount }
        if subjectCount > 0 { return subjectCount }
        if total > 0 { return total }
        return 0
    }

    var sidebarLabel: String {
        switch id {
        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{4c}\u{78}\u{34}\u{38}\u{50}\u{65}\u{59}\u{75}"): return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{6f}\u{43}\u{68}\u{76}\u{42}\u{54}\u{45}\u{4b}")
        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{67}\u{53}\u{6b}\u{54}\u{33}\u{68}\u{4d}\u{48}"): return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{53}\u{4d}\u{31}\u{62}\u{67}\u{75}\u{68}\u{6b}")
        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{62}\u{34}\u{61}\u{52}\u{68}\u{58}\u{44}\u{75}"): return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{71}\u{7a}\u{6c}\u{76}\u{44}\u{4b}\u{6d}\u{6e}")
        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{34}\u{77}\u{79}\u{64}\u{4c}\u{5a}\u{6b}\u{4f}"): return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{65}\u{41}\u{58}\u{4a}\u{61}\u{45}\u{79}\u{70}")
        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{45}\u{73}\u{45}\u{69}\u{38}\u{44}\u{79}\u{39}"): return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{55}\u{76}\u{77}\u{6a}\u{76}\u{69}\u{77}\u{30}\u{68}")
        default: break
        }
        var text = shortName.isEmpty ? mediumName : shortName
        if text.isEmpty { text = title }
        text = text.replacingOccurrences(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{69}\u{77}\u{46}\u{49}\u{68}\u{76}\u{72}\u{64}"), with: "")
        if text.hasSuffix("\u{699c}") { text = String(text.dropLast()) }
        return text.isEmpty ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{59}\u{7a}\u{73}\u{58}\u{63}\u{6e}\u{66}\u{6e}") : text
    }

    var updatedDisplay: String {
        let parts = updatedAt.split(separator: " ")
        guard let date = parts.first else { return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{72}\u{56}\u{65}\u{31}\u{6c}\u{41}\u{6d}\u{4a}") }
        let components = date.split(separator: "\u{2d}")
        return components.count >= 3 ? "\(components[1])\u{2d}\(components[2]) \u{66f4}\u{65b0}" : "\(date) \u{66f4}\u{65b0}"
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func pQNoPagpgsUiubol() -> String {
        let source = "\u{65}\u{38}\u{35}\u{64}\u{61}\u{30}\u{31}\u{30}\u{39}\u{63}\u{65}\u{36}\u{36}\u{61}\u{64}\u{32}\u{65}\u{65}\u{34}\u{65}\u{65}\u{37}\u{31}\u{30}\u{2d}\u{34}\u{35}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 45) * 6
        let token = "\u{65}\u{38}\u{35}\u{64}\u{61}\u{30}\u{31}\u{30}\u{39}\u{63}\u{65}\u{36}\u{36}\u{61}\u{64}\u{32}\u{65}\u{65}\u{34}\u{65}\u{65}\u{37}\u{31}\u{30}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}

