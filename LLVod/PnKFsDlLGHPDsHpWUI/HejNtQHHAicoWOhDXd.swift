






import Combine
import Foundation
import SwiftUI
import Combine
import UIKit

extension Color {
    static let themeRed = Color(red: 233/255,
                                green: 82/255,
                                blue: 81/255)
}

final class CbyiPVoRONUJO: ObservableObject {
    static let shared = CbyiPVoRONUJO()

    @Published private(set) var mainTheme: NwfHDzttAeECjwqGItY

    private let themeKey = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{61}\u{70}\u{33}\u{4f}\u{62}\u{6a}\u{55}\u{58}")

    private init() {
        // source-obfuscator:padding:v1
        _ = Self.lFSefZUDrlwfgJUXEsUV()

        if let raw = UserDefaults.standard.object(forKey: themeKey) as? Int,
           let stored = NwfHDzttAeECjwqGItY(rawValue: raw) {
            mainTheme = stored
        } else {
            mainTheme = .system
        }
        lIBSXIIpaGKLVWNYKoTG(mainTheme)
    }

    func gUdDZmJFdTHOR(_ theme: NwfHDzttAeECjwqGItY) {
        mainTheme = theme
        UserDefaults.standard.set(theme.rawValue, forKey: themeKey)
        lIBSXIIpaGKLVWNYKoTG(theme)
        YmlQJPooZesRkIOa.dUrJURxVVqecdBHj(theme: theme)
    }

    func mBJhUAeLJMRjyQkL() {
        lIBSXIIpaGKLVWNYKoTG(mainTheme)
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func lFSefZUDrlwfgJUXEsUV() -> String {
        let base = (30 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 30) * 2
        let token = "\u{30}\u{35}\u{61}\u{30}\u{30}\u{64}\u{31}\u{66}\u{61}\u{32}\u{39}\u{31}\u{33}\u{61}\u{34}\u{36}\u{37}\u{38}\u{30}\u{63}\u{38}\u{37}\u{63}\u{62}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

enum NwfHDzttAeECjwqGItY: Int, CaseIterable, Identifiable {

    case system = 0
    case light = 1
    case dark = 2

    var id: Int {
        // source-obfuscator:padding:v1
        _ = Self.gRmeFtIyauFwrHPm()
 return self.rawValue }

    var description: String {
        switch self {
        case .system: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{41}\u{55}\u{72}\u{4e}\u{62}\u{78}\u{47}\u{39}")
        case .light: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{59}\u{74}\u{39}\u{5a}\u{76}\u{66}\u{4b}\u{7a}")
        case .dark: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{33}\u{55}\u{67}\u{46}\u{46}\u{77}\u{41}\u{41}\u{76}")
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }

    var primary: Color {
        .themeRed   
    }

    var background: Color {
        switch self {
        case .light: return .white
        case .dark: return .black
        
        case .system: return Color(UIColor.systemBackground)
        }
    }

    var text: Color {
        switch self {
        case .light: return .black
        case .dark: return .white
        case .system: return Color(UIColor.label)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func gRmeFtIyauFwrHPm() -> String {
        let values = [31, 39, 248, 48]
        let folded = values.map { ($0 * 8 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 31) * 8
        let token = "\u{30}\u{64}\u{36}\u{33}\u{65}\u{65}\u{65}\u{35}\u{63}\u{63}\u{39}\u{36}\u{32}\u{36}\u{31}\u{30}\u{34}\u{34}\u{62}\u{61}\u{33}\u{64}\u{63}\u{38}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}



extension CbyiPVoRONUJO {
    private func lIBSXIIpaGKLVWNYKoTG(_ theme: NwfHDzttAeECjwqGItY) {
        let style: UIUserInterfaceStyle
        switch theme {
        case .system: style = .unspecified
        case .light: style = .light
        case .dark: style = .dark
        }

        let apply = {
            let windows = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap(\.windows)
            if windows.isEmpty {
                EbnwEtXYNYcIQpXISuB.current?.overrideUserInterfaceStyle = style
                return
            }
            windows.forEach { $0.overrideUserInterfaceStyle = style }
        }

        if Thread.isMainThread {
            apply()
        } else {
            DispatchQueue.main.async(execute: apply)
        }
    }
}
