




import Foundation
import SwiftUI

struct JqIVyfygrJYY: Identifiable {
    let id = UUID()
    let time: Double        
    let text: String        
    let color: Color        
    let type: WpzNYyffZmCSNVd   
    let fontSize: CGFloat   

    enum WpzNYyffZmCSNVd: Int {
        case scroll = 1     
        case bottom = 4     
        case top = 5        

        static func kOQABzdGQHlKDBSuQQAn(mode: Int) -> WpzNYyffZmCSNVd {
            switch mode {
            case 4: return .bottom
            case 5: return .top
            default: return .scroll
            }
        }
    }
}

struct VeiHztjEDahyOlz {
    let time: Double
    let text: String
    let colorHex: String
    let type: Int

    init(time: Double, text: String, colorHex: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{37}\u{53}\u{37}\u{5a}\u{70}\u{35}\u{41}\u{34}\u{54}"), type: Int = 1) {
        // source-obfuscator:padding:v1
        _ = Self.pYThZzxynehMi()

        self.time = time
        self.text = text
        self.colorHex = colorHex
        self.type = type
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func pYThZzxynehMi() -> String {
        let values = [14, 21, 98, 31]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 14) * 7
        let token = "\u{33}\u{30}\u{62}\u{31}\u{61}\u{64}\u{65}\u{64}\u{62}\u{65}\u{62}\u{63}\u{30}\u{37}\u{65}\u{34}\u{62}\u{32}\u{36}\u{36}\u{65}\u{38}\u{37}\u{30}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}

struct ZpyCaqfvdmdi {
    let vodName: String
    let episode: Int
    let playURL: String
}

struct NyEntjjjOoTtEDgfOvhY {
    let vodName: String
    let episode: Int
    let text: String
    let colorHex: String
    let time: Double
}

enum HzZfDaHsKSkyMdviQ {
    case success
    case rejected(String?)
    case failed
}

enum UvBxBoMIYrRWck {

    static var provider: ((ZpyCaqfvdmdi, @escaping ([VeiHztjEDahyOlz]) -> Void) -> Void)?

    static var sender: ((NyEntjjjOoTtEDgfOvhY, @escaping (HzZfDaHsKSkyMdviQ) -> Void) -> Void)?
}

enum BekLjtVkGtRK {
    static var colors: [String] = [
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{37}\u{53}\u{37}\u{5a}\u{70}\u{35}\u{41}\u{34}\u{54}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{6a}\u{41}\u{58}\u{70}\u{52}\u{41}\u{65}\u{67}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{76}\u{47}\u{64}\u{62}\u{6c}\u{34}\u{78}\u{48}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{52}\u{50}\u{65}\u{36}\u{49}\u{71}\u{33}\u{41}\u{73}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{6e}\u{6f}\u{7a}\u{52}\u{72}\u{43}\u{50}\u{54}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{35}\u{41}\u{58}\u{6e}\u{33}\u{4d}\u{62}\u{49}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{34}\u{33}\u{56}\u{50}\u{6c}\u{33}\u{4e}\u{56}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{42}\u{63}\u{6c}\u{41}\u{57}\u{4f}\u{52}\u{36}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{71}\u{64}\u{38}\u{7a}\u{76}\u{50}\u{4f}\u{72}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{4e}\u{68}\u{61}\u{65}\u{57}\u{54}\u{4d}\u{61}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{4a}\u{6b}\u{51}\u{45}\u{6e}\u{35}\u{72}\u{79}"), AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{37}\u{6c}\u{6b}\u{50}\u{58}\u{58}\u{41}\u{64}\u{50}")
    ]
}

