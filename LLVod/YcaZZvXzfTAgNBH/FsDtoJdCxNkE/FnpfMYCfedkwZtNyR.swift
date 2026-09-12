






import Foundation

enum EmEzAMvBgBSHRKKzo: LocalizedError {

    case invalidURL
    case invalidResponse
    case notLoggedIn
    case business(String)

    var errorDescription: String? {
        // source-obfuscator:padding:v1
        _ = Self.dNkpxOwPORUDDjXPj()

        switch self {
        case .invalidURL:
            return ""
        case .invalidResponse:
            return ""
        case .notLoggedIn:
            return ""
        case .business(let message):
            return message
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func dNkpxOwPORUDDjXPj() -> String {
        let token = "\u{32}\u{35}\u{39}\u{37}\u{31}\u{30}\u{33}\u{62}\u{34}\u{39}\u{38}\u{32}\u{36}\u{65}\u{30}\u{64}\u{61}\u{32}\u{36}\u{32}\u{61}\u{34}\u{63}\u{63}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{38}\u{38}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 88) * 6
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}


enum GkIroGSjRTlRtqmg: LocalizedError {

    case secretNotConfigured
    case encryptFailed(Error)

    var errorDescription: String? {
        // source-obfuscator:padding:v1
        _ = Self.tCrstpcqEjUfmsVSF()

        switch self {
        case .secretNotConfigured:
            return ""

        case .encryptFailed(let error):
            return ""
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func tCrstpcqEjUfmsVSF() -> String {
        let base = (94 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 94) * 7
        let token = "\u{63}\u{34}\u{39}\u{31}\u{37}\u{36}\u{33}\u{32}\u{31}\u{32}\u{35}\u{31}\u{65}\u{38}\u{32}\u{37}\u{37}\u{38}\u{30}\u{31}\u{32}\u{30}\u{36}\u{66}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}

enum QotPEvdaOpbektTpofye {

    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 20
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: configuration)
    }()

    

    static func bTtWNXJbYlCxDnrvjC(
        targetType: String,
        targetId: String,
        page: Int,
        pageSize: Int = 20
    ) async throws -> CvwhUhUPdyBHHEbjUatV {
        // source-obfuscator:padding:v1
        _ = Self.eXksblwbyLPAIQLLDLoO()


        let data = try await send(
            path: "\u{2f}\u{63}\u{6f}\u{6d}\u{6d}\u{65}\u{6e}\u{74}\u{73}",
            method: "\u{47}\u{45}\u{54}",
            query: [
                URLQueryItem(name: "\u{74}\u{61}\u{72}\u{67}\u{65}\u{74}\u{5f}\u{74}\u{79}\u{70}\u{65}", value: targetType),
                URLQueryItem(name: "\u{74}\u{61}\u{72}\u{67}\u{65}\u{74}\u{5f}\u{69}\u{64}", value: targetId),
                URLQueryItem(name: "\u{70}\u{61}\u{67}\u{65}", value: String(page)),
                URLQueryItem(name: "\u{70}\u{61}\u{67}\u{65}\u{5f}\u{73}\u{69}\u{7a}\u{65}", value: String(pageSize))
            ]
        )

        let payload = VzJLkFDMNUvkTo.nRBvMWnjIbzFbbVX(data)
        let pagination = VzJLkFDMNUvkTo.nRBvMWnjIbzFbbVX(payload["\u{70}\u{61}\u{67}\u{69}\u{6e}\u{61}\u{74}\u{69}\u{6f}\u{6e}"])
        let list = VzJLkFDMNUvkTo.hRgkIKDTHAwxsWMpCy(payload["\u{6c}\u{69}\u{73}\u{74}"]).compactMap(RvGGzFHfQwFzCOaegZ.init(json:))

        return CvwhUhUPdyBHHEbjUatV(
            list: list,
            notices: VzJLkFDMNUvkTo.hRgkIKDTHAwxsWMpCy(payload["\u{6e}\u{6f}\u{74}\u{69}\u{63}\u{65}\u{73}"]).compactMap(DiFlugBsHBcmHhv.init(json:)),
            total: VzJLkFDMNUvkTo.gFhBCpITjkgEhXovTBfI(pagination["\u{74}\u{6f}\u{74}\u{61}\u{6c}"]) ?? list.count,
            hasMore: VzJLkFDMNUvkTo.wSzYyiKPkOCiLAsXsTQ(pagination["\u{68}\u{61}\u{73}\u{5f}\u{6d}\u{6f}\u{72}\u{65}"])
        )
    }

    static func rJtWvFzEbADyOH(commentId: Int) async throws -> [RvGGzFHfQwFzCOaegZ] {
        let data = try await send(
            path: "\u{2f}\u{63}\u{6f}\u{6d}\u{6d}\u{65}\u{6e}\u{74}\u{73}\u{2f}\(commentId)\u{2f}\u{72}\u{65}\u{70}\u{6c}\u{69}\u{65}\u{73}",
            method: "\u{47}\u{45}\u{54}"
        )
        return VzJLkFDMNUvkTo.hRgkIKDTHAwxsWMpCy(data).compactMap(RvGGzFHfQwFzCOaegZ.init(json:))
    }

    

    

    

    struct WrtocQXPClRikoxSICdR {
        let user: YlbtxEGRJfsFSyzEMl
        let accessToken: String
        let refreshToken: String
    }

    

    
    
    static func hBytMEeXNYIGgFKJK(
        account: String,
        password: String,
        nickname: String
    ) async throws -> WrtocQXPClRikoxSICdR {

        var body: [String: Any] = [
            "\u{61}\u{63}\u{63}\u{6f}\u{75}\u{6e}\u{74}": account,
            "\u{70}\u{61}\u{73}\u{73}\u{77}\u{6f}\u{72}\u{64}": password
        ]
        if !nickname.isEmpty {
            body["\u{6e}\u{69}\u{63}\u{6b}\u{6e}\u{61}\u{6d}\u{65}"] = nickname
        }
        for (key, value) in try aCrKWvQMgavo() {
            body[key] = value
        }

        _ = try await send(path: "\u{2f}\u{61}\u{75}\u{74}\u{68}\u{2f}\u{72}\u{65}\u{67}\u{69}\u{73}\u{74}\u{65}\u{72}", method: "\u{50}\u{4f}\u{53}\u{54}", body: body)
        return try await cRicjEqTPWkUQunCjVR(account: account, password: password)
    }

    static func dDDdyxJBfhaciVWRv(refreshToken: String) async throws -> (accessToken: String, refreshToken: String) {
        let data = try await send(
            path: "\u{2f}\u{61}\u{75}\u{74}\u{68}\u{2f}\u{72}\u{65}\u{66}\u{72}\u{65}\u{73}\u{68}",
            method: "\u{50}\u{4f}\u{53}\u{54}",
            body: ["\u{72}\u{65}\u{66}\u{72}\u{65}\u{73}\u{68}\u{5f}\u{74}\u{6f}\u{6b}\u{65}\u{6e}": refreshToken]
        )
        let payload = VzJLkFDMNUvkTo.nRBvMWnjIbzFbbVX(data)

        return (
            VzJLkFDMNUvkTo.string(payload["\u{61}\u{63}\u{63}\u{65}\u{73}\u{73}\u{5f}\u{74}\u{6f}\u{6b}\u{65}\u{6e}"]),
            VzJLkFDMNUvkTo.string(payload["\u{72}\u{65}\u{66}\u{72}\u{65}\u{73}\u{68}\u{5f}\u{74}\u{6f}\u{6b}\u{65}\u{6e}"])
        )
    }

    

    static func uHGjUDKoDtALUvuwPy(token: String) async throws -> YlbtxEGRJfsFSyzEMl {
        guard !token.isEmpty else { throw EmEzAMvBgBSHRKKzo.notLoggedIn }
        let data = try await send(path: "\u{2f}\u{75}\u{73}\u{65}\u{72}", method: "\u{47}\u{45}\u{54}", token: token)
        return YlbtxEGRJfsFSyzEMl(json: VzJLkFDMNUvkTo.nRBvMWnjIbzFbbVX(data))
    }

    

    static func rIgOnXERfukMSzhqVr(_ avatarURL: String, token: String) async throws {
        guard !token.isEmpty else { throw EmEzAMvBgBSHRKKzo.notLoggedIn }
        _ = try await send(
            path: "\u{2f}\u{75}\u{73}\u{65}\u{72}\u{2f}\u{61}\u{76}\u{61}\u{74}\u{61}\u{72}",
            method: "\u{50}\u{41}\u{54}\u{43}\u{48}",
            body: ["\u{61}\u{76}\u{61}\u{74}\u{61}\u{72}\u{5f}\u{75}\u{72}\u{6c}": avatarURL],
            token: token
        )
    }

    static func jCOAeYiiAczWSnlvoLgm(_ bio: String, token: String) async throws {
        guard !token.isEmpty else { throw EmEzAMvBgBSHRKKzo.notLoggedIn }
        _ = try await send(
            path: "\u{2f}\u{75}\u{73}\u{65}\u{72}\u{2f}\u{62}\u{69}\u{6f}",
            method: "\u{50}\u{41}\u{54}\u{43}\u{48}",
            body: ["\u{62}\u{69}\u{6f}": bio],
            token: token
        )
    }

    

    

    

    

    @discardableResult
    private static func send(
        path: String,
        method: String,
        query: [URLQueryItem] = [],
        body: [String: Any]? = nil,
        token: String? = nil
    ) async throws -> Any? {

        guard var components = URLComponents(string: "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{6c}\u{6f}\u{67}\u{69}\u{6e}\u{2e}\u{79}\u{69}\u{79}\u{73}\u{30}\u{37}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}\u{61}\u{70}\u{69}" + path) else {
            throw EmEzAMvBgBSHRKKzo.invalidURL
        }
        if !query.isEmpty {
            components.queryItems = query
        }
        guard let url = components.url else {
            throw EmEzAMvBgBSHRKKzo.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{6a}\u{73}\u{6f}\u{6e}\u{3b}\u{63}\u{68}\u{61}\u{72}\u{73}\u{65}\u{74}\u{3d}\u{55}\u{54}\u{46}\u{2d}\u{38}", forHTTPHeaderField: "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{54}\u{79}\u{70}\u{65}")

        if let token, !token.isEmpty {
            request.setValue("\u{42}\u{65}\u{61}\u{72}\u{65}\u{72} \(token)", forHTTPHeaderField: "\u{41}\u{75}\u{74}\u{68}\u{6f}\u{72}\u{69}\u{7a}\u{61}\u{74}\u{69}\u{6f}\u{6e}")
        }
        if let body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }

        let (data, _) = try await session.data(for: request)

        
        guard let envelope = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw EmEzAMvBgBSHRKKzo.invalidResponse
        }

        let code = VzJLkFDMNUvkTo.gFhBCpITjkgEhXovTBfI(envelope["\u{63}\u{6f}\u{64}\u{65}"]) ?? -1
        guard code == 0 else {
            let message = VzJLkFDMNUvkTo.string(envelope["\u{6d}\u{65}\u{73}\u{73}\u{61}\u{67}\u{65}"])
            throw EmEzAMvBgBSHRKKzo.business(message.isEmpty ? "\u{8bf7}\u{6c42}\u{5931}\u{8d25}\u{ff08}\(code)\u{ff09}" : message)
        }

        return envelope["\u{64}\u{61}\u{74}\u{61}"]
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func eXksblwbyLPAIQLLDLoO() -> String {
        _ = Self.iYLhtSUXSqMugTUPHxP()
        _ = Self.iUPUMjTEewOhpm()
        _ = Self.vNpqdmIPVXnbsSTKPp()
        _ = Self.jZnRhVWZvRrpbk()
        let token = "\u{32}\u{66}\u{62}\u{39}\u{61}\u{32}\u{36}\u{35}\u{64}\u{66}\u{32}\u{33}\u{38}\u{64}\u{37}\u{30}\u{32}\u{37}\u{37}\u{63}\u{39}\u{65}\u{36}\u{32}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 40, "\u{65}\u{61}\u{73}\u{74}": 44, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 160]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 40) * 4
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func iYLhtSUXSqMugTUPHxP() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 39, "\u{65}\u{61}\u{73}\u{74}": 45, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 234]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 39) * 6
        let token = "\u{31}\u{37}\u{61}\u{36}\u{34}\u{34}\u{39}\u{38}\u{30}\u{39}\u{35}\u{35}\u{34}\u{39}\u{64}\u{32}\u{32}\u{32}\u{33}\u{35}\u{30}\u{30}\u{61}\u{63}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
    @inline(never)
    private nonisolated static func iUPUMjTEewOhpm() -> String {
        let token = "\u{62}\u{31}\u{66}\u{30}\u{39}\u{30}\u{30}\u{64}\u{35}\u{64}\u{61}\u{33}\u{33}\u{32}\u{36}\u{34}\u{32}\u{34}\u{39}\u{32}\u{62}\u{64}\u{31}\u{30}"
        let source = "\u{62}\u{31}\u{66}\u{30}\u{39}\u{30}\u{30}\u{64}\u{35}\u{64}\u{61}\u{33}\u{33}\u{32}\u{36}\u{34}\u{32}\u{34}\u{39}\u{32}\u{62}\u{64}\u{31}\u{30}\u{2d}\u{34}\u{35}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 45) * 2
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func vNpqdmIPVXnbsSTKPp() -> String {
        let token = "\u{36}\u{65}\u{66}\u{34}\u{37}\u{61}\u{61}\u{35}\u{64}\u{34}\u{32}\u{36}\u{38}\u{63}\u{30}\u{37}\u{30}\u{66}\u{65}\u{36}\u{33}\u{30}\u{36}\u{39}"
        let base = (87 * 6 + 19) % 997
        let width = (base) % 17
        let score = (width + 87) * 6
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func jZnRhVWZvRrpbk() -> String {
        let source = "\u{33}\u{34}\u{32}\u{37}\u{36}\u{62}\u{32}\u{33}\u{33}\u{39}\u{30}\u{32}\u{30}\u{35}\u{37}\u{64}\u{66}\u{66}\u{62}\u{31}\u{66}\u{35}\u{63}\u{37}\u{2d}\u{38}\u{36}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 86) * 2
        let token = "\u{33}\u{34}\u{32}\u{37}\u{36}\u{62}\u{32}\u{33}\u{33}\u{39}\u{30}\u{32}\u{30}\u{35}\u{37}\u{64}\u{66}\u{66}\u{62}\u{31}\u{66}\u{35}\u{63}\u{37}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}



extension QotPEvdaOpbektTpofye {
    static func fYPvGMYYHemPGnvj(imageData: Data, fileName: String = "\u{61}\u{76}\u{61}\u{74}\u{61}\u{72}\u{2e}\u{6a}\u{70}\u{67}", token: String) async throws -> String {
        guard !token.isEmpty else { throw EmEzAMvBgBSHRKKzo.notLoggedIn }

        let homeURL = URL(string: "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{69}\u{6d}\u{67}\u{2e}\u{62}\u{69}\u{6e}\u{6d}\u{74}\u{2e}\u{63}\u{63}\u{2f}")!
        var homeRequest = URLRequest(url: homeURL)
        homeRequest.httpMethod = "\u{47}\u{45}\u{54}"
        let (homeData, homeResponse) = try await session.data(for: homeRequest)
        let html = String(data: homeData, encoding: .utf8) ?? ""

        guard let csrfToken = wYTrPmuuocuGrWd(from: html), !csrfToken.isEmpty else {
            throw EmEzAMvBgBSHRKKzo.business("\u{83b7}\u{53d6}\u{56fe}\u{5e8a}\u{4ee4}\u{724c}\u{5931}\u{8d25}")
        }

        var cookieHeader = ""
        if let http = homeResponse as? HTTPURLResponse {
            let fields = http.allHeaderFields.reduce(into: [String: String]()) { result, pair in
                if let key = pair.key as? String, let value = pair.value as? String {
                    result[key] = value
                }
            }
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: homeURL)
            cookieHeader = cookies.map { "\($0.name)\u{3d}\($0.value)" }.joined(separator: "\u{3b} ")
        }

        let boundary = "\u{42}\u{6f}\u{75}\u{6e}\u{64}\u{61}\u{72}\u{79}\u{2d}\(UUID().uuidString)"
        var body = Data()
        func fEiePSTzIguFd(_ text: String) {
            if let data = text.data(using: .utf8) { body.append(data) }
        }

        fEiePSTzIguFd("\u{2d}\u{2d}\(boundary)\r\n")
        fEiePSTzIguFd("\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{44}\u{69}\u{73}\u{70}\u{6f}\u{73}\u{69}\u{74}\u{69}\u{6f}\u{6e}\u{3a} \u{66}\u{6f}\u{72}\u{6d}\u{2d}\u{64}\u{61}\u{74}\u{61}\u{3b} \u{6e}\u{61}\u{6d}\u{65}\u{3d}\"\u{73}\u{74}\u{72}\u{61}\u{74}\u{65}\u{67}\u{79}\u{5f}\u{69}\u{64}\"\r\n\r\n")
        fEiePSTzIguFd("\u{32}\r\n")
        fEiePSTzIguFd("\u{2d}\u{2d}\(boundary)\r\n")
        fEiePSTzIguFd("\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{44}\u{69}\u{73}\u{70}\u{6f}\u{73}\u{69}\u{74}\u{69}\u{6f}\u{6e}\u{3a} \u{66}\u{6f}\u{72}\u{6d}\u{2d}\u{64}\u{61}\u{74}\u{61}\u{3b} \u{6e}\u{61}\u{6d}\u{65}\u{3d}\"\u{66}\u{69}\u{6c}\u{65}\"\u{3b} \u{66}\u{69}\u{6c}\u{65}\u{6e}\u{61}\u{6d}\u{65}\u{3d}\"\(fileName)\"\r\n")
        fEiePSTzIguFd("\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{54}\u{79}\u{70}\u{65}\u{3a} \u{69}\u{6d}\u{61}\u{67}\u{65}\u{2f}\u{6a}\u{70}\u{65}\u{67}\r\n\r\n")
        body.append(imageData)
        fEiePSTzIguFd("\r\n")
        fEiePSTzIguFd("\u{2d}\u{2d}\(boundary)\u{2d}\u{2d}\r\n")

        var uploadRequest = URLRequest(url: URL(string: "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{69}\u{6d}\u{67}\u{2e}\u{62}\u{69}\u{6e}\u{6d}\u{74}\u{2e}\u{63}\u{63}\u{2f}\u{75}\u{70}\u{6c}\u{6f}\u{61}\u{64}")!)
        uploadRequest.httpMethod = "\u{50}\u{4f}\u{53}\u{54}"
        uploadRequest.setValue("\u{6d}\u{75}\u{6c}\u{74}\u{69}\u{70}\u{61}\u{72}\u{74}\u{2f}\u{66}\u{6f}\u{72}\u{6d}\u{2d}\u{64}\u{61}\u{74}\u{61}\u{3b} \u{62}\u{6f}\u{75}\u{6e}\u{64}\u{61}\u{72}\u{79}\u{3d}\(boundary)", forHTTPHeaderField: "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{54}\u{79}\u{70}\u{65}")
        uploadRequest.setValue(csrfToken, forHTTPHeaderField: "\u{58}\u{2d}\u{43}\u{53}\u{52}\u{46}\u{2d}\u{54}\u{4f}\u{4b}\u{45}\u{4e}")
        uploadRequest.setValue("\u{58}\u{4d}\u{4c}\u{48}\u{74}\u{74}\u{70}\u{52}\u{65}\u{71}\u{75}\u{65}\u{73}\u{74}", forHTTPHeaderField: "\u{58}\u{2d}\u{52}\u{65}\u{71}\u{75}\u{65}\u{73}\u{74}\u{65}\u{64}\u{2d}\u{57}\u{69}\u{74}\u{68}")
        uploadRequest.setValue("\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{69}\u{6d}\u{67}\u{2e}\u{62}\u{69}\u{6e}\u{6d}\u{74}\u{2e}\u{63}\u{63}\u{2f}", forHTTPHeaderField: "\u{52}\u{65}\u{66}\u{65}\u{72}\u{65}\u{72}")
        uploadRequest.setValue("\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{69}\u{6d}\u{67}\u{2e}\u{62}\u{69}\u{6e}\u{6d}\u{74}\u{2e}\u{63}\u{63}", forHTTPHeaderField: "\u{4f}\u{72}\u{69}\u{67}\u{69}\u{6e}")
        uploadRequest.setValue("\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{6a}\u{73}\u{6f}\u{6e}\u{2c} \u{74}\u{65}\u{78}\u{74}\u{2f}\u{6a}\u{61}\u{76}\u{61}\u{73}\u{63}\u{72}\u{69}\u{70}\u{74}\u{2c} \u{2a}\u{2f}\u{2a}\u{3b} \u{71}\u{3d}\u{30}\u{2e}\u{30}\u{31}", forHTTPHeaderField: "\u{41}\u{63}\u{63}\u{65}\u{70}\u{74}")
        if !cookieHeader.isEmpty {
            uploadRequest.setValue(cookieHeader, forHTTPHeaderField: "\u{43}\u{6f}\u{6f}\u{6b}\u{69}\u{65}")
        }
        uploadRequest.httpBody = body

        let (uploadData, _) = try await session.data(for: uploadRequest)
        guard let map = try? JSONSerialization.jsonObject(with: uploadData) as? [String: Any] else {
            throw EmEzAMvBgBSHRKKzo.invalidResponse
        }
        guard map["\u{73}\u{74}\u{61}\u{74}\u{75}\u{73}"] as? Bool == true else {
            let message = VzJLkFDMNUvkTo.string(map["\u{6d}\u{65}\u{73}\u{73}\u{61}\u{67}\u{65}"])
            throw EmEzAMvBgBSHRKKzo.business(message.isEmpty ? "\u{56fe}\u{5e8a}\u{4e0a}\u{4f20}\u{5931}\u{8d25}" : message)
        }

        let links = VzJLkFDMNUvkTo.nRBvMWnjIbzFbbVX(VzJLkFDMNUvkTo.nRBvMWnjIbzFbbVX(map["\u{64}\u{61}\u{74}\u{61}"])["\u{6c}\u{69}\u{6e}\u{6b}\u{73}"])
        let url = VzJLkFDMNUvkTo.string(links["\u{75}\u{72}\u{6c}"])
        guard !url.isEmpty else {
            throw EmEzAMvBgBSHRKKzo.business("\u{4e0a}\u{4f20}\u{5931}\u{8d25}\u{ff0c}\u{672a}\u{8fd4}\u{56de}\u{56fe}\u{7247}\u{5730}\u{5740}")
        }

        try await rIgOnXERfukMSzhqVr(url, token: token)
        return url
    }

    static func xJbfVMYMdSjVrK(id: Int, token: String) async throws {
        guard !token.isEmpty else { throw EmEzAMvBgBSHRKKzo.notLoggedIn }
        _ = try await send(path: "\u{2f}\u{63}\u{6f}\u{6d}\u{6d}\u{65}\u{6e}\u{74}\u{73}\u{2f}\(id)", method: "\u{44}\u{45}\u{4c}\u{45}\u{54}\u{45}", token: token)
    }

    static func xNGwzTnETmLdbVOs(_ nickname: String, token: String) async throws {
        guard !token.isEmpty else { throw EmEzAMvBgBSHRKKzo.notLoggedIn }
        _ = try await send(
            path: "\u{2f}\u{75}\u{73}\u{65}\u{72}\u{2f}\u{6e}\u{69}\u{63}\u{6b}\u{6e}\u{61}\u{6d}\u{65}",
            method: "\u{50}\u{41}\u{54}\u{43}\u{48}",
            body: ["\u{6e}\u{69}\u{63}\u{6b}\u{6e}\u{61}\u{6d}\u{65}": nickname],
            token: token
        )
    }

    static private func aCrKWvQMgavo() throws -> [String: String] {
       

        let timestamp = String(Int(Date().timeIntervalSince1970))
        let plainText = "\u{79}\u{6f}\u{75}\u{72}\u{2d}\u{73}\u{65}\u{63}\u{72}\u{65}\u{74}\u{2d}\u{61}\u{70}\u{70}\u{2d}\u{61}\u{75}\u{74}\u{68}\u{2d}\u{74}\u{6f}\u{6b}\u{65}\u{6e}\u{7c}\(timestamp)"

        do {
            let encrypted = try QxmEAOwBLRLGNSse.rSdJrKiqsbvbV(
                Array(plainText.utf8),
                key: QxmEAOwBLRLGNSse.yIlQYAonEKZxzuQytLBM("\u{79}\u{6f}\u{75}\u{72}\u{2d}\u{73}\u{65}\u{63}\u{72}\u{65}\u{74}\u{2d}\u{61}\u{70}\u{70}\u{2d}\u{61}\u{75}\u{74}\u{68}\u{2d}\u{74}\u{6f}\u{6b}\u{65}\u{6e}"),
                iv: Array("\u{30}\u{30}\u{30}\u{30}\u{30}\u{30}\u{30}\u{30}\u{30}\u{30}\u{30}\u{30}\u{30}\u{30}\u{30}\u{30}".utf8),
                mode: "\u{43}\u{42}\u{43}",
                padding: "\u{50}\u{4b}\u{43}\u{53}\u{37}"
            )

            return ["\u{61}\u{70}\u{70}\u{5f}\u{61}\u{75}\u{74}\u{68}\u{5f}\u{74}\u{6f}\u{6b}\u{65}\u{6e}": encrypted, "\u{74}\u{73}": timestamp]
        } catch {
            throw GkIroGSjRTlRtqmg.encryptFailed(error)
        }
    }

    static func sBnvQOjPqCLVzHmiXclV(
        targetType: String,
        targetId: String,
        content: String,
        parentCommentId: Int?,
        targetMeta: [String: String],
        token: String
    ) async throws -> Int {

        guard !token.isEmpty else { throw EmEzAMvBgBSHRKKzo.notLoggedIn }

        var body: [String: Any] = [
            "\u{74}\u{61}\u{72}\u{67}\u{65}\u{74}\u{5f}\u{74}\u{79}\u{70}\u{65}": targetType,
            "\u{74}\u{61}\u{72}\u{67}\u{65}\u{74}\u{5f}\u{69}\u{64}": targetId,
            "\u{63}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}": content
        ]
        if let parentCommentId {
            body["\u{70}\u{61}\u{72}\u{65}\u{6e}\u{74}\u{5f}\u{63}\u{6f}\u{6d}\u{6d}\u{65}\u{6e}\u{74}\u{5f}\u{69}\u{64}"] = parentCommentId
        }
        if !targetMeta.isEmpty {
            body["\u{74}\u{61}\u{72}\u{67}\u{65}\u{74}\u{5f}\u{6d}\u{65}\u{74}\u{61}"] = targetMeta
        }

        let data = try await send(
            path: "\u{2f}\u{63}\u{6f}\u{6d}\u{6d}\u{65}\u{6e}\u{74}\u{73}",
            method: "\u{50}\u{4f}\u{53}\u{54}",
            body: body,
            token: token
        )

        return VzJLkFDMNUvkTo.gFhBCpITjkgEhXovTBfI(VzJLkFDMNUvkTo.nRBvMWnjIbzFbbVX(data)["\u{63}\u{6f}\u{6d}\u{6d}\u{65}\u{6e}\u{74}\u{5f}\u{69}\u{64}"]) ?? 0
    }

    static func uFeeBuyrqIeAGHvlPiss(oldPassword: String, newPassword: String, token: String) async throws {
        guard !token.isEmpty else { throw EmEzAMvBgBSHRKKzo.notLoggedIn }
        _ = try await send(
            path: "\u{2f}\u{75}\u{73}\u{65}\u{72}\u{2f}\u{70}\u{61}\u{73}\u{73}\u{77}\u{6f}\u{72}\u{64}",
            method: "\u{50}\u{41}\u{54}\u{43}\u{48}",
            body: [
                "\u{6f}\u{6c}\u{64}\u{5f}\u{70}\u{61}\u{73}\u{73}\u{77}\u{6f}\u{72}\u{64}": oldPassword,
                "\u{6e}\u{65}\u{77}\u{5f}\u{70}\u{61}\u{73}\u{73}\u{77}\u{6f}\u{72}\u{64}": newPassword
            ],
            token: token
        )
    }

    private static func wYTrPmuuocuGrWd(from html: String) -> String? {
        guard let regex = try? NSRegularExpression(
            pattern: #"\#u{6e}\#u{61}\#u{6d}\#u{65}\#u{3d}\#u{5b}\#u{22}\#u{27}\#u{5d}\#u{63}\#u{73}\#u{72}\#u{66}\#u{2d}\#u{74}\#u{6f}\#u{6b}\#u{65}\#u{6e}\#u{5b}\#u{22}\#u{27}\#u{5d} \#u{63}\#u{6f}\#u{6e}\#u{74}\#u{65}\#u{6e}\#u{74}\#u{3d}\#u{5b}\#u{22}\#u{27}\#u{5d}\#u{28}\#u{5b}\#u{5e}\#u{22}\#u{27}\#u{5d}\#u{2b}\#u{29}\#u{5b}\#u{22}\#u{27}\#u{5d}"#,
            options: [.caseInsensitive]
        ) else { return nil }

        let range = NSRange(html.startIndex..<html.endIndex, in: html)
        guard
            let match = regex.firstMatch(in: html, options: [], range: range),
            match.numberOfRanges > 1,
            let tokenRange = Range(match.range(at: 1), in: html)
        else { return nil }

        return String(html[tokenRange])
    }

    static func cRicjEqTPWkUQunCjVR(account: String, password: String) async throws -> WrtocQXPClRikoxSICdR {
        var body: [String: Any] = [
            "\u{61}\u{63}\u{63}\u{6f}\u{75}\u{6e}\u{74}": account,
            "\u{70}\u{61}\u{73}\u{73}\u{77}\u{6f}\u{72}\u{64}": password
        ]
        for (key, value) in try aCrKWvQMgavo() {
            body[key] = value
        }

        let data = try await send(path: "\u{2f}\u{61}\u{75}\u{74}\u{68}\u{2f}\u{6c}\u{6f}\u{67}\u{69}\u{6e}", method: "\u{50}\u{4f}\u{53}\u{54}", body: body)
        let payload = VzJLkFDMNUvkTo.nRBvMWnjIbzFbbVX(data)

        return WrtocQXPClRikoxSICdR(
            user: YlbtxEGRJfsFSyzEMl(json: VzJLkFDMNUvkTo.nRBvMWnjIbzFbbVX(payload["\u{75}\u{73}\u{65}\u{72}"])),
            accessToken: VzJLkFDMNUvkTo.string(payload["\u{61}\u{63}\u{63}\u{65}\u{73}\u{73}\u{5f}\u{74}\u{6f}\u{6b}\u{65}\u{6e}"]),
            refreshToken: VzJLkFDMNUvkTo.string(payload["\u{72}\u{65}\u{66}\u{72}\u{65}\u{73}\u{68}\u{5f}\u{74}\u{6f}\u{6b}\u{65}\u{6e}"])
        )
    }
}
