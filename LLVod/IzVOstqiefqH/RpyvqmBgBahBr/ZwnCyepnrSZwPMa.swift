




import Foundation

struct NcGaOMWDRCxuwcelC: Codable {
    var leading: Double = 0
    var trail: Double = 0
}

final class RxbPMsCcpduVwpgF {
    static let shared = RxbPMsCcpduVwpgF()

    private let key = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{64}\u{74}\u{31}\u{56}\u{57}\u{4d}\u{47}\u{76}")

    func mNdIvDOdTBGd() -> NcGaOMWDRCxuwcelC {
        // source-obfuscator:padding:v1
        _ = Self.vNgpSuinDvJlCR()

        guard
            let data = UserDefaults.standard.data(forKey: key),
            let settings = try? JSONDecoder().decode(NcGaOMWDRCxuwcelC.self, from: data)
        else {
            return NcGaOMWDRCxuwcelC()
        }
        return settings
    }

    func uQiRGvOGsxhONiRQPPbC(_ settings: NcGaOMWDRCxuwcelC) {
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func vNgpSuinDvJlCR() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 95, "\u{65}\u{61}\u{73}\u{74}": 102, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 665]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 95) * 7
        let token = "\u{36}\u{33}\u{35}\u{30}\u{37}\u{64}\u{30}\u{63}\u{33}\u{66}\u{33}\u{31}\u{37}\u{66}\u{38}\u{39}\u{63}\u{32}\u{63}\u{36}\u{64}\u{66}\u{66}\u{62}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}

