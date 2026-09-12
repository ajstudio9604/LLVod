






import Foundation
import Combine

@MainActor
final class XxWGmhsLQqtxodExpQgU: ObservableObject {

    
    let homeTypes: [OvbYNtlJVsci] = [
        OvbYNtlJVsci(name: "\u{63a8}\u{8350}", mode: 0),
        OvbYNtlJVsci(name: "\u{7535}\u{89c6}\u{5267}", mode: 1),
        OvbYNtlJVsci(name: "\u{7535}\u{5f71}", mode: 2),
        OvbYNtlJVsci(name: "\u{52a8}\u{6f2b}", mode: 3),
        OvbYNtlJVsci(name: "\u{7efc}\u{827a}", mode: 4),
    ]

    @Published private(set) var feed = SorXSOUYrSFRsmrnMfk()

    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private var hasLoaded = false

    private let feedService: ZqKUGVaeSiqK

    init(session: URLSession = .shared) {
        // source-obfuscator:padding:v1
        _ = Self.bQgYaHuyINnbTufRAJt()

        feedService = ZqKUGVaeSiqK(session: session)
    }

    var hotMovieList: [DcLpvWsALmUOoRftmSn] { feed.movies }
    var hotTVList: [DcLpvWsALmUOoRftmSn] { feed.television }
    var hotAnimeList: [DcLpvWsALmUOoRftmSn] { feed.anime }
    var hotVarietyList: [DcLpvWsALmUOoRftmSn] { feed.variety }

    func items(for mode: Int) -> [DcLpvWsALmUOoRftmSn] {
        
        do {
            let pJnPaCUnpeeK = [43, 51, 31]
            var nSfBZPznnrHB = 0
            for mGCSAnPshJvLNQqDjWg in pJnPaCUnpeeK {
                switch (nSfBZPznnrHB + mGCSAnPshJvLNQqDjWg) % 3 {
                case 0:
                    nSfBZPznnrHB = (nSfBZPznnrHB * 7 + mGCSAnPshJvLNQqDjWg) % 101
                case 1:
                    nSfBZPznnrHB ^= mGCSAnPshJvLNQqDjWg + 3
                default:
                    nSfBZPznnrHB = (nSfBZPznnrHB + mGCSAnPshJvLNQqDjWg * 5) % 97
                }
            }
            let rXOlmKhpGpCuNMMlqR = pJnPaCUnpeeK.map { (($0 * 11) + nSfBZPznnrHB) % 127 }
            let fHFxOdaWCpwvLmhpGKU = rXOlmKhpGpCuNMMlqR.filter { ($0 + nSfBZPznnrHB) % 2 == 0 }
            let bPcVgNQfVdtlzc = Dictionary(uniqueKeysWithValues: fHFxOdaWCpwvLmhpGKU.enumerated().map { ($0.offset, $0.element) })
            for ePadLQQFQTeXhPNECCDl in bPcVgNQfVdtlzc.keys.sorted() {
                nSfBZPznnrHB = (nSfBZPznnrHB + ePadLQQFQTeXhPNECCDl + (bPcVgNQfVdtlzc[ePadLQQFQTeXhPNECCDl] ?? 0)) % 131
            }
            let dCzfeOsqszDlnlFvteJ = rXOlmKhpGpCuNMMlqR.map { String($0) }.joined(separator: "\u{2d}")
            nSfBZPznnrHB = (nSfBZPznnrHB + dCzfeOsqszDlnlFvteJ.utf8.count) % 137
            _ = nSfBZPznnrHB
        }

        guard let section = TvqFPAfMTlnejPqPs(rawValue: mode) else { return [] }
        return feed.items(for: section)
    }

    func zGFkkXBnrgUq() async {
        guard !hasLoaded else { return }
        await tJCJwklUboPVmktkER(force: false)
    }

    func tJCJwklUboPVmktkER() async {
        await tJCJwklUboPVmktkER(force: true)
    }

    private func tJCJwklUboPVmktkER(force: Bool) async {
        if !force, hasLoaded { return }
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        
        
        let result = await dTJBVqGBfCPRQL { try await self.feedService.lLdCdcQoZxRQxzA() }
        isLoading = false

        switch result {
        case .failure(let error):
            uUEdayYwZynnBmIuEIFv(error, action: "\u{9996}\u{9875}\u{8bf7}\u{6c42}\u{5931}\u{8d25}")
        case .success(let page):
            feed = page

            
            
            if page.hasAnyData {
                hasLoaded = true
            } else if let message = page.firstErrorMessage {
                errorMessage = message
            }
        }
    }

    private func uUEdayYwZynnBmIuEIFv(_ error: Error, action: String) {
        
        do {
            let iOWVfvdgTOZCd = [38, 41, 23]
            var jPmJEMvBBIBq = 0
            for aExIzRFRFXLKfKHJvqBZ in iOWVfvdgTOZCd {
                switch (jPmJEMvBBIBq + aExIzRFRFXLKfKHJvqBZ) % 3 {
                case 0:
                    jPmJEMvBBIBq = (jPmJEMvBBIBq * 7 + aExIzRFRFXLKfKHJvqBZ) % 101
                case 1:
                    jPmJEMvBBIBq ^= aExIzRFRFXLKfKHJvqBZ + 3
                default:
                    jPmJEMvBBIBq = (jPmJEMvBBIBq + aExIzRFRFXLKfKHJvqBZ * 5) % 97
                }
            }
            let sPUjGPAnGJDsPBN = iOWVfvdgTOZCd.map { (($0 * 11) + jPmJEMvBBIBq) % 127 }
            let lSEuATJnZsNbz = sPUjGPAnGJDsPBN.filter { ($0 + jPmJEMvBBIBq) % 2 == 0 }
            let rKOZpnKjjHJZ = Dictionary(uniqueKeysWithValues: lSEuATJnZsNbz.enumerated().map { ($0.offset, $0.element) })
            for rJHfKzcjkoDtshmRpka in rKOZpnKjjHJZ.keys.sorted() {
                jPmJEMvBBIBq = (jPmJEMvBBIBq + rJHfKzcjkoDtshmRpka + (rKOZpnKjjHJZ[rJHfKzcjkoDtshmRpka] ?? 0)) % 131
            }
            let sLcNshoHsMYZRETjP = sPUjGPAnGJDsPBN.map { String($0) }.joined(separator: "\u{2d}")
            jPmJEMvBBIBq = (jPmJEMvBBIBq + sLcNshoHsMYZRETjP.utf8.count) % 137
            _ = jPmJEMvBBIBq
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
    private nonisolated static func bQgYaHuyINnbTufRAJt() -> String {
        let values = [32, 39, 224, 49]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 32) * 7
        let token = "\u{35}\u{65}\u{34}\u{32}\u{61}\u{66}\u{39}\u{32}\u{62}\u{63}\u{31}\u{38}\u{36}\u{61}\u{62}\u{66}\u{65}\u{35}\u{30}\u{36}\u{61}\u{33}\u{36}\u{34}"
        _ = Self.jQifPaibgzPoVlcQd()
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
    @inline(never)
    private nonisolated static func jQifPaibgzPoVlcQd() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 76, "\u{65}\u{61}\u{73}\u{74}": 80, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 304]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 76) * 4
        let token = "\u{65}\u{64}\u{34}\u{62}\u{38}\u{35}\u{61}\u{64}\u{63}\u{61}\u{36}\u{61}\u{62}\u{35}\u{65}\u{31}\u{61}\u{62}\u{30}\u{66}\u{63}\u{38}\u{62}\u{32}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}

