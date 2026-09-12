







import Foundation
import Combine
import UIKit

@MainActor
final class KxKjCCiFrdtCTwJh: ObservableObject {
    static let shared = KxKjCCiFrdtCTwJh()

    @Published private(set) var isDanmakuAvailable = false

    @Published private(set) var canSendDanmaku = false

    @Published private(set) var websiteURL = ""

    @Published private(set) var qqGroupURL = ""
    @Published private(set) var tgGroupURL = ""

    @Published var pendingNotice: KeQvvjmQCvsYeVNH?

    @Published var pendingUpdate: JtekaluVnEPfuBNeJE?

    var canJoinCommunity: Bool {
        !qqGroupURL.isEmpty || !tgGroupURL.isEmpty
    }

    private init() {
        // source-obfuscator:padding:v1
        _ = Self.gGiPdpHREjLOyDK()

        yPAkDChJuitKz()
    }

    

    func yWqSEwAfYMlZ(neverShowAgain: Bool) {
        if neverShowAgain, let content = pendingNotice?.content {
            UserDefaults.standard.set(content, forKey: "\u{516c}\u{544a}\u{63d0}\u{793a}\u{6570}\u{636e}\u{63}\u{61}\u{63}\u{68}\u{65}")
        }
        pendingNotice = nil
    }

    func yCMnEXodGwuc() {
        
        guard let pendingUpdate, !pendingUpdate.isForce else { return }
        self.pendingUpdate = nil
    }

    func cTfrIcfhkhggMd() {
        guard let raw = pendingUpdate?.downloadURL.trimmingCharacters(in: .whitespacesAndNewlines),
              !raw.isEmpty else { return }

        var text = raw
        if !text.contains("\u{3a}\u{2f}\u{2f}") {
            text = "\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\(text)"
        }
        guard let url = URL(string: text) else { return }
        UIApplication.shared.open(url)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func gGiPdpHREjLOyDK() -> String {
        let base = (60 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 60) * 9
        let token = "\u{37}\u{62}\u{31}\u{63}\u{34}\u{34}\u{32}\u{61}\u{39}\u{34}\u{39}\u{63}\u{32}\u{65}\u{36}\u{63}\u{38}\u{65}\u{35}\u{36}\u{38}\u{65}\u{34}\u{63}"
        _ = Self.bSnLBBqStRZy()
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func bSnLBBqStRZy() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 16, "\u{65}\u{61}\u{73}\u{74}": 21, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 80]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 16) * 5
        let token = "\u{38}\u{64}\u{38}\u{39}\u{64}\u{39}\u{64}\u{64}\u{30}\u{63}\u{63}\u{61}\u{66}\u{39}\u{37}\u{30}\u{65}\u{35}\u{62}\u{64}\u{64}\u{37}\u{38}\u{34}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}

enum AzqCURaEoPGpgIYOF {

    private static let danmakuKeys: [(key: String, field: String)] = [
        ("\u{81ea}\u{5efa}\u{5f39}\u{5e55}\u{61}\u{70}\u{69}\u{63}\u{61}\u{63}\u{68}\u{65}", "\u{64}\u{61}\u{6e}\u{6d}\u{61}\u{6b}\u{75}\u{5f}\u{63}\u{75}\u{73}\u{74}\u{6f}\u{6d}\u{5f}\u{61}\u{70}\u{69}"),
        ("\u{5b98}\u{65b9}\u{5f39}\u{5e55}\u{61}\u{70}\u{69}\u{63}\u{61}\u{63}\u{68}\u{65}", "\u{64}\u{61}\u{6e}\u{6d}\u{61}\u{6b}\u{75}\u{5f}\u{6f}\u{66}\u{66}\u{69}\u{63}\u{69}\u{61}\u{6c}\u{5f}\u{61}\u{70}\u{69}"),
        ("\u{5b98}\u{65b9}\u{5f39}\u{5e55}\u{641c}\u{7d22}\u{61}\u{70}\u{69}\u{63}\u{61}\u{63}\u{68}\u{65}", "\u{64}\u{61}\u{6e}\u{6d}\u{61}\u{6b}\u{75}\u{5f}\u{73}\u{65}\u{61}\u{72}\u{63}\u{68}\u{5f}\u{61}\u{70}\u{69}"),
        ("\u{53d1}\u{9001}\u{5f39}\u{5e55}\u{61}\u{70}\u{69}\u{63}\u{61}\u{63}\u{68}\u{65}", "\u{64}\u{61}\u{6e}\u{6d}\u{61}\u{6b}\u{75}\u{5f}\u{73}\u{65}\u{6e}\u{64}\u{5f}\u{61}\u{70}\u{69}"),
        ("\u{5f39}\u{5e55}\u{5173}\u{952e}\u{8bcd}\u{63}\u{61}\u{63}\u{68}\u{65}", "\u{64}\u{61}\u{6e}\u{6d}\u{61}\u{6b}\u{75}\u{5f}\u{6b}\u{65}\u{79}\u{77}\u{6f}\u{72}\u{64}\u{73}")
    ]

    private static let serverKeys = [
        "\u{78}\u{4e3b}\u{670d}\u{52a1}\u{5668}\u{57df}\u{540d}\u{63}\u{61}\u{68}\u{63}\u{65}",
        "\u{78}\u{4e3b}\u{670d}\u{52a1}\u{5668}\u{57df}\u{540d}\u{63}\u{61}\u{68}\u{63}\u{65}\u{31}",
        "\u{78}\u{4e3b}\u{670d}\u{52a1}\u{5668}\u{57df}\u{540d}\u{63}\u{61}\u{68}\u{63}\u{65}\u{32}"
    ]

    private static var task: Task<Bool, Never>?
    private static var isLoaded = false
    private static var didEvaluatePrompts = false

    

    

    

    

    

    

    

    

    private static func gYdzDmFkYGpSVzj(
        from config: [String: Any],
        currentVersion: String
    ) -> JtekaluVnEPfuBNeJE? {
        // source-obfuscator:padding:v1
        _ = Self.qQnYTSQtaGJT()

        var enabled = QpzbkjrJqEGYJHxtRs.cQxqCRKnMUFzIUeJnNj(config["\u{69}\u{6f}\u{73}\u{5f}\u{75}\u{70}\u{64}\u{61}\u{74}\u{65}\u{5f}\u{65}\u{6e}\u{61}\u{62}\u{6c}\u{65}\u{64}"])
        var isForce = QpzbkjrJqEGYJHxtRs.cQxqCRKnMUFzIUeJnNj(config["\u{69}\u{6f}\u{73}\u{5f}\u{66}\u{6f}\u{72}\u{63}\u{65}\u{5f}\u{75}\u{70}\u{64}\u{61}\u{74}\u{65}"])

        
        let packagesRaw = QpzbkjrJqEGYJHxtRs.string(config["\u{69}\u{6f}\u{73}\u{5f}\u{75}\u{70}\u{64}\u{61}\u{74}\u{65}\u{5f}\u{70}\u{61}\u{63}\u{6b}\u{61}\u{67}\u{65}\u{73}"])
        if enabled, !packagesRaw.isEmpty {
            let allowed = packagesRaw
                .split(separator: "\u{2c}")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { !$0.isEmpty }
            let bundleId = DdlOncyxpuyeNVpKKPv.bundleIdentifier
            if !allowed.isEmpty, !allowed.contains(bundleId) {
                enabled = false
                isForce = false
            }
        }

        guard enabled else { return nil }

        let latest = QpzbkjrJqEGYJHxtRs.string(config["\u{69}\u{6f}\u{73}\u{5f}\u{61}\u{70}\u{70}\u{5f}\u{76}\u{65}\u{72}\u{73}\u{69}\u{6f}\u{6e}"])
        guard !latest.isEmpty, !currentVersion.isEmpty else { return nil }
        guard let comparison = DdlOncyxpuyeNVpKKPv.fLWkFabMmgZJxqLIuYOA(current: currentVersion, latest: latest),
              comparison < 0 else {
            return nil
        }

        return JtekaluVnEPfuBNeJE(
            version: latest,
            sizeText: QpzbkjrJqEGYJHxtRs.string(config["\u{69}\u{6f}\u{73}\u{5f}\u{61}\u{70}\u{70}\u{5f}\u{73}\u{69}\u{7a}\u{65}"]),
            changelog: QpzbkjrJqEGYJHxtRs.string(config["\u{69}\u{6f}\u{73}\u{5f}\u{63}\u{68}\u{61}\u{6e}\u{67}\u{65}\u{6c}\u{6f}\u{67}"]),
            isForce: isForce,
            downloadURL: QpzbkjrJqEGYJHxtRs.string(config["\u{69}\u{6f}\u{73}\u{5f}\u{64}\u{6f}\u{77}\u{6e}\u{6c}\u{6f}\u{61}\u{64}\u{5f}\u{75}\u{72}\u{6c}"]),
            downloadMode: QpzbkjrJqEGYJHxtRs.string(config["\u{69}\u{6f}\u{73}\u{5f}\u{64}\u{6f}\u{77}\u{6e}\u{6c}\u{6f}\u{61}\u{64}\u{5f}\u{6d}\u{6f}\u{64}\u{65}"])
        )
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qQnYTSQtaGJT() -> String {
        _ = Self.pXCkbooYGntUWqnqte()
        _ = Self.pQSledpEDvytUlZCb()
        let token = "\u{37}\u{38}\u{33}\u{33}\u{64}\u{63}\u{32}\u{39}\u{39}\u{39}\u{64}\u{61}\u{39}\u{39}\u{63}\u{62}\u{37}\u{30}\u{63}\u{37}\u{33}\u{61}\u{64}\u{36}"
        let source = "\u{37}\u{38}\u{33}\u{33}\u{64}\u{63}\u{32}\u{39}\u{39}\u{39}\u{64}\u{61}\u{39}\u{39}\u{63}\u{62}\u{37}\u{30}\u{63}\u{37}\u{33}\u{61}\u{64}\u{36}\u{2d}\u{35}\u{33}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 53) * 2
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func pXCkbooYGntUWqnqte() -> String {
        let token = "\u{66}\u{34}\u{31}\u{38}\u{36}\u{31}\u{38}\u{31}\u{38}\u{35}\u{34}\u{63}\u{64}\u{32}\u{38}\u{66}\u{39}\u{32}\u{39}\u{33}\u{32}\u{36}\u{36}\u{64}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 91, "\u{65}\u{61}\u{73}\u{74}": 98, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 637]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 91) * 7
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func pQSledpEDvytUlZCb() -> String {
        let values = [14, 18, 56, 31]
        let folded = values.map { ($0 * 4 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 14) * 4
        let token = "\u{34}\u{32}\u{66}\u{35}\u{30}\u{34}\u{39}\u{31}\u{64}\u{37}\u{65}\u{33}\u{38}\u{66}\u{38}\u{31}\u{35}\u{39}\u{66}\u{62}\u{30}\u{61}\u{37}\u{30}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
}



extension KxKjCCiFrdtCTwJh {
    fileprivate func yPAkDChJuitKz() {
        let defaults = UserDefaults.standard
        isDanmakuAvailable = LkzXORcEdLaolfAi.isMasterSwitchOn
        canSendDanmaku = LkzXORcEdLaolfAi.canSend
        websiteURL = defaults.string(forKey: "\u{5b98}\u{7f51}\u{63}\u{61}\u{63}\u{68}\u{65}") ?? ""
        qqGroupURL = defaults.string(forKey: "\u{51}\u{51}\u{7fa4}\u{63}\u{61}\u{68}\u{63}\u{65}") ?? ""
        tgGroupURL = defaults.string(forKey: "\u{54}\u{47}\u{7fa4}\u{63}\u{61}\u{68}\u{63}\u{65}") ?? ""
    }
}


extension AzqCURaEoPGpgIYOF {
    private static func iQGTvmpAlnDluBRzw(_ endpoint: String) async -> [String: Any]? {
        guard let url = URL(string: endpoint) else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "\u{47}\u{45}\u{54}"
        request.timeoutInterval = 15
        request.setValue("\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{6a}\u{73}\u{6f}\u{6e}\u{3b} \u{63}\u{68}\u{61}\u{72}\u{73}\u{65}\u{74}\u{3d}\u{75}\u{74}\u{66}\u{2d}\u{38}", forHTTPHeaderField: "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{54}\u{79}\u{70}\u{65}")
        request.setValue("\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{6a}\u{73}\u{6f}\u{6e}\u{3b} \u{63}\u{68}\u{61}\u{72}\u{73}\u{65}\u{74}\u{3d}\u{75}\u{74}\u{66}\u{2d}\u{38}", forHTTPHeaderField: "\u{41}\u{63}\u{63}\u{65}\u{70}\u{74}")
        request.setValue(LjmjUaFraWCnXMcEO.yARuYxPxHRneqiyaFw(), forHTTPHeaderField: "\u{55}\u{73}\u{65}\u{72}\u{2d}\u{41}\u{67}\u{65}\u{6e}\u{74}")

        guard let (data, response) = try? await URLSession.shared.data(for: request),
              let http = response as? HTTPURLResponse,
              200...299 ~= http.statusCode,
              let body = String(data: data, encoding: .utf8) else {
            return nil
        }

        return QpzbkjrJqEGYJHxtRs.decode(body)
    }

    private static func uSrXFZsdhnpIn(_ config: [String: Any]) {
        let defaults = UserDefaults.standard

        let currentVersion = DdlOncyxpuyeNVpKKPv.currentShortVersion
        if !currentVersion.isEmpty {
            defaults.set(currentVersion, forKey: "\u{7248}\u{672c}\u{53f7}\u{63}\u{61}\u{68}\u{63}\u{65}")
        }

        defaults.set(
            QpzbkjrJqEGYJHxtRs.cQxqCRKnMUFzIUeJnNj(config["\u{64}\u{61}\u{6e}\u{6d}\u{61}\u{6b}\u{75}\u{5f}\u{65}\u{6e}\u{61}\u{62}\u{6c}\u{65}\u{64}"]),
            forKey: "\u{5f39}\u{5e55}\u{603b}\u{5f00}\u{5173}\u{63}\u{61}\u{63}\u{68}\u{65}"
        )

        for item in danmakuKeys {
            defaults.set(QpzbkjrJqEGYJHxtRs.string(config[item.field]), forKey: item.key)
        }

        let servers = ["\u{73}\u{65}\u{72}\u{76}\u{65}\u{72}\u{5f}\u{6d}\u{61}\u{69}\u{6e}", "\u{73}\u{65}\u{72}\u{76}\u{65}\u{72}\u{5f}\u{6d}\u{61}\u{69}\u{6e}\u{31}", "\u{73}\u{65}\u{72}\u{76}\u{65}\u{72}\u{5f}\u{6d}\u{61}\u{69}\u{6e}\u{32}"]
        for (key, field) in zip(serverKeys, servers) {
            let value = QpzbkjrJqEGYJHxtRs.string(config[field])
            if value.isEmpty {
                defaults.removeObject(forKey: key)
            } else {
                defaults.set(value, forKey: key)
            }
        }

        
        let community: [(key: String, field: String)] = [
            ("\u{5b98}\u{7f51}\u{63}\u{61}\u{63}\u{68}\u{65}", "\u{77}\u{65}\u{62}\u{73}\u{69}\u{74}\u{65}"),
            ("\u{51}\u{51}\u{7fa4}\u{63}\u{61}\u{68}\u{63}\u{65}", "\u{71}\u{71}\u{5f}\u{67}\u{72}\u{6f}\u{75}\u{70}"),
            ("\u{54}\u{47}\u{7fa4}\u{63}\u{61}\u{68}\u{63}\u{65}", "\u{74}\u{67}\u{5f}\u{67}\u{72}\u{6f}\u{75}\u{70}"),
        ]
        for item in community {
            let value = QpzbkjrJqEGYJHxtRs.string(config[item.field])
            if value.isEmpty {
                defaults.removeObject(forKey: item.key)
            } else {
                defaults.set(value, forKey: item.key)
            }
        }

        let notice = wVAdCxfDuzEhSp(from: config)
        let update = gYdzDmFkYGpSVzj(from: config, currentVersion: currentVersion)

        Task { @MainActor in
            KxKjCCiFrdtCTwJh.shared.yPAkDChJuitKz()
            guard !didEvaluatePrompts else { return }
            didEvaluatePrompts = true
            KxKjCCiFrdtCTwJh.shared.pendingNotice = notice
            KxKjCCiFrdtCTwJh.shared.pendingUpdate = update
        }
    }

    private static func eSOjxGRWzsLQ() async -> Bool {
        for endpoint in dAyMphjFSifHvPGn() {
            guard let config = await iQGTvmpAlnDluBRzw(endpoint) else { continue }

            uSrXFZsdhnpIn(config)
            return true
        }

        return false
    }

    private static func dAyMphjFSifHvPGn() -> [String] {
        let defaults = UserDefaults.standard

        
        var list = serverKeys.compactMap { key in
            QpzbkjrJqEGYJHxtRs.pFtdpgkhELBnROtHSqJW(from: defaults.string(forKey: key) ?? "")
        }

        list.append("\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{6c}\u{6f}\u{67}\u{69}\u{6e}\u{2e}\u{79}\u{69}\u{79}\u{73}\u{30}\u{37}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}\u{61}\u{70}\u{70}\u{2f}\u{63}\u{6f}\u{6e}\u{66}\u{69}\u{67}")
        list.append("\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}\u{6c}\u{6f}\u{67}\u{69}\u{6e}\u{2e}\u{79}\u{69}\u{79}\u{73}\u{30}\u{36}\u{2e}\u{63}\u{6f}\u{6d}\u{2f}\u{61}\u{70}\u{70}\u{2f}\u{63}\u{6f}\u{6e}\u{66}\u{69}\u{67}")

        var seen = Set<String>()
        return list.filter { seen.insert($0).inserted }
    }

    private static func wVAdCxfDuzEhSp(from config: [String: Any]) -> KeQvvjmQCvsYeVNH? {
        let enabled = QpzbkjrJqEGYJHxtRs.cQxqCRKnMUFzIUeJnNj(config["\u{6e}\u{6f}\u{74}\u{69}\u{63}\u{65}\u{5f}\u{65}\u{6e}\u{61}\u{62}\u{6c}\u{65}\u{64}"])
        let content = QpzbkjrJqEGYJHxtRs.string(config["\u{6e}\u{6f}\u{74}\u{69}\u{63}\u{65}\u{5f}\u{63}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}"])
        guard enabled, !content.isEmpty else { return nil }

        let cached = UserDefaults.standard.string(forKey: "\u{516c}\u{544a}\u{63d0}\u{793a}\u{6570}\u{636e}\u{63}\u{61}\u{63}\u{68}\u{65}") ?? ""
        guard cached != content else { return nil }
        return KeQvvjmQCvsYeVNH(content: content)
    }

    static func vMjlwSWYSxtpQctaRnSO() async {
        if isLoaded { return }

        if let task {
            _ = await task.value
            return
        }

        let task = Task { await eSOjxGRWzsLQ() }
        Self.task = task
        let applied = await task.value

        
        
        Self.task = nil
        isLoaded = applied
    }

    static func fBNLBpMerBfp(showPrompts: Bool = true) async {
        task = nil
        isLoaded = false
        if showPrompts {
            didEvaluatePrompts = false
        }
        await vMjlwSWYSxtpQctaRnSO()
    }
}
