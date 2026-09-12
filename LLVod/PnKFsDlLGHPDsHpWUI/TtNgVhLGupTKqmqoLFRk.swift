






import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // source-obfuscator:padding:v1
        _ = Self.nJRoDSkFQfcTw()

        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return OnPrpbuxpZZkoVt.orientation
    }
    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func nJRoDSkFQfcTw() -> String {
        let values = [50, 54, 200, 67]
        let folded = values.map { ($0 * 4 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 50) * 4
        let token = "\u{63}\u{62}\u{31}\u{39}\u{33}\u{34}\u{31}\u{30}\u{31}\u{64}\u{37}\u{63}\u{35}\u{61}\u{38}\u{31}\u{31}\u{62}\u{36}\u{36}\u{62}\u{33}\u{32}\u{62}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}

