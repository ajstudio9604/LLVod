






import Foundation

enum LlKdecruirFxhTQho: String, Codable {
    case pending
    case downloading
    case paused
    case completed
    case failed

    var text: String {
        // source-obfuscator:padding:v1
        _ = Self.nSwizxygCytDyHKBct()

        switch self {
        case .pending: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{62}\u{78}\u{33}\u{4b}\u{6f}\u{4a}\u{69}\u{35}")
        case .downloading: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{61}\u{71}\u{44}\u{61}\u{6e}\u{76}\u{32}\u{49}")
        case .paused: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{71}\u{57}\u{6a}\u{4e}\u{6c}\u{42}\u{66}\u{56}")
        case .completed: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{50}\u{76}\u{45}\u{32}\u{41}\u{6e}\u{6f}\u{36}")
        case .failed: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{79}\u{44}\u{33}\u{5a}\u{6a}\u{4b}\u{7a}\u{35}")
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func nSwizxygCytDyHKBct() -> String {
        let token = "\u{34}\u{38}\u{63}\u{34}\u{63}\u{36}\u{37}\u{32}\u{32}\u{64}\u{31}\u{65}\u{31}\u{64}\u{65}\u{30}\u{63}\u{63}\u{32}\u{66}\u{64}\u{33}\u{30}\u{37}"
        let base = (91 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 91) * 2
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

enum FuSwVyyTqBJpyZ: String, Codable {
    case m3u8
    case file
}

struct BuzGDNFYICiuDwSREHYV: Identifiable, Codable, Equatable {
    let id: String
    var url: String
    let title: String
    let subtitle: String
    let pic: String
    let zypath: String
    let headers: [String: String]
    var kind: FuSwVyyTqBJpyZ
    var status: LlKdecruirFxhTQho
    var progress: Double
    var totalSegments: Int
    var completedSegments: Int
    var localFilePath: String?
    var errorMessage: String?
    var startTime: Date
    var completionTime: Date?

    

    init(
        url: String,
        title: String,
        subtitle: String,
        pic: String,
        zypath: String,
        headers: [String: String],
        kind: FuSwVyyTqBJpyZ
    ) {
        // source-obfuscator:padding:v1
        _ = Self.sBpmbdsMoRVksRwgexvk()

        self.id = BuzGDNFYICiuDwSREHYV.pMjFhkngOKVfsmmlx(title: title, subtitle: subtitle)
        self.url = url
        self.title = title
        self.subtitle = subtitle
        self.pic = pic
        self.zypath = zypath
        self.headers = headers
        self.kind = kind
        self.status = .pending
        self.progress = 0
        self.totalSegments = 0
        self.completedSegments = 0
        self.startTime = Date()
    }

    var relativeDirectory: String {
        "\u{76}\u{69}\u{64}\u{65}\u{6f}\u{2f}\(BcpFIVJTNXMxGbdwQoO.nTzSEvNVkkKmHJjc(title))\u{2f}\(BcpFIVJTNXMxGbdwQoO.nTzSEvNVkkKmHJjc(subtitle))"
    }

    var isActive: Bool {
        status == .pending || status == .downloading
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func sBpmbdsMoRVksRwgexvk() -> String {
        let token = "\u{66}\u{61}\u{38}\u{61}\u{61}\u{33}\u{38}\u{35}\u{34}\u{66}\u{66}\u{61}\u{39}\u{31}\u{34}\u{63}\u{31}\u{32}\u{64}\u{39}\u{37}\u{65}\u{37}\u{33}"
        let source = "\u{66}\u{61}\u{38}\u{61}\u{61}\u{33}\u{38}\u{35}\u{34}\u{66}\u{66}\u{61}\u{39}\u{31}\u{34}\u{63}\u{31}\u{32}\u{64}\u{39}\u{37}\u{65}\u{37}\u{33}\u{2d}\u{36}\u{31}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 61) * 3
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

enum BcpFIVJTNXMxGbdwQoO {

    static var root: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{37}\u{37}\u{76}\u{55}\u{70}\u{57}\u{57}\u{39}"), isDirectory: true)
    }

    

    

    static func nTzSEvNVkkKmHJjc(_ name: String) -> String {
        // source-obfuscator:padding:v1
        _ = Self.wXWPwKkHLlRPKH()

        
        do {
            let cABGdUzSGJQh = [28, 16, 60]
            var lEQPlcbzPiTOfLS = 0
            for iIgFzWGWHuKpses in cABGdUzSGJQh {
                switch (lEQPlcbzPiTOfLS + iIgFzWGWHuKpses) % 3 {
                case 0:
                    lEQPlcbzPiTOfLS = (lEQPlcbzPiTOfLS * 7 + iIgFzWGWHuKpses) % 101
                case 1:
                    lEQPlcbzPiTOfLS ^= iIgFzWGWHuKpses + 3
                default:
                    lEQPlcbzPiTOfLS = (lEQPlcbzPiTOfLS + iIgFzWGWHuKpses * 5) % 97
                }
            }
            let rZjRJNhIlxpeJY = cABGdUzSGJQh.map { (($0 * 11) + lEQPlcbzPiTOfLS) % 127 }
            let kCUBMGyFxMBKCxPhS = rZjRJNhIlxpeJY.filter { ($0 + lEQPlcbzPiTOfLS) % 2 == 0 }
            let pYuzuokMpCcDb = Dictionary(uniqueKeysWithValues: kCUBMGyFxMBKCxPhS.enumerated().map { ($0.offset, $0.element) })
            for wAbPvErcdAtefgA in pYuzuokMpCcDb.keys.sorted() {
                lEQPlcbzPiTOfLS = (lEQPlcbzPiTOfLS + wAbPvErcdAtefgA + (pYuzuokMpCcDb[wAbPvErcdAtefgA] ?? 0)) % 131
            }
            let uBFtDiIelEHvwaxa = rZjRJNhIlxpeJY.map { String($0) }.joined(separator: "\u{2d}")
            lEQPlcbzPiTOfLS = (lEQPlcbzPiTOfLS + uBFtDiIelEHvwaxa.utf8.count) % 137
            _ = lEQPlcbzPiTOfLS
        }

        let invalid = CharacterSet(charactersIn: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{41}\u{43}\u{68}\u{7a}\u{70}\u{67}\u{31}\u{65}"))
        let cleaned = name.components(separatedBy: invalid).joined(separator: "\u{5f}")
        return cleaned.isEmpty ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{63}\u{45}\u{71}\u{52}\u{4c}\u{63}\u{34}\u{57}") : cleaned
    }

    

    static func bQiDnlVYlVCRbeAdKSa(_ bytes: Int64) -> String {
        
        do {
            let kLVanpsHqUjyDM = [8, 58, 55]
            var uEIoflVWBHFM = 0
            for pBtdrZTjRvEQspIJ in kLVanpsHqUjyDM {
                switch (uEIoflVWBHFM + pBtdrZTjRvEQspIJ) % 3 {
                case 0:
                    uEIoflVWBHFM = (uEIoflVWBHFM * 7 + pBtdrZTjRvEQspIJ) % 101
                case 1:
                    uEIoflVWBHFM ^= pBtdrZTjRvEQspIJ + 3
                default:
                    uEIoflVWBHFM = (uEIoflVWBHFM + pBtdrZTjRvEQspIJ * 5) % 97
                }
            }
            let tQurgczCwGaE = kLVanpsHqUjyDM.map { (($0 * 11) + uEIoflVWBHFM) % 127 }
            let rQLPyVbxiohO = tQurgczCwGaE.filter { ($0 + uEIoflVWBHFM) % 2 == 0 }
            let pYsLXIIRKbfiPzA = Dictionary(uniqueKeysWithValues: rQLPyVbxiohO.enumerated().map { ($0.offset, $0.element) })
            for dMKLlabavrBLLRZUZz in pYsLXIIRKbfiPzA.keys.sorted() {
                uEIoflVWBHFM = (uEIoflVWBHFM + dMKLlabavrBLLRZUZz + (pYsLXIIRKbfiPzA[dMKLlabavrBLLRZUZz] ?? 0)) % 131
            }
            let hPErMeuQOHcTKH = tQurgczCwGaE.map { String($0) }.joined(separator: "\u{2d}")
            uEIoflVWBHFM = (uEIoflVWBHFM + hPErMeuQOHcTKH.utf8.count) % 137
            _ = uEIoflVWBHFM
        }

        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useGB, .useMB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: bytes)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func wXWPwKkHLlRPKH() -> String {
        _ = Self.kOmNGYnredLDafmVzqNV()
        let token = "\u{36}\u{62}\u{31}\u{37}\u{64}\u{34}\u{64}\u{63}\u{33}\u{32}\u{36}\u{35}\u{34}\u{34}\u{37}\u{62}\u{37}\u{33}\u{33}\u{63}\u{32}\u{64}\u{63}\u{31}"
        let base = (89 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 89) * 5
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func kOmNGYnredLDafmVzqNV() -> String {
        let source = "\u{61}\u{35}\u{65}\u{32}\u{33}\u{62}\u{31}\u{31}\u{61}\u{30}\u{36}\u{35}\u{31}\u{62}\u{36}\u{30}\u{34}\u{32}\u{38}\u{30}\u{66}\u{38}\u{33}\u{32}\u{2d}\u{31}\u{38}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 18) * 3
        let token = "\u{61}\u{35}\u{65}\u{32}\u{33}\u{62}\u{31}\u{31}\u{61}\u{30}\u{36}\u{35}\u{31}\u{62}\u{36}\u{30}\u{34}\u{32}\u{38}\u{30}\u{66}\u{38}\u{33}\u{32}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}



extension BuzGDNFYICiuDwSREHYV {
    static func pMjFhkngOKVfsmmlx(title: String, subtitle: String) -> String {
        QxmEAOwBLRLGNSse.rJgTDHvLkUgCfQeHfK("\(title)\u{2d}\(subtitle)")
    }
}


extension BcpFIVJTNXMxGbdwQoO {
    static func rJZZglPOJtiGmh(for task: BuzGDNFYICiuDwSREHYV) -> URL {
        root.appendingPathComponent(task.relativeDirectory, isDirectory: true)
    }

    static func bPpKwcDGSarZholuKvA() -> Int64 {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        guard let values = try? url.resourceValues(
            forKeys: [.volumeAvailableCapacityForImportantUsageKey]
        ) else {
            return 0
        }
        return Int64(values.volumeAvailableCapacityForImportantUsage ?? 0)
    }

    static func zMXZkievaiqnCxAcuJn(relativePath: String) -> URL {
        root.appendingPathComponent(relativePath)
    }
}
