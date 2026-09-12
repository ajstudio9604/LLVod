






import SwiftUI
import Combine
import UIKit

struct PsdtSIiEwfhxR: View {
    @EnvironmentObject var themeManager: CbyiPVoRONUJO

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.eLoejvuQYBaqy()

        TabView {

            LchYNbZOgLJYfuX()
                .tabItem {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{6c}\u{4f}\u{44}\u{62}\u{38}\u{7a}\u{48}\u{71}"))
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{78}\u{47}\u{70}\u{72}\u{59}\u{66}\u{73}\u{67}"))
                }

            VjxReJegdKprSmfMnSPG()
                .tabItem {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{48}\u{48}\u{73}\u{4d}\u{61}\u{32}\u{61}\u{6e}"))
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{37}\u{66}\u{66}\u{54}\u{47}\u{73}\u{52}\u{6b}"))
                }

            ZkijlQRgpawAVTPCBeX()
                .tabItem {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{47}\u{42}\u{42}\u{79}\u{62}\u{57}\u{74}\u{4b}"))
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{65}\u{32}\u{68}\u{33}\u{79}\u{74}\u{47}\u{6d}"))
                }

            YcXNMyaFWaZfUY()
                .tabItem {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{35}\u{7a}\u{44}\u{70}\u{37}\u{39}\u{70}\u{39}"))
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{41}\u{73}\u{59}\u{74}\u{4c}\u{35}\u{66}\u{74}\u{73}"))
                }

            UswfVlIylKVJmgOnqrP()
                .tabItem {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{53}\u{44}\u{7a}\u{6b}\u{47}\u{6a}\u{6c}\u{57}"))
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{37}\u{46}\u{69}\u{6c}\u{45}\u{66}\u{4c}\u{45}\u{38}"))
                }
        }
        .onAppear {
            YmlQJPooZesRkIOa.dUrJURxVVqecdBHj(theme: themeManager.mainTheme)
        }
        .onChange(of: themeManager.mainTheme) { theme in
            YmlQJPooZesRkIOa.dUrJURxVVqecdBHj(theme: theme)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func eLoejvuQYBaqy() -> String {
        let token = "\u{32}\u{65}\u{65}\u{65}\u{66}\u{61}\u{63}\u{64}\u{36}\u{31}\u{62}\u{31}\u{37}\u{33}\u{34}\u{30}\u{66}\u{33}\u{36}\u{62}\u{66}\u{33}\u{33}\u{65}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 9, "\u{65}\u{61}\u{73}\u{74}": 17, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 72]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 9) * 8
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

enum YmlQJPooZesRkIOa {

    static func dUrJURxVVqecdBHj(theme: NwfHDzttAeECjwqGItY) {
        // source-obfuscator:padding:v1
        _ = Self.aNFhiQRbMnizJGo()

        let primary = UIColor(theme.primary)
        let appearance = UITabBarAppearance()

        if #available(iOS 26.0, *) {
            appearance.configureWithTransparentBackground()
        } else {
            appearance.configureWithDefaultBackground()
        }
        appearance.shadowColor = UIColor.separator.withAlphaComponent(0.25)

        rDPTrSoFiQbKRhsap(appearance.stackedLayoutAppearance, primary: primary)
        rDPTrSoFiQbKRhsap(appearance.inlineLayoutAppearance, primary: primary)
        rDPTrSoFiQbKRhsap(appearance.compactInlineLayoutAppearance, primary: primary)

        let proxy = UITabBar.appearance()
        proxy.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            proxy.scrollEdgeAppearance = appearance
        }
        proxy.isTranslucent = true
        proxy.backgroundColor = .clear
        proxy.barTintColor = nil
        proxy.tintColor = primary
        proxy.unselectedItemTintColor = .gray
        
        proxy.itemPositioning = .fill

        DispatchQueue.main.async {
            for window in UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap(\.windows) {
                dAuwfwFgBTeJ(appearance, primary: primary, in: window.rootViewController)
            }
        }
    }

    

    private static func dAuwfwFgBTeJ(
        _ appearance: UITabBarAppearance,
        primary: UIColor,
        in controller: UIViewController?
    ) {
        guard let controller else { return }

        if let tab = controller as? UITabBarController {
            let tabBar = tab.tabBar
            tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
            tabBar.isTranslucent = true
            tabBar.backgroundColor = .clear
            tabBar.barTintColor = nil
            tabBar.tintColor = primary
            tabBar.itemPositioning = .fill
        }

        for child in controller.children {
            dAuwfwFgBTeJ(appearance, primary: primary, in: child)
        }
        if let presented = controller.presentedViewController {
            dAuwfwFgBTeJ(appearance, primary: primary, in: presented)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func aNFhiQRbMnizJGo() -> String {
        let token = "\u{65}\u{63}\u{37}\u{65}\u{32}\u{34}\u{65}\u{35}\u{66}\u{38}\u{31}\u{37}\u{64}\u{63}\u{63}\u{66}\u{66}\u{31}\u{32}\u{65}\u{64}\u{30}\u{65}\u{39}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 51, "\u{65}\u{61}\u{73}\u{74}": 60, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 459]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 51) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension YmlQJPooZesRkIOa {
    private static func rDPTrSoFiQbKRhsap(
        _ itemAppearance: UITabBarItemAppearance,
        primary: UIColor
    ) {
        
        let font = UIFont.systemFont(ofSize: 10)
        itemAppearance.normal.iconColor = .gray
        itemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray,
            .font: font
        ]
        itemAppearance.selected.iconColor = primary
        itemAppearance.selected.titleTextAttributes = [
            .foregroundColor: primary,
            .font: font
        ]
        itemAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        itemAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
    }
}
