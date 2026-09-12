




import Foundation
import SwiftUI
import Combine
import DanmakuKit

struct NyDHuuVghMbObgSF: Codable {
    var opacity: Double = 0.8
    var area: Double = 0.3
    var speed: Double = 1.0
    var fontSize: CGFloat = 18
}

final class PmZWrVvNnWEOq {
    static let shared = PmZWrVvNnWEOq()

    private let key = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{41}\u{50}\u{78}\u{4d}\u{66}\u{51}\u{54}\u{4c}\u{4a}")

    func cAQLAGfTtPOblbydJmjJ() -> NyDHuuVghMbObgSF {
        // source-obfuscator:padding:v1
        _ = Self.aNIOQOMWCviauioFQsnl()

        guard
            let data = UserDefaults.standard.data(forKey: key),
            let settings = try? JSONDecoder().decode(NyDHuuVghMbObgSF.self, from: data)
        else {
            return NyDHuuVghMbObgSF()
        }
        return settings
    }

    func rUfRSskygrTijxBpvEP(_ settings: NyDHuuVghMbObgSF) {
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func aNIOQOMWCviauioFQsnl() -> String {
        let token = "\u{38}\u{39}\u{64}\u{33}\u{38}\u{33}\u{63}\u{30}\u{34}\u{65}\u{33}\u{37}\u{32}\u{66}\u{66}\u{65}\u{36}\u{32}\u{65}\u{33}\u{31}\u{61}\u{33}\u{32}"
        let base = (18 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 18) * 8
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

class XmSboKowMSNlcjQ: ObservableObject {

    let controller = VqxMXjjYrHuMBKhfRqIl()

    @Published var isLoadingDanmaku = false

    @Published var danmakuCount = 0

    private var loadedKey: String?

    private var timeline = DwLOuINpeVFwFl()

    private var cancellables = Set<AnyCancellable>()

    @Published var enabled: Bool = true
    @Published var danmakuOpacity: Double = 0.8
    @Published var danmakuArea: Double = 0.3
    @Published var danmakuSpeed: Double = 0
    @Published var danmakuFontSize: Double = 18.0

    init() {
        // source-obfuscator:padding:v1
        _ = Self.eDWgmPliKTEVLlLkz()

        let settings = PmZWrVvNnWEOq.shared.cAQLAGfTtPOblbydJmjJ()

        self.danmakuOpacity = settings.opacity
        self.danmakuArea = settings.area
        self.danmakuSpeed = settings.speed
        self.danmakuFontSize = settings.fontSize

        self.controller.danmakuArea = settings.area
        self.controller.danmakuOpacity = settings.opacity
        self.controller.danmakuSpeed = settings.speed
        self.controller.danmakuFontSize = settings.fontSize

        hRutIBWfvRRAjtVW()
    }

    

    

    func gYUvHCrorFaSt(request: ZpyCaqfvdmdi, startAt: TimeInterval = 0) {
        let key = "\(request.vodName)\u{7c}\(request.episode)\u{7c}\(request.playURL)"
        guard key != loadedKey else { return }
        loadedKey = key

        
        wWgELdUqPJsjKI([], startAt: startAt)

        guard let provider = UvBxBoMIYrRWck.provider else { return }

        isLoadingDanmaku = true
        provider(request) { [weak self] list in
            guard let self else { return }
            DispatchQueue.main.async {
                guard key == self.loadedKey else { return }
                self.isLoadingDanmaku = false
                self.wWgELdUqPJsjKI(self.uHEQcYvqaxTKTxH(list), startAt: self.timeline.currentTime ?? startAt)
            }
        }
    }

    

    

    private func hYvhMoDNNQFwc(_ colorString: String) -> Color {
        
        let cLXhujSyZHtDqh: Swift.UInt64 = 0xFFFFFF
        var colorInt: UInt64 = cLXhujSyZHtDqh

        if colorString.hasPrefix("\u{23}") {
            let hex = String(colorString.dropFirst())
            Scanner(string: hex).scanHexInt64(&colorInt)
        } else if let intValue = UInt64(colorString) {
            colorInt = intValue
        }

        
        let uVIFwCIQEOLDwSaA: Swift.Double = Double((colorInt & 0xFF0000) >> 16) / 255.0
        let red = uVIFwCIQEOLDwSaA
        
        let (green, blue) = Self.dQdGtavuqBgTqXyzoQ(colorInt)

        return Color(red: red, green: green, blue: blue)
    }

    

    func rIjxshbFfOhW(currentTime: TimeInterval) {
        
        guard enabled, LkzXORcEdLaolfAi.isMasterSwitchOn else { return }

        let lVljBCCGLiTE = timeline.lVljBCCGLiTE(to: currentTime)

        if lVljBCCGLiTE.didJump {
            controller.xCfNISbQXeaYEQgjTcsl()
            controller.lBqDioNjNLBVafGlauXk()
        }

        lVljBCCGLiTE.items.forEach(controller.send)
    }

    func wPCxYHZRJfFZPQAPNP(to time: TimeInterval) {
        timeline.seek(to: time)
        controller.xCfNISbQXeaYEQgjTcsl()
        controller.lBqDioNjNLBVafGlauXk()
    }

    func wSpabVaTsqoMXBk(text: String, colorHex: String) {
        guard !text.isEmpty else { return }

        controller.send(
            JqIVyfygrJYY(
                time: timeline.currentTime ?? 0,
                text: "\u{5b}\(text)\u{5d}",
                color: hYvhMoDNNQFwc(colorHex),
                type: .scroll,
                fontSize: danmakuFontSize
            )
        )
    }

    

    func qVPeftNHOcXtLRGsA() {
        controller.danmakuView?.recalculateTracks()
    }

    func rIjxshbFfOhW(danmuFontSize: CGFloat) {
        danmakuFontSize = danmuFontSize
        controller.danmakuFontSize = danmuFontSize
    }

    func rIjxshbFfOhW(area: Double) {
        danmakuArea = area
        controller.danmakuArea = area
    }

    func rIjxshbFfOhW(opacity: Double) {
        danmakuOpacity = opacity
        controller.danmakuOpacity = opacity
    }

    func rIjxshbFfOhW(speed: Double) {
        danmakuSpeed = speed
        controller.danmakuSpeed = speed
    }

    func tAwIYlHytXvHkYetSk() {
        controller.tBwnSRBDSHQEGfGFo()
    }

    func lMSfpDHFwMlcoSp() {
        controller.lBqDioNjNLBVafGlauXk()
    }

    func fQiyoZMrQZVtJRvhbzT() {
        controller.xCfNISbQXeaYEQgjTcsl()
    }

    
    private nonisolated static func dQdGtavuqBgTqXyzoQ(_ colorInt: Swift.UInt64) -> (Swift.Double, Swift.Double) {
        let green = Double((colorInt & 0x00FF00) >> 8) / 255.0
        let blue = Double(colorInt & 0x0000FF) / 255.0
        return (green, blue)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func eDWgmPliKTEVLlLkz() -> String {
        let source = "\u{36}\u{38}\u{33}\u{61}\u{32}\u{38}\u{36}\u{37}\u{30}\u{61}\u{64}\u{65}\u{32}\u{33}\u{37}\u{32}\u{62}\u{35}\u{62}\u{38}\u{62}\u{38}\u{34}\u{36}\u{2d}\u{37}\u{35}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 75) * 8
        let token = "\u{36}\u{38}\u{33}\u{61}\u{32}\u{38}\u{36}\u{37}\u{30}\u{61}\u{64}\u{65}\u{32}\u{33}\u{37}\u{32}\u{62}\u{35}\u{62}\u{38}\u{62}\u{38}\u{34}\u{36}"
        _ = Self.yCbKChunKdbo()
        _ = Self.bRXAXPCvyaepJqq()
        _ = Self.eDgVbZasLveqQuMgvcV()
        _ = Self.aHFXZNwdIDCEedQZlpu()
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
    @inline(never)
    private nonisolated static func aHFXZNwdIDCEedQZlpu() -> String {
        let token = "\u{63}\u{66}\u{33}\u{30}\u{33}\u{65}\u{62}\u{66}\u{39}\u{32}\u{63}\u{63}\u{39}\u{30}\u{34}\u{31}\u{62}\u{30}\u{66}\u{32}\u{32}\u{38}\u{30}\u{65}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 80, "\u{65}\u{61}\u{73}\u{74}": 87, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 560]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 80) * 7
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func eDgVbZasLveqQuMgvcV() -> String {
        let values = [66, 72, 396, 83]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 66) * 6
        let token = "\u{64}\u{35}\u{36}\u{63}\u{35}\u{64}\u{61}\u{37}\u{30}\u{64}\u{33}\u{38}\u{39}\u{31}\u{63}\u{32}\u{64}\u{34}\u{35}\u{35}\u{33}\u{64}\u{36}\u{39}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
    @inline(never)
    private nonisolated static func yCbKChunKdbo() -> String {
        let base = (20 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 20) * 7
        let token = "\u{30}\u{32}\u{34}\u{32}\u{62}\u{34}\u{65}\u{66}\u{34}\u{32}\u{33}\u{36}\u{35}\u{39}\u{66}\u{36}\u{63}\u{66}\u{66}\u{65}\u{38}\u{63}\u{66}\u{34}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
    @inline(never)
    private nonisolated static func bRXAXPCvyaepJqq() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 57, "\u{65}\u{61}\u{73}\u{74}": 64, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 399]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 57) * 7
        let token = "\u{32}\u{65}\u{39}\u{37}\u{30}\u{39}\u{35}\u{39}\u{31}\u{65}\u{31}\u{32}\u{63}\u{30}\u{36}\u{63}\u{30}\u{61}\u{34}\u{63}\u{64}\u{34}\u{38}\u{36}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}



extension XmSboKowMSNlcjQ {
    private func uHEQcYvqaxTKTxH(_ data: [VeiHztjEDahyOlz]) -> [JqIVyfygrJYY] {
        data.compactMap { item -> JqIVyfygrJYY? in
            var content = item.text
            return JqIVyfygrJYY(
                time: item.time,
                text: content,
                color: hYvhMoDNNQFwc(item.colorHex),
                type: .kOQABzdGQHlKDBSuQQAn(mode: item.type),
                fontSize: danmakuFontSize
            )
        }
    }

    private func wWgELdUqPJsjKI(_ items: [JqIVyfygrJYY], startAt: TimeInterval) {
        timeline.gJFfxRXZAHUdxJsmndb(with: items, startAt: startAt)
        danmakuCount = timeline.items.count
        controller.xCfNISbQXeaYEQgjTcsl()
        qVPeftNHOcXtLRGsA()
        controller.lBqDioNjNLBVafGlauXk()
    }

    private func hRutIBWfvRRAjtVW() {
        
        $enabled
            .sink { [weak self] in self?.controller.isEnabled = $0 }
            .store(in: &cancellables)

        Publishers.CombineLatest4(
            $danmakuOpacity,
            $danmakuArea,
            $danmakuSpeed,
            $danmakuFontSize
        )
        .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
        .sink { [weak self] opacity, area, speed, fontSize in
            guard let self else { return }

            self.controller.danmakuOpacity = opacity
            self.controller.danmakuArea = area
            self.controller.danmakuSpeed = speed
            self.controller.danmakuFontSize = fontSize

            let newSettings = NyDHuuVghMbObgSF(
                opacity: opacity,
                area: area,
                speed: speed,
                fontSize: fontSize
            )

            PmZWrVvNnWEOq.shared.rUfRSskygrTijxBpvEP(newSettings)
        }
        .store(in: &cancellables)
    }
}
