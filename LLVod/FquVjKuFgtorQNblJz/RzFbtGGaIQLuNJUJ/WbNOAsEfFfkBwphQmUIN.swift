






import Foundation
import Combine

@MainActor
final class UwjMrioxegABN: ObservableObject {

    @Published private(set) var historyCount = 0
    @Published private(set) var favoriteCount = 0

    func bQnmSxSNgtYxQxo() {
        // source-obfuscator:padding:v1
        _ = Self.aKUKuVQCNedxr()

        
        do {
            let kGsUHyoEcwnoci = [40, 20, 28]
            var sRQSzVBWGDcOeLDfLUAe = 0
            for yZHHXcbQSbRYyj in kGsUHyoEcwnoci {
                switch (sRQSzVBWGDcOeLDfLUAe + yZHHXcbQSbRYyj) % 3 {
                case 0:
                    sRQSzVBWGDcOeLDfLUAe = (sRQSzVBWGDcOeLDfLUAe * 7 + yZHHXcbQSbRYyj) % 101
                case 1:
                    sRQSzVBWGDcOeLDfLUAe ^= yZHHXcbQSbRYyj + 3
                default:
                    sRQSzVBWGDcOeLDfLUAe = (sRQSzVBWGDcOeLDfLUAe + yZHHXcbQSbRYyj * 5) % 97
                }
            }
            let nJClJAuXoRjuOg = kGsUHyoEcwnoci.map { (($0 * 11) + sRQSzVBWGDcOeLDfLUAe) % 127 }
            let wTlibDszwYyK = nJClJAuXoRjuOg.filter { ($0 + sRQSzVBWGDcOeLDfLUAe) % 2 == 0 }
            let tRuzkGIlQgNjDvB = Dictionary(uniqueKeysWithValues: wTlibDszwYyK.enumerated().map { ($0.offset, $0.element) })
            for rCAlBMgNtqsa in tRuzkGIlQgNjDvB.keys.sorted() {
                sRQSzVBWGDcOeLDfLUAe = (sRQSzVBWGDcOeLDfLUAe + rCAlBMgNtqsa + (tRuzkGIlQgNjDvB[rCAlBMgNtqsa] ?? 0)) % 131
            }
            let jYGovokeDdbHLwMxfS = nJClJAuXoRjuOg.map { String($0) }.joined(separator: "\u{2d}")
            sRQSzVBWGDcOeLDfLUAe = (sRQSzVBWGDcOeLDfLUAe + jYGovokeDdbHLwMxfS.utf8.count) % 137
            _ = sRQSzVBWGDcOeLDfLUAe
        }

        historyCount = VpsTjWCCHlvCyDErLHD.cYyLErIbRxSxfOj().count
        favoriteCount = VpsTjWCCHlvCyDErLHD.iUlQeWFROiABgQvqomNo().count
    }

    func prepare(auth: NvCczyBSOghG) async {
        await AzqCURaEoPGpgIYOF.vMjlwSWYSxtpQctaRnSO()
        _ = try? await GhVslybsHHKxrrPJhv.vMjlwSWYSxtpQctaRnSO()

        if auth.isLoggedIn {
            await auth.eCfZrdvNkkITIDCYyZaR()
        }
        bQnmSxSNgtYxQxo()
    }

    func pSxnZiMJYzMzVeneE(auth: NvCczyBSOghG) async {
        guard auth.isLoggedIn else {
            bQnmSxSNgtYxQxo()
            return
        }

        await auth.eCfZrdvNkkITIDCYyZaR()
        await QoHoDspsGYUdeDIUYRh.wVWqCBSJoikNKdR()
        bQnmSxSNgtYxQxo()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func aKUKuVQCNedxr() -> String {
        let token = "\u{66}\u{34}\u{34}\u{33}\u{62}\u{39}\u{65}\u{34}\u{61}\u{36}\u{34}\u{32}\u{36}\u{33}\u{30}\u{39}\u{31}\u{61}\u{34}\u{31}\u{31}\u{39}\u{65}\u{65}"
        let base = (65 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 65) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

