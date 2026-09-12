











import Foundation
import WebKit

@MainActor
final class NiGJMaCaHQvrol: NSObject {

    static func qDrKfZMPgVkyVtpktECj(
        url: String,
        whitelist: String,
        blacklist: String,
        userAgent: String = "",
        referer: String = "",
        timeout: TimeInterval = 15
    ) async -> String? {
        // source-obfuscator:padding:v1
        _ = Self.zCUZaKRGcanvNlORBhd()

        let sniffer = NiGJMaCaHQvrol(
            whitelist: whitelist,
            blacklist: blacklist,
            userAgent: userAgent,
            referer: referer,
            timeout: timeout
        )
        return await sniffer.start(url: url)
    }

    

    private static let autoPattern = try? NSRegularExpression(
        pattern: #"\#u{68}\#u{74}\#u{74}\#u{70}\#u{73}\#u{3f}\#u{3a}\#u{2f}\#u{2f}\#u{5b}\#u{5e}\#u{5c}\#u{73}\#u{5d}\#u{7b}\#u{31}\#u{32}\#u{2c}\#u{7d}\#u{5c}\#u{2e}\#u{28}\#u{3f}\#u{3a}\#u{6d}\#u{33}\#u{75}\#u{38}\#u{7c}\#u{6d}\#u{70}\#u{34}\#u{7c}\#u{6d}\#u{6b}\#u{76}\#u{7c}\#u{66}\#u{6c}\#u{76}\#u{7c}\#u{6d}\#u{70}\#u{33}\#u{7c}\#u{6d}\#u{34}\#u{61}\#u{7c}\#u{61}\#u{61}\#u{63}\#u{7c}\#u{6d}\#u{70}\#u{64}\#u{29}\#u{28}\#u{3f}\#u{3a}\#u{5c}\#u{3f}\#u{2e}\#u{2a}\#u{29}\#u{3f}\#u{7c}\#u{68}\#u{74}\#u{74}\#u{70}\#u{73}\#u{3f}\#u{3a}\#u{2f}\#u{2f}\#u{2e}\#u{2a}\#u{3f}\#u{76}\#u{69}\#u{64}\#u{65}\#u{6f}\#u{2f}\#u{74}\#u{6f}\#u{73}\#u{5b}\#u{5e}\#u{5c}\#u{73}\#u{5d}\#u{2a}\#u{7c}\#u{72}\#u{74}\#u{6d}\#u{70}\#u{3a}\#u{5b}\#u{5e}\#u{5c}\#u{73}\#u{5d}\#u{2b}"#,
        options: .caseInsensitive
    )

    private static let playerBridgePattern = try? NSRegularExpression(
        pattern: #"\#u{70}\#u{6c}\#u{61}\#u{79}\#u{65}\#u{72}\#u{2e}\#u{2a}\#u{68}\#u{74}\#u{74}\#u{70}\#u{73}\#u{3f}\#u{3a}\#u{2f}\#u{2f}"#,
        options: .caseInsensitive
    )

    private static let staticAssetPattern = try? NSRegularExpression(
        pattern: #"\#u{5c}\#u{2e}\#u{28}\#u{3f}\#u{3a}\#u{63}\#u{73}\#u{73}\#u{7c}\#u{6a}\#u{73}\#u{7c}\#u{6d}\#u{6a}\#u{73}\#u{7c}\#u{6a}\#u{70}\#u{67}\#u{7c}\#u{6a}\#u{70}\#u{65}\#u{67}\#u{7c}\#u{70}\#u{6e}\#u{67}\#u{7c}\#u{67}\#u{69}\#u{66}\#u{7c}\#u{62}\#u{6d}\#u{70}\#u{7c}\#u{77}\#u{65}\#u{62}\#u{70}\#u{7c}\#u{73}\#u{76}\#u{67}\#u{7c}\#u{69}\#u{63}\#u{6f}\#u{7c}\#u{6d}\#u{61}\#u{70}\#u{7c}\#u{77}\#u{6f}\#u{66}\#u{66}\#u{7c}\#u{77}\#u{6f}\#u{66}\#u{66}\#u{32}\#u{7c}\#u{74}\#u{74}\#u{66}\#u{7c}\#u{6f}\#u{74}\#u{66}\#u{7c}\#u{65}\#u{6f}\#u{74}\#u{7c}\#u{6a}\#u{73}\#u{6f}\#u{6e}\#u{7c}\#u{78}\#u{6d}\#u{6c}\#u{29}\#u{28}\#u{3f}\#u{3a}\#u{5c}\#u{3f}\#u{7c}\#u{24}\#u{29}"#,
        options: .caseInsensitive
    )

    private static let videoExtensions: Set<String> = [
        "\u{6d}\u{33}\u{75}\u{38}", "\u{6d}\u{70}\u{34}", "\u{6d}\u{6b}\u{76}", "\u{66}\u{6c}\u{76}", "\u{6d}\u{70}\u{33}", "\u{6d}\u{34}\u{61}", "\u{61}\u{61}\u{63}", "\u{6d}\u{70}\u{64}",
        "\u{74}\u{73}", "\u{6d}\u{34}\u{73}", "\u{6d}\u{6f}\u{76}", "\u{61}\u{76}\u{69}", "\u{77}\u{6d}\u{76}", "\u{72}\u{6d}\u{76}\u{62}", "\u{77}\u{65}\u{62}\u{6d}", "\u{66}\u{34}\u{76}", "\u{6d}\u{33}\u{75}"
    ]

    private static let maxProbeCandidates = 5

    

    private let whitelist: String
    private let blacklist: String
    private let userAgent: String
    private let referer: String
    private let timeout: TimeInterval

    private var webView: WKWebView?
    private var probeWebView: WKWebView?
    private var continuation: CheckedContinuation<String?, Never>?
    private var timeoutTask: Task<Void, Never>?
    private var finished = false
    private var probeCandidates: Set<String> = []
    private var isProbing = false

    private init(
        whitelist: String,
        blacklist: String,
        userAgent: String,
        referer: String,
        timeout: TimeInterval
    ) {
        self.whitelist = whitelist
        self.blacklist = blacklist
        self.userAgent = userAgent
        self.referer = referer
        self.timeout = timeout
        super.init()
    }

    

    

    

    private func pOjlcvRzCtaUR() -> WKWebView {
        let configuration = kPjfwLuarKejjwUu(fromProbe: false)
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), configuration: configuration)
        webView.navigationDelegate = self
        if !userAgent.isEmpty {
            webView.customUserAgent = userAgent
        }

        
        oHARUqnXEcgrdnj(webView)
        return webView
    }

    

    

    

    fileprivate func gQsjlrgHkXoFtaAZs(candidate raw: String, fromProbe: Bool) {
        guard !finished else { return }

        let url = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !url.isEmpty else { return }

        if useListMode {
            if oLFXsBlyPWlxzjGSs(url) {
                pQCCvnPVUnkEbnwIWIVl(with: url)
            }
            return
        }

        if lKjuUGpIMCvMgKYNgTTG(url) {
            pQCCvnPVUnkEbnwIWIVl(with: url)
            return
        }

        if !fromProbe, gJNLTNQmpItljaiSrock(url) {
            jBTDwJVRXkqyKTLjqUCj(url)
        }
    }

    

    

    private func gJNLTNQmpItljaiSrock(_ url: String) -> Bool {
        let lower = url.lowercased()
        guard lower.hasPrefix("\u{68}\u{74}\u{74}\u{70}\u{3a}\u{2f}\u{2f}") || lower.hasPrefix("\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}") else { return false }
        guard !pAIzvEeabJbbvoiQ(NiGJMaCaHQvrol.staticAssetPattern, lower) else { return false }
        guard pAIzvEeabJbbvoiQ(NiGJMaCaHQvrol.playerBridgePattern, lower) else { return false }

        if probeCandidates.count > NiGJMaCaHQvrol.maxProbeCandidates {
            probeCandidates.removeAll()
        }

        return probeCandidates.insert(lower).inserted
    }

    

    

    

    

    

    

    

    

    

    fileprivate static let messageName = "\u{61}\u{68}\u{53}\u{6e}\u{69}\u{66}\u{66}\u{65}\u{72}"

    private static let injectedScript = """
    \u{28}\u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e} \u{28}\u{29} \u{7b}
      \u{69}\u{66} \u{28}\u{77}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{2e}\u{5f}\u{5f}\u{61}\u{68}\u{53}\u{6e}\u{69}\u{66}\u{66}\u{65}\u{72}\u{49}\u{6e}\u{73}\u{74}\u{61}\u{6c}\u{6c}\u{65}\u{64}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e}\u{3b} \u{7d}
      \u{77}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{2e}\u{5f}\u{5f}\u{61}\u{68}\u{53}\u{6e}\u{69}\u{66}\u{66}\u{65}\u{72}\u{49}\u{6e}\u{73}\u{74}\u{61}\u{6c}\u{6c}\u{65}\u{64} \u{3d} \u{74}\u{72}\u{75}\u{65}\u{3b}

      \u{76}\u{61}\u{72} \u{73}\u{65}\u{65}\u{6e} \u{3d} \u{7b}\u{7d}\u{3b}

      \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e} \u{72}\u{65}\u{70}\u{6f}\u{72}\u{74}\u{28}\u{75}\u{72}\u{6c}\u{29} \u{7b}
        \u{69}\u{66} \u{28}\u{21}\u{75}\u{72}\u{6c} \u{7c}\u{7c} \u{74}\u{79}\u{70}\u{65}\u{6f}\u{66} \u{75}\u{72}\u{6c} \u{21}\u{3d}\u{3d} \u{27}\u{73}\u{74}\u{72}\u{69}\u{6e}\u{67}\u{27}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e}\u{3b} \u{7d}
        \u{69}\u{66} \u{28}\u{75}\u{72}\u{6c}\u{2e}\u{69}\u{6e}\u{64}\u{65}\u{78}\u{4f}\u{66}\u{28}\u{27}\u{68}\u{74}\u{74}\u{70}\u{27}\u{29} \u{21}\u{3d}\u{3d} \u{30} \u{26}\u{26} \u{75}\u{72}\u{6c}\u{2e}\u{69}\u{6e}\u{64}\u{65}\u{78}\u{4f}\u{66}\u{28}\u{27}\u{72}\u{74}\u{6d}\u{70}\u{27}\u{29} \u{21}\u{3d}\u{3d} \u{30}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e}\u{3b} \u{7d}
        \u{69}\u{66} \u{28}\u{73}\u{65}\u{65}\u{6e}\u{5b}\u{75}\u{72}\u{6c}\u{5d}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e}\u{3b} \u{7d}
        \u{73}\u{65}\u{65}\u{6e}\u{5b}\u{75}\u{72}\u{6c}\u{5d} \u{3d} \u{74}\u{72}\u{75}\u{65}\u{3b}
        \u{74}\u{72}\u{79} \u{7b}
          \u{77}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{2e}\u{77}\u{65}\u{62}\u{6b}\u{69}\u{74}\u{2e}\u{6d}\u{65}\u{73}\u{73}\u{61}\u{67}\u{65}\u{48}\u{61}\u{6e}\u{64}\u{6c}\u{65}\u{72}\u{73}\u{2e}\u{61}\u{68}\u{53}\u{6e}\u{69}\u{66}\u{66}\u{65}\u{72}\u{2e}\u{70}\u{6f}\u{73}\u{74}\u{4d}\u{65}\u{73}\u{73}\u{61}\u{67}\u{65}\u{28}\u{75}\u{72}\u{6c}\u{29}\u{3b}
        \u{7d} \u{63}\u{61}\u{74}\u{63}\u{68} \u{28}\u{65}\u{29} \u{7b}\u{7d}
      \u{7d}

      \u{76}\u{61}\u{72} \u{6f}\u{70}\u{65}\u{6e} \u{3d} \u{58}\u{4d}\u{4c}\u{48}\u{74}\u{74}\u{70}\u{52}\u{65}\u{71}\u{75}\u{65}\u{73}\u{74}\u{2e}\u{70}\u{72}\u{6f}\u{74}\u{6f}\u{74}\u{79}\u{70}\u{65}\u{2e}\u{6f}\u{70}\u{65}\u{6e}\u{3b}
      \u{58}\u{4d}\u{4c}\u{48}\u{74}\u{74}\u{70}\u{52}\u{65}\u{71}\u{75}\u{65}\u{73}\u{74}\u{2e}\u{70}\u{72}\u{6f}\u{74}\u{6f}\u{74}\u{79}\u{70}\u{65}\u{2e}\u{6f}\u{70}\u{65}\u{6e} \u{3d} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e} \u{28}\u{6d}\u{65}\u{74}\u{68}\u{6f}\u{64}\u{2c} \u{75}\u{72}\u{6c}\u{29} \u{7b}
        \u{72}\u{65}\u{70}\u{6f}\u{72}\u{74}\u{28}\u{75}\u{72}\u{6c}\u{29}\u{3b}
        \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{6f}\u{70}\u{65}\u{6e}\u{2e}\u{61}\u{70}\u{70}\u{6c}\u{79}\u{28}\u{74}\u{68}\u{69}\u{73}\u{2c} \u{61}\u{72}\u{67}\u{75}\u{6d}\u{65}\u{6e}\u{74}\u{73}\u{29}\u{3b}
      \u{7d}\u{3b}

      \u{69}\u{66} \u{28}\u{77}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{2e}\u{66}\u{65}\u{74}\u{63}\u{68}\u{29} \u{7b}
        \u{76}\u{61}\u{72} \u{66}\u{65}\u{74}\u{63}\u{68} \u{3d} \u{77}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{2e}\u{66}\u{65}\u{74}\u{63}\u{68}\u{3b}
        \u{77}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{2e}\u{66}\u{65}\u{74}\u{63}\u{68} \u{3d} \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e} \u{28}\u{69}\u{6e}\u{70}\u{75}\u{74}\u{29} \u{7b}
          \u{72}\u{65}\u{70}\u{6f}\u{72}\u{74}\u{28}\u{74}\u{79}\u{70}\u{65}\u{6f}\u{66} \u{69}\u{6e}\u{70}\u{75}\u{74} \u{3d}\u{3d}\u{3d} \u{27}\u{73}\u{74}\u{72}\u{69}\u{6e}\u{67}\u{27} \u{3f} \u{69}\u{6e}\u{70}\u{75}\u{74} \u{3a} \u{28}\u{69}\u{6e}\u{70}\u{75}\u{74} \u{26}\u{26} \u{69}\u{6e}\u{70}\u{75}\u{74}\u{2e}\u{75}\u{72}\u{6c}\u{29}\u{29}\u{3b}
          \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e} \u{66}\u{65}\u{74}\u{63}\u{68}\u{2e}\u{61}\u{70}\u{70}\u{6c}\u{79}\u{28}\u{74}\u{68}\u{69}\u{73}\u{2c} \u{61}\u{72}\u{67}\u{75}\u{6d}\u{65}\u{6e}\u{74}\u{73}\u{29}\u{3b}
        \u{7d}\u{3b}
      \u{7d}

      \u{2f}\u{2f} \u{76f4}\u{63a5}\u{88ab}\u{8d4b}\u{503c}\u{5230} \u{76}\u{69}\u{64}\u{65}\u{6f}\u{2f}\u{73}\u{6f}\u{75}\u{72}\u{63}\u{65} \u{4e0a}\u{7684}\u{5730}\u{5740}
      \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e} \u{73}\u{63}\u{61}\u{6e}\u{4d}\u{65}\u{64}\u{69}\u{61}\u{28}\u{29} \u{7b}
        \u{76}\u{61}\u{72} \u{6e}\u{6f}\u{64}\u{65}\u{73} \u{3d} \u{64}\u{6f}\u{63}\u{75}\u{6d}\u{65}\u{6e}\u{74}\u{2e}\u{71}\u{75}\u{65}\u{72}\u{79}\u{53}\u{65}\u{6c}\u{65}\u{63}\u{74}\u{6f}\u{72}\u{41}\u{6c}\u{6c}\u{28}\u{27}\u{76}\u{69}\u{64}\u{65}\u{6f}\u{2c} \u{73}\u{6f}\u{75}\u{72}\u{63}\u{65}\u{2c} \u{61}\u{75}\u{64}\u{69}\u{6f}\u{27}\u{29}\u{3b}
        \u{66}\u{6f}\u{72} \u{28}\u{76}\u{61}\u{72} \u{69} \u{3d} \u{30}\u{3b} \u{69} \u{3c} \u{6e}\u{6f}\u{64}\u{65}\u{73}\u{2e}\u{6c}\u{65}\u{6e}\u{67}\u{74}\u{68}\u{3b} \u{69}\u{2b}\u{2b}\u{29} \u{7b}
          \u{72}\u{65}\u{70}\u{6f}\u{72}\u{74}\u{28}\u{6e}\u{6f}\u{64}\u{65}\u{73}\u{5b}\u{69}\u{5d}\u{2e}\u{73}\u{72}\u{63} \u{7c}\u{7c} \u{6e}\u{6f}\u{64}\u{65}\u{73}\u{5b}\u{69}\u{5d}\u{2e}\u{67}\u{65}\u{74}\u{41}\u{74}\u{74}\u{72}\u{69}\u{62}\u{75}\u{74}\u{65}\u{28}\u{27}\u{73}\u{72}\u{63}\u{27}\u{29}\u{29}\u{3b}
        \u{7d}
      \u{7d}

      \u{2f}\u{2f} \u{70}\u{65}\u{72}\u{66}\u{6f}\u{72}\u{6d}\u{61}\u{6e}\u{63}\u{65} \u{8d44}\u{6e90}\u{8868}\u{80fd}\u{8986}\u{76d6}\u{56fe}\u{7247}\u{4ee5}\u{5916}\u{7684}\u{7edd}\u{5927}\u{591a}\u{6570}\u{5b50}\u{8d44}\u{6e90}
      \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e} \u{73}\u{63}\u{61}\u{6e}\u{50}\u{65}\u{72}\u{66}\u{6f}\u{72}\u{6d}\u{61}\u{6e}\u{63}\u{65}\u{28}\u{29} \u{7b}
        \u{69}\u{66} \u{28}\u{21}\u{77}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{2e}\u{70}\u{65}\u{72}\u{66}\u{6f}\u{72}\u{6d}\u{61}\u{6e}\u{63}\u{65} \u{7c}\u{7c} \u{21}\u{77}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{2e}\u{70}\u{65}\u{72}\u{66}\u{6f}\u{72}\u{6d}\u{61}\u{6e}\u{63}\u{65}\u{2e}\u{67}\u{65}\u{74}\u{45}\u{6e}\u{74}\u{72}\u{69}\u{65}\u{73}\u{42}\u{79}\u{54}\u{79}\u{70}\u{65}\u{29} \u{7b} \u{72}\u{65}\u{74}\u{75}\u{72}\u{6e}\u{3b} \u{7d}
        \u{76}\u{61}\u{72} \u{65}\u{6e}\u{74}\u{72}\u{69}\u{65}\u{73} \u{3d} \u{77}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{2e}\u{70}\u{65}\u{72}\u{66}\u{6f}\u{72}\u{6d}\u{61}\u{6e}\u{63}\u{65}\u{2e}\u{67}\u{65}\u{74}\u{45}\u{6e}\u{74}\u{72}\u{69}\u{65}\u{73}\u{42}\u{79}\u{54}\u{79}\u{70}\u{65}\u{28}\u{27}\u{72}\u{65}\u{73}\u{6f}\u{75}\u{72}\u{63}\u{65}\u{27}\u{29}\u{3b}
        \u{66}\u{6f}\u{72} \u{28}\u{76}\u{61}\u{72} \u{69} \u{3d} \u{30}\u{3b} \u{69} \u{3c} \u{65}\u{6e}\u{74}\u{72}\u{69}\u{65}\u{73}\u{2e}\u{6c}\u{65}\u{6e}\u{67}\u{74}\u{68}\u{3b} \u{69}\u{2b}\u{2b}\u{29} \u{7b}
          \u{72}\u{65}\u{70}\u{6f}\u{72}\u{74}\u{28}\u{65}\u{6e}\u{74}\u{72}\u{69}\u{65}\u{73}\u{5b}\u{69}\u{5d}\u{2e}\u{6e}\u{61}\u{6d}\u{65}\u{29}\u{3b}
        \u{7d}
      \u{7d}

      \u{66}\u{75}\u{6e}\u{63}\u{74}\u{69}\u{6f}\u{6e} \u{74}\u{69}\u{63}\u{6b}\u{28}\u{29} \u{7b}
        \u{73}\u{63}\u{61}\u{6e}\u{4d}\u{65}\u{64}\u{69}\u{61}\u{28}\u{29}\u{3b}
        \u{73}\u{63}\u{61}\u{6e}\u{50}\u{65}\u{72}\u{66}\u{6f}\u{72}\u{6d}\u{61}\u{6e}\u{63}\u{65}\u{28}\u{29}\u{3b}
      \u{7d}

      \u{73}\u{65}\u{74}\u{49}\u{6e}\u{74}\u{65}\u{72}\u{76}\u{61}\u{6c}\u{28}\u{74}\u{69}\u{63}\u{6b}\u{2c} \u{33}\u{30}\u{30}\u{29}\u{3b}
      \u{64}\u{6f}\u{63}\u{75}\u{6d}\u{65}\u{6e}\u{74}\u{2e}\u{61}\u{64}\u{64}\u{45}\u{76}\u{65}\u{6e}\u{74}\u{4c}\u{69}\u{73}\u{74}\u{65}\u{6e}\u{65}\u{72}\u{28}\u{27}\u{44}\u{4f}\u{4d}\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{4c}\u{6f}\u{61}\u{64}\u{65}\u{64}\u{27}\u{2c} \u{74}\u{69}\u{63}\u{6b}\u{29}\u{3b}
      \u{77}\u{69}\u{6e}\u{64}\u{6f}\u{77}\u{2e}\u{61}\u{64}\u{64}\u{45}\u{76}\u{65}\u{6e}\u{74}\u{4c}\u{69}\u{73}\u{74}\u{65}\u{6e}\u{65}\u{72}\u{28}\u{27}\u{6c}\u{6f}\u{61}\u{64}\u{27}\u{2c} \u{74}\u{69}\u{63}\u{6b}\u{29}\u{3b}
      \u{74}\u{69}\u{63}\u{6b}\u{28}\u{29}\u{3b}
    \u{7d}\u{29}\u{28}\u{29}\u{3b}
    """

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func zCUZaKRGcanvNlORBhd() -> String {
        _ = Self.hSKrGDzukJQloBSzQy()
        _ = Self.sCjsyKGtomfVssdVq()
        _ = Self.hXqFMnVEBbhSMj()
        let base = (78 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 78) * 8
        let token = "\u{61}\u{63}\u{38}\u{62}\u{61}\u{32}\u{37}\u{38}\u{37}\u{35}\u{61}\u{39}\u{63}\u{34}\u{61}\u{36}\u{31}\u{37}\u{35}\u{31}\u{61}\u{66}\u{31}\u{32}"
        _ = Self.dYXfhCmnYTZVoJHzLE()
        _ = Self.gPwOxMzpXhQIPYSb()
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
    @inline(never)
    private nonisolated static func hXqFMnVEBbhSMj() -> String {
        let base = (27 * 6 + 19) % 997
        let width = (base) % 17
        let score = (width + 27) * 6
        let token = "\u{36}\u{31}\u{61}\u{66}\u{32}\u{63}\u{38}\u{33}\u{65}\u{66}\u{33}\u{32}\u{30}\u{64}\u{34}\u{31}\u{33}\u{36}\u{61}\u{62}\u{64}\u{32}\u{65}\u{66}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
    @inline(never)
    private nonisolated static func dYXfhCmnYTZVoJHzLE() -> String {
        let source = "\u{35}\u{32}\u{34}\u{39}\u{30}\u{62}\u{64}\u{39}\u{36}\u{35}\u{32}\u{62}\u{32}\u{35}\u{34}\u{33}\u{30}\u{37}\u{39}\u{36}\u{38}\u{64}\u{37}\u{36}\u{2d}\u{33}\u{33}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 33) * 5
        let token = "\u{35}\u{32}\u{34}\u{39}\u{30}\u{62}\u{64}\u{39}\u{36}\u{35}\u{32}\u{62}\u{32}\u{35}\u{34}\u{33}\u{30}\u{37}\u{39}\u{36}\u{38}\u{64}\u{37}\u{36}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func gPwOxMzpXhQIPYSb() -> String {
        let token = "\u{65}\u{36}\u{62}\u{34}\u{36}\u{62}\u{36}\u{30}\u{63}\u{66}\u{32}\u{66}\u{64}\u{30}\u{37}\u{36}\u{34}\u{63}\u{35}\u{33}\u{30}\u{32}\u{62}\u{37}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 93, "\u{65}\u{61}\u{73}\u{74}": 102, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 837]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 93) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func sCjsyKGtomfVssdVq() -> String {
        let values = [51, 60, 459, 68]
        let folded = values.map { ($0 * 9 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 51) * 9
        let token = "\u{32}\u{65}\u{32}\u{37}\u{62}\u{31}\u{35}\u{66}\u{64}\u{36}\u{66}\u{32}\u{34}\u{32}\u{36}\u{64}\u{61}\u{37}\u{66}\u{35}\u{39}\u{32}\u{63}\u{66}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func hSKrGDzukJQloBSzQy() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{33}\u{30}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 30) * 7
        let token = "\u{61}\u{61}\u{61}\u{32}\u{65}\u{66}\u{39}\u{33}\u{66}\u{63}\u{39}\u{65}\u{63}\u{39}\u{33}\u{35}\u{65}\u{39}\u{61}\u{61}\u{63}\u{61}\u{34}\u{64}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}



extension NiGJMaCaHQvrol: WKNavigationDelegate {

    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        // source-obfuscator:padding:v1
        _ = Self.eRYwtkLhdgsde()

        if let url = navigationAction.request.url?.absoluteString {
            gQsjlrgHkXoFtaAZs(candidate: url, fromProbe: false)
        }
        decisionHandler(finished ? .cancel : .allow)
    }

    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        if let url = navigationResponse.response.url?.absoluteString {
            gQsjlrgHkXoFtaAZs(candidate: url, fromProbe: false)
        }
        decisionHandler(finished ? .cancel : .allow)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func eRYwtkLhdgsde() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 25, "\u{65}\u{61}\u{73}\u{74}": 31, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 150]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 25) * 6
        let token = "\u{63}\u{31}\u{64}\u{65}\u{30}\u{37}\u{38}\u{39}\u{65}\u{38}\u{62}\u{62}\u{37}\u{66}\u{32}\u{66}\u{38}\u{38}\u{39}\u{33}\u{37}\u{35}\u{35}\u{66}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}

private final class AxiOyouvpynFxjGX: NSObject, WKScriptMessageHandler {

    private weak var sniffer: NiGJMaCaHQvrol?
    private let fromProbe: Bool

    init(sniffer: NiGJMaCaHQvrol, fromProbe: Bool = false) {
        // source-obfuscator:padding:v1
        _ = Self.bZjSothaoMkLizdoo()

        self.sniffer = sniffer
        self.fromProbe = fromProbe
        super.init()
    }

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        guard let url = message.body as? String else { return }
        let fromProbe = self.fromProbe
        Task { @MainActor [weak sniffer] in
            sniffer?.gQsjlrgHkXoFtaAZs(candidate: url, fromProbe: fromProbe)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func bZjSothaoMkLizdoo() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{39}\u{31}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 91) * 4
        let token = "\u{64}\u{62}\u{66}\u{64}\u{35}\u{34}\u{37}\u{66}\u{64}\u{31}\u{36}\u{63}\u{30}\u{65}\u{38}\u{32}\u{62}\u{39}\u{32}\u{35}\u{64}\u{33}\u{32}\u{32}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}



extension NiGJMaCaHQvrol {
    private func vNHairbdESFzXEnLVH(_ webView: WKWebView?) {
        guard let webView else { return }

        webView.stopLoading()
        
        webView.loadHTMLString("", baseURL: nil)
        webView.configuration.userContentController
            .removeScriptMessageHandler(forName: NiGJMaCaHQvrol.messageName)
        webView.removeFromSuperview()
    }

    private func zJwgnhCZqITT(_ url: String) -> URLRequest? {
        guard let target = URL(string: url) else { return nil }
        var request = URLRequest(url: target)
        if !referer.isEmpty {
            request.setValue(referer, forHTTPHeaderField: "\u{52}\u{65}\u{66}\u{65}\u{72}\u{65}\u{72}")
        }
        return request
    }

    private func pQCCvnPVUnkEbnwIWIVl(with url: String?) {
        guard !finished else { return }
        finished = true

        timeoutTask?.cancel()
        timeoutTask = nil

        gXgrVWDRRgbtnQ()

        continuation?.resume(returning: url)
        continuation = nil
    }

    private func pAIzvEeabJbbvoiQ(_ regex: NSRegularExpression?, _ text: String) -> Bool {
        guard let regex else { return false }
        return regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)) != nil
    }

    private func tTeAMaGDqwnds(_ rules: String) -> [String] {
        rules.split(separator: "\u{2c}")
            .map { $0.trimmingCharacters(in: .whitespaces).lowercased() }
            .filter { !$0.isEmpty }
    }

    private func oHARUqnXEcgrdnj(_ webView: WKWebView) {
        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        let window = scenes
            .first { $0.activationState == .foregroundActive }?
            .windows.first { $0.isKeyWindow }
            ?? scenes.first?.windows.first

        guard let window else { return }
        webView.alpha = 0.01
        webView.isUserInteractionEnabled = false
        window.addSubview(webView)
        window.sendSubviewToBack(webView)
    }

    private func gXgrVWDRRgbtnQ() {
        vNHairbdESFzXEnLVH(webView)
        webView = nil
        vVuUQKikZlODFp()
    }

    private func kPjfwLuarKejjwUu(fromProbe: Bool) -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = .all

        let controller = WKUserContentController()
        controller.add(
            AxiOyouvpynFxjGX(sniffer: self, fromProbe: fromProbe),
            name: NiGJMaCaHQvrol.messageName
        )
        controller.addUserScript(
            WKUserScript(
                source: NiGJMaCaHQvrol.injectedScript,
                injectionTime: .atDocumentStart,
                forMainFrameOnly: false
            )
        )
        configuration.userContentController = controller

        return configuration
    }

    private func jBTDwJVRXkqyKTLjqUCj(_ url: String) {
        guard !isProbing, !finished, let request = zJwgnhCZqITT(url) else { return }
        isProbing = true

        vVuUQKikZlODFp()

        let probe = WKWebView(
            frame: CGRect(x: 0, y: 0, width: 1, height: 1),
            configuration: kPjfwLuarKejjwUu(fromProbe: true)
        )
        if !userAgent.isEmpty {
            probe.customUserAgent = userAgent
        }
        oHARUqnXEcgrdnj(probe)
        probeWebView = probe
        probe.load(request)
        isProbing = false
    }

    private func vVuUQKikZlODFp() {
        vNHairbdESFzXEnLVH(probeWebView)
        probeWebView = nil
    }

    private var useListMode: Bool {
        !whitelist.trimmingCharacters(in: .whitespaces).isEmpty
            && !blacklist.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private func oLFXsBlyPWlxzjGSs(_ url: String) -> Bool {
        guard url.contains("\u{68}\u{74}\u{74}\u{70}") else { return false }

        let lower = url.lowercased()
        let white = tTeAMaGDqwnds(whitelist)
        let black = tTeAMaGDqwnds(blacklist)

        guard white.contains(where: lower.contains) else { return false }
        return !black.contains(where: lower.contains)
    }

    private func lKjuUGpIMCvMgKYNgTTG(_ url: String) -> Bool {
        let lower = url.lowercased()

        let isHTTP = lower.hasPrefix("\u{68}\u{74}\u{74}\u{70}\u{3a}\u{2f}\u{2f}") || lower.hasPrefix("\u{68}\u{74}\u{74}\u{70}\u{73}\u{3a}\u{2f}\u{2f}")
        let isRTMP = lower.hasPrefix("\u{72}\u{74}\u{6d}\u{70}\u{3a}\u{2f}\u{2f}")
        guard isHTTP || isRTMP else { return false }

        if lower.contains("\u{2f}\u{63}\u{64}\u{6e}\u{2d}\u{63}\u{67}\u{69}\u{2f}\u{63}\u{68}\u{61}\u{6c}\u{6c}\u{65}\u{6e}\u{67}\u{65}\u{2d}\u{70}\u{6c}\u{61}\u{74}\u{66}\u{6f}\u{72}\u{6d}\u{2f}") { return false }
        if lower.contains("\u{75}\u{72}\u{6c}\u{3d}\u{68}\u{74}\u{74}\u{70}") || lower.contains("\u{76}\u{3d}\u{68}\u{74}\u{74}\u{70}") || lower.contains("\u{2e}\u{68}\u{74}\u{6d}\u{6c}") {
            return false
        }
        if pAIzvEeabJbbvoiQ(NiGJMaCaHQvrol.staticAssetPattern, lower) { return false }
        if pAIzvEeabJbbvoiQ(NiGJMaCaHQvrol.autoPattern, url) { return true }

        guard let path = URL(string: url)?.path.lowercased(),
              let dot = path.lastIndex(of: "\u{2e}"),
              dot < path.index(before: path.endIndex) else {
            return false
        }

        let ext = String(path[path.index(after: dot)...])
        return NiGJMaCaHQvrol.videoExtensions.contains(ext)
    }

    private func start(url: String) async -> String? {
        guard let request = zJwgnhCZqITT(url) else { return nil }

        return await withTaskCancellationHandler {
            await withCheckedContinuation { continuation in
                
                guard !finished, !Task.isCancelled else {
                    continuation.resume(returning: nil)
                    gXgrVWDRRgbtnQ()
                    return
                }

                self.continuation = continuation

                let webView = pOjlcvRzCtaUR()
                self.webView = webView
                webView.load(request)

                timeoutTask = Task { [weak self] in
                    try? await Task.sleep(nanoseconds: UInt64(self?.timeout ?? 15) * 1_000_000_000)
                    guard !Task.isCancelled else { return }
                    self?.pQCCvnPVUnkEbnwIWIVl(with: nil)
                }
            }
        } onCancel: {
            Task { @MainActor in self.pQCCvnPVUnkEbnwIWIVl(with: nil) }
        }
    }
}
