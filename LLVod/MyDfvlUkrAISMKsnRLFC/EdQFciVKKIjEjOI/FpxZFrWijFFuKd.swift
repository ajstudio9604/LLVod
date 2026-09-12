import Foundation

struct CnihTLLzfVcSCaHRMWu {
    private let session: URLSession
    private let decrypt: (String) throws -> String

    init(session: URLSession, decrypt: @escaping (String) throws -> String) {
        // source-obfuscator:padding:v1
        _ = Self.cALYvOEtqmUMGSRYJ()

        self.session = session
        self.decrypt = decrypt
    }

    func iJJnfQavIAizUtUCTn(
        _ urlString: String
    ) async throws -> FmTzCIXSVNdT {
        do {
            return try await gZvQxzjOJzsnMT(urlString)
        } catch {
            /*
             保留 Flutter 逻辑：
             当前地址不是备用地址时，改为请求备用地址；
             当前已经是备用地址时，不再重复请求。
             */
            guard urlString != "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{6c}\u{6f}\u{67}\u{69}\u{6e}\u{2e}\u{79}\u{69}\u{79}\u{73}\u{30}\u{36}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}\u{7a}\u{79}\u{2e}\u{6a}\u{73}\u{6f}\u{6e}" else { throw error }
            let primaryError = error
            let fallbackURL = "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{6c}\u{6f}\u{67}\u{69}\u{6e}\u{2e}\u{79}\u{69}\u{79}\u{73}\u{30}\u{36}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}\u{7a}\u{79}\u{2e}\u{6a}\u{73}\u{6f}\u{6e}"
            do {
                return try await gZvQxzjOJzsnMT(fallbackURL)
            } catch {
                throw SegVMgxaYBEke(
                    primaryURL: urlString,
                    primaryError: primaryError,
                    fallbackURL: fallbackURL,
                    fallbackError: error
                )
            }
        }
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func cALYvOEtqmUMGSRYJ() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 22, "\u{65}\u{61}\u{73}\u{74}": 26, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 88]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 22) * 4
        let token = "\u{30}\u{62}\u{64}\u{35}\u{66}\u{37}\u{64}\u{62}\u{32}\u{33}\u{36}\u{39}\u{63}\u{32}\u{64}\u{64}\u{61}\u{36}\u{66}\u{63}\u{35}\u{33}\u{34}\u{35}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}



extension CnihTLLzfVcSCaHRMWu {
    private func gZvQxzjOJzsnMT(
        _ urlString: String
    ) async throws -> FmTzCIXSVNdT {
        guard let url = URL(string: urlString) else {
            throw GsxneZnqWwtGcuOkvg.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "\u{47}\u{45}\u{54}"
        request.timeoutInterval = 20

        request.setValue(
            "\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{6a}\u{73}\u{6f}\u{6e}\u{3b} \u{63}\u{68}\u{61}\u{72}\u{73}\u{65}\u{74}\u{3d}\u{75}\u{74}\u{66}\u{2d}\u{38}",
            forHTTPHeaderField: "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{54}\u{79}\u{70}\u{65}"
        )

        request.setValue(
            "\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{6a}\u{73}\u{6f}\u{6e}\u{3b} \u{63}\u{68}\u{61}\u{72}\u{73}\u{65}\u{74}\u{3d}\u{75}\u{74}\u{66}\u{2d}\u{38}",
            forHTTPHeaderField: "\u{41}\u{63}\u{63}\u{65}\u{70}\u{74}"
        )

        /*
         Flutter 原代码写的是 Content-Encoding: gzip。

         Content-Encoding 通常表示请求体经过 gzip 编码，
         GET 请求没有请求体，因此不建议这样设置。

         客户端希望服务器返回 gzip 时，应使用 Accept-Encoding。
         */
        request.setValue(
            "\u{67}\u{7a}\u{69}\u{70}\u{2c} \u{64}\u{65}\u{66}\u{6c}\u{61}\u{74}\u{65}",
            forHTTPHeaderField: "\u{41}\u{63}\u{63}\u{65}\u{70}\u{74}\u{2d}\u{45}\u{6e}\u{63}\u{6f}\u{64}\u{69}\u{6e}\u{67}"
        )

        let (data, response) = try await session.data(
            for: request
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw GsxneZnqWwtGcuOkvg.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw GsxneZnqWwtGcuOkvg.httpError(
                httpResponse.statusCode
            )
        }

        guard !data.isEmpty else {
            throw GsxneZnqWwtGcuOkvg.emptyData
        }

        return try FfggdovnzCxJeJEIBHG.decode(data, decrypt: decrypt)
    }
}
