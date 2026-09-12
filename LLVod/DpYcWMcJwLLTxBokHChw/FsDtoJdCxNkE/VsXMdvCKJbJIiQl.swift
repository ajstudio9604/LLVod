






import Foundation

enum AniKjrmweMtR {

    private static let host = "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{66}\u{72}\u{6f}\u{64}\u{6f}\u{2e}\u{64}\u{6f}\u{75}\u{62}\u{61}\u{6e}\u{2e}\u{63}\u{6f}\u{6d}"
    private static let apikey = "\u{30}\u{64}\u{61}\u{64}\u{35}\u{35}\u{31}\u{65}\u{63}\u{30}\u{66}\u{38}\u{34}\u{65}\u{64}\u{30}\u{32}\u{39}\u{30}\u{37}\u{66}\u{66}\u{35}\u{63}\u{34}\u{32}\u{65}\u{38}\u{65}\u{63}\u{37}\u{30}"
    private static let signSecret = "\u{62}\u{66}\u{37}\u{64}\u{64}\u{64}\u{63}\u{37}\u{63}\u{39}\u{63}\u{66}\u{65}\u{36}\u{66}\u{37}"

    private static let unreservedCharacters = CharacterSet(
        charactersIn: "\u{41}\u{42}\u{43}\u{44}\u{45}\u{46}\u{47}\u{48}\u{49}\u{4a}\u{4b}\u{4c}\u{4d}\u{4e}\u{4f}\u{50}\u{51}\u{52}\u{53}\u{54}\u{55}\u{56}\u{57}\u{58}\u{59}\u{5a}\u{61}\u{62}\u{63}\u{64}\u{65}\u{66}\u{67}\u{68}\u{69}\u{6a}\u{6b}\u{6c}\u{6d}\u{6e}\u{6f}\u{70}\u{71}\u{72}\u{73}\u{74}\u{75}\u{76}\u{77}\u{78}\u{79}\u{7a}\u{30}\u{31}\u{32}\u{33}\u{34}\u{35}\u{36}\u{37}\u{38}\u{39}\u{2d}\u{5f}\u{2e}\u{21}\u{7e}\u{2a}\u{27}\u{28}\u{29}"
    )

    static func rGoBpQdxzjbCfr(
        path: String,
        extraQuery: [URLQueryItem] = [],
        session: URLSession = .shared
    ) async throws -> Data {
        // source-obfuscator:padding:v1
        _ = Self.gOGSeqUyHrYdZAreYur()

        let time = Int(Date().timeIntervalSince1970)
        let udid = xXwnnfygjsmv()
        let endpoint = host + path

        let arg1 = path.replacingOccurrences(of: "\u{2f}", with: "\u{25}\u{32}\u{46}")
        let signInput = "\u{47}\u{45}\u{54}\u{26}\(arg1)\u{26}\(time)"
        let sig = try QxmEAOwBLRLGNSse.oGIWvvvfdhBliJGHfm(signInput, secret: signSecret, outputBase64: true)

        guard var components = URLComponents(string: endpoint) else {
            throw IrxblUEoPFOBtF.invalidURL
        }

        var items: [URLQueryItem] = [
            URLQueryItem(name: "\u{75}\u{64}\u{69}\u{64}", value: udid),
            URLQueryItem(name: "\u{75}\u{75}\u{69}\u{64}", value: udid),
            URLQueryItem(name: "\u{72}\u{6f}\u{6d}", value: "\u{61}\u{6e}\u{64}\u{72}\u{6f}\u{69}\u{64}"),
            URLQueryItem(name: "\u{61}\u{70}\u{69}\u{6b}\u{65}\u{79}", value: apikey),
            URLQueryItem(name: "\u{73}", value: "\u{72}\u{65}\u{78}\u{78}\u{61}\u{72}\u{5f}\u{6e}\u{65}\u{77}"),
            URLQueryItem(name: "\u{63}\u{68}\u{61}\u{6e}\u{6e}\u{65}\u{6c}", value: "\u{59}\u{69}\u{6e}\u{67}\u{79}\u{6f}\u{6e}\u{67}\u{62}\u{61}\u{6f}\u{5f}\u{4d}\u{61}\u{72}\u{6b}\u{65}\u{74}"),
            URLQueryItem(name: "\u{74}\u{69}\u{6d}\u{65}\u{7a}\u{6f}\u{6e}\u{65}", value: "\u{41}\u{73}\u{69}\u{61}\u{2f}\u{53}\u{68}\u{61}\u{6e}\u{67}\u{68}\u{61}\u{69}"),
            URLQueryItem(name: "\u{64}\u{65}\u{76}\u{69}\u{63}\u{65}\u{5f}\u{69}\u{64}", value: udid),
            URLQueryItem(name: "\u{6f}\u{73}\u{5f}\u{72}\u{6f}\u{6d}", value: "\u{61}\u{6e}\u{64}\u{72}\u{6f}\u{69}\u{64}"),
            URLQueryItem(name: "\u{61}\u{70}\u{70}\u{6c}\u{65}", value: "\u{63}\u{35}\u{32}\u{66}\u{62}\u{62}\u{39}\u{39}\u{62}\u{39}\u{30}\u{38}\u{62}\u{65}\u{34}\u{64}\u{30}\u{32}\u{36}\u{39}\u{35}\u{34}\u{63}\u{63}\u{34}\u{33}\u{37}\u{34}\u{66}\u{31}\u{36}\u{64}"),
            URLQueryItem(name: "\u{6d}\u{6f}\u{6f}\u{6e}\u{63}\u{61}\u{6b}\u{65}", value: "\u{30}\u{66}\u{36}\u{30}\u{37}\u{32}\u{36}\u{34}\u{66}\u{63}\u{36}\u{33}\u{31}\u{38}\u{61}\u{39}\u{32}\u{62}\u{39}\u{65}\u{31}\u{33}\u{63}\u{36}\u{35}\u{64}\u{62}\u{37}\u{63}\u{64}\u{33}\u{63}"),
            URLQueryItem(name: "\u{73}\u{75}\u{67}\u{61}\u{72}", value: "\u{30}"),
            URLQueryItem(name: "\u{6c}\u{6f}\u{63}\u{5f}\u{69}\u{64}", value: "\u{30}"),
            URLQueryItem(name: "\u{5f}\u{74}\u{73}", value: String(time))
        ]
        items.append(contentsOf: extraQuery)
        components.queryItems = items

        components.percentEncodedQuery = [
            components.percentEncodedQuery,
            "\u{5f}\u{73}\u{69}\u{67}\u{3d}\(bLpyMCTqOsdOHT(sig))"
        ]
        .compactMap { $0 }
        .joined(separator: "\u{26}")

        guard let url = components.url else {
            throw IrxblUEoPFOBtF.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "\u{47}\u{45}\u{54}"
        request.timeoutInterval = 20
        request.setValue(
            """
            \u{52}\u{65}\u{78}\u{78}\u{61}\u{72}\u{2d}\u{43}\u{6f}\u{72}\u{65}\u{2f}\u{30}\u{2e}\u{31}\u{2e}\u{33} \u{61}\u{70}\u{69}\u{2d}\u{63}\u{6c}\u{69}\u{65}\u{6e}\u{74}\u{2f}\u{31} \u{63}\u{6f}\u{6d}\u{2e}\u{64}\u{6f}\u{75}\u{62}\u{61}\u{6e}\u{2e}\u{66}\u{72}\u{6f}\u{64}\u{6f}\u{2f}\u{37}\u{2e}\u{39}\u{2e}\u{30}\u{28}\u{32}\u{31}\u{36}\u{29} \
            \u{41}\u{6e}\u{64}\u{72}\u{6f}\u{69}\u{64}\u{2f}\u{32}\u{38} \u{70}\u{72}\u{6f}\u{64}\u{75}\u{63}\u{74}\u{2f}\u{58}\u{69}\u{61}\u{6f}\u{6d}\u{69}\u{31}\u{31} \u{72}\u{6f}\u{6d}\u{2f}\u{61}\u{6e}\u{64}\u{72}\u{6f}\u{69}\u{64} \u{6e}\u{65}\u{74}\u{77}\u{6f}\u{72}\u{6b}\u{2f}\u{77}\u{69}\u{66}\u{69} \u{75}\u{64}\u{69}\u{64}\u{2f}\(udid) \
            \u{70}\u{6c}\u{61}\u{74}\u{66}\u{6f}\u{72}\u{6d}\u{2f}\u{6d}\u{6f}\u{62}\u{69}\u{6c}\u{65} \u{63}\u{6f}\u{6d}\u{2e}\u{64}\u{6f}\u{75}\u{62}\u{61}\u{6e}\u{2e}\u{66}\u{72}\u{6f}\u{64}\u{6f}\u{2f}\u{37}\u{2e}\u{39}\u{2e}\u{30}\u{28}\u{32}\u{31}\u{36}\u{29} \u{52}\u{65}\u{78}\u{78}\u{61}\u{72}\u{2f}\u{31}\u{2e}\u{32}\u{2e}\u{31}\u{35}\u{31} \
            \u{70}\u{6c}\u{61}\u{74}\u{66}\u{6f}\u{72}\u{6d}\u{2f}\u{6d}\u{6f}\u{62}\u{69}\u{6c}\u{65} \u{31}\u{2e}\u{32}\u{2e}\u{31}\u{35}\u{31}
            """,
            forHTTPHeaderField: "\u{55}\u{73}\u{65}\u{72}\u{2d}\u{41}\u{67}\u{65}\u{6e}\u{74}"
        )

        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw IrxblUEoPFOBtF.invalidResponse
        }
        guard 200...299 ~= http.statusCode else {
            throw IrxblUEoPFOBtF.httpError(http.statusCode)
        }
        return data
    }

    
    
    
    static func playlists(
        category: String,
        start: Int,
        count: Int,
        session: URLSession = .shared
    ) async throws -> Data {
        try await rGoBpQdxzjbCfr(
            path: "\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{73}\u{6b}\u{79}\u{6e}\u{65}\u{74}\u{2f}\u{6e}\u{65}\u{77}\u{5f}\u{70}\u{6c}\u{61}\u{79}\u{6c}\u{69}\u{73}\u{74}\u{73}",
            extraQuery: [
                URLQueryItem(name: "\u{73}\u{75}\u{62}\u{6a}\u{65}\u{63}\u{74}\u{5f}\u{74}\u{79}\u{70}\u{65}", value: "\u{6d}\u{6f}\u{76}\u{69}\u{65}"),
                URLQueryItem(name: "\u{63}\u{61}\u{74}\u{65}\u{67}\u{6f}\u{72}\u{79}", value: category),
                URLQueryItem(name: "\u{73}\u{74}\u{61}\u{72}\u{74}", value: String(start)),
                URLQueryItem(name: "\u{63}\u{6f}\u{75}\u{6e}\u{74}", value: String(count))
            ],
            session: session
        )
    }

    
    

    

    private static func xXwnnfygjsmv() -> String {
        
        do {
            let qJRArdjJVuSsbzd = [32, 43, 70]
            var zBMjjdDeqnEyrJEJmKBZ = 0
            for qLxXCYDBiYNX in qJRArdjJVuSsbzd {
                switch (zBMjjdDeqnEyrJEJmKBZ + qLxXCYDBiYNX) % 3 {
                case 0:
                    zBMjjdDeqnEyrJEJmKBZ = (zBMjjdDeqnEyrJEJmKBZ * 7 + qLxXCYDBiYNX) % 101
                case 1:
                    zBMjjdDeqnEyrJEJmKBZ ^= qLxXCYDBiYNX + 3
                default:
                    zBMjjdDeqnEyrJEJmKBZ = (zBMjjdDeqnEyrJEJmKBZ + qLxXCYDBiYNX * 5) % 97
                }
            }
            let bBMvMaivBVrjW = qJRArdjJVuSsbzd.map { (($0 * 11) + zBMjjdDeqnEyrJEJmKBZ) % 127 }
            let oRrvKWTffnrttlAaV = bBMvMaivBVrjW.filter { ($0 + zBMjjdDeqnEyrJEJmKBZ) % 2 == 0 }
            let dNiZNkgNEtQxNmmX = Dictionary(uniqueKeysWithValues: oRrvKWTffnrttlAaV.enumerated().map { ($0.offset, $0.element) })
            for oKJwymWScHQQjq in dNiZNkgNEtQxNmmX.keys.sorted() {
                zBMjjdDeqnEyrJEJmKBZ = (zBMjjdDeqnEyrJEJmKBZ + oKJwymWScHQQjq + (dNiZNkgNEtQxNmmX[oKJwymWScHQQjq] ?? 0)) % 131
            }
            let kEkOJKjwNGoCYfJDbjP = bBMvMaivBVrjW.map { String($0) }.joined(separator: "\u{2d}")
            zBMjjdDeqnEyrJEJmKBZ = (zBMjjdDeqnEyrJEJmKBZ + kEkOJKjwNGoCYfJDbjP.utf8.count) % 137
            _ = zBMjjdDeqnEyrJEJmKBZ
        }

        let chars = Array("\u{61}\u{62}\u{63}\u{64}\u{65}\u{66}\u{67}\u{68}\u{69}\u{6a}\u{6b}\u{6c}\u{6d}\u{6e}\u{6f}\u{70}\u{71}\u{72}\u{73}\u{74}\u{75}\u{76}\u{77}\u{78}\u{79}\u{7a}\u{30}\u{31}\u{32}\u{33}\u{34}\u{35}\u{36}\u{37}\u{38}\u{39}")
        return String((0..<40).map { _ in chars.randomElement()! })
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func gOGSeqUyHrYdZAreYur() -> String {
        _ = Self.xPmXbiFlAxhjjyrFNVQ()
        let token = "\u{36}\u{30}\u{36}\u{37}\u{66}\u{32}\u{63}\u{64}\u{65}\u{32}\u{37}\u{63}\u{37}\u{34}\u{65}\u{64}\u{38}\u{39}\u{36}\u{64}\u{63}\u{31}\u{34}\u{63}"
        let base = (12 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 12) * 7
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func xPmXbiFlAxhjjyrFNVQ() -> String {
        let token = "\u{35}\u{64}\u{37}\u{36}\u{32}\u{66}\u{38}\u{37}\u{38}\u{38}\u{34}\u{35}\u{38}\u{37}\u{35}\u{36}\u{36}\u{64}\u{36}\u{35}\u{61}\u{61}\u{32}\u{39}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 25, "\u{65}\u{61}\u{73}\u{74}": 29, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 100]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 25) * 4
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



extension AniKjrmweMtR {
    private static func bLpyMCTqOsdOHT(_ value: String) -> String {
        value.addingPercentEncoding(withAllowedCharacters: unreservedCharacters) ?? value
    }

    static func zWmALwGqXcVdzUVhiFn(
        id: String,
        isDoulist: Bool,
        start: Int,
        count: Int,
        itemsOnly: String,
        session: URLSession = .shared
    ) async throws -> Data {
        let path = isDoulist
            ? "\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{64}\u{6f}\u{75}\u{6c}\u{69}\u{73}\u{74}\u{2f}\(id)\u{2f}\u{70}\u{6f}\u{73}\u{74}\u{73}"
            : "\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{73}\u{75}\u{62}\u{6a}\u{65}\u{63}\u{74}\u{5f}\u{63}\u{6f}\u{6c}\u{6c}\u{65}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\(id)\u{2f}\u{69}\u{74}\u{65}\u{6d}\u{73}"
        return try await rGoBpQdxzjbCfr(
            path: path,
            extraQuery: [
                URLQueryItem(name: "\u{73}\u{74}\u{61}\u{72}\u{74}", value: String(start)),
                URLQueryItem(name: "\u{63}\u{6f}\u{75}\u{6e}\u{74}", value: String(count)),
                URLQueryItem(name: "\u{75}\u{70}\u{64}\u{61}\u{74}\u{65}\u{64}\u{5f}\u{61}\u{74}", value: ""),
                URLQueryItem(name: "\u{69}\u{74}\u{65}\u{6d}\u{73}\u{5f}\u{6f}\u{6e}\u{6c}\u{79}", value: itemsOnly)
            ],
            session: session
        )
    }
}
