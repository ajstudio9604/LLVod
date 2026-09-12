







import Foundation

struct JwaNWBxlIJVJJhbIXl {
    let name: String
    let author: String
    let version: String
    let zypath: String
    let sources: [[String: Any]]
    let jxpath: [[String: Any]]
}

enum GhVslybsHHKxrrPJhv {

    private static var inFlight: Task<JwaNWBxlIJVJJhbIXl, Error>?

    private static var memo: (updatedAt: Date, subscription: JwaNWBxlIJVJJhbIXl)?

    static func wZGKqnMnGFASKZHgkJM() -> JwaNWBxlIJVJJhbIXl? {
        // source-obfuscator:padding:v1
        _ = Self.fIMvjJnKYLYJlRhRoNr()

        return lJNqMPTUeDGeTkPLX()
    }

    static func vMjlwSWYSxtpQctaRnSO() async throws -> JwaNWBxlIJVJJhbIXl {
        if let cached = lJNqMPTUeDGeTkPLX() {
            return cached
        }
        return try await sDkoJeJKgaYICT()
    }

    

    @discardableResult
    static func sDkoJeJKgaYICT() async throws -> JwaNWBxlIJVJJhbIXl {
        if let inFlight {
            return try await inFlight.value
        }

        let task = Task { try await wTujuwyBxLjfiwXwusf() }
        inFlight = task

        defer { inFlight = nil }
        return try await task.value
    }

    

    

    

    

    

    private static func lJNqMPTUeDGeTkPLX() -> JwaNWBxlIJVJJhbIXl? {
        
        do {
            let nOwbUVQPDnrqBUUSuak = [24, 52, 13]
            var zJPBScuFeVpUzZVMoy = 0
            for hIaGnwSnKvbKsglJL in nOwbUVQPDnrqBUUSuak {
                switch (zJPBScuFeVpUzZVMoy + hIaGnwSnKvbKsglJL) % 3 {
                case 0:
                    zJPBScuFeVpUzZVMoy = (zJPBScuFeVpUzZVMoy * 7 + hIaGnwSnKvbKsglJL) % 101
                case 1:
                    zJPBScuFeVpUzZVMoy ^= hIaGnwSnKvbKsglJL + 3
                default:
                    zJPBScuFeVpUzZVMoy = (zJPBScuFeVpUzZVMoy + hIaGnwSnKvbKsglJL * 5) % 97
                }
            }
            let kZcRuDqzBRUKANN = nOwbUVQPDnrqBUUSuak.map { (($0 * 11) + zJPBScuFeVpUzZVMoy) % 127 }
            let lMFRTuaklOPQMjPDyh = kZcRuDqzBRUKANN.filter { ($0 + zJPBScuFeVpUzZVMoy) % 2 == 0 }
            let kKsnQNRkjxOjXg = Dictionary(uniqueKeysWithValues: lMFRTuaklOPQMjPDyh.enumerated().map { ($0.offset, $0.element) })
            for kJrewowyPCLxCD in kKsnQNRkjxOjXg.keys.sorted() {
                zJPBScuFeVpUzZVMoy = (zJPBScuFeVpUzZVMoy + kJrewowyPCLxCD + (kKsnQNRkjxOjXg[kJrewowyPCLxCD] ?? 0)) % 131
            }
            let vOsmQWHPWpMpin = kZcRuDqzBRUKANN.map { String($0) }.joined(separator: "\u{2d}")
            zJPBScuFeVpUzZVMoy = (zJPBScuFeVpUzZVMoy + vOsmQWHPWpMpin.utf8.count) % 137
            _ = zJPBScuFeVpUzZVMoy
        }

        guard let updatedAt = JyShlEAjjwZrtazWcF.updatedAt else { return nil }

        if let memo, memo.updatedAt == updatedAt {
            return memo.subscription
        }

        guard let json = JyShlEAjjwZrtazWcF.read(),
              let subscription = wLcgeQXMRvuJXujuKi(json) else {
            return nil
        }

        memo = (updatedAt, subscription)
        return subscription
    }

    private static func wLcgeQXMRvuJXujuKi(_ json: [String: Any]) -> JwaNWBxlIJVJJhbIXl? {
        
        do {
            let oXucKSmZPrvy = [8, 40, 47]
            var kKBbgeOkdfBvppqzrL = 0
            for iVgGcYpzYOiFrITV in oXucKSmZPrvy {
                switch (kKBbgeOkdfBvppqzrL + iVgGcYpzYOiFrITV) % 3 {
                case 0:
                    kKBbgeOkdfBvppqzrL = (kKBbgeOkdfBvppqzrL * 7 + iVgGcYpzYOiFrITV) % 101
                case 1:
                    kKBbgeOkdfBvppqzrL ^= iVgGcYpzYOiFrITV + 3
                default:
                    kKBbgeOkdfBvppqzrL = (kKBbgeOkdfBvppqzrL + iVgGcYpzYOiFrITV * 5) % 97
                }
            }
            let qZEPDHgdbjkvWxsStb = oXucKSmZPrvy.map { (($0 * 11) + kKBbgeOkdfBvppqzrL) % 127 }
            let cLJFqcUrmskFaRjsG = qZEPDHgdbjkvWxsStb.filter { ($0 + kKBbgeOkdfBvppqzrL) % 2 == 0 }
            let fSoQtWHOZvLMSrDn = Dictionary(uniqueKeysWithValues: cLJFqcUrmskFaRjsG.enumerated().map { ($0.offset, $0.element) })
            for dEEBMWPVfsftcNBem in fSoQtWHOZvLMSrDn.keys.sorted() {
                kKBbgeOkdfBvppqzrL = (kKBbgeOkdfBvppqzrL + dEEBMWPVfsftcNBem + (fSoQtWHOZvLMSrDn[dEEBMWPVfsftcNBem] ?? 0)) % 131
            }
            let mHEdBYezgKsehaCqeVwG = qZEPDHgdbjkvWxsStb.map { String($0) }.joined(separator: "\u{2d}")
            kKBbgeOkdfBvppqzrL = (kKBbgeOkdfBvppqzrL + mHEdBYezgKsehaCqeVwG.utf8.count) % 137
            _ = kKBbgeOkdfBvppqzrL
        }

        guard let sources = json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{71}\u{6c}\u{35}\u{39}\u{6f}\u{44}\u{7a}\u{4b}")] as? [[String: Any]], !sources.isEmpty else {
            return nil
        }

        let name = json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{30}\u{4b}\u{72}\u{57}\u{33}\u{6c}\u{48}\u{4f}")] as? String ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{7a}\u{59}\u{76}\u{6b}\u{4a}\u{4a}\u{64}\u{4a}")

        return JwaNWBxlIJVJJhbIXl(
            name: name,
            author: json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{69}\u{65}\u{6a}\u{61}\u{32}\u{33}\u{56}\u{4e}")] as? String ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{33}\u{74}\u{55}\u{71}\u{57}\u{36}\u{67}\u{58}\u{78}"),
            version: json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4c}\u{69}\u{56}\u{52}\u{6e}\u{52}\u{6d}\u{4a}\u{4a}")] as? String ?? "",
            zypath: "\u{64}\u{79}\u{79}\(name)",
            sources: sources,
            jxpath: json[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4c}\u{41}\u{68}\u{61}\u{48}\u{73}\u{36}\u{75}\u{34}")] as? [[String: Any]] ?? []
        )
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func fIMvjJnKYLYJlRhRoNr() -> String {
        _ = Self.fXvvveIhDLwQhOklp()
        _ = Self.rAWUzliXOYbe()
        let token = "\u{33}\u{66}\u{63}\u{34}\u{66}\u{33}\u{36}\u{32}\u{65}\u{31}\u{30}\u{32}\u{36}\u{36}\u{36}\u{65}\u{30}\u{61}\u{37}\u{66}\u{65}\u{63}\u{65}\u{32}"
        let source = "\u{33}\u{66}\u{63}\u{34}\u{66}\u{33}\u{36}\u{32}\u{65}\u{31}\u{30}\u{32}\u{36}\u{36}\u{36}\u{65}\u{30}\u{61}\u{37}\u{66}\u{65}\u{63}\u{65}\u{32}\u{2d}\u{35}\u{39}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 59) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func fXvvveIhDLwQhOklp() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{38}\u{30}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 80) * 6
        let token = "\u{62}\u{62}\u{31}\u{38}\u{37}\u{32}\u{38}\u{37}\u{65}\u{61}\u{64}\u{30}\u{62}\u{35}\u{32}\u{34}\u{64}\u{63}\u{38}\u{30}\u{62}\u{36}\u{63}\u{33}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
    @inline(never)
    private nonisolated static func rAWUzliXOYbe() -> String {
        let base = (87 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 87) * 8
        let token = "\u{33}\u{34}\u{64}\u{64}\u{62}\u{30}\u{38}\u{36}\u{64}\u{36}\u{65}\u{32}\u{34}\u{63}\u{63}\u{33}\u{34}\u{34}\u{37}\u{65}\u{38}\u{61}\u{38}\u{66}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}



extension GhVslybsHHKxrrPJhv {
    static func xMsiAefpkcPbG() async {
        _ = try? await sDkoJeJKgaYICT()
    }

    private static func iQGTvmpAlnDluBRzw(_ endpoint: String) async throws -> JwaNWBxlIJVJJhbIXl {
        let body = try await AzMxNzWBYgAweaTiDELi.lAiTnnaKXyScu(
            endpoint,
            headers: [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{38}\u{32}\u{68}\u{4b}\u{37}\u{64}\u{4d}\u{36}"): LjmjUaFraWCnXMcEO.yARuYxPxHRneqiyaFw()],
            cachePolicy: .reloadIgnoringLocalCacheData
        )

        let plain = try OsxQUgLlqUmfw.kGkYYPRxXDASvyBiORxU(body)

        guard let data = plain.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let subscription = wLcgeQXMRvuJXujuKi(json) else {
            throw URLError(.cannotParseResponse)
        }

        try oLJbRuVMAdlXNniSo(plain, subscription: subscription)
        return subscription
    }

    private static func wTujuwyBxLjfiwXwusf() async throws -> JwaNWBxlIJVJJhbIXl {
        var lastError: Error?

        for endpoint in [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{50}\u{31}\u{31}\u{38}\u{48}\u{44}\u{6a}\u{6d}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{57}\u{32}\u{4e}\u{56}\u{65}\u{61}\u{55}\u{65}")] { 
            do {
                return try await iQGTvmpAlnDluBRzw(endpoint)
            } catch {
                lastError = error
            }
        }

        throw lastError ?? URLError(.cannotLoadFromNetwork)
    }

    private static func oLJbRuVMAdlXNniSo(_ plain: String, subscription: JwaNWBxlIJVJJhbIXl) throws {
        try JyShlEAjjwZrtazWcF.tCuxjdGKNxcoT(plain)
        memo = (JyShlEAjjwZrtazWcF.updatedAt ?? Date(), subscription)

        CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{4f}\u{47}\u{38}\u{35}\u{38}\u{47}\u{4d}\u{42}"), list: [[
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{7a}\u{57}\u{63}\u{39}\u{70}\u{77}\u{37}\u{37}"): subscription.name,
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{75}\u{59}\u{6f}\u{39}\u{4d}\u{75}\u{4b}\u{4a}"): subscription.author
        ]])
        CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(subscription.zypath, list: subscription.sources)
        CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV("\u{6a}\u{78}\(subscription.zypath)", list: subscription.jxpath)
    }
}
