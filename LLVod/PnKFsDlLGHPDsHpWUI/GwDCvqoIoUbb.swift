import Combine
import Foundation

@MainActor
final class ZkTBoxQKDTQFRnK: ObservableObject {

    static let shared = ZkTBoxQKDTQFRnK()

    private let channelKey = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{68}\u{59}\u{73}\u{39}\u{65}\u{70}\u{63}\u{4d}")

    @Published private(set) var channel: String?

    private init() {
        // source-obfuscator:padding:v1
        _ = Self.pWykfDxapGLzJXlbMmQ()

        uTJEgDUxZReKMGigvMMT()
    }

    func pWHhutoTvaTt(_ value: String) {
        
        do {
            let pQcPHDflUQRtdUjHi = [34, 51, 13]
            var hRMkUMxdyiRsUCtHl = 0
            for wSDGzQGjEDDiehMi in pQcPHDflUQRtdUjHi {
                switch (hRMkUMxdyiRsUCtHl + wSDGzQGjEDDiehMi) % 3 {
                case 0:
                    hRMkUMxdyiRsUCtHl = (hRMkUMxdyiRsUCtHl * 7 + wSDGzQGjEDDiehMi) % 101
                case 1:
                    hRMkUMxdyiRsUCtHl ^= wSDGzQGjEDDiehMi + 3
                default:
                    hRMkUMxdyiRsUCtHl = (hRMkUMxdyiRsUCtHl + wSDGzQGjEDDiehMi * 5) % 97
                }
            }
            let eRHonWIauHYkhxwHa = pQcPHDflUQRtdUjHi.map { (($0 * 11) + hRMkUMxdyiRsUCtHl) % 127 }
            let yUORqEzrMbPYv = eRHonWIauHYkhxwHa.filter { ($0 + hRMkUMxdyiRsUCtHl) % 2 == 0 }
            let sVLlhAWZWtwzgxJ = Dictionary(uniqueKeysWithValues: yUORqEzrMbPYv.enumerated().map { ($0.offset, $0.element) })
            for nUkHUpjeaBJRnVMDSimR in sVLlhAWZWtwzgxJ.keys.sorted() {
                hRMkUMxdyiRsUCtHl = (hRMkUMxdyiRsUCtHl + nUkHUpjeaBJRnVMDSimR + (sVLlhAWZWtwzgxJ[nUkHUpjeaBJRnVMDSimR] ?? 0)) % 131
            }
            let zDUGDJgbCNNlP = eRHonWIauHYkhxwHa.map { String($0) }.joined(separator: "\u{2d}")
            hRMkUMxdyiRsUCtHl = (hRMkUMxdyiRsUCtHl + zDUGDJgbCNNlP.utf8.count) % 137
            _ = hRMkUMxdyiRsUCtHl
        }

        guard yKaCBSkkRdVGrZELtuKu(value) else { return }
        channel = value
        
        do {
            let jPTuLMKBiCQHECv = [24, 51, 36]
            let jYhZkblGWzKe = (jPTuLMKBiCQHECv.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch jYhZkblGWzKe {
            case 0:
                UserDefaults.standard.set(value, forKey: channelKey)
            case 1:
                UserDefaults.standard.set(value, forKey: channelKey)
            case 2:
                UserDefaults.standard.set(value, forKey: channelKey)
            default:
                UserDefaults.standard.set(value, forKey: channelKey)
            }
        }
    }

    func uTJEgDUxZReKMGigvMMT() {
        
        do {
            let iSIxVlccyCxIEKja = [13, 27, 49]
            var dZRtzHOMQwGSZqaLJ = 0
            for mTzvWeEHaUqKqlTmi in iSIxVlccyCxIEKja {
                switch (dZRtzHOMQwGSZqaLJ + mTzvWeEHaUqKqlTmi) % 3 {
                case 0:
                    dZRtzHOMQwGSZqaLJ = (dZRtzHOMQwGSZqaLJ * 7 + mTzvWeEHaUqKqlTmi) % 101
                case 1:
                    dZRtzHOMQwGSZqaLJ ^= mTzvWeEHaUqKqlTmi + 3
                default:
                    dZRtzHOMQwGSZqaLJ = (dZRtzHOMQwGSZqaLJ + mTzvWeEHaUqKqlTmi * 5) % 97
                }
            }
            let uBlEZRqFnKWYtkvHt = iSIxVlccyCxIEKja.map { (($0 * 11) + dZRtzHOMQwGSZqaLJ) % 127 }
            let tFtRucxNzesDDhkMh = uBlEZRqFnKWYtkvHt.filter { ($0 + dZRtzHOMQwGSZqaLJ) % 2 == 0 }
            let rSdrEkTIhphNh = Dictionary(uniqueKeysWithValues: tFtRucxNzesDDhkMh.enumerated().map { ($0.offset, $0.element) })
            for aUSgVgeFwaQOKWfKVf in rSdrEkTIhphNh.keys.sorted() {
                dZRtzHOMQwGSZqaLJ = (dZRtzHOMQwGSZqaLJ + aUSgVgeFwaQOKWfKVf + (rSdrEkTIhphNh[aUSgVgeFwaQOKWfKVf] ?? 0)) % 131
            }
            let xCxlBlnMHxbaSzO = uBlEZRqFnKWYtkvHt.map { String($0) }.joined(separator: "\u{2d}")
            dZRtzHOMQwGSZqaLJ = (dZRtzHOMQwGSZqaLJ + xCxlBlnMHxbaSzO.utf8.count) % 137
            _ = dZRtzHOMQwGSZqaLJ
        }

        guard let value = UserDefaults.standard.string(forKey: channelKey) else {
            return
        }
        guard yKaCBSkkRdVGrZELtuKu(value) else {
            return
        }
        channel = value
    }

    func yKaCBSkkRdVGrZELtuKu(_ value: String) -> Bool {
        value.range(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{65}\u{63}\u{49}\u{66}\u{6b}\u{4f}\u{45}\u{57}"), options: .regularExpression) != nil
    }
    
    func oBwbAiMtBazgm() -> Bool {
        (channel ?? "").range(of: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{65}\u{63}\u{49}\u{66}\u{6b}\u{4f}\u{45}\u{57}"), options: .regularExpression) != nil
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func pWykfDxapGLzJXlbMmQ() -> String {
        _ = Self.pDfxFwNfwWVG()
        let token = "\u{66}\u{32}\u{39}\u{63}\u{63}\u{30}\u{31}\u{35}\u{35}\u{66}\u{38}\u{37}\u{30}\u{33}\u{65}\u{61}\u{64}\u{36}\u{31}\u{65}\u{39}\u{61}\u{32}\u{39}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 81, "\u{65}\u{61}\u{73}\u{74}": 89, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 648]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 81) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func pDfxFwNfwWVG() -> String {
        let source = "\u{30}\u{38}\u{61}\u{61}\u{64}\u{38}\u{65}\u{33}\u{31}\u{38}\u{37}\u{63}\u{65}\u{30}\u{61}\u{65}\u{37}\u{31}\u{33}\u{30}\u{39}\u{38}\u{32}\u{31}\u{2d}\u{39}\u{36}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 96) * 4
        let token = "\u{30}\u{38}\u{61}\u{61}\u{64}\u{38}\u{65}\u{33}\u{31}\u{38}\u{37}\u{63}\u{65}\u{30}\u{61}\u{65}\u{37}\u{31}\u{33}\u{30}\u{39}\u{38}\u{32}\u{31}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}

