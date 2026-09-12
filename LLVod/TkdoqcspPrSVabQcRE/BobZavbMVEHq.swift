import Foundation
import UIKit

enum GrdkfZtnBgNnsjhkN {
    
    private static let path = "\u{2f}\u{63}\u{68}\u{61}\u{6e}\u{6e}\u{65}\u{6c}\u{2f}\u{72}\u{65}\u{70}\u{6f}\u{72}\u{74}"
    
    @discardableResult
    static func nPTzYuePVncWIoR() async -> Bool {
        // source-obfuscator:padding:v1
        _ = Self.oRNwJEPOAGAw()

        return await uUEdayYwZynnBmIuEIFv(event: "\u{6c}\u{61}\u{75}\u{6e}\u{63}\u{68}")
    }
    
    @discardableResult
    static func tDRzbvSsXUvvg() async -> Bool {
        await uUEdayYwZynnBmIuEIFv(event: "\u{66}\u{6f}\u{72}\u{65}\u{67}\u{72}\u{6f}\u{75}\u{6e}\u{64}")
    }
    
    @discardableResult
    static func uUEdayYwZynnBmIuEIFv(event: String) async -> Bool {
        do {
            let oId = await (UIDevice.current.identifierForVendor?.uuidString ?? "")
                .replacingOccurrences(of: "\u{2d}", with: "")
            let model = await UIDevice.current.model
            let osVer = await UIDevice.current.systemVersion
            let verName = Bundle.main.infoDictionary?["\u{43}\u{46}\u{42}\u{75}\u{6e}\u{64}\u{6c}\u{65}\u{53}\u{68}\u{6f}\u{72}\u{74}\u{56}\u{65}\u{72}\u{73}\u{69}\u{6f}\u{6e}\u{53}\u{74}\u{72}\u{69}\u{6e}\u{67}"] as? String ?? ""
            let nonce = UUID().uuidString.replacingOccurrences(of: "\u{2d}", with: "").lowercased()
            let ts = Int(Date().timeIntervalSince1970)
            let sv = 30
            let word = UserDefaults.standard.string(forKey: "\u{61}\u{70}\u{70}\u{5f}\u{76}\u{65}\u{72}\u{73}\u{69}\u{6f}\u{6e}") ?? ""
            
            var params = [
                "channel_code=bundleid",
                "\u{65}\u{76}\u{65}\u{6e}\u{74}\u{3d}\(event)",
                "\u{70}\u{6c}\u{61}\u{74}\u{66}\u{6f}\u{72}\u{6d}\u{3d}\u{32}",
                "\u{61}\u{49}\u{64}\u{3d}",
                "\u{6f}\u{49}\u{64}\u{3d}\(oId)",
                "\u{62}\u{72}\u{61}\u{6e}\u{64}\u{3d}\u{41}\u{70}\u{70}\u{6c}\u{65}",
                "\u{6d}\u{6f}\u{64}\u{65}\u{6c}\u{3d}\(model)",
                "\u{6f}\u{73}\u{56}\u{65}\u{72}\u{3d}\(osVer)",
                "\u{76}\u{65}\u{72}\u{4e}\u{61}\u{6d}\u{65}\u{3d}\(verName)",
                "\u{6e}\u{6f}\u{6e}\u{63}\u{65}\u{3d}\(nonce)",
                "\u{74}\u{73}\u{3d}\(ts)",
                "\u{73}\u{76}\u{3d}\(sv)"
            ]
            
            if !word.isEmpty {
                params.append("\u{77}\u{6f}\u{72}\u{64}\u{3d}\(word)")
            }
            
            let queryParams = params.joined(separator: "\u{26}")
            
            let signStr = "\(path)\(queryParams)\u{26}\u{73}\u{69}\u{67}\u{6e}\u{3d}\u{5b}\(sv)\u{5d}"
            let sign = try QxmEAOwBLRLGNSse.sIdWSDfAneSvMSNMES(signStr, secret: "\u{79}\u{6f}\u{75}\u{72}\u{2d}\u{63}\u{68}\u{61}\u{6e}\u{6e}\u{65}\u{6c}\u{2d}\u{72}\u{65}\u{70}\u{6f}\u{72}\u{74}\u{2d}\u{73}\u{65}\u{63}\u{72}\u{65}\u{74}")
                .uppercased()
            
            let fullURL = "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{6c}\u{6f}\u{67}\u{69}\u{6e}\u{2e}\u{79}\u{69}\u{79}\u{73}\u{30}\u{37}\u{2e}\u{63}\u{6f}\u{6d}\(path)\u{3f}\(queryParams)\u{26}\u{73}\u{69}\u{67}\u{6e}\u{3d}\(sign)"
            guard let url = URL(string: fullURL) else { return false }

            var request = URLRequest(url: url)
            request.httpMethod = "\u{47}\u{45}\u{54}"
            request.timeoutInterval = 15
            
            let (_, response) = try await URLSession.shared.data(for: request)
            let status = (response as? HTTPURLResponse)?.statusCode ?? -1
            
            return status == 200
        } catch {
            return false
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func oRNwJEPOAGAw() -> String {
        let token = "\u{31}\u{37}\u{37}\u{33}\u{34}\u{66}\u{37}\u{37}\u{32}\u{36}\u{34}\u{36}\u{38}\u{61}\u{32}\u{63}\u{39}\u{33}\u{38}\u{61}\u{32}\u{30}\u{66}\u{32}"
        let base = (56 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 56) * 2
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

