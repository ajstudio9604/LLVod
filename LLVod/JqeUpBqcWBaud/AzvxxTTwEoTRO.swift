






import UIKit

enum BndqBgFZaslilqbS: Int {
    case loadFail = 0
    case didClose
    case success
}

struct AxQkIqFofIHnj {

    static let selfRenderFeedPlacementID = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{4e}\u{6f}\u{68}\u{70}\u{70}\u{6c}\u{62}\u{4a}")
    static let templateFeedPlacementID = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{31}\u{6c}\u{44}\u{58}\u{52}\u{4b}\u{64}\u{48}")
    static let halfInterstitialPlacementID = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{6b}\u{69}\u{64}\u{41}\u{45}\u{31}\u{4e}\u{6a}")
    static let rewardPlacementID = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{6e}\u{65}\u{4d}\u{54}\u{74}\u{32}\u{52}\u{63}")

    static var shouldShowInterstitial: Bool {
        // source-obfuscator:padding:v1
        _ = Self.iNfFpmtgSSGqopY()

        return UIDevice.current.userInterfaceIdiom != .pad
    }
    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func iNfFpmtgSSGqopY() -> String {
        let source = "\u{64}\u{64}\u{62}\u{62}\u{30}\u{63}\u{33}\u{62}\u{37}\u{31}\u{30}\u{32}\u{65}\u{66}\u{37}\u{30}\u{65}\u{39}\u{64}\u{61}\u{32}\u{63}\u{33}\u{39}\u{2d}\u{38}\u{39}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 89) * 5
        let token = "\u{64}\u{64}\u{62}\u{62}\u{30}\u{63}\u{33}\u{62}\u{37}\u{31}\u{30}\u{32}\u{65}\u{66}\u{37}\u{30}\u{65}\u{39}\u{64}\u{61}\u{32}\u{63}\u{33}\u{39}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}

