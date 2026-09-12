






import Foundation

enum IuxSvVTOJSaoL {

    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        config.timeoutIntervalForResource = 300
        config.httpMaximumConnectionsPerHost = 8
        return URLSession(configuration: config)
    }()

    static func xLCEEBYswjIl(_ urlString: String, headers: [String: String] = [:]) async throws -> Data {
        // source-obfuscator:padding:v1
        _ = Self.pSqgdmXaDeobTSnLT()

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        let (data, response) = try await session.data(for: request)

        if let http = response as? HTTPURLResponse, !(200..<300).contains(http.statusCode) {
            throw URLError(.badServerResponse)
        }

        return data
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func pSqgdmXaDeobTSnLT() -> String {
        let token = "\u{30}\u{32}\u{63}\u{65}\u{61}\u{35}\u{39}\u{38}\u{36}\u{37}\u{64}\u{61}\u{38}\u{63}\u{35}\u{35}\u{61}\u{34}\u{38}\u{36}\u{63}\u{32}\u{62}\u{62}"
        let base = (14 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 14) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension IuxSvVTOJSaoL {
    static func cNJgXwioDBtXJLbOeA(_ urlString: String, headers: [String: String] = [:]) async throws -> String {
        let data = try await xLCEEBYswjIl(urlString, headers: headers)
        guard let text = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        return text
    }
}
