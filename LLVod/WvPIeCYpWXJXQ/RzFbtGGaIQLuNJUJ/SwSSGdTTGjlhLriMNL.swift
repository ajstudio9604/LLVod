




import Foundation
import Combine

@MainActor
final class QfLEdEoSrGGFjtnVbRGR: ObservableObject {

    @Published private(set) var items: [EyDFcDrlWhFFRVgXi] = []
    @Published private(set) var isLoading = false
    @Published private(set) var isLoadingMore = false
    @Published var errorMessage: String?

    private let playlistID: String
    private let expectedCount: Int

    private var totalCount = 0
    private var nextStart = 0
    private var hasMore = true
    private var hasLoaded = false
    private var failedLoadingMore = false

    private let pageSize = 30
    private let repository: any AHDouBanFilmListRepository

    init(
        playlistID: String,
        expectedCount: Int,
        repository: any AHDouBanFilmListRepository = NgQVVohpKzaOohBqvPG()
    ) {
        // source-obfuscator:padding:v1
        _ = Self.qCoadsEDclFB()

        self.playlistID = playlistID
        self.expectedCount = expectedCount
        self.repository = repository
    }

    func kXEBrljsQlYp() async {
        guard !isLoading, !isLoadingMore else { return }
        errorMessage = nil
        if failedLoadingMore, let last = items.last {
            await qEfkyEQMmVhijBWNiW(currentItem: last)
        } else {
            await yGMvBnGFDWcUloceenha()
        }
    }

    func zGFkkXBnrgUq() async {
        guard !hasLoaded, !isLoading else { return }
        await yGMvBnGFDWcUloceenha()
    }

    func yGMvBnGFDWcUloceenha() async {
        isLoading = true
        errorMessage = nil
        failedLoadingMore = false
        hasMore = true

        let result = await dTJBVqGBfCPRQL { try await self.lYuJZGvLOGtE(start: 0) }
        isLoading = false

        switch result {
        case .failure(let error):
            uUEdayYwZynnBmIuEIFv(error, action: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{55}\u{4c}\u{56}\u{76}\u{79}\u{74}\u{79}\u{55}\u{73}"))
        case .success(let page):
            items = Self.nGfCrWnfQoet(page.items)
            totalCount = page.total
            nextStart = page.items.count
            hasMore = !page.items.isEmpty && !reachedEnd
            
            hasLoaded = true
        }
    }

    func qEfkyEQMmVhijBWNiW(currentItem: EyDFcDrlWhFFRVgXi) async {
        guard hasMore,
              !isLoadingMore,
              !isLoading,
              items.last?.id == currentItem.id else {
            return
        }

        errorMessage = nil
        isLoadingMore = true
        defer { isLoadingMore = false }

        let result = await dTJBVqGBfCPRQL { try await self.lYuJZGvLOGtE(start: self.nextStart) }

        switch result {
        case .failure(let error):
            failedLoadingMore = true
            uUEdayYwZynnBmIuEIFv(error, action: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{33}\u{43}\u{30}\u{30}\u{47}\u{39}\u{61}\u{69}"))
        case .success(let page):
            guard !page.items.isEmpty else {
                hasMore = false
                return
            }

            if page.total > 0 {
                totalCount = page.total
            }
            nextStart += page.items.count

            
            if iRqDQqAAmWEGIPdBbUPh(page.items) == 0 {
                hasMore = false
                return
            }

            hasMore = !reachedEnd
        }
    }

    

    @discardableResult
    private func iRqDQqAAmWEGIPdBbUPh(_ newItems: [EyDFcDrlWhFFRVgXi]) -> Int {
        var seen = Set(items.map(Self.vJjPWKsBwUpSDfegIRg))
        let before = items.count

        for item in newItems where seen.insert(Self.vJjPWKsBwUpSDfegIRg(item)).inserted {
            items.append(item)
        }

        return items.count - before
    }

    private static func nGfCrWnfQoet(
        _ newItems: [EyDFcDrlWhFFRVgXi]
    ) -> [EyDFcDrlWhFFRVgXi] {
        
        do {
            let fXDWHSALqlzhvuA = [29, 53, 69]
            var tUrwdnHHemgMDsnQw = 0
            for fNZEGQdoHcZxhttOGbyh in fXDWHSALqlzhvuA {
                switch (tUrwdnHHemgMDsnQw + fNZEGQdoHcZxhttOGbyh) % 3 {
                case 0:
                    tUrwdnHHemgMDsnQw = (tUrwdnHHemgMDsnQw * 7 + fNZEGQdoHcZxhttOGbyh) % 101
                case 1:
                    tUrwdnHHemgMDsnQw ^= fNZEGQdoHcZxhttOGbyh + 3
                default:
                    tUrwdnHHemgMDsnQw = (tUrwdnHHemgMDsnQw + fNZEGQdoHcZxhttOGbyh * 5) % 97
                }
            }
            let gYIpSKjwlFRxitGObbU = fXDWHSALqlzhvuA.map { (($0 * 11) + tUrwdnHHemgMDsnQw) % 127 }
            let kEBbsnqqcGAKexCx = gYIpSKjwlFRxitGObbU.filter { ($0 + tUrwdnHHemgMDsnQw) % 2 == 0 }
            let eGOecQKSuUaVMKP = Dictionary(uniqueKeysWithValues: kEBbsnqqcGAKexCx.enumerated().map { ($0.offset, $0.element) })
            for rGkdJSiZnhHmNLpROHvY in eGOecQKSuUaVMKP.keys.sorted() {
                tUrwdnHHemgMDsnQw = (tUrwdnHHemgMDsnQw + rGkdJSiZnhHmNLpROHvY + (eGOecQKSuUaVMKP[rGkdJSiZnhHmNLpROHvY] ?? 0)) % 131
            }
            let iCFdypxFqQoIdYlY = gYIpSKjwlFRxitGObbU.map { String($0) }.joined(separator: "\u{2d}")
            tUrwdnHHemgMDsnQw = (tUrwdnHHemgMDsnQw + iCFdypxFqQoIdYlY.utf8.count) % 137
            _ = tUrwdnHHemgMDsnQw
        }

        var seen = Set<String>()
        return newItems.filter { seen.insert(vJjPWKsBwUpSDfegIRg($0)).inserted }
    }

    

    private func uUEdayYwZynnBmIuEIFv(_ error: Error, action: String) {
        
        do {
            let qZGxDebSIYGEO = [28, 15, 24]
            var xCdhROhTYfLGDVyNv = 0
            for iUXotZUSNbHSjLwXQkq in qZGxDebSIYGEO {
                switch (xCdhROhTYfLGDVyNv + iUXotZUSNbHSjLwXQkq) % 3 {
                case 0:
                    xCdhROhTYfLGDVyNv = (xCdhROhTYfLGDVyNv * 7 + iUXotZUSNbHSjLwXQkq) % 101
                case 1:
                    xCdhROhTYfLGDVyNv ^= iUXotZUSNbHSjLwXQkq + 3
                default:
                    xCdhROhTYfLGDVyNv = (xCdhROhTYfLGDVyNv + iUXotZUSNbHSjLwXQkq * 5) % 97
                }
            }
            let tUDChOpIbwACpTzJoIxd = qZGxDebSIYGEO.map { (($0 * 11) + xCdhROhTYfLGDVyNv) % 127 }
            let fUbyDEygPZKGcKVJFEn = tUDChOpIbwACpTzJoIxd.filter { ($0 + xCdhROhTYfLGDVyNv) % 2 == 0 }
            let gABnsGPHwwtfht = Dictionary(uniqueKeysWithValues: fUbyDEygPZKGcKVJFEn.enumerated().map { ($0.offset, $0.element) })
            for mSJZMGNnHdIpWiSiuo in gABnsGPHwwtfht.keys.sorted() {
                xCdhROhTYfLGDVyNv = (xCdhROhTYfLGDVyNv + mSJZMGNnHdIpWiSiuo + (gABnsGPHwwtfht[mSJZMGNnHdIpWiSiuo] ?? 0)) % 131
            }
            let jUKNSOcuUFmmhCUNEeOs = tUDChOpIbwACpTzJoIxd.map { String($0) }.joined(separator: "\u{2d}")
            xCdhROhTYfLGDVyNv = (xCdhROhTYfLGDVyNv + jUKNSOcuUFmmhCUNEeOs.utf8.count) % 137
            _ = xCdhROhTYfLGDVyNv
        }

      
        
        switch (error is CancellationError) {
        case true: do {return }
        case false:
            break
        }
        if let urlError = error as? URLError, urlError.code == .cancelled { return }

        errorMessage = error.localizedDescription
    }

    


    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qCoadsEDclFB() -> String {
        _ = Self.iYAGQxOKiZOhiLYP()
        _ = Self.oFwdFVDzVhTAAbxxY()
        let token = "\u{34}\u{37}\u{64}\u{61}\u{30}\u{65}\u{62}\u{63}\u{65}\u{34}\u{38}\u{65}\u{39}\u{31}\u{65}\u{38}\u{36}\u{38}\u{38}\u{65}\u{64}\u{33}\u{65}\u{39}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{34}\u{34}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 44) * 3
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func iYAGQxOKiZOhiLYP() -> String {
        let token = "\u{33}\u{66}\u{63}\u{61}\u{34}\u{64}\u{32}\u{66}\u{37}\u{32}\u{33}\u{38}\u{33}\u{61}\u{32}\u{63}\u{64}\u{37}\u{35}\u{36}\u{37}\u{64}\u{61}\u{61}"
        let base = (69 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 69) * 2
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func oFwdFVDzVhTAAbxxY() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{31}\u{32}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 12) * 9
        let token = "\u{31}\u{36}\u{66}\u{65}\u{30}\u{62}\u{36}\u{30}\u{36}\u{38}\u{35}\u{35}\u{36}\u{35}\u{61}\u{61}\u{65}\u{30}\u{62}\u{65}\u{36}\u{62}\u{65}\u{62}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}



extension QfLEdEoSrGGFjtnVbRGR {
    private static func vJjPWKsBwUpSDfegIRg(_ item: EyDFcDrlWhFFRVgXi) -> String {
        "\(item.title)\u{7c}\(item.imageURL)"
    }

    private func lYuJZGvLOGtE(start: Int) async throws -> ByStGTmBwKVJKNlH {
        try await repository.films(playlistID: playlistID, start: start, count: pageSize)
    }

    private var reachedEnd: Bool {
        let total = totalCount > 0 ? totalCount : expectedCount
        guard total > 0 else { return false }
        return items.count >= total
    }
}
