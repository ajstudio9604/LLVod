






import SwiftUI



struct RvGGzFHfQwFzCOaegZ: Identifiable, Equatable {

    let id: Int
    let userId: Int
    let content: String
    let parentCommentId: Int?
    let rootCommentId: Int?
    let createdAt: TimeInterval
    let nickname: String
    let avatarURL: String
    let parentUserNickname: String?
    let replyCount: Int

    init?(json: [String: Any]) {
        // source-obfuscator:padding:v1
        _ = Self.aIuLTBDuOgWDsjLA()

        guard let id = VzJLkFDMNUvkTo.gFhBCpITjkgEhXovTBfI(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{4b}\u{78}\u{67}\u{50}\u{6b}\u{56}\u{33}\u{33}")]) else { return nil }

        self.id = id
        userId = VzJLkFDMNUvkTo.gFhBCpITjkgEhXovTBfI(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{7a}\u{66}\u{77}\u{73}\u{68}\u{4c}\u{5a}\u{4a}\u{31}")]) ?? 0
        content = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{51}\u{79}\u{50}\u{49}\u{79}\u{43}\u{72}\u{7a}")])
        
        parentCommentId = VzJLkFDMNUvkTo.fILQgpiVMTwcvHV(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{36}\u{6c}\u{47}\u{45}\u{6c}\u{4e}\u{78}\u{4c}")])
        rootCommentId = VzJLkFDMNUvkTo.fILQgpiVMTwcvHV(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{69}\u{67}\u{51}\u{63}\u{61}\u{4b}\u{62}\u{32}")])
        createdAt = VzJLkFDMNUvkTo.double(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{4c}\u{4b}\u{37}\u{50}\u{41}\u{72}\u{6c}\u{6f}")]) ?? 0
        nickname = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{79}\u{73}\u{42}\u{69}\u{4d}\u{71}\u{55}\u{42}")])
        avatarURL = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{48}\u{42}\u{56}\u{43}\u{70}\u{4f}\u{55}\u{6e}")])
        replyCount = VzJLkFDMNUvkTo.gFhBCpITjkgEhXovTBfI(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{45}\u{6c}\u{49}\u{52}\u{6a}\u{62}\u{44}\u{34}\u{73}")]) ?? 0

        let parentNickname = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{4d}\u{62}\u{36}\u{51}\u{79}\u{31}\u{44}\u{36}")])
        parentUserNickname = parentNickname.isEmpty ? nil : parentNickname
    }

    var displayName: String {
        nickname.isEmpty ? "\u{7528}\u{6237}\(userId)" : nickname
    }

    var isRoot: Bool {
        parentCommentId == nil
    }

    var isReply: Bool {
        !isRoot
    }

    var relativeTime: String {
        guard createdAt > 0 else { return "" }

        let interval = Date().timeIntervalSince1970 - createdAt
        switch interval {
        case ..<60:
            return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{33}\u{73}\u{59}\u{73}\u{4b}\u{41}\u{36}\u{33}\u{78}")
        case ..<3600:
            return "\(Int(interval / 60))\u{5206}\u{949f}\u{524d}"
        case ..<86400:
            return "\(Int(interval / 3600))\u{5c0f}\u{65f6}\u{524d}"
        case ..<(86400 * 30):
            return "\(Int(interval / 86400))\u{5929}\u{524d}"
        default:
            return QwmJzyjXvlfoDGt.day.string(
                from: Date(timeIntervalSince1970: createdAt)
            )
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func aIuLTBDuOgWDsjLA() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 32, "\u{65}\u{61}\u{73}\u{74}": 34, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 64]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 32) * 2
        let token = "\u{37}\u{66}\u{37}\u{63}\u{66}\u{65}\u{64}\u{61}\u{30}\u{34}\u{62}\u{33}\u{66}\u{64}\u{31}\u{32}\u{66}\u{36}\u{33}\u{38}\u{31}\u{30}\u{39}\u{35}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
}



struct DiFlugBsHBcmHhv: Identifiable {

    let id: Int
    let title: String
    let content: String
    let linkURL: String
    let icon: String
    let backgroundColor: Color
    let textColor: Color

    init?(json: [String: Any]) {
        // source-obfuscator:padding:v1
        _ = Self.rTTnjtXMfcwHW()

        guard let id = VzJLkFDMNUvkTo.gFhBCpITjkgEhXovTBfI(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{4b}\u{78}\u{67}\u{50}\u{6b}\u{56}\u{33}\u{33}")]) else { return nil }

        self.id = id
        title = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{67}\u{61}\u{79}\u{72}\u{66}\u{63}\u{52}\u{62}")])
        content = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{51}\u{79}\u{50}\u{49}\u{79}\u{43}\u{72}\u{7a}")])
        linkURL = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{41}\u{50}\u{31}\u{77}\u{6f}\u{57}\u{6e}\u{46}\u{64}")])
        icon = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{73}\u{53}\u{6b}\u{67}\u{62}\u{75}\u{51}\u{54}")])
        backgroundColor = MrFwvMVUhwwkAE.zTnhfmHVYDsVNTRNpu(
            VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{45}\u{76}\u{67}\u{78}\u{36}\u{5a}\u{67}\u{6c}\u{4a}")]),
            fallback: Color(red: 31 / 255, green: 41 / 255, blue: 55 / 255)
        )
        textColor = MrFwvMVUhwwkAE.zTnhfmHVYDsVNTRNpu(
            VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{33}\u{69}\u{38}\u{55}\u{37}\u{52}\u{55}\u{30}")]),
            fallback: .white
        )
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func rTTnjtXMfcwHW() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 34, "\u{65}\u{61}\u{73}\u{74}": 40, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 204]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 34) * 6
        let token = "\u{64}\u{31}\u{63}\u{31}\u{63}\u{36}\u{38}\u{30}\u{37}\u{64}\u{32}\u{66}\u{30}\u{38}\u{35}\u{39}\u{30}\u{32}\u{34}\u{37}\u{33}\u{61}\u{65}\u{30}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}



struct CvwhUhUPdyBHHEbjUatV {
    let list: [RvGGzFHfQwFzCOaegZ]
    let notices: [DiFlugBsHBcmHhv]
    let total: Int
    let hasMore: Bool
}



struct YlbtxEGRJfsFSyzEMl: Codable, Equatable {

    let id: Int
    let account: String
    let nickname: String
    let avatarURL: String
    let bio: String
    let title: String
    let vip: Bool
    let vipExpiresAt: TimeInterval
    let createdAt: TimeInterval

    enum CodingKeys: String, CodingKey {
        case id, account, nickname, avatarURL, bio, title, vip, vipExpiresAt, createdAt
    }

    init(json: [String: Any]) {
        // source-obfuscator:padding:v1
        _ = Self.kVnMBBIIvshHG()

        id = VzJLkFDMNUvkTo.gFhBCpITjkgEhXovTBfI(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{4b}\u{78}\u{67}\u{50}\u{6b}\u{56}\u{33}\u{33}")]) ?? 0
        account = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{52}\u{73}\u{7a}\u{56}\u{51}\u{57}\u{64}\u{5a}\u{78}")])
        nickname = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{79}\u{73}\u{42}\u{69}\u{4d}\u{71}\u{55}\u{42}")])
        avatarURL = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{48}\u{42}\u{56}\u{43}\u{70}\u{4f}\u{55}\u{6e}")])
        bio = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{6d}\u{36}\u{35}\u{37}\u{4f}\u{4f}\u{51}\u{70}")])
        title = VzJLkFDMNUvkTo.string(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{67}\u{61}\u{79}\u{72}\u{66}\u{63}\u{52}\u{62}")])
        vip = VzJLkFDMNUvkTo.wSzYyiKPkOCiLAsXsTQ(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{39}\u{44}\u{78}\u{64}\u{63}\u{78}\u{69}\u{47}")])
        vipExpiresAt = VzJLkFDMNUvkTo.double(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{36}\u{33}\u{56}\u{48}\u{50}\u{70}\u{4c}\u{76}")]) ?? 0
        createdAt = VzJLkFDMNUvkTo.double(json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{4c}\u{4b}\u{37}\u{50}\u{41}\u{72}\u{6c}\u{6f}")]) ?? 0
    }

    init(
        id: Int,
        account: String,
        nickname: String,
        avatarURL: String,
        bio: String = "",
        title: String = "",
        vip: Bool = false,
        vipExpiresAt: TimeInterval = 0,
        createdAt: TimeInterval = 0
    ) {
        self.id = id
        self.account = account
        self.nickname = nickname
        self.avatarURL = avatarURL
        self.bio = bio
        self.title = title
        self.vip = vip
        self.vipExpiresAt = vipExpiresAt
        self.createdAt = createdAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        account = try container.decode(String.self, forKey: .account)
        nickname = try container.decode(String.self, forKey: .nickname)
        avatarURL = try container.decode(String.self, forKey: .avatarURL)
        bio = try container.decodeIfPresent(String.self, forKey: .bio) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        vip = try container.decodeIfPresent(Bool.self, forKey: .vip) ?? false
        vipExpiresAt = try container.decodeIfPresent(TimeInterval.self, forKey: .vipExpiresAt) ?? 0
        createdAt = try container.decodeIfPresent(TimeInterval.self, forKey: .createdAt) ?? 0
    }

    var displayName: String {
        nickname.isEmpty ? account : nickname
    }

    func lINPYINixlycN(
        nickname: String? = nil,
        avatarURL: String? = nil,
        bio: String? = nil,
        title: String? = nil,
        vip: Bool? = nil,
        vipExpiresAt: TimeInterval? = nil
    ) -> YlbtxEGRJfsFSyzEMl {
        YlbtxEGRJfsFSyzEMl(
            id: id,
            account: account,
            nickname: nickname ?? self.nickname,
            avatarURL: avatarURL ?? self.avatarURL,
            bio: bio ?? self.bio,
            title: title ?? self.title,
            vip: vip ?? self.vip,
            vipExpiresAt: vipExpiresAt ?? self.vipExpiresAt,
            createdAt: createdAt
        )
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func kVnMBBIIvshHG() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 24, "\u{65}\u{61}\u{73}\u{74}": 30, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 144]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 24) * 6
        let token = "\u{65}\u{30}\u{36}\u{64}\u{31}\u{38}\u{63}\u{31}\u{34}\u{64}\u{66}\u{35}\u{66}\u{31}\u{37}\u{39}\u{63}\u{65}\u{36}\u{62}\u{66}\u{65}\u{31}\u{63}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}



enum VzJLkFDMNUvkTo {

    

    

    

    static func string(_ value: Any?) -> String {
        // source-obfuscator:padding:v1
        _ = Self.mLFKIiOTaeiFAr()

        switch value {
        case let text as String:
            return text
        case let number as NSNumber:
            return number.stringValue
        default:
            return ""
        }
    }

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mLFKIiOTaeiFAr() -> String {
        _ = Self.aGhhUKiojnFjJ()
        let base = (81 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 81) * 3
        let token = "\u{66}\u{61}\u{61}\u{31}\u{30}\u{31}\u{31}\u{63}\u{31}\u{30}\u{64}\u{62}\u{66}\u{64}\u{37}\u{66}\u{61}\u{31}\u{33}\u{30}\u{37}\u{35}\u{34}\u{31}"
        _ = Self.sLgyVpoIgZjbYmI()
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func sLgyVpoIgZjbYmI() -> String {
        let values = [80, 83, 240, 97]
        let folded = values.map { ($0 * 3 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 80) * 3
        let token = "\u{35}\u{64}\u{31}\u{34}\u{63}\u{63}\u{37}\u{36}\u{63}\u{38}\u{66}\u{38}\u{36}\u{39}\u{62}\u{36}\u{38}\u{39}\u{39}\u{62}\u{33}\u{39}\u{30}\u{61}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func aGhhUKiojnFjJ() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{35}\u{38}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 58) * 5
        let token = "\u{37}\u{37}\u{32}\u{36}\u{65}\u{61}\u{33}\u{35}\u{31}\u{61}\u{36}\u{31}\u{36}\u{33}\u{32}\u{32}\u{33}\u{35}\u{63}\u{31}\u{35}\u{30}\u{35}\u{32}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}

enum MrFwvMVUhwwkAE {

    static func zTnhfmHVYDsVNTRNpu(_ hex: String, fallback: Color) -> Color {
        // source-obfuscator:padding:v1
        _ = Self.uEVuUSQegxYtEy()

        var text = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return fallback }

        if text.hasPrefix("\u{23}") {
            text = String(text.dropFirst())
        }
        if text.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{44}\u{65}\u{33}\u{61}\u{4b}\u{6b}\u{6c}\u{79}")) || text.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{37}\u{4b}\u{42}\u{51}\u{48}\u{46}\u{4a}\u{73}")) {
            text = String(text.dropFirst(2))
        }
        guard text.count == 6 || text.count == 8 else { return fallback }

        
        let yERvqHnXVCFlxzmPGe: Swift.UInt64 = 0
        var value: UInt64 = yERvqHnXVCFlxzmPGe
        guard Scanner(string: text).scanHexInt64(&value) else { return fallback }

        
        let hasAlpha = text.count == 8
        let red = Double((value >> (hasAlpha ? 24 : 16)) & 0xFF) / 255
        let green = Double((value >> (hasAlpha ? 16 : 8)) & 0xFF) / 255
        let blue = Double((value >> (hasAlpha ? 8 : 0)) & 0xFF) / 255
        let alpha = hasAlpha ? Double(value & 0xFF) / 255 : 1

        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func uEVuUSQegxYtEy() -> String {
        let token = "\u{65}\u{37}\u{66}\u{33}\u{34}\u{39}\u{31}\u{33}\u{33}\u{66}\u{65}\u{32}\u{30}\u{38}\u{32}\u{62}\u{61}\u{62}\u{36}\u{37}\u{35}\u{34}\u{34}\u{64}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 52, "\u{65}\u{61}\u{73}\u{74}": 59, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 364]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 52) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

enum QwmJzyjXvlfoDGt {
    static let day: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4c}\u{34}\u{47}\u{79}\u{56}\u{70}\u{4c}\u{69}\u{57}")
        return formatter
    }()
}



extension VzJLkFDMNUvkTo {
    static func double(_ value: Any?) -> Double? {
        switch value {
        case let number as NSNumber:
            return number.doubleValue
        case let text as String:
            return Double(text)
        default:
            return nil
        }
    }

    static func fILQgpiVMTwcvHV(_ value: Any?) -> Int? {
        guard let number = gFhBCpITjkgEhXovTBfI(value), number > 0 else { return nil }
        return number
    }

    static func hRgkIKDTHAwxsWMpCy(_ value: Any?) -> [[String: Any]] {
        value as? [[String: Any]] ?? []
    }

    static func gFhBCpITjkgEhXovTBfI(_ value: Any?) -> Int? {
        if value is NSNull { return nil }
        switch value {
        case let number as NSNumber:
            return number.intValue
        case let text as String:
            return Int(text)
        default:
            return nil
        }
    }

    static func nRBvMWnjIbzFbbVX(_ value: Any?) -> [String: Any] {
        value as? [String: Any] ?? [:]
    }

    static func wSzYyiKPkOCiLAsXsTQ(_ value: Any?) -> Bool {
        switch value {
        case let flag as Bool:
            return flag
        case let number as NSNumber:
            return number.boolValue
        case let text as String:
            let normalized = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            return normalized == "\u{31}" || normalized == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{45}\u{56}\u{6b}\u{6b}\u{56}\u{4b}\u{71}\u{59}\u{47}") || normalized == AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{79}\u{41}\u{4b}\u{67}\u{4f}\u{66}\u{6b}\u{33}")
        default:
            return (gFhBCpITjkgEhXovTBfI(value) ?? 0) != 0
        }
    }
}
