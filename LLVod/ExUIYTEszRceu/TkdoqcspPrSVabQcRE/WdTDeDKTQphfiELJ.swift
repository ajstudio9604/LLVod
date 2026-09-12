






import Foundation

actor SearchBatchRequestManager {

    private var isCancelled = false

    func cancelAll() {
        // source-obfuscator:padding:v1
        _ = Self.fTVxBQkKlkGFXz()

        isCancelled = true
    }

    private func cancelled() -> Bool {
        isCancelled
    }

    func pNbjRxzHpsHAPaoew(
        _ paramsList: [KlkwtQJcDoqqkNfKrkYt],
        maxConcurrency: Int = 5,
        onCompleted: @escaping @Sendable (PqwnbXOtbYouONfDwy) async -> Void
    ) async {
        let eOpNRSxoxEdSdCpw: [() async -> KlkwtQJcDoqqkNfKrkYt?] = paramsList.enumerated().map { index, params in
            {
                KlkwtQJcDoqqkNfKrkYt(
                    url: params.url,
                    method: params.method,
                    data: params.data,
                    headers: params.headers,
                    sourceIndex: params.sourceIndex ?? index
                )
            }
        }
        await batchRequestAsReady(eOpNRSxoxEdSdCpw, maxConcurrency: maxConcurrency, onCompleted: onCompleted)
    }

    func batchRequestAsReady(
        _ paramsFutures: [() async -> KlkwtQJcDoqqkNfKrkYt?],
        maxConcurrency: Int = 5,
        onCompleted: @escaping @Sendable (PqwnbXOtbYouONfDwy) async -> Void
    ) async {
        isCancelled = false
        guard !paramsFutures.isEmpty else { return }

        let limit = max(1, maxConcurrency)
        let gate = AHSearchConcurrencyGate(limit: limit)

        await withTaskGroup(of: Void.self) { group in
            for (index, factory) in paramsFutures.enumerated() {
                group.addTask {
                    guard await !self.cancelled() else { return }
                    guard let built = await factory() else { return }

                    let params = KlkwtQJcDoqqkNfKrkYt(
                        url: built.url,
                        method: built.method,
                        data: built.data,
                        headers: built.headers,
                        sourceIndex: built.sourceIndex ?? index
                    )

                    await gate.wait()
                    guard await !self.cancelled() else {
                        await gate.signal()
                        return
                    }

                    let result = await Self.executeRequest(
                        params,
                        fallbackIndex: params.sourceIndex ?? index
                    )
                    await gate.signal()
                    await onCompleted(result)
                }
            }
        }
    }

    private static func executeRequest(
        _ params: KlkwtQJcDoqqkNfKrkYt,
        fallbackIndex: Int
    ) async -> PqwnbXOtbYouONfDwy {
        let index = params.sourceIndex ?? fallbackIndex
        let (response, networkError) = await AzMxNzWBYgAweaTiDELi.pNbjRxzHpsHAPaoew(
            method: params.method,
            urlString: params.url,
            body: params.data,
            headers: params.headers
        )

        if response.statusCode < 0 {
            return PqwnbXOtbYouONfDwy(
                index: index,
                data: nil,
                statusCode: nil,
                errorMessage: networkError ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{78}\u{72}\u{38}\u{38}\u{76}\u{4a}\u{63}\u{6e}"),
                realURI: response.realURI
            )
        }

        if !(200...299).contains(response.statusCode) {
            return PqwnbXOtbYouONfDwy(
                index: index,
                data: response.body.isEmpty ? nil : response.body,
                statusCode: response.statusCode,
                errorMessage: "\u{48}\u{54}\u{54}\u{50} \(response.statusCode)",
                realURI: response.realURI
            )
        }

        return PqwnbXOtbYouONfDwy(
            index: index,
            data: response.body,
            statusCode: response.statusCode,
            errorMessage: nil,
            realURI: response.realURI
        )
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func fTVxBQkKlkGFXz() -> String {
        _ = Self.qKsiPKUPROBQAaouoJK()
        let token = "\u{36}\u{34}\u{33}\u{64}\u{35}\u{36}\u{66}\u{39}\u{37}\u{33}\u{34}\u{64}\u{34}\u{39}\u{34}\u{39}\u{34}\u{36}\u{65}\u{31}\u{33}\u{65}\u{30}\u{36}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{38}\u{34}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 84) * 9
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func qKsiPKUPROBQAaouoJK() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{34}\u{39}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 49) * 3
        let token = "\u{33}\u{39}\u{33}\u{65}\u{64}\u{38}\u{35}\u{66}\u{34}\u{66}\u{37}\u{31}\u{63}\u{39}\u{66}\u{33}\u{61}\u{30}\u{66}\u{36}\u{34}\u{32}\u{38}\u{61}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
}

private actor AHSearchConcurrencyGate {
    private let limit: Int
    private var available: Int
    private var waiters: [CheckedContinuation<Void, Never>] = []

    init(limit: Int) {
        // source-obfuscator:padding:v1
        _ = Self.eYcsvOEOahVs()

        self.limit = limit
        self.available = limit
    }

    func wait() async {
        if available > 0 {
            available -= 1
            return
        }
        await withCheckedContinuation { continuation in
            waiters.append(continuation)
        }
    }

    func signal() {
        if let waiter = waiters.first {
            waiters.removeFirst()
            waiter.resume()
        } else {
            available = min(limit, available + 1)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func eYcsvOEOahVs() -> String {
        let token = "\u{35}\u{65}\u{64}\u{35}\u{33}\u{30}\u{35}\u{39}\u{63}\u{61}\u{35}\u{35}\u{62}\u{61}\u{64}\u{38}\u{62}\u{31}\u{34}\u{65}\u{31}\u{30}\u{62}\u{32}"
        let base = (47 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 47) * 4
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

