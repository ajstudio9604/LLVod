import Foundation

enum TvqFPAfMTlnejPqPs: Int, CaseIterable, Identifiable {
    case recommendation = 0
    case television = 1
    case movies = 2
    case anime = 3
    case variety = 4

    var id: Int {
        // source-obfuscator:padding:v1
        _ = Self.eFmrGIqBeUpFM()
 return rawValue }

    var title: String {
        switch self {
        case .recommendation: return "\u{63a8}\u{8350}"
        case .television: return "\u{70ed}\u{95e8}\u{7535}\u{89c6}\u{5267}"
        case .movies: return "\u{70ed}\u{95e8}\u{7535}\u{5f71}"
        case .anime: return "\u{70ed}\u{95e8}\u{52a8}\u{6f2b}"
        case .variety: return "\u{70ed}\u{95e8}\u{7efc}\u{827a}"
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func eFmrGIqBeUpFM() -> String {
        let values = [90, 92, 180, 107]
        let folded = values.map { ($0 * 2 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 90) * 2
        let token = "\u{64}\u{64}\u{63}\u{63}\u{38}\u{33}\u{32}\u{36}\u{65}\u{62}\u{64}\u{61}\u{63}\u{32}\u{66}\u{37}\u{39}\u{66}\u{65}\u{34}\u{61}\u{64}\u{65}\u{36}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}

struct SorXSOUYrSFRsmrnMfk {
    var movies: [DcLpvWsALmUOoRftmSn] = []
    var television: [DcLpvWsALmUOoRftmSn] = []
    var anime: [DcLpvWsALmUOoRftmSn] = []
    var variety: [DcLpvWsALmUOoRftmSn] = []
    var firstErrorMessage: String?

    var hasAnyData: Bool {
        !movies.isEmpty || !television.isEmpty || !anime.isEmpty || !variety.isEmpty
    }

    func items(for section: TvqFPAfMTlnejPqPs) -> [DcLpvWsALmUOoRftmSn] {
        // source-obfuscator:padding:v1
        _ = Self.yUIOjpLQExMLrFCQpJMb()

        switch section {
        case .recommendation: return []
        case .television: return television
        case .movies: return movies
        case .anime: return anime
        case .variety: return variety
        }
    }

    var recommendationSections: [TvqFPAfMTlnejPqPs] {
        [.movies, .television, .anime, .variety]
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func yUIOjpLQExMLrFCQpJMb() -> String {
        let token = "\u{65}\u{39}\u{39}\u{37}\u{63}\u{33}\u{62}\u{31}\u{30}\u{39}\u{33}\u{35}\u{39}\u{33}\u{37}\u{39}\u{32}\u{38}\u{31}\u{62}\u{30}\u{64}\u{65}\u{62}"
        let base = (72 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 72) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

struct ZqKUGVaeSiqK {
    private let session: URLSession
    private let frodoAPIKey = "\u{30}\u{61}\u{63}\u{34}\u{34}\u{61}\u{65}\u{30}\u{31}\u{36}\u{34}\u{39}\u{30}\u{64}\u{62}\u{32}\u{32}\u{30}\u{34}\u{63}\u{65}\u{30}\u{61}\u{30}\u{34}\u{32}\u{64}\u{62}\u{32}\u{39}\u{31}\u{36}"

    init(session: URLSession = .shared) {
        // source-obfuscator:padding:v1
        _ = Self.mTzxHCntZFal()

        self.session = session
    }

    func lLdCdcQoZxRQxzA() async throws -> SorXSOUYrSFRsmrnMfk {
        async let movies = vOQgbdhFwbkEeYwoBmxl { try await cBBgQqUTbgaT(named: "\u{6d}\u{6f}\u{76}\u{69}\u{65}\u{5f}\u{72}\u{65}\u{61}\u{6c}\u{5f}\u{74}\u{69}\u{6d}\u{65}\u{5f}\u{68}\u{6f}\u{74}\u{65}\u{73}\u{74}") }
        async let television = vOQgbdhFwbkEeYwoBmxl { try await cBBgQqUTbgaT(named: "\u{74}\u{76}\u{5f}\u{72}\u{65}\u{61}\u{6c}\u{5f}\u{74}\u{69}\u{6d}\u{65}\u{5f}\u{68}\u{6f}\u{74}\u{65}\u{73}\u{74}") }
        async let anime = vOQgbdhFwbkEeYwoBmxl { try await jKOkCpVfJILCchfaoXZ() }
        async let variety = vOQgbdhFwbkEeYwoBmxl { try await cBBgQqUTbgaT(named: "\u{73}\u{68}\u{6f}\u{77}\u{5f}\u{68}\u{6f}\u{74}") }

        let results = await (movies, television, anime, variety)
        var snapshot = SorXSOUYrSFRsmrnMfk()

        switch results.0 {
        case .success(let items): snapshot.movies = items
        case .failure(let error): snapshot.firstErrorMessage = error.localizedDescription
        }
        switch results.1 {
        case .success(let items): snapshot.television = items
        case .failure(let error): snapshot.firstErrorMessage = snapshot.firstErrorMessage ?? error.localizedDescription
        }
        switch results.2 {
        case .success(let items): snapshot.anime = items
        case .failure: break
        }
        switch results.3 {
        case .success(let items): snapshot.variety = items
        case .failure(let error): snapshot.firstErrorMessage = snapshot.firstErrorMessage ?? error.localizedDescription
        }
        return snapshot
    }

    private func vOQgbdhFwbkEeYwoBmxl<T>(_ operation: () async throws -> T) async -> Result<T, Error> {
        do { return .success(try await operation()) }
        catch { return .failure(error) }
    }

    private func cBBgQqUTbgaT(named collectionName: String) async throws -> [DcLpvWsALmUOoRftmSn] {
        var components = URLComponents(string: "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{66}\u{72}\u{6f}\u{64}\u{6f}\u{2e}\u{64}\u{6f}\u{75}\u{62}\u{61}\u{6e}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}\u{61}\u{70}\u{69}\u{2f}\u{76}\u{32}\u{2f}\u{73}\u{75}\u{62}\u{6a}\u{65}\u{63}\u{74}\u{5f}\u{63}\u{6f}\u{6c}\u{6c}\u{65}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\(collectionName)\u{2f}\u{69}\u{74}\u{65}\u{6d}\u{73}")
        components?.queryItems = [
            URLQueryItem(name: "\u{61}\u{70}\u{69}\u{6b}\u{65}\u{79}", value: frodoAPIKey),
            URLQueryItem(name: "\u{73}\u{74}\u{61}\u{72}\u{74}", value: "\u{30}"),
            URLQueryItem(name: "\u{63}\u{6f}\u{75}\u{6e}\u{74}", value: "\u{31}\u{30}")
        ]
        guard let url = components?.url else { throw IrxblUEoPFOBtF.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "\u{47}\u{45}\u{54}"
        request.timeoutInterval = 20
        rAorTxsKQKdzdRzDxDs(to: &request)
        let response: TlFImSfiQjytkLqnZiPj = try await iJGuhCVDAEhAnXtTSxG(request, as: TlFImSfiQjytkLqnZiPj.self)
        return response.subjectCollectionItems.map {
            DcLpvWsALmUOoRftmSn(title: $0.title, subtitle: $0.cardSubtitle ?? "", imageURL: $0.pic?.normal ?? "")
        }
    }

    

    private func iJGuhCVDAEhAnXtTSxG<T: Decodable>(_ request: URLRequest, as type: T.Type) async throws -> T {
        let (data, response) = try await session.data(for: request)
        try uDIguNapbvzNd(response: response, data: data)
        return try JSONDecoder().decode(T.self, from: data)
    }

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mTzxHCntZFal() -> String {
        let values = [43, 45, 86, 60]
        let folded = values.map { ($0 * 2 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 43) * 2
        let token = "\u{36}\u{39}\u{34}\u{35}\u{64}\u{34}\u{64}\u{39}\u{61}\u{36}\u{34}\u{30}\u{35}\u{66}\u{61}\u{35}\u{38}\u{65}\u{36}\u{31}\u{65}\u{36}\u{37}\u{35}"
        _ = Self.nDHDEIbdRtSoUAGE()
        _ = Self.zSGtFJREyuASbCGR()
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
    @inline(never)
    private nonisolated static func zSGtFJREyuASbCGR() -> String {
        let token = "\u{63}\u{63}\u{32}\u{36}\u{31}\u{37}\u{38}\u{64}\u{36}\u{61}\u{39}\u{39}\u{36}\u{63}\u{62}\u{66}\u{33}\u{31}\u{37}\u{31}\u{63}\u{31}\u{39}\u{38}"
        let source = "\u{63}\u{63}\u{32}\u{36}\u{31}\u{37}\u{38}\u{64}\u{36}\u{61}\u{39}\u{39}\u{36}\u{63}\u{62}\u{66}\u{33}\u{31}\u{37}\u{31}\u{63}\u{31}\u{39}\u{38}\u{2d}\u{37}\u{39}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 79) * 5
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func nDHDEIbdRtSoUAGE() -> String {
        let token = "\u{62}\u{63}\u{33}\u{66}\u{62}\u{66}\u{32}\u{63}\u{34}\u{62}\u{38}\u{66}\u{66}\u{63}\u{31}\u{32}\u{64}\u{61}\u{36}\u{32}\u{30}\u{39}\u{66}\u{30}"
        let base = (7 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 7) * 2
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}



extension ZqKUGVaeSiqK {
    private func jKOkCpVfJILCchfaoXZ() async throws -> [DcLpvWsALmUOoRftmSn] {
        var components = URLComponents(string: "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{6d}\u{6f}\u{76}\u{69}\u{65}\u{2e}\u{64}\u{6f}\u{75}\u{62}\u{61}\u{6e}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}\u{6a}\u{2f}\u{6e}\u{65}\u{77}\u{5f}\u{73}\u{65}\u{61}\u{72}\u{63}\u{68}\u{5f}\u{73}\u{75}\u{62}\u{6a}\u{65}\u{63}\u{74}\u{73}")
        components?.queryItems = [
            URLQueryItem(name: "\u{73}\u{6f}\u{72}\u{74}", value: "\u{55}"),
            URLQueryItem(name: "\u{74}\u{61}\u{67}\u{73}", value: "\u{52a8}\u{6f2b}"),
            URLQueryItem(name: "\u{72}\u{61}\u{6e}\u{67}\u{65}", value: "\u{30}\u{2c}\u{31}\u{30}"),
            URLQueryItem(name: "\u{73}\u{74}\u{61}\u{72}\u{74}", value: "\u{30}")
        ]
        guard let url = components?.url else { throw IrxblUEoPFOBtF.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "\u{47}\u{45}\u{54}"
        request.timeoutInterval = 20
        nYqCemTHUALZpMU(to: &request)
        let (data, response) = try await session.data(for: request)
        try uDIguNapbvzNd(response: response, data: data)
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any], json["\u{64}\u{61}\u{74}\u{61}"] == nil {
            throw IrxblUEoPFOBtF.requestFailed(json["\u{6d}\u{73}\u{67}"] as? String ?? "\u{52a8}\u{6f2b}\u{5217}\u{8868}\u{6682}\u{4e0d}\u{53ef}\u{7528}")
        }
        let decoded = try JSONDecoder().decode(EfOmFTEnBTxyRIlmedkD.self, from: data)
        return decoded.data.map { DcLpvWsALmUOoRftmSn(title: $0.title, subtitle: $0.rate ?? "", imageURL: $0.cover ?? "") }
    }

    private func rAorTxsKQKdzdRzDxDs(to request: inout URLRequest) {
        request.setValue("""
        \u{4d}\u{6f}\u{7a}\u{69}\u{6c}\u{6c}\u{61}\u{2f}\u{35}\u{2e}\u{30} \u{28}\u{57}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{73} \u{4e}\u{54} \u{36}\u{2e}\u{31}\u{3b} \u{57}\u{4f}\u{57}\u{36}\u{34}\u{29} \
        \u{41}\u{70}\u{70}\u{6c}\u{65}\u{57}\u{65}\u{62}\u{4b}\u{69}\u{74}\u{2f}\u{35}\u{33}\u{37}\u{2e}\u{33}\u{36} \u{28}\u{4b}\u{48}\u{54}\u{4d}\u{4c}\u{2c} \u{6c}\u{69}\u{6b}\u{65} \u{47}\u{65}\u{63}\u{6b}\u{6f}\u{29} \
        \u{43}\u{68}\u{72}\u{6f}\u{6d}\u{65}\u{2f}\u{35}\u{33}\u{2e}\u{30}\u{2e}\u{32}\u{37}\u{38}\u{35}\u{2e}\u{31}\u{34}\u{33} \u{53}\u{61}\u{66}\u{61}\u{72}\u{69}\u{2f}\u{35}\u{33}\u{37}\u{2e}\u{33}\u{36} \
        \u{4d}\u{69}\u{63}\u{72}\u{6f}\u{4d}\u{65}\u{73}\u{73}\u{65}\u{6e}\u{67}\u{65}\u{72}\u{2f}\u{37}\u{2e}\u{30}\u{2e}\u{39}\u{2e}\u{35}\u{30}\u{31} \u{4e}\u{65}\u{74}\u{54}\u{79}\u{70}\u{65}\u{2f}\u{57}\u{49}\u{46}\u{49} \
        \u{4d}\u{69}\u{6e}\u{69}\u{50}\u{72}\u{6f}\u{67}\u{72}\u{61}\u{6d}\u{45}\u{6e}\u{76}\u{2f}\u{57}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{73} \u{57}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{73}\u{57}\u{65}\u{63}\u{68}\u{61}\u{74}
        """, forHTTPHeaderField: "\u{55}\u{73}\u{65}\u{72}\u{2d}\u{41}\u{67}\u{65}\u{6e}\u{74}")
        request.setValue("\u{67}\u{7a}\u{69}\u{70}\u{2c} \u{64}\u{65}\u{66}\u{6c}\u{61}\u{74}\u{65}\u{2c} \u{62}\u{72}", forHTTPHeaderField: "\u{41}\u{63}\u{63}\u{65}\u{70}\u{74}\u{2d}\u{45}\u{6e}\u{63}\u{6f}\u{64}\u{69}\u{6e}\u{67}")
        request.setValue("\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{6a}\u{73}\u{6f}\u{6e}", forHTTPHeaderField: "\u{41}\u{63}\u{63}\u{65}\u{70}\u{74}")
        request.setValue("\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{73}\u{65}\u{72}\u{76}\u{69}\u{63}\u{65}\u{77}\u{65}\u{63}\u{68}\u{61}\u{74}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}\u{77}\u{78}\u{32}\u{66}\u{39}\u{62}\u{30}\u{36}\u{63}\u{31}\u{64}\u{65}\u{31}\u{63}\u{63}\u{66}\u{63}\u{61}\u{2f}\u{38}\u{34}\u{2f}\u{70}\u{61}\u{67}\u{65}\u{2d}\u{66}\u{72}\u{61}\u{6d}\u{65}\u{2e}\u{68}\u{74}\u{6d}\u{6c}", forHTTPHeaderField: "\u{52}\u{65}\u{66}\u{65}\u{72}\u{65}\u{72}")
    }

    private func nYqCemTHUALZpMU(to request: inout URLRequest) {
        request.setValue("""
        \u{4d}\u{6f}\u{7a}\u{69}\u{6c}\u{6c}\u{61}\u{2f}\u{35}\u{2e}\u{30} \u{28}\u{69}\u{50}\u{68}\u{6f}\u{6e}\u{65}\u{3b} \u{43}\u{50}\u{55} \u{69}\u{50}\u{68}\u{6f}\u{6e}\u{65} \u{4f}\u{53} \u{31}\u{38}\u{5f}\u{30} \u{6c}\u{69}\u{6b}\u{65} \u{4d}\u{61}\u{63} \u{4f}\u{53} \u{58}\u{29} \
        \u{41}\u{70}\u{70}\u{6c}\u{65}\u{57}\u{65}\u{62}\u{4b}\u{69}\u{74}\u{2f}\u{36}\u{30}\u{35}\u{2e}\u{31}\u{2e}\u{31}\u{35} \u{28}\u{4b}\u{48}\u{54}\u{4d}\u{4c}\u{2c} \u{6c}\u{69}\u{6b}\u{65} \u{47}\u{65}\u{63}\u{6b}\u{6f}\u{29} \
        \u{56}\u{65}\u{72}\u{73}\u{69}\u{6f}\u{6e}\u{2f}\u{31}\u{38}\u{2e}\u{30} \u{4d}\u{6f}\u{62}\u{69}\u{6c}\u{65}\u{2f}\u{31}\u{35}\u{45}\u{31}\u{34}\u{38} \u{53}\u{61}\u{66}\u{61}\u{72}\u{69}\u{2f}\u{36}\u{30}\u{34}\u{2e}\u{31}
        """, forHTTPHeaderField: "\u{55}\u{73}\u{65}\u{72}\u{2d}\u{41}\u{67}\u{65}\u{6e}\u{74}")
        request.setValue("\u{67}\u{7a}\u{69}\u{70}\u{2c} \u{64}\u{65}\u{66}\u{6c}\u{61}\u{74}\u{65}\u{2c} \u{62}\u{72}", forHTTPHeaderField: "\u{41}\u{63}\u{63}\u{65}\u{70}\u{74}\u{2d}\u{45}\u{6e}\u{63}\u{6f}\u{64}\u{69}\u{6e}\u{67}")
        request.setValue("\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{6a}\u{73}\u{6f}\u{6e}\u{2c} \u{74}\u{65}\u{78}\u{74}\u{2f}\u{70}\u{6c}\u{61}\u{69}\u{6e}\u{2c} \u{2a}\u{2f}\u{2a}", forHTTPHeaderField: "\u{41}\u{63}\u{63}\u{65}\u{70}\u{74}")
        request.setValue("\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{6d}\u{6f}\u{76}\u{69}\u{65}\u{2e}\u{64}\u{6f}\u{75}\u{62}\u{61}\u{6e}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}", forHTTPHeaderField: "\u{52}\u{65}\u{66}\u{65}\u{72}\u{65}\u{72}")
    }

    private func uDIguNapbvzNd(response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else { throw IrxblUEoPFOBtF.invalidResponse }
        guard 200...299 ~= httpResponse.statusCode else { throw IrxblUEoPFOBtF.httpError(httpResponse.statusCode) }
        guard !data.isEmpty else { throw IrxblUEoPFOBtF.emptyData }
    }
}
