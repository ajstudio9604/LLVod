//
//  AHWebSniffer.swift
//  LLVod
//
//  无头 WebView 视频嗅探，对应 Flutter WebviewMobileItemControllerImpel
//
//  WKWebView 没有 onLoadResource / shouldInterceptRequest，
//  这里改成注入脚本：钩住 XHR、fetch、video 元素，并轮询 performance 资源表，
//  把候选地址回传给原生按同一套规则判定。
//  两种模式与 Flutter 一致：黑白名单都非空走名单模式，否则走自动规则。
//

import Foundation
import WebKit

@MainActor
final class AHWebSniffer: NSObject {

    static func sniff(
        url: String,
        whitelist: String,
        blacklist: String,
        userAgent: String = "",
        referer: String = "",
        timeout: TimeInterval = 15
    ) async -> String? {
        let sniffer = AHWebSniffer(
            whitelist: whitelist,
            blacklist: blacklist,
            userAgent: userAgent,
            referer: referer,
            timeout: timeout
        )
        return await sniffer.start(url: url)
    }

    // MARK: - 规则

    private static let autoPattern = try? NSRegularExpression(
        pattern: #"https?://[^\s]{12,}\.(?:m3u8|mp4|mkv|flv|mp3|m4a|aac|mpd)(?:\?.*)?|https?://.*?video/tos[^\s]*|rtmp:[^\s]+"#,
        options: .caseInsensitive
    )

    private static let playerBridgePattern = try? NSRegularExpression(
        pattern: #"player.*https?://"#,
        options: .caseInsensitive
    )

    private static let staticAssetPattern = try? NSRegularExpression(
        pattern: #"\.(?:css|js|mjs|jpg|jpeg|png|gif|bmp|webp|svg|ico|map|woff|woff2|ttf|otf|eot|json|xml)(?:\?|$)"#,
        options: .caseInsensitive
    )

    private static let videoExtensions: Set<String> = [
        "m3u8", "mp4", "mkv", "flv", "mp3", "m4a", "aac", "mpd",
        "ts", "m4s", "mov", "avi", "wmv", "rmvb", "webm", "f4v", "m3u"
    ]

    private static let maxProbeCandidates = 5

    // MARK: - 状态

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

    private var useListMode: Bool {
        !whitelist.trimmingCharacters(in: .whitespaces).isEmpty
            && !blacklist.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private func start(url: String) async -> String? {
        guard let request = makeRequest(url) else { return nil }

        return await withTaskCancellationHandler {
            await withCheckedContinuation { continuation in
                // 取消可能比这里先到，那时直接空手返回，否则 continuation 没人 resume 会一直挂着
                guard !finished, !Task.isCancelled else {
                    continuation.resume(returning: nil)
                    cleanup()
                    return
                }

                self.continuation = continuation

                let webView = makeWebView()
                self.webView = webView
                webView.load(request)

                timeoutTask = Task { [weak self] in
                    try? await Task.sleep(nanoseconds: UInt64(self?.timeout ?? 15) * 1_000_000_000)
                    guard !Task.isCancelled else { return }
                    self?.finish(with: nil)
                }
            }
        } onCancel: {
            Task { @MainActor in self.finish(with: nil) }
        }
    }

    private func makeRequest(_ url: String) -> URLRequest? {
        guard let target = URL(string: url) else { return nil }
        var request = URLRequest(url: target)
        if !referer.isEmpty {
            request.setValue(referer, forHTTPHeaderField: "Referer")
        }
        return request
    }

    private func makeWebView() -> WKWebView {
        let configuration = makeConfiguration(fromProbe: false)
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), configuration: configuration)
        webView.navigationDelegate = self
        if !userAgent.isEmpty {
            webView.customUserAgent = userAgent
        }

        // 脱离视图层级的 WebView 会被系统降频，挂到窗口上但不可见
        attachInvisible(webView)
        return webView
    }

    private func makeConfiguration(fromProbe: Bool) -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = .all

        let controller = WKUserContentController()
        controller.add(
            AHWebSnifferMessageProxy(sniffer: self, fromProbe: fromProbe),
            name: AHWebSniffer.messageName
        )
        controller.addUserScript(
            WKUserScript(
                source: AHWebSniffer.injectedScript,
                injectionTime: .atDocumentStart,
                forMainFrameOnly: false
            )
        )
        configuration.userContentController = controller

        return configuration
    }

    private func attachInvisible(_ webView: WKWebView) {
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

    // MARK: - 候选处理

    fileprivate func handle(candidate raw: String, fromProbe: Bool) {
        guard !finished else { return }

        let url = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !url.isEmpty else { return }

        if useListMode {
            if matchesLists(url) {
                finish(with: url)
            }
            return
        }

        if isVideoCandidate(url) {
            finish(with: url)
            return
        }

        if !fromProbe, shouldProbe(url) {
            startProbe(url)
        }
    }

    private func matchesLists(_ url: String) -> Bool {
        guard url.contains("http") else { return false }

        let lower = url.lowercased()
        let white = splitRules(whitelist)
        let black = splitRules(blacklist)

        guard white.contains(where: lower.contains) else { return false }
        return !black.contains(where: lower.contains)
    }

    private func isVideoCandidate(_ url: String) -> Bool {
        let lower = url.lowercased()

        let isHTTP = lower.hasPrefix("http://") || lower.hasPrefix("https://")
        let isRTMP = lower.hasPrefix("rtmp://")
        guard isHTTP || isRTMP else { return false }

        if lower.contains("/cdn-cgi/challenge-platform/") { return false }
        if lower.contains("url=http") || lower.contains("v=http") || lower.contains(".html") {
            return false
        }
        if matches(AHWebSniffer.staticAssetPattern, lower) { return false }
        if matches(AHWebSniffer.autoPattern, url) { return true }

        guard let path = URL(string: url)?.path.lowercased(),
              let dot = path.lastIndex(of: "."),
              dot < path.index(before: path.endIndex) else {
            return false
        }

        let ext = String(path[path.index(after: dot)...])
        return AHWebSniffer.videoExtensions.contains(ext)
    }

    private func shouldProbe(_ url: String) -> Bool {
        let lower = url.lowercased()
        guard lower.hasPrefix("http://") || lower.hasPrefix("https://") else { return false }
        guard !matches(AHWebSniffer.staticAssetPattern, lower) else { return false }
        guard matches(AHWebSniffer.playerBridgePattern, lower) else { return false }

        if probeCandidates.count > AHWebSniffer.maxProbeCandidates {
            probeCandidates.removeAll()
        }

        return probeCandidates.insert(lower).inserted
    }

    private func startProbe(_ url: String) {
        guard !isProbing, !finished, let request = makeRequest(url) else { return }
        isProbing = true

        disposeProbe()

        let probe = WKWebView(
            frame: CGRect(x: 0, y: 0, width: 1, height: 1),
            configuration: makeConfiguration(fromProbe: true)
        )
        if !userAgent.isEmpty {
            probe.customUserAgent = userAgent
        }
        attachInvisible(probe)
        probeWebView = probe
        probe.load(request)
        isProbing = false
    }

    // MARK: - 收尾

    private func finish(with url: String?) {
        guard !finished else { return }
        finished = true

        timeoutTask?.cancel()
        timeoutTask = nil

        cleanup()

        continuation?.resume(returning: url)
        continuation = nil
    }

    private func cleanup() {
        dispose(webView)
        webView = nil
        disposeProbe()
    }

    private func disposeProbe() {
        dispose(probeWebView)
        probeWebView = nil
    }

    private func dispose(_ webView: WKWebView?) {
        guard let webView else { return }

        webView.stopLoading()
        // 页面里的 <video> 要靠换页才会真正停下来，光 stopLoading 拦不住已经在放的媒体
        webView.loadHTMLString("", baseURL: nil)
        webView.configuration.userContentController
            .removeScriptMessageHandler(forName: AHWebSniffer.messageName)
        webView.removeFromSuperview()
    }

    // MARK: - 工具

    private func splitRules(_ rules: String) -> [String] {
        rules.split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces).lowercased() }
            .filter { !$0.isEmpty }
    }

    private func matches(_ regex: NSRegularExpression?, _ text: String) -> Bool {
        guard let regex else { return false }
        return regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)) != nil
    }

    fileprivate static let messageName = "ahSniffer"

    private static let injectedScript = """
    (function () {
      if (window.__ahSnifferInstalled) { return; }
      window.__ahSnifferInstalled = true;

      var seen = {};

      function report(url) {
        if (!url || typeof url !== 'string') { return; }
        if (url.indexOf('http') !== 0 && url.indexOf('rtmp') !== 0) { return; }
        if (seen[url]) { return; }
        seen[url] = true;
        try {
          window.webkit.messageHandlers.ahSniffer.postMessage(url);
        } catch (e) {}
      }

      var open = XMLHttpRequest.prototype.open;
      XMLHttpRequest.prototype.open = function (method, url) {
        report(url);
        return open.apply(this, arguments);
      };

      if (window.fetch) {
        var fetch = window.fetch;
        window.fetch = function (input) {
          report(typeof input === 'string' ? input : (input && input.url));
          return fetch.apply(this, arguments);
        };
      }

      // 直接被赋值到 video/source 上的地址
      function scanMedia() {
        var nodes = document.querySelectorAll('video, source, audio');
        for (var i = 0; i < nodes.length; i++) {
          report(nodes[i].src || nodes[i].getAttribute('src'));
        }
      }

      // performance 资源表能覆盖图片以外的绝大多数子资源
      function scanPerformance() {
        if (!window.performance || !window.performance.getEntriesByType) { return; }
        var entries = window.performance.getEntriesByType('resource');
        for (var i = 0; i < entries.length; i++) {
          report(entries[i].name);
        }
      }

      function tick() {
        scanMedia();
        scanPerformance();
      }

      setInterval(tick, 300);
      document.addEventListener('DOMContentLoaded', tick);
      window.addEventListener('load', tick);
      tick();
    })();
    """
}

// MARK: - 导航拦截

extension AHWebSniffer: WKNavigationDelegate {

    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if let url = navigationAction.request.url?.absoluteString {
            handle(candidate: url, fromProbe: false)
        }
        decisionHandler(finished ? .cancel : .allow)
    }

    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        if let url = navigationResponse.response.url?.absoluteString {
            handle(candidate: url, fromProbe: false)
        }
        decisionHandler(finished ? .cancel : .allow)
    }
}

private final class AHWebSnifferMessageProxy: NSObject, WKScriptMessageHandler {

    private weak var sniffer: AHWebSniffer?
    private let fromProbe: Bool

    init(sniffer: AHWebSniffer, fromProbe: Bool = false) {
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
            sniffer?.handle(candidate: url, fromProbe: fromProbe)
        }
    }
}
