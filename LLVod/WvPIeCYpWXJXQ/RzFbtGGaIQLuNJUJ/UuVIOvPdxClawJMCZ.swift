




import Foundation
import Combine

@MainActor
final class FtlBotApdQvTuJhsRwI: ObservableObject {

    let tabs: [EculVzlfyFSWuDv] = [
        EculVzlfyFSWuDv(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{4a}\u{49}\u{4a}\u{55}\u{31}\u{6e}\u{52}\u{4b}"), category: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{4f}\u{38}\u{75}\u{67}\u{69}\u{45}\u{56}\u{76}")),
        EculVzlfyFSWuDv(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{50}\u{66}\u{39}\u{54}\u{77}\u{49}\u{73}\u{51}"), category: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{38}\u{6b}\u{57}\u{44}\u{59}\u{4f}\u{38}\u{61}")),
        EculVzlfyFSWuDv(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{4e}\u{41}\u{73}\u{50}\u{50}\u{72}\u{41}\u{68}"), category: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{63}\u{59}\u{7a}\u{74}\u{61}\u{59}\u{55}\u{4a}")),
        EculVzlfyFSWuDv(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{4a}\u{62}\u{67}\u{67}\u{68}\u{4f}\u{71}\u{5a}"), category: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{6b}\u{34}\u{71}\u{6b}\u{50}\u{42}\u{47}\u{30}")),
        EculVzlfyFSWuDv(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{59}\u{7a}\u{73}\u{58}\u{63}\u{6e}\u{66}\u{6e}"), category: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{54}\u{44}\u{78}\u{6c}\u{4a}\u{6c}\u{43}\u{5a}")),
        EculVzlfyFSWuDv(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{47}\u{74}\u{55}\u{72}\u{68}\u{6a}\u{74}\u{42}"), category: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{49}\u{72}\u{69}\u{76}\u{74}\u{66}\u{67}\u{39}")),
        EculVzlfyFSWuDv(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{57}\u{77}\u{6b}\u{54}\u{63}\u{65}\u{73}\u{75}\u{32}"), category: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{5a}\u{64}\u{55}\u{45}\u{4a}\u{43}\u{75}\u{67}\u{67}")),
        EculVzlfyFSWuDv(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{43}\u{65}\u{76}\u{64}\u{49}\u{4e}\u{59}\u{35}"), category: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{67}\u{32}\u{48}\u{38}\u{6c}\u{4b}\u{6a}\u{41}")),
    ]

    private var pieceViewModels: [String: EizFlwEHoMPRnxjsSfB] = [:]

    func pDRdQNffzXzAx(for tab: EculVzlfyFSWuDv) -> EizFlwEHoMPRnxjsSfB {
        // source-obfuscator:padding:v1
        _ = Self.hRZxSJoyQzCMa()

        
        do {
            let zVlDqOnRegUqXENRC = [22, 31, 63]
            var fWBoXFwdMIZFpsrj = 0
            for dCzPxkPjjTQCZ in zVlDqOnRegUqXENRC {
                switch (fWBoXFwdMIZFpsrj + dCzPxkPjjTQCZ) % 3 {
                case 0:
                    fWBoXFwdMIZFpsrj = (fWBoXFwdMIZFpsrj * 7 + dCzPxkPjjTQCZ) % 101
                case 1:
                    fWBoXFwdMIZFpsrj ^= dCzPxkPjjTQCZ + 3
                default:
                    fWBoXFwdMIZFpsrj = (fWBoXFwdMIZFpsrj + dCzPxkPjjTQCZ * 5) % 97
                }
            }
            let rYlrKwcQSVOS = zVlDqOnRegUqXENRC.map { (($0 * 11) + fWBoXFwdMIZFpsrj) % 127 }
            let vOdnxXPBmvZqQza = rYlrKwcQSVOS.filter { ($0 + fWBoXFwdMIZFpsrj) % 2 == 0 }
            let kEJdMdclxuesmc = Dictionary(uniqueKeysWithValues: vOdnxXPBmvZqQza.enumerated().map { ($0.offset, $0.element) })
            for cOvrEVAKyPYanFb in kEJdMdclxuesmc.keys.sorted() {
                fWBoXFwdMIZFpsrj = (fWBoXFwdMIZFpsrj + cOvrEVAKyPYanFb + (kEJdMdclxuesmc[cOvrEVAKyPYanFb] ?? 0)) % 131
            }
            let gVXVjACTDntwFjb = rYlrKwcQSVOS.map { String($0) }.joined(separator: "\u{2d}")
            fWBoXFwdMIZFpsrj = (fWBoXFwdMIZFpsrj + gVXVjACTDntwFjb.utf8.count) % 137
            _ = fWBoXFwdMIZFpsrj
        }

        if let existing = pieceViewModels[tab.category] {
            return existing
        }

        let viewModel = EizFlwEHoMPRnxjsSfB(category: tab.category)
        pieceViewModels[tab.category] = viewModel
        return viewModel
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func hRZxSJoyQzCMa() -> String {
        let token = "\u{31}\u{32}\u{32}\u{36}\u{39}\u{61}\u{36}\u{32}\u{33}\u{66}\u{33}\u{65}\u{32}\u{30}\u{66}\u{32}\u{61}\u{36}\u{33}\u{30}\u{62}\u{65}\u{62}\u{38}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{37}\u{31}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 71) * 3
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

