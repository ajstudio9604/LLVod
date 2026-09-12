




import Foundation

enum GvBrMJSUwgNJ: CaseIterable, Identifiable {
    case mediaType
    case genre
    case region
    case year
    case sort

    var id: String {
        // source-obfuscator:padding:v1
        _ = Self.lFNpIqfrkHyBxr()
 return String(describing: self) }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func lFNpIqfrkHyBxr() -> String {
        let values = [54, 60, 324, 71]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 54) * 6
        let token = "\u{30}\u{61}\u{30}\u{36}\u{66}\u{65}\u{32}\u{30}\u{30}\u{33}\u{62}\u{31}\u{39}\u{65}\u{63}\u{33}\u{62}\u{36}\u{64}\u{38}\u{32}\u{63}\u{38}\u{32}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}

struct EyDFcDrlWhFFRVgXi: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageURL: String
}

struct YywBMtLThQlkUPUwYzzP: Decodable {
    let items: [WcnMvWOblfTNf]?
}

struct WcnMvWOblfTNf: Decodable {
    let title: String
    let pic: EfUFRNfVXUPjmS?
    let rating: FbcbJNnKLFrSEsoRqGS?
    let cardSubtitle: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case title
        case pic
        case rating
        case type
        case cardSubtitle = "\u{63}\u{61}\u{72}\u{64}\u{5f}\u{73}\u{75}\u{62}\u{74}\u{69}\u{74}\u{6c}\u{65}"
    }
}

struct EfUFRNfVXUPjmS: Decodable {
    let normal: String?
    let large: String?
    let url: String?

    var bestURL: String {
        // source-obfuscator:padding:v1
        _ = Self.xNeAgkmufgCQBqEYFwOp()

        return normal ?? large ?? url ?? ""
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func xNeAgkmufgCQBqEYFwOp() -> String {
        let token = "\u{36}\u{37}\u{34}\u{34}\u{33}\u{30}\u{63}\u{61}\u{31}\u{66}\u{35}\u{30}\u{64}\u{30}\u{37}\u{37}\u{33}\u{66}\u{62}\u{38}\u{64}\u{31}\u{61}\u{65}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 76, "\u{65}\u{61}\u{73}\u{74}": 79, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 228]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 76) * 3
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

struct FbcbJNnKLFrSEsoRqGS: Decodable {
    let value: Double?

    enum CodingKeys: String, CodingKey {
        case value
    }

    init(from decoder: Decoder) throws {
        // source-obfuscator:padding:v1
        _ = Self.kOWlQBttVSsrGF()

        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let doubleValue = try? container.decode(Double.self, forKey: .value) {
            value = doubleValue
        } else if let intValue = try? container.decode(Int.self, forKey: .value) {
            value = Double(intValue)
        } else if let stringValue = try? container.decode(String.self, forKey: .value),
                  let parsed = Double(stringValue) {
            value = parsed
        } else {
            value = nil
        }
    }

    var displayValue: String {
        guard let value, value > 0 else { return "" }
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{55}\u{4a}\u{4c}\u{66}\u{49}\u{63}\u{4e}\u{6d}"), value)
        }
        return String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{69}\u{58}\u{38}\u{66}\u{77}\u{78}\u{4a}\u{6c}"), value)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func kOWlQBttVSsrGF() -> String {
        let token = "\u{34}\u{30}\u{33}\u{30}\u{37}\u{39}\u{61}\u{66}\u{30}\u{63}\u{63}\u{30}\u{39}\u{66}\u{31}\u{39}\u{63}\u{33}\u{30}\u{65}\u{36}\u{32}\u{37}\u{32}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{31}\u{34}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 14) * 8
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

enum JeqpkbJziOceK {

    static let mediaTypes = [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{7a}\u{79}\u{6c}\u{65}\u{74}\u{6c}\u{53}\u{70}\u{55}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{6f}\u{43}\u{68}\u{76}\u{42}\u{54}\u{45}\u{4b}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{78}\u{31}\u{71}\u{4d}\u{5a}\u{61}\u{37}\u{54}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{56}\u{56}\u{59}\u{75}\u{32}\u{49}\u{67}\u{68}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{57}\u{68}\u{6a}\u{65}\u{49}\u{6a}\u{33}\u{73}")]

    static let genres = [
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{4a}\u{49}\u{4a}\u{55}\u{31}\u{6e}\u{52}\u{4b}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{32}\u{61}\u{38}\u{6a}\u{73}\u{35}\u{70}\u{73}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{78}\u{55}\u{35}\u{53}\u{58}\u{52}\u{75}\u{7a}\u{50}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{47}\u{75}\u{76}\u{77}\u{72}\u{36}\u{30}\u{54}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{70}\u{46}\u{5a}\u{4e}\u{49}\u{49}\u{34}\u{32}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{38}\u{34}\u{66}\u{52}\u{62}\u{54}\u{37}\u{43}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{69}\u{6b}\u{6f}\u{78}\u{56}\u{76}\u{63}\u{75}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{66}\u{36}\u{4f}\u{50}\u{4e}\u{77}\u{6e}\u{35}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{72}\u{72}\u{74}\u{6d}\u{52}\u{35}\u{57}\u{6f}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{78}\u{61}\u{66}\u{72}\u{51}\u{65}\u{38}\u{31}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{55}\u{71}\u{6a}\u{79}\u{34}\u{31}\u{75}\u{62}\u{5a}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{4b}\u{46}\u{44}\u{73}\u{71}\u{6b}\u{36}\u{76}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{41}\u{52}\u{48}\u{74}\u{37}\u{42}\u{42}\u{6c}\u{6e}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{64}\u{75}\u{4e}\u{58}\u{4c}\u{38}\u{67}\u{57}")
    ]

    static let regions = [
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{4a}\u{49}\u{4a}\u{55}\u{31}\u{6e}\u{52}\u{4b}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{6b}\u{67}\u{4a}\u{46}\u{62}\u{31}\u{64}\u{57}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{61}\u{36}\u{70}\u{68}\u{67}\u{45}\u{51}\u{67}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{31}\u{6d}\u{70}\u{48}\u{4c}\u{36}\u{75}\u{4f}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{41}\u{32}\u{49}\u{61}\u{59}\u{65}\u{52}\u{47}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{6e}\u{77}\u{46}\u{59}\u{48}\u{6d}\u{6e}\u{63}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{57}\u{77}\u{6b}\u{54}\u{63}\u{65}\u{73}\u{75}\u{32}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{4a}\u{67}\u{74}\u{79}\u{70}\u{46}\u{4f}\u{57}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{45}\u{56}\u{6a}\u{65}\u{58}\u{69}\u{78}\u{44}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{47}\u{30}\u{48}\u{74}\u{79}\u{57}\u{48}\u{6a}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{4c}\u{36}\u{52}\u{46}\u{61}\u{58}\u{69}\u{4f}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{31}\u{70}\u{65}\u{75}\u{51}\u{68}\u{45}\u{64}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{79}\u{79}\u{61}\u{4b}\u{74}\u{71}\u{37}\u{76}\u{55}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{41}\u{45}\u{4e}\u{34}\u{57}\u{61}\u{4b}\u{55}\u{68}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{55}\u{46}\u{35}\u{70}\u{30}\u{68}\u{70}\u{7a}\u{7a}")
    ]

    static let sortOptions = [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{4a}\u{49}\u{4a}\u{55}\u{31}\u{6e}\u{52}\u{4b}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{49}\u{6c}\u{64}\u{6f}\u{49}\u{6a}\u{57}\u{31}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{71}\u{4d}\u{34}\u{55}\u{4a}\u{59}\u{32}\u{52}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{75}\u{64}\u{41}\u{51}\u{72}\u{58}\u{58}\u{43}")]

    static func dADiPagDRyPJAcn() -> [String] {
        // source-obfuscator:padding:v1
        _ = Self.tBCTPhPCfpEqqx()

        
        do {
            let rVsMsFjPLJrIHTQGp = [10, 38, 60]
            var wJMrmDhVPnxMSo = 0
            for oPDppQqIALrEGzJl in rVsMsFjPLJrIHTQGp {
                switch (wJMrmDhVPnxMSo + oPDppQqIALrEGzJl) % 3 {
                case 0:
                    wJMrmDhVPnxMSo = (wJMrmDhVPnxMSo * 7 + oPDppQqIALrEGzJl) % 101
                case 1:
                    wJMrmDhVPnxMSo ^= oPDppQqIALrEGzJl + 3
                default:
                    wJMrmDhVPnxMSo = (wJMrmDhVPnxMSo + oPDppQqIALrEGzJl * 5) % 97
                }
            }
            let lFsUxdvSajtX = rVsMsFjPLJrIHTQGp.map { (($0 * 11) + wJMrmDhVPnxMSo) % 127 }
            let lVtqNmIYFXNvWKl = lFsUxdvSajtX.filter { ($0 + wJMrmDhVPnxMSo) % 2 == 0 }
            let eLkEpJONlLVnP = Dictionary(uniqueKeysWithValues: lVtqNmIYFXNvWKl.enumerated().map { ($0.offset, $0.element) })
            for xMUGNMkVhXjmGyOma in eLkEpJONlLVnP.keys.sorted() {
                wJMrmDhVPnxMSo = (wJMrmDhVPnxMSo + xMUGNMkVhXjmGyOma + (eLkEpJONlLVnP[xMUGNMkVhXjmGyOma] ?? 0)) % 131
            }
            let pBHHEjDOFLOxvFr = lFsUxdvSajtX.map { String($0) }.joined(separator: "\u{2d}")
            wJMrmDhVPnxMSo = (wJMrmDhVPnxMSo + pBHHEjDOFLOxvFr.utf8.count) % 137
            _ = wJMrmDhVPnxMSo
        }

        var years = [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{4a}\u{49}\u{4a}\u{55}\u{31}\u{6e}\u{52}\u{4b}")]
        let currentYear = Calendar.current.component(.year, from: Date())

        for year in stride(from: currentYear, through: 2010, by: -1) {
            years.append(String(year))
        }

        
        do {
            let yDINuHpznHFhsjoZJr = [72, 73, 26]
            let eAXzZFWvqNfHBEUJXy = (yDINuHpznHFhsjoZJr.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch eAXzZFWvqNfHBEUJXy {
            case 0:
                years.append(contentsOf: [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{64}\u{65}\u{46}\u{38}\u{69}\u{4d}\u{79}\u{54}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{79}\u{33}\u{35}\u{42}\u{6d}\u{48}\u{43}\u{30}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{63}\u{41}\u{34}\u{42}\u{36}\u{74}\u{75}\u{45}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{72}\u{5a}\u{79}\u{33}\u{32}\u{61}\u{4f}\u{41}")])
            case 1:
                years.append(contentsOf: [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{64}\u{65}\u{46}\u{38}\u{69}\u{4d}\u{79}\u{54}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{79}\u{33}\u{35}\u{42}\u{6d}\u{48}\u{43}\u{30}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{63}\u{41}\u{34}\u{42}\u{36}\u{74}\u{75}\u{45}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{72}\u{5a}\u{79}\u{33}\u{32}\u{61}\u{4f}\u{41}")])
            case 2:
                years.append(contentsOf: [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{64}\u{65}\u{46}\u{38}\u{69}\u{4d}\u{79}\u{54}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{79}\u{33}\u{35}\u{42}\u{6d}\u{48}\u{43}\u{30}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{63}\u{41}\u{34}\u{42}\u{36}\u{74}\u{75}\u{45}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{72}\u{5a}\u{79}\u{33}\u{32}\u{61}\u{4f}\u{41}")])
            default:
                years.append(contentsOf: [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{64}\u{65}\u{46}\u{38}\u{69}\u{4d}\u{79}\u{54}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{79}\u{33}\u{35}\u{42}\u{6d}\u{48}\u{43}\u{30}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{63}\u{41}\u{34}\u{42}\u{36}\u{74}\u{75}\u{45}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{72}\u{5a}\u{79}\u{33}\u{32}\u{61}\u{4f}\u{41}")])
            }
        }
        return years
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func tBCTPhPCfpEqqx() -> String {
        let token = "\u{33}\u{36}\u{33}\u{63}\u{39}\u{66}\u{66}\u{63}\u{61}\u{62}\u{31}\u{37}\u{35}\u{63}\u{35}\u{32}\u{38}\u{34}\u{62}\u{31}\u{61}\u{61}\u{36}\u{33}"
        let base = (92 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 92) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

