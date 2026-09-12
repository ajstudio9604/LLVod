






import SwiftUI

struct LkjQqPFGbJBcwGT: View {
    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.oVcXeJlomFSVGxyIsV()

        UswfVlIylKVJmgOnqrP()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func oVcXeJlomFSVGxyIsV() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 85, "\u{65}\u{61}\u{73}\u{74}": 88, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 255]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 85) * 3
        let token = "\u{31}\u{65}\u{31}\u{61}\u{35}\u{62}\u{39}\u{31}\u{33}\u{64}\u{65}\u{39}\u{65}\u{38}\u{37}\u{37}\u{38}\u{33}\u{38}\u{39}\u{35}\u{62}\u{33}\u{34}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}

#Preview {
    LkjQqPFGbJBcwGT()
        .environmentObject(CbyiPVoRONUJO.shared)
}

