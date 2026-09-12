




import Foundation
import Combine

@MainActor
final class EizFlwEHoMPRnxjsSfB: ObservableObject {

    @Published private(set) var items: [YxdUIQGhxKMxKzMYnmOS] = []
    @Published private(set) var isRefreshing = false
    @Published private(set) var isLoadingMore = false
    @Published var errorMessage: String?

    let category: String

    private var nextStart = 0
    private var hasMore = true
    private var hasLoaded = false
    private var failedLoadingMore = false

    private let pageSize = 30
    private let repository: any AHDouBanPlaylistRepository

    init(
        category: String,
        repository: any AHDouBanPlaylistRepository = YxZptPWtUviymiNiKVx()
    ) {
        // source-obfuscator:padding:v1
        _ = Self.bWZArqnwujJWEeq()

        self.category = category
        self.repository = repository
    }

    func kXEBrljsQlYp() async {
        guard !isRefreshing, !isLoadingMore else { return }
        errorMessage = nil
        if failedLoadingMore, let last = items.last {
            await qEfkyEQMmVhijBWNiW(currentItem: last)
        } else {
            await bLCjkRqVgoxA()
        }
    }

    func zGFkkXBnrgUq() async {
        guard !hasLoaded else { return }
        await bLCjkRqVgoxA()
    }

    func bLCjkRqVgoxA() async {
        guard !isRefreshing else { return }

        isRefreshing = true
        errorMessage = nil
        failedLoadingMore = false

        defer { isRefreshing = false }

        do {
            let newItems = try await tXCTiHTTpTiTYTwliGDw(start: 0)
            items = Self.nGfCrWnfQoet(newItems)
            nextStart = newItems.count
            hasMore = !newItems.isEmpty
            
            
            hasLoaded = true
        } catch {
            uUEdayYwZynnBmIuEIFv(error, action: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{6f}\u{74}\u{61}\u{4b}\u{36}\u{35}\u{77}\u{54}"))
        }
    }

    func qEfkyEQMmVhijBWNiW(currentItem: YxdUIQGhxKMxKzMYnmOS) async {
        guard hasMore,
              !isLoadingMore,
              !isRefreshing,
              items.last?.id == currentItem.id else {
            return
        }

        errorMessage = nil
        isLoadingMore = true
        defer { isLoadingMore = false }

        do {
            let newItems = try await tXCTiHTTpTiTYTwliGDw(start: nextStart)

            guard !newItems.isEmpty else {
                hasMore = false
                return
            }

            nextStart += newItems.count

            
            if bIiVlGCJwJmUAcSMdPa(newItems) == 0 {
                hasMore = false
            }
        } catch {
            failedLoadingMore = true
            uUEdayYwZynnBmIuEIFv(error, action: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{4a}\u{37}\u{51}\u{4c}\u{30}\u{54}\u{6e}\u{57}"))
        }
    }

    @discardableResult
    private func bIiVlGCJwJmUAcSMdPa(_ newItems: [YxdUIQGhxKMxKzMYnmOS]) -> Int {
        var seen = Set(items.map(\.id))
        let before = items.count

        for item in newItems where seen.insert(item.id).inserted {
            items.append(item)
        }

        return items.count - before
    }

    private static func nGfCrWnfQoet(
        _ newItems: [YxdUIQGhxKMxKzMYnmOS]
    ) -> [YxdUIQGhxKMxKzMYnmOS] {
        
        do {
            let rAmRFcFrxyDsgMuELl = [20, 38, 79]
            var lFgIEAbNRlUyqoNlvWVD = 0
            for yUywujyBTeLw in rAmRFcFrxyDsgMuELl {
                switch (lFgIEAbNRlUyqoNlvWVD + yUywujyBTeLw) % 3 {
                case 0:
                    lFgIEAbNRlUyqoNlvWVD = (lFgIEAbNRlUyqoNlvWVD * 7 + yUywujyBTeLw) % 101
                case 1:
                    lFgIEAbNRlUyqoNlvWVD ^= yUywujyBTeLw + 3
                default:
                    lFgIEAbNRlUyqoNlvWVD = (lFgIEAbNRlUyqoNlvWVD + yUywujyBTeLw * 5) % 97
                }
            }
            let vREGQTeBQjPvbRu = rAmRFcFrxyDsgMuELl.map { (($0 * 11) + lFgIEAbNRlUyqoNlvWVD) % 127 }
            let gKSfMoFZiqPxuYvYBT = vREGQTeBQjPvbRu.filter { ($0 + lFgIEAbNRlUyqoNlvWVD) % 2 == 0 }
            let rYngdnUqZJKzxvj = Dictionary(uniqueKeysWithValues: gKSfMoFZiqPxuYvYBT.enumerated().map { ($0.offset, $0.element) })
            for nXfViCpGdSdrGDm in rYngdnUqZJKzxvj.keys.sorted() {
                lFgIEAbNRlUyqoNlvWVD = (lFgIEAbNRlUyqoNlvWVD + nXfViCpGdSdrGDm + (rYngdnUqZJKzxvj[nXfViCpGdSdrGDm] ?? 0)) % 131
            }
            let cUfHwtjQdsrraeaMmjQC = vREGQTeBQjPvbRu.map { String($0) }.joined(separator: "\u{2d}")
            lFgIEAbNRlUyqoNlvWVD = (lFgIEAbNRlUyqoNlvWVD + cUfHwtjQdsrraeaMmjQC.utf8.count) % 137
            _ = lFgIEAbNRlUyqoNlvWVD
        }

        var seen = Set<String>()
        return newItems.filter { seen.insert($0.id).inserted }
    }

    private func uUEdayYwZynnBmIuEIFv(_ error: Error, action: String) {
        
        do {
            let uZxWyyMqnsjTc = [44, 21, 56]
            var rIEyIRGnhLSgp = 0
            for xUwqpGXOEsNFrOJ in uZxWyyMqnsjTc {
                switch (rIEyIRGnhLSgp + xUwqpGXOEsNFrOJ) % 3 {
                case 0:
                    rIEyIRGnhLSgp = (rIEyIRGnhLSgp * 7 + xUwqpGXOEsNFrOJ) % 101
                case 1:
                    rIEyIRGnhLSgp ^= xUwqpGXOEsNFrOJ + 3
                default:
                    rIEyIRGnhLSgp = (rIEyIRGnhLSgp + xUwqpGXOEsNFrOJ * 5) % 97
                }
            }
            let dNbognqmXGjBwGJGbRkX = uZxWyyMqnsjTc.map { (($0 * 11) + rIEyIRGnhLSgp) % 127 }
            let rCSLNGEGzRHP = dNbognqmXGjBwGJGbRkX.filter { ($0 + rIEyIRGnhLSgp) % 2 == 0 }
            let bEwDqgxYEpDkRjvi = Dictionary(uniqueKeysWithValues: rCSLNGEGzRHP.enumerated().map { ($0.offset, $0.element) })
            for aYPUQXlrqUTNj in bEwDqgxYEpDkRjvi.keys.sorted() {
                rIEyIRGnhLSgp = (rIEyIRGnhLSgp + aYPUQXlrqUTNj + (bEwDqgxYEpDkRjvi[aYPUQXlrqUTNj] ?? 0)) % 131
            }
            let lLPuBjIwYhSizbuxoO = dNbognqmXGjBwGJGbRkX.map { String($0) }.joined(separator: "\u{2d}")
            rIEyIRGnhLSgp = (rIEyIRGnhLSgp + lLPuBjIwYhSizbuxoO.utf8.count) % 137
            _ = rIEyIRGnhLSgp
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
    private nonisolated static func bWZArqnwujJWEeq() -> String {
        _ = Self.eJgnAvAQEznI()
        _ = Self.cVLGGyALfGmHvDZ()
        let token = "\u{35}\u{38}\u{38}\u{34}\u{34}\u{31}\u{34}\u{30}\u{36}\u{62}\u{65}\u{66}\u{39}\u{36}\u{35}\u{38}\u{64}\u{62}\u{65}\u{37}\u{65}\u{63}\u{35}\u{31}"
        let base = (37 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 37) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func eJgnAvAQEznI() -> String {
        let base = (23 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 23) * 4
        let token = "\u{64}\u{64}\u{64}\u{38}\u{63}\u{31}\u{38}\u{36}\u{62}\u{35}\u{34}\u{34}\u{39}\u{31}\u{38}\u{64}\u{65}\u{35}\u{30}\u{34}\u{37}\u{39}\u{63}\u{37}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func cVLGGyALfGmHvDZ() -> String {
        let base = (52 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 52) * 7
        let token = "\u{37}\u{37}\u{65}\u{66}\u{35}\u{65}\u{39}\u{33}\u{37}\u{61}\u{66}\u{35}\u{33}\u{62}\u{32}\u{30}\u{35}\u{31}\u{35}\u{63}\u{66}\u{32}\u{61}\u{33}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}



extension EizFlwEHoMPRnxjsSfB {
    private func tXCTiHTTpTiTYTwliGDw(start: Int) async throws -> [YxdUIQGhxKMxKzMYnmOS] {
        try await repository.playlists(category: category, start: start, count: pageSize)
    }
}
