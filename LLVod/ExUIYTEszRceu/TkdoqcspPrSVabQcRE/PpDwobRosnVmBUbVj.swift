






import Foundation

enum KhwwtnFdXURelyOHB: LocalizedError {
    case subscriptionUnavailable
    case noEnabledSubscription
    case noSources(String)

    var errorDescription: String? {
        // source-obfuscator:padding:v1
        _ = Self.gURnbHNcbcoevgLcqYnO()

        switch self {
        case .subscriptionUnavailable:
            return ""
        case .noEnabledSubscription:
            return ""
        case .noSources(let title):
            return ""
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func gURnbHNcbcoevgLcqYnO() -> String {
        let base = (79 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 79) * 2
        let token = "\u{36}\u{66}\u{35}\u{63}\u{39}\u{32}\u{64}\u{32}\u{35}\u{66}\u{65}\u{63}\u{31}\u{35}\u{38}\u{36}\u{61}\u{30}\u{32}\u{37}\u{64}\u{65}\u{30}\u{34}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

struct HvqNROnXTVdqzVR {
    let title: String
    let zypath: String
    let sources: [[String: Any]]
}

enum IgQraPLdWxFYQgtQZvD {

    

    

    private static func lYWafNQEFasAzHBMZvV(
        from subscriptions: [[String: Any]]
    ) -> (title: String, item: [String: Any])? {
        // source-obfuscator:padding:v1
        _ = Self.cLomOpzfuVPv()

        
        do {
            let aJJBvkuoOVjy = [37, 23, 32]
            var eLYpqcmOKCbb = 0
            for fAcWmEClmjuLvrCRGnXV in aJJBvkuoOVjy {
                switch (eLYpqcmOKCbb + fAcWmEClmjuLvrCRGnXV) % 3 {
                case 0:
                    eLYpqcmOKCbb = (eLYpqcmOKCbb * 7 + fAcWmEClmjuLvrCRGnXV) % 101
                case 1:
                    eLYpqcmOKCbb ^= fAcWmEClmjuLvrCRGnXV + 3
                default:
                    eLYpqcmOKCbb = (eLYpqcmOKCbb + fAcWmEClmjuLvrCRGnXV * 5) % 97
                }
            }
            let hUoVBrmiveMehHZNSbT = aJJBvkuoOVjy.map { (($0 * 11) + eLYpqcmOKCbb) % 127 }
            let tIsiwFflOyAhI = hUoVBrmiveMehHZNSbT.filter { ($0 + eLYpqcmOKCbb) % 2 == 0 }
            let aWIbbjcfLFiYlkhjVcS = Dictionary(uniqueKeysWithValues: tIsiwFflOyAhI.enumerated().map { ($0.offset, $0.element) })
            for iQFakKNyYPPFrsxV in aWIbbjcfLFiYlkhjVcS.keys.sorted() {
                eLYpqcmOKCbb = (eLYpqcmOKCbb + iQFakKNyYPPFrsxV + (aWIbbjcfLFiYlkhjVcS[iQFakKNyYPPFrsxV] ?? 0)) % 131
            }
            let aVJPYWkwNvdvlN = hUoVBrmiveMehHZNSbT.map { String($0) }.joined(separator: "\u{2d}")
            eLYpqcmOKCbb = (eLYpqcmOKCbb + aVJPYWkwNvdvlN.utf8.count) % 137
            _ = eLYpqcmOKCbb
        }

        for item in subscriptions {
            guard let title = item[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{7a}\u{57}\u{63}\u{39}\u{70}\u{77}\u{37}\u{37}")] as? String, !title.isEmpty else {
                continue
            }

            if CxWPAnqmBQWGgWkAY.zRgroAFqeZPrwnWz(title: title) {
                return (title, item)
            }
        }
        return nil
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func cLomOpzfuVPv() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 65, "\u{65}\u{61}\u{73}\u{74}": 67, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 130]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 65) * 2
        let token = "\u{39}\u{61}\u{33}\u{31}\u{32}\u{30}\u{66}\u{61}\u{33}\u{65}\u{66}\u{64}\u{37}\u{35}\u{30}\u{32}\u{36}\u{31}\u{34}\u{36}\u{63}\u{63}\u{37}\u{33}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}



extension IgQraPLdWxFYQgtQZvD {
    private static func yJbjoAXoTDhqvmp() throws -> HvqNROnXTVdqzVR {
        let subscriptions = CxWPAnqmBQWGgWkAY.wHZBVdSuuCSi(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{4f}\u{47}\u{38}\u{35}\u{38}\u{47}\u{4d}\u{42}"))
        guard !subscriptions.isEmpty else {
            throw KhwwtnFdXURelyOHB.subscriptionUnavailable
        }

        guard let active = lYWafNQEFasAzHBMZvV(from: subscriptions) else {
            throw KhwwtnFdXURelyOHB.noEnabledSubscription
        }

        let zypath = "\u{64}\u{79}\u{79}\(active.title)"
        let sources = CxWPAnqmBQWGgWkAY.wHZBVdSuuCSi(zypath)

        guard !sources.isEmpty else {
            throw KhwwtnFdXURelyOHB.noSources(active.title)
        }

        return HvqNROnXTVdqzVR(
            title: active.title,
            zypath: zypath,
            sources: sources
        )
    }

    static func oALhgFCblpTllVI() async throws -> HvqNROnXTVdqzVR {
        if let subscription = try? await GhVslybsHHKxrrPJhv.vMjlwSWYSxtpQctaRnSO() {
            CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{4f}\u{47}\u{38}\u{35}\u{38}\u{47}\u{4d}\u{42}"), list: [[
                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{7a}\u{57}\u{63}\u{39}\u{70}\u{77}\u{37}\u{37}"): subscription.name,
                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{75}\u{59}\u{6f}\u{39}\u{4d}\u{75}\u{4b}\u{4a}"): subscription.author
            ]])
            CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(subscription.zypath, list: subscription.sources)

            return HvqNROnXTVdqzVR(
                title: subscription.name,
                zypath: subscription.zypath,
                sources: subscription.sources
            )
        }

        return try yJbjoAXoTDhqvmp()
    }
}
