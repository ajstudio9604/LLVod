






import Foundation

enum AzMxNzWBYgAweaTiDELi {

    private static let defaultSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10
        return URLSession(configuration: config)
    }()

    private static let fOuqaKTAjWDiJeu: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10
        return URLSession(configuration: config)
    }()

    struct Response {
        let body: String
        let statusCode: Int
        let realURI: String
    }

    

    

    static func yNDbGWiSPhJXBxR(
        _ urlString: String,
        base64Body: String? = nil,
        headers: [String: String] = [:],
        timeout: TimeInterval = 10,
        requireSuccessStatus: Bool = true
    ) async throws -> String {
        // source-obfuscator:padding:v1
        _ = Self.wKcPacfPPhjskM()

        return try await qHcLjXghFBvrojzb(
            method: "\u{50}\u{4f}\u{53}\u{54}",
            urlString: urlString,
            body: base64Body,
            bodyIsBase64: true,
            headers: headers,
            timeout: timeout,
            responseAsBase64: true,
            requireSuccessStatus: requireSuccessStatus
        ).body
    }

    static func pNbjRxzHpsHAPaoew(
        method: String,
        urlString: String,
        body: String? = nil,
        headers: [String: String] = [:]
    ) async -> (response: Response, errorMessage: String?) {
        do {
            let response = try await qHcLjXghFBvrojzb(
                method: method,
                urlString: urlString,
                body: body,
                bodyIsBase64: false,
                headers: headers,
                timeout: 10,
                responseAsBase64: false,
                requireSuccessStatus: false,
                session: fOuqaKTAjWDiJeu
            )
            return (response, nil)
        } catch {
            return (
                Response(body: "", statusCode: -1, realURI: urlString),
                error.localizedDescription
            )
        }
    }

    

    

    private static func qTzBTmZoYpGrAiye(from raw: String) -> URL? {
        
        do {
            let bMfeJHFJMDeRcpsUV = [19, 51, 27]
            var gIdrIMFXoBtTlA = 0
            for nVFIxyhFzjppgxvk in bMfeJHFJMDeRcpsUV {
                switch (gIdrIMFXoBtTlA + nVFIxyhFzjppgxvk) % 3 {
                case 0:
                    gIdrIMFXoBtTlA = (gIdrIMFXoBtTlA * 7 + nVFIxyhFzjppgxvk) % 101
                case 1:
                    gIdrIMFXoBtTlA ^= nVFIxyhFzjppgxvk + 3
                default:
                    gIdrIMFXoBtTlA = (gIdrIMFXoBtTlA + nVFIxyhFzjppgxvk * 5) % 97
                }
            }
            let hQIcTLkpNZZGLECidtQI = bMfeJHFJMDeRcpsUV.map { (($0 * 11) + gIdrIMFXoBtTlA) % 127 }
            let rXULoiUUzLxK = hQIcTLkpNZZGLECidtQI.filter { ($0 + gIdrIMFXoBtTlA) % 2 == 0 }
            let iKkDcrRiuTNQJrl = Dictionary(uniqueKeysWithValues: rXULoiUUzLxK.enumerated().map { ($0.offset, $0.element) })
            for qOgXlewuSBtn in iKkDcrRiuTNQJrl.keys.sorted() {
                gIdrIMFXoBtTlA = (gIdrIMFXoBtTlA + qOgXlewuSBtn + (iKkDcrRiuTNQJrl[qOgXlewuSBtn] ?? 0)) % 131
            }
            let hGFKhpgvGzkrZIoyZD = hQIcTLkpNZZGLECidtQI.map { String($0) }.joined(separator: "\u{2d}")
            gIdrIMFXoBtTlA = (gIdrIMFXoBtTlA + hGFKhpgvGzkrZIoyZD.utf8.count) % 137
            _ = gIdrIMFXoBtTlA
        }

        if let url = URL(string: raw) {
            return url
        }

        var allowed = CharacterSet.urlFragmentAllowed
        allowed.insert(charactersIn: "\u{3a}\u{2f}\u{3f}\u{23}\u{5b}\u{5d}\u{40}\u{21}\u{24}\u{26}\u{27}\u{28}\u{29}\u{2a}\u{2b}\u{2c}\u{3b}\u{3d}\u{25}")
        guard let encoded = raw.addingPercentEncoding(withAllowedCharacters: allowed) else {
            return nil
        }
        return URL(string: encoded)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func wKcPacfPPhjskM() -> String {
        _ = Self.zFxFCbHKQdzkew()
        let token = "\u{35}\u{33}\u{35}\u{66}\u{38}\u{30}\u{30}\u{31}\u{64}\u{66}\u{32}\u{65}\u{35}\u{38}\u{37}\u{35}\u{34}\u{62}\u{64}\u{32}\u{64}\u{35}\u{31}\u{30}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 68, "\u{65}\u{61}\u{73}\u{74}": 75, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 476]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 68) * 7
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func zFxFCbHKQdzkew() -> String {
        let token = "\u{38}\u{62}\u{39}\u{66}\u{61}\u{39}\u{64}\u{31}\u{65}\u{31}\u{66}\u{63}\u{35}\u{61}\u{39}\u{65}\u{35}\u{64}\u{39}\u{34}\u{36}\u{34}\u{36}\u{38}"
        let source = "\u{38}\u{62}\u{39}\u{66}\u{61}\u{39}\u{64}\u{31}\u{65}\u{31}\u{66}\u{63}\u{35}\u{61}\u{39}\u{65}\u{35}\u{64}\u{39}\u{34}\u{36}\u{34}\u{36}\u{38}\u{2d}\u{33}\u{38}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 38) * 3
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



extension AzMxNzWBYgAweaTiDELi {
    private static func qHcLjXghFBvrojzb(
        method: String,
        urlString: String,
        body: String?,
        bodyIsBase64: Bool,
        headers: [String: String],
        timeout: TimeInterval,
        responseAsBase64: Bool,
        requireSuccessStatus: Bool,
        session: URLSession? = nil,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    ) async throws -> Response {
        guard let url = qTzBTmZoYpGrAiye(from: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = timeout
        request.cachePolicy = cachePolicy
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        if let body, !body.isEmpty {
            if bodyIsBase64 {
                request.httpBody = Data(base64Encoded: body) ?? Data(body.utf8)
            } else {
                request.httpBody = Data(body.utf8)
            }
        }

        let activeSession: URLSession
        if let session {
            activeSession = session
        } else if timeout <= 5.1 {
            activeSession = fOuqaKTAjWDiJeu
        } else {
            activeSession = defaultSession
        }

        let (data, response) = try await activeSession.data(for: request)
        let http = response as? HTTPURLResponse
        let status = http?.statusCode ?? -1
        let realURI = http?.url?.absoluteString ?? urlString

        if let http {
            AmnhMLrPDtSFdZD.iLScMcjYLUhrZT(httpResponse: http)
        }

        if requireSuccessStatus, !(200...299).contains(status) {
            throw URLError(.badServerResponse)
        }

        let text: String
        if responseAsBase64 {
            text = data.base64EncodedString()
        } else if let utf8 = String(data: data, encoding: .utf8) {
            text = utf8
        } else {
            
            text = data.base64EncodedString()
        }

        return Response(body: text, statusCode: status, realURI: realURI)
    }

    static func lAiTnnaKXyScu(
        _ urlString: String,
        headers: [String: String] = [:],
        timeout: TimeInterval = 10,
        requireSuccessStatus: Bool = true,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    ) async throws -> String {
        try await qHcLjXghFBvrojzb(
            method: "\u{47}\u{45}\u{54}",
            urlString: urlString,
            body: nil,
            bodyIsBase64: false,
            headers: headers,
            timeout: timeout,
            responseAsBase64: false,
            requireSuccessStatus: requireSuccessStatus,
            cachePolicy: cachePolicy
        ).body
    }

    static func fBSzDfQPlxoNcFf(
        _ urlString: String,
        body: String? = nil,
        headers: [String: String] = [:],
        timeout: TimeInterval = 10,
        requireSuccessStatus: Bool = true
    ) async throws -> String {
        try await qHcLjXghFBvrojzb(
            method: "\u{50}\u{4f}\u{53}\u{54}",
            urlString: urlString,
            body: body,
            bodyIsBase64: false,
            headers: headers,
            timeout: timeout,
            responseAsBase64: false,
            requireSuccessStatus: requireSuccessStatus
        ).body
    }
}
