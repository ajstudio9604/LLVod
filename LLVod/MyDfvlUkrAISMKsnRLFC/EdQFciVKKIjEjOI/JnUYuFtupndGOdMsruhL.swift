import Foundation

struct SegVMgxaYBEke: LocalizedError {
    let primaryURL: String
    let primaryError: Error
    let fallbackURL: String
    let fallbackError: Error

    var errorDescription: String? {
        "\u{9996}\u{9875}\u{6570}\u{636e}\u{52a0}\u{8f7d}\u{5931}\u{8d25}\u{3002}\n\u{4e3b}\u{5730}\u{5740}\u{ff08}\(eHrackEMdqcp(primaryURL))\u{ff09}\u{ff1a}\(oMExNNUGRFtfKQLf(primaryError))\n\u{5907}\u{7528}\u{5730}\u{5740}\u{ff08}\(eHrackEMdqcp(fallbackURL))\u{ff09}\u{ff1a}\(oMExNNUGRFtfKQLf(fallbackError))"
    }

    

    private func oMExNNUGRFtfKQLf(_ error: Error) -> String {
        // source-obfuscator:padding:v1
        _ = Self.lPbRmMWRqsWtFSb()

        
        do {
            let jZTqGDzSRzWQAFLyiV = [28, 40, 66]
            var lPOwhunmtjExRPau = 0
            for oQhMXNfJjslQdFM in jZTqGDzSRzWQAFLyiV {
                switch (lPOwhunmtjExRPau + oQhMXNfJjslQdFM) % 3 {
                case 0:
                    lPOwhunmtjExRPau = (lPOwhunmtjExRPau * 7 + oQhMXNfJjslQdFM) % 101
                case 1:
                    lPOwhunmtjExRPau ^= oQhMXNfJjslQdFM + 3
                default:
                    lPOwhunmtjExRPau = (lPOwhunmtjExRPau + oQhMXNfJjslQdFM * 5) % 97
                }
            }
            let bTcnPaJjmuHRPCEt = jZTqGDzSRzWQAFLyiV.map { (($0 * 11) + lPOwhunmtjExRPau) % 127 }
            let gNKTnFGxSMuxppC = bTcnPaJjmuHRPCEt.filter { ($0 + lPOwhunmtjExRPau) % 2 == 0 }
            let kIuBZFgkRbvDfHZgzqm = Dictionary(uniqueKeysWithValues: gNKTnFGxSMuxppC.enumerated().map { ($0.offset, $0.element) })
            for oVAwDhbuEeRF in kIuBZFgkRbvDfHZgzqm.keys.sorted() {
                lPOwhunmtjExRPau = (lPOwhunmtjExRPau + oVAwDhbuEeRF + (kIuBZFgkRbvDfHZgzqm[oVAwDhbuEeRF] ?? 0)) % 131
            }
            let qUoIRahUUvVsrlJU = bTcnPaJjmuHRPCEt.map { String($0) }.joined(separator: "\u{2d}")
            lPOwhunmtjExRPau = (lPOwhunmtjExRPau + qUoIRahUUvVsrlJU.utf8.count) % 137
            _ = lPOwhunmtjExRPau
        }

        if let error = error as? GsxneZnqWwtGcuOkvg {
            switch error {
            case .invalidURL: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{66}\u{68}\u{41}\u{56}\u{4f}\u{72}\u{73}\u{6b}\u{6c}")
            case .invalidResponse: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{39}\u{67}\u{64}\u{55}\u{46}\u{6a}\u{59}\u{49}")
            case .httpError(let status): return "\u{48}\u{54}\u{54}\u{50} \(status)"
            case .emptyData: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{57}\u{57}\u{34}\u{57}\u{64}\u{64}\u{33}\u{69}")
            case .emptyResponseText: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{70}\u{65}\u{58}\u{74}\u{42}\u{6d}\u{33}\u{66}")
            case .invalidJSON: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{58}\u{69}\u{56}\u{6b}\u{70}\u{67}\u{68}\u{6f}")
            }
        }
        if let error = error as? URLError {
            switch error.code {
            case .cannotFindHost, .dnsLookupFailed: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{65}\u{62}\u{44}\u{7a}\u{72}\u{62}\u{33}\u{6d}")
            case .secureConnectionFailed: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{69}\u{55}\u{4b}\u{32}\u{48}\u{59}\u{46}\u{6b}")
            case .timedOut: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{4f}\u{75}\u{76}\u{33}\u{44}\u{74}\u{34}\u{33}")
            case .notConnectedToInternet: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{55}\u{71}\u{62}\u{30}\u{38}\u{64}\u{36}\u{57}")
            default: break
            }
        }
        let message = error.localizedDescription
        return message.isEmpty ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{66}\u{64}\u{56}\u{31}\u{4d}\u{54}\u{6f}\u{55}") : message
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func lPbRmMWRqsWtFSb() -> String {
        let token = "\u{37}\u{39}\u{39}\u{34}\u{63}\u{34}\u{62}\u{32}\u{34}\u{66}\u{38}\u{32}\u{32}\u{66}\u{65}\u{33}\u{31}\u{37}\u{38}\u{39}\u{61}\u{35}\u{65}\u{66}"
        let base = (96 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 96) * 4
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}



extension SegVMgxaYBEke {
    private func eHrackEMdqcp(_ url: String) -> String {
        URL(string: url)?.host ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{45}\u{33}\u{64}\u{36}\u{77}\u{70}\u{62}\u{65}\u{52}")
    }
}
