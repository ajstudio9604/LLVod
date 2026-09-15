//
//  AHDanmakuManager.swift
//  LLVod
//

import Foundation
import SwiftUI
import Combine
import DanmakuKit

struct AHDanmakuSettings: Codable {
    var opacity: Double = 0.8
    var area: Double = 0.3
    var speed: Double = 1.0
    var fontSize: CGFloat = 18
}

final class AHDanmakuSettingsStore {
    static let shared = AHDanmakuSettingsStore()

    private let key = "ah.danmaku.settings"

    func load() -> AHDanmakuSettings {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let settings = try? JSONDecoder().decode(AHDanmakuSettings.self, from: data)
        else {
            return AHDanmakuSettings()
        }
        return settings
    }

    func save(_ settings: AHDanmakuSettings) {
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

class AHDanmakuManager: ObservableObject {

    let controller = AHDanmakuController()

    @Published var isLoadingDanmaku = false

    @Published var danmakuCount = 0

    private var loadedKey: String?

    private var timeline = AHDanmakuTimeline()

    private var cancellables = Set<AnyCancellable>()

    @Published var enabled: Bool = true
    @Published var danmakuOpacity: Double = 0.8
    @Published var danmakuArea: Double = 0.3
    @Published var danmakuSpeed: Double = 0
    @Published var danmakuFontSize: Double = 18.0

    init() {
        let settings = AHDanmakuSettingsStore.shared.load()

        self.danmakuOpacity = settings.opacity
        self.danmakuArea = settings.area
        self.danmakuSpeed = settings.speed
        self.danmakuFontSize = settings.fontSize

        self.controller.danmakuArea = settings.area
        self.controller.danmakuOpacity = settings.opacity
        self.controller.danmakuSpeed = settings.speed
        self.controller.danmakuFontSize = settings.fontSize

        bindSettings()
    }

    private func bindSettings() {
        // 切回来的弹幕层要知道当前该不该显示
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

            let newSettings = AHDanmakuSettings(
                opacity: opacity,
                area: area,
                speed: speed,
                fontSize: fontSize
            )

            AHDanmakuSettingsStore.shared.save(newSettings)
        }
        .store(in: &cancellables)
    }

    // MARK: - 公共方法

    func loadDanmaku(request: AHDanmakuRequest, startAt: TimeInterval = 0) {
        let key = "\(request.vodName)|\(request.episode)|\(request.playURL)"
        guard key != loadedKey else { return }
        loadedKey = key

        // 先把上一集的清掉，接口没数据时也不会留着旧弹幕继续飘
        apply([], startAt: startAt)

        guard let provider = AHDanmakuSource.provider else { return }

        isLoadingDanmaku = true
        provider(request) { [weak self] list in
            guard let self else { return }
            DispatchQueue.main.async {
                guard key == self.loadedKey else { return }
                self.isLoadingDanmaku = false
                self.apply(self.convert(list), startAt: self.timeline.currentTime ?? startAt)
            }
        }
    }

    private func convert(_ data: [AHDanmakuRawItem]) -> [AHDanmakuItem] {
        data.compactMap { item -> AHDanmakuItem? in
            var content = item.text
            return AHDanmakuItem(
                time: item.time,
                text: content,
                color: parseColor(item.colorHex),
                type: .from(mode: item.type),
                fontSize: danmakuFontSize
            )
        }
    }

    private func apply(_ items: [AHDanmakuItem], startAt: TimeInterval) {
        timeline.replace(with: items, startAt: startAt)
        danmakuCount = timeline.items.count
        controller.reset()
        reloadTracks()
        controller.play()
    }

    private func parseColor(_ colorString: String) -> Color {
        var colorInt: UInt64 = 0xFFFFFF

        if colorString.hasPrefix("#") {
            let hex = String(colorString.dropFirst())
            Scanner(string: hex).scanHexInt64(&colorInt)
        } else if let intValue = UInt64(colorString) {
            colorInt = intValue
        }

        let red = Double((colorInt & 0xFF0000) >> 16) / 255.0
        let green = Double((colorInt & 0x00FF00) >> 8) / 255.0
        let blue = Double(colorInt & 0x0000FF) / 255.0

        return Color(red: red, green: green, blue: blue)
    }

    // MARK: - 时间驱动

    func update(currentTime: TimeInterval) {
        // 对齐 Flutter：总开关关掉时连离线弹幕也不显示
        guard enabled, AHDanmakuService.isMasterSwitchOn else { return }

        let advance = timeline.advance(to: currentTime)

        if advance.didJump {
            controller.reset()
            controller.play()
        }

        advance.items.forEach(controller.send)
    }

    func jumped(to time: TimeInterval) {
        timeline.seek(to: time)
        controller.reset()
        controller.play()
    }

    func shootLocal(text: String, colorHex: String) {
        guard !text.isEmpty else { return }

        controller.send(
            AHDanmakuItem(
                time: timeline.currentTime ?? 0,
                text: "[\(text)]",
                color: parseColor(colorHex),
                type: .scroll,
                fontSize: danmakuFontSize
            )
        )
    }

    // MARK: - 播放控制

    func reloadTracks() {
        controller.danmakuView?.recalculateTracks()
    }

    func update(danmuFontSize: CGFloat) {
        danmakuFontSize = danmuFontSize
        controller.danmakuFontSize = danmuFontSize
    }

    func update(area: Double) {
        danmakuArea = area
        controller.danmakuArea = area
    }

    func update(opacity: Double) {
        danmakuOpacity = opacity
        controller.danmakuOpacity = opacity
    }

    func update(speed: Double) {
        danmakuSpeed = speed
        controller.danmakuSpeed = speed
    }

    func pause() {
        controller.pause()
    }

    func play() {
        controller.play()
    }

    func clear() {
        controller.reset()
    }
}
