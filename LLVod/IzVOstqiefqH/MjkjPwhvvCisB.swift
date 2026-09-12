






import SwiftUI
import UIKit

enum RovJYbgHizJRPfPhjl {
    static let yIwIPIfCujElqafLOp = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{57}\u{54}\u{41}\u{32}\u{44}\u{34}\u{64}\u{79}")
    static let comic = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4f}\u{74}\u{59}\u{69}\u{35}\u{6e}\u{6e}\u{76}\u{36}")
    static let music = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{65}\u{59}\u{69}\u{6f}\u{6d}\u{71}\u{52}\u{47}")
    static let telegram = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{47}\u{76}\u{54}\u{34}\u{49}\u{79}\u{71}\u{4b}")

    

    
}

struct UbgpmyeixVTwzjLUu: Identifiable {
    let id = UUID()
    let text: String
    let url: URL?

    var activityItems: [Any] {
        // source-obfuscator:padding:v1
        _ = Self.sOOTfsOVQOgUxeKUpoBD()

        var items: [Any] = [text]
        if let url {
            items.append(url)
        }
        return items
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func sOOTfsOVQOgUxeKUpoBD() -> String {
        let token = "\u{61}\u{63}\u{62}\u{63}\u{32}\u{38}\u{66}\u{66}\u{35}\u{36}\u{65}\u{65}\u{36}\u{66}\u{33}\u{63}\u{33}\u{61}\u{33}\u{62}\u{36}\u{64}\u{34}\u{63}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{38}\u{38}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 88) * 3
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

struct FeRnqrmGJsspQCDWqx: UIViewControllerRepresentable {
    let item: UbgpmyeixVTwzjLUu

    

    
}



extension UbgpmyeixVTwzjLUu {
    static func yIwIPIfCujElqafLOp(extraText: String = "") -> UbgpmyeixVTwzjLUu {
        let site = RovJYbgHizJRPfPhjl.yIwIPIfCujElqafLOp
        let text = extraText.isEmpty ? site : "\(extraText)\n\(site)"
        return UbgpmyeixVTwzjLUu(text: text, url: RovJYbgHizJRPfPhjl.oVvnWQOQQkpxzD(site))
    }
}


extension RovJYbgHizJRPfPhjl {
    static func yZjmwCpuOULEzoEJ(_ raw: String) {
        // source-obfuscator:padding:v1
        _ = Self.iCrhwJikCcCJzJgbH()

        guard let url = oVvnWQOQQkpxzD(raw) else { return }
        UIApplication.shared.open(url)
    }

    static func oVvnWQOQQkpxzD(_ raw: String) -> URL? {
        var text = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return nil }
        if !text.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{4e}\u{36}\u{6b}\u{44}\u{53}\u{61}\u{51}\u{77}")) {
            text = "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\(text)"
        }
        return URL(string: text)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func iCrhwJikCcCJzJgbH() -> String {
        let base = (7 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 7) * 5
        let token = "\u{34}\u{36}\u{65}\u{34}\u{33}\u{35}\u{37}\u{31}\u{37}\u{30}\u{33}\u{64}\u{36}\u{61}\u{31}\u{63}\u{31}\u{32}\u{66}\u{64}\u{33}\u{33}\u{33}\u{32}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}


extension FeRnqrmGJsspQCDWqx {
    func updateUIViewController(_ controller: UIActivityViewController, context: Context) {
        // source-obfuscator:padding:v1
        _ = Self.pDKMSfTyOVDhwGk()
}

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: item.activityItems, applicationActivities: nil)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func pDKMSfTyOVDhwGk() -> String {
        let base = (53 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 53) * 7
        let token = "\u{34}\u{63}\u{34}\u{64}\u{65}\u{38}\u{66}\u{65}\u{31}\u{39}\u{30}\u{31}\u{34}\u{31}\u{34}\u{39}\u{33}\u{38}\u{63}\u{62}\u{33}\u{32}\u{37}\u{39}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}
