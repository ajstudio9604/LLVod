import Foundation
import UIKit

enum AHChannelReportUtil {
    
    private static let path = "/channel/report"
    
    @discardableResult
    static func reportLaunch() async -> Bool {
        await report(event: "launch")
    }
    
    @discardableResult
    static func reportForeground() async -> Bool {
        await report(event: "foreground")
    }
    
    @discardableResult
    static func report(event: String) async -> Bool {
        do {
            let oId = await (UIDevice.current.identifierForVendor?.uuidString ?? "")
                .replacingOccurrences(of: "-", with: "")
            let model = await UIDevice.current.model
            let osVer = await UIDevice.current.systemVersion
            let verName = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            let nonce = UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()
            let ts = Int(Date().timeIntervalSince1970)
            let sv = 30
            let word = UserDefaults.standard.string(forKey: "app_version") ?? ""
            
            var params = [
                "channel_code=com.KaarnaVaihBurosmApp.KaarnaVaih",
                "event=\(event)",
                "platform=2",
                "aId=",
                "oId=\(oId)",
                "brand=Apple",
                "model=\(model)",
                "osVer=\(osVer)",
                "verName=\(verName)",
                "nonce=\(nonce)",
                "ts=\(ts)",
                "sv=\(sv)"
            ]
            
            if !word.isEmpty {
                params.append("word=\(word)")
            }
            
            let queryParams = params.joined(separator: "&")
            
            let signStr = "\(path)\(queryParams)&sign=[\(sv)]"
            let sign = try CryptoUtil.hmacSha256(signStr, secret: "your-channel-report-secret")
                .uppercased()
            
            let fullURL = "https://login.yiys07.com\(path)?\(queryParams)&sign=\(sign)"
            guard let url = URL(string: fullURL) else { return false }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 15
            
            let (_, response) = try await URLSession.shared.data(for: request)
            let status = (response as? HTTPURLResponse)?.statusCode ?? -1
            
            return status == 200
        } catch {
            return false
        }
    }
}
