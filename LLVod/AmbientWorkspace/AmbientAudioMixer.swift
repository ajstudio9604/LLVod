import AVFoundation
import UIKit

/// 只控制应用内四轨的配比，系统音量由原生媒体音量控件负责。
@MainActor
final class AmbientAudioMixer {
    static let tracks: [(id: String, title: String)] = [
        ("ambient_rain", "细雨"), ("ambient_forest", "林间"),
        ("ambient_jungle", "雨林"), ("ambient_ember", "炉火")
    ]
    private var players: [String: AVAudioPlayer] = [:]
    private var isRest = false
    private var gain: Float = 1
    var isPlaying: Bool { players.values.contains { $0.isPlaying } }
    var hasPlayers: Bool { !players.isEmpty }

    func levels(for scene: AmbientScene) -> [String: Float] {
        let preferences = AmbientPreferences.shared.values
        if isRest && preferences.restMixIsCustom != true { return ["ambient_rain": 0.25] }
        return preferences.followsScene ? [scene.audioIdentifier: 1] : preferences.levels
    }

    func setRest(_ value: Bool) {
        isRest = value
        if !value && AmbientPreferences.shared.values.restMixIsCustom == true {
            AmbientPreferences.shared.update { $0.restMixIsCustom = nil }
        }
    }

    func changedByUser() { if isRest { AmbientPreferences.shared.update { $0.restMixIsCustom = true } } }

    func play(scene: AmbientScene, gain: Float) throws {
        self.gain = gain
        let levels = levels(for: scene)
        // 先准备全部新增音轨，准备失败时原有播放器仍可由服务统一关闭。
        var next = players
        for track in Self.tracks where (levels[track.id] ?? 0) > 0 {
            if next[track.id] == nil {
                guard let url = Bundle.main.url(forResource: track.id, withExtension: "m4a")
                    ?? Bundle.main.url(forResource: track.id, withExtension: "m4a", subdirectory: "Resources") else { throw AmbientProgressError.missingResource }
                let player = try AVAudioPlayer(contentsOf: url)
                player.numberOfLoops = -1
                player.volume = 0
                guard player.prepareToPlay() else { throw AmbientProgressError.missingResource }
                next[track.id] = player
            }
        }
        for (id, player) in next where (levels[id] ?? 0) <= 0 { player.stop(); next.removeValue(forKey: id) }
        players = next
        apply(levels: levels)
        for player in players.values where !player.isPlaying {
            guard player.play() else { throw AmbientProgressError.missingResource }
        }
    }

    func updateGain(_ value: Float, scene: AmbientScene) { gain = value; apply(levels: levels(for: scene)) }

    private func apply(levels: [String: Float]) {
        let total = max(1, levels.values.reduce(0, +))
        for (id, player) in players {
            player.setVolume((levels[id] ?? 0) / total * gain, fadeDuration: 0.25)
        }
    }

    func pause() { players.values.forEach { $0.pause() } }
    func stop() { players.values.forEach { $0.stop() }; players.removeAll() }
}

/// 自制短提示音沿用共享会话；结束后由服务判断是否释放音频会话。
@MainActor
final class AmbientPhaseCue: NSObject, AVAudioPlayerDelegate {
    private var player: AVAudioPlayer?
    var onFinish: (() -> Void)?
    var isPlaying: Bool { player?.isPlaying == true }

    func play() throws {
        stop()
        guard let url = Bundle.main.url(forResource: "ambient_signal", withExtension: "wav")
            ?? Bundle.main.url(forResource: "ambient_signal", withExtension: "wav", subdirectory: "Resources") else { throw AmbientProgressError.missingResource }
        let player = try AVAudioPlayer(contentsOf: url)
        player.delegate = self
        player.volume = 0.6
        self.player = player
        guard player.play() else { throw AmbientProgressError.missingResource }
    }
    func stop() { player?.stop(); player?.delegate = nil; player = nil }
    nonisolated func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let identifier = ObjectIdentifier(player)
        Task { @MainActor [weak self] in
            guard let self, self.player.map({ ObjectIdentifier($0) }) == identifier else { return }
            self.stop()
            self.onFinish?()
        }
    }
    nonisolated func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        let identifier = ObjectIdentifier(player)
        Task { @MainActor [weak self] in
            guard let self, self.player.map({ ObjectIdentifier($0) }) == identifier else { return }
            self.stop()
            self.onFinish?()
        }
    }
}
