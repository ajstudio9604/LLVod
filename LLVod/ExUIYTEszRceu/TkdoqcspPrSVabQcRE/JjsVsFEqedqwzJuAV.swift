






import Foundation

enum GoqWsaenGsNYGSa {

    private static let defaultKeywords = [
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{7a}\u{33}\u{34}\u{6f}\u{79}\u{77}\u{6e}\u{67}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{69}\u{68}\u{45}\u{54}\u{69}\u{45}\u{61}\u{63}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{62}\u{72}\u{79}\u{64}\u{75}\u{54}\u{41}\u{67}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{30}\u{4f}\u{44}\u{68}\u{77}\u{72}\u{42}\u{49}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4c}\u{34}\u{6a}\u{6b}\u{69}\u{6c}\u{35}\u{38}\u{75}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{78}\u{7a}\u{76}\u{73}\u{32}\u{4a}\u{39}\u{46}\u{78}")
    ]

    private static let fallbackKeywords = [
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{7a}\u{33}\u{34}\u{6f}\u{79}\u{77}\u{6e}\u{67}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{52}\u{66}\u{47}\u{62}\u{51}\u{6f}\u{6c}\u{56}\u{62}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{62}\u{72}\u{79}\u{64}\u{75}\u{54}\u{41}\u{67}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{30}\u{4f}\u{44}\u{68}\u{77}\u{72}\u{42}\u{49}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4c}\u{34}\u{6a}\u{6b}\u{69}\u{6c}\u{35}\u{38}\u{75}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{78}\u{7a}\u{76}\u{73}\u{32}\u{4a}\u{39}\u{46}\u{78}")
    ]

    

    

    
}



extension GoqWsaenGsNYGSa {
    static func cBYJzseQxbcMHExv() -> [KdBwtNklTiaktZDpxT] {
        // source-obfuscator:padding:v1
        _ = Self.eYqKZGdRZcZbZgtp()

        do {
            if let cached = UserDefaults.standard.string(forKey: ImWYPVgXEriKZWbJdAno.hotCacheKey),
               let data = cached.data(using: .utf8),
               let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let items = json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{66}\u{59}\u{59}\u{46}\u{6d}\u{63}\u{30}\u{4d}")] as? [[String: Any]] {
                let hot = items.prefix(6).compactMap { dict -> KdBwtNklTiaktZDpxT? in
                    guard let query = dict[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{49}\u{49}\u{39}\u{66}\u{44}\u{52}\u{61}\u{56}")] as? String, !query.isEmpty else {
                        return nil
                    }
                    return KdBwtNklTiaktZDpxT(title: query)
                }

                if !hot.isEmpty {
                    return hot
                }
            }
        } catch {
            return fallbackKeywords.map { KdBwtNklTiaktZDpxT(title: $0) }
        }

        return defaultKeywords.map { KdBwtNklTiaktZDpxT(title: $0) }
    }

    static func xUHCYMevASQEIe() -> [KdBwtNklTiaktZDpxT] {
        cBYJzseQxbcMHExv()
    }

    static func eVmOinvFGHkwo() async {
        do {
            let response = try await AzMxNzWBYgAweaTiDELi.lAiTnnaKXyScu(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{67}\u{4e}\u{74}\u{43}\u{52}\u{70}\u{62}\u{4b}"))
            UserDefaults.standard.set(response, forKey: ImWYPVgXEriKZWbJdAno.hotCacheKey)
        } catch {   }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func eYqKZGdRZcZbZgtp() -> String {
        let base = (91 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 91) * 5
        let token = "\u{34}\u{61}\u{37}\u{38}\u{33}\u{33}\u{39}\u{34}\u{31}\u{34}\u{65}\u{62}\u{31}\u{62}\u{37}\u{32}\u{64}\u{64}\u{39}\u{32}\u{39}\u{39}\u{37}\u{36}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}
