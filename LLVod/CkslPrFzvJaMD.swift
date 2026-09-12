






import SwiftUI

@main
struct LLVodApp: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // source-obfuscator:padding:v1
        let _ = Self.dYcseKwCkKQLbIVCGgq()

        WindowGroup {
            JlEJfSpxSpqaL {
                CfiTLjnAqOBvwvS()
            }
            .environmentObject(CbyiPVoRONUJO.shared)
            .background(BscyIwBACbmNs())
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func dYcseKwCkKQLbIVCGgq() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 19, "\u{65}\u{61}\u{73}\u{74}": 21, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 38]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 19) * 2
        let token = "\u{62}\u{66}\u{32}\u{63}\u{37}\u{66}\u{63}\u{63}\u{35}\u{64}\u{39}\u{63}\u{39}\u{61}\u{35}\u{39}\u{33}\u{33}\u{34}\u{32}\u{30}\u{35}\u{34}\u{61}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

