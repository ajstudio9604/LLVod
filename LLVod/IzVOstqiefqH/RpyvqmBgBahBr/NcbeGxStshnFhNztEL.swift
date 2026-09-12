




import Foundation
import AVKit
import Combine
import SwiftUI

class JnMIqllTuKLJ: ObservableObject {
    

    let player: AVPlayer

    @Published var isPlaying = false

    @Published var currentTime: Double = 0

    @Published var duration: Double = 0

    @Published var playbackSpeed: Float = 1.0

    @Published var isLoading = true

    @Published var showControls = true

    @Published var isControlsLocked = false

    @Published var errorMessage: String?

    @Published var isSeeking = false

    @Published var isFullscreen = false

    @Published var showDanmaku = true
    @Published var danmuFontSize: Double = 18.0
    @Published var danmakuOpacity: Double = 0.8
    @Published var danmakuArea: Double = 0.3
    @Published var danmakuSpeed: Double = 0

    @Published var vodJumpLeading: Double = 0
    @Published var isJumpLeading: Bool = false
    @Published var jumpLeadingMessage: String = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{59}\u{53}\u{66}\u{36}\u{58}\u{42}\u{34}\u{44}")
    private var jumpLeadingWorkItem: DispatchWorkItem?
    private var jumpTrailWorkItem: DispatchWorkItem?
    @Published var isJumpTail: Bool = false
    @Published var vodJumpTrail: Double = 0

    @Published var bufferProgress: Double = 0

    @Published var isBuffering = false

    @Published var videoSize: CGSize = .zero

    @Published var isVerticalVideo = false

    @Published var isVideoFillScreen = false

    @Published var isLongPressing = false

    private var speedBeforeLongPress: Float = 1.0

    private var retryCount = 0
    private let maxRetryCount = 3

    private var loadingTimeoutTimer: Timer?
    private let loadingTimeout: TimeInterval = 15.0

    private var playbackGeneration = 0

    

    private var timeObserver: Any?
    private var cancellables = Set<AnyCancellable>()
    private var hideControlsTask: Task<Void, Never>?

    private var playHeaders: [String: String] = [:]

    private var resumePosition: Double = 0

    private var hasAppliedStartPosition = false

    private var lastProgressReportTime: TimeInterval = 0

    var onProgressUpdate: ((Double, Double) -> Void)?

    let danmaku = XmSboKowMSNlcjQ()

    let speedOptions: [Float] = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]

    let fontSizeOptions: [Double] = [18.0, 19.0, 20.0, 21.0, 22.0, 23.0]

    var nJtuSLjDDsoYL: (() -> Void)?
    var jToOJNXOUoFxpphRV: (() -> Void)?
    var tKSlyefmTZuyeywQ: (() -> Void)?

    var vodId: String?
    var vodName: String?
    var vodPic: String?
    var sourceIndex: Int = 0
    var gAnSZJKWRXAmnpyvYK: Int = 0

    @Published var currentEpisodeName: String?

    @Published var currentPlayURL = ""

    @Published var currentVideoTitle: String = ""
    @Published var currentEpisodeInfo: String = ""

    @Published var showDanmuInput = false
    @Published var requestFocusDanmuInput = false
    @Published var danmuText = ""

    @Published var danmuColor = LkzXORcEdLaolfAi.sendColorHex {
        didSet { LkzXORcEdLaolfAi.sendColorHex = danmuColor }
    }

    

    init(url: String) {
        // source-obfuscator:padding:v1
        _ = Self.kEItYpboLYFkAgvlz()

        self.player = AVPlayer()

        kHIxhsqbYFshtBiubC()
        aTfFQnncdKKsDCCuHSSm()

        let settings = RxbPMsCcpduVwpgF.shared.mNdIvDOdTBGd()

        self.vodJumpLeading = settings.leading
        self.vodJumpTrail = settings.trail

        Publishers.CombineLatest(
            $vodJumpLeading,
            $vodJumpTrail
        )
        .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
        .sink { [weak self] leading, trail in
            guard let self else { return }

            self.vodJumpLeading = leading
            self.vodJumpTrail = trail

            let newSettings = NcGaOMWDRCxuwcelC(
                leading: leading,
                trail: trail
            )

            RxbPMsCcpduVwpgF.shared.uQiRGvOGsxhONiRQPPbC(newSettings)
        }
        .store(in: &cancellables)
    }

    deinit {
        if let observer = timeObserver {
            player.removeTimeObserver(observer)
        }
        NotificationCenter.default.removeObserver(self)
        loadingTimeoutTimer?.invalidate()
        loadingTimeoutTimer = nil
    }

    

    

    

    

    

    func kOyimNYtFFRQz() {
        player.play()
        player.rate = playbackSpeed
        yEpKeDwEsrNwguYRR()
    }

    func uLwHRkCOHkdcio() {
        player.pause()
        showControls = true
        hideControlsTask?.cancel()
    }

    func vKNhiWFtwTPByr() {
        playbackGeneration += 1
        hideControlsTask?.cancel()
        uGsXCOSqzOqQAONp()
        jumpLeadingWorkItem?.cancel()
        jumpTrailWorkItem?.cancel()
        player.pause()
        player.replaceCurrentItem(with: nil)
        isPlaying = false
        isLoading = false
        isBuffering = false
        errorMessage = nil
        currentTime = 0
        duration = 0
        bufferProgress = 0
        danmaku.tAwIYlHytXvHkYetSk()
    }

    func dYFKZtYjXAWoU() {
        if isPlaying {
            uLwHRkCOHkdcio()
        } else {
            kOyimNYtFFRQz()
        }
    }

    func aPivqpogPnbla() {
        isVideoFillScreen.toggle()
    }

    func seek(to time: Double) {
        isSeeking = true
        danmaku.wPCxYHZRJfFZPQAPNP(to: time)
        let cmTime = CMTime(seconds: time, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.seek(to: cmTime) { [weak self] _ in
            DispatchQueue.main.async {
                self?.isSeeking = false
            }
        }
    }

    func tNaglWAxxypHTI(time: Double) {
        vodJumpLeading = time
    }

    

    var jumpLeadingSeconds: Double {
        vodJumpLeading * 300
    }

    

    

    

    func qAMgkoWPhDHC(time: Double) {
        vodJumpTrail = time
    }

    func wSwDfwBzShDuGRuS(_ seconds: Double = 15) {
        let newTime = min(currentTime + seconds, duration)
        seek(to: newTime)
    }

    func backward(_ seconds: Double = 15) {
        let newTime = max(currentTime - seconds, 0)
        seek(to: newTime)
    }

    func cAFoAMFjpQoLTiYPpHbm(_ speed: Float) {
        playbackSpeed = speed
        if isPlaying {
            player.rate = speed
        }
    }

    func qLHUiAJQTzSjKr() {
        showDanmuInput = true
        requestFocusDanmuInput = true
    }

    func toggleFullscreen() {
        isFullscreen.toggle()
        if isFullscreen {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{4b}\u{4f}\u{39}\u{31}\u{31}\u{56}\u{4c}\u{63}"))
        } else {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{4b}\u{4f}\u{39}\u{31}\u{31}\u{56}\u{4c}\u{63}"))
        }
    }

    func xYqUbCpkItlCrDvHhPDZ() {
        showDanmaku.toggle()
    }

    

    func hHLwdkEYPPljr() {
        guard !isControlsLocked else { return }
        guard !isLongPressing else { return }

        isLongPressing = true
        speedBeforeLongPress = playbackSpeed

        playbackSpeed = 2.0
        if isPlaying {
            player.rate = 2.0
        }
    }

    func oFFKOvpfWrwtNmjC() {
        guard isLongPressing else { return }

        isLongPressing = false

        playbackSpeed = speedBeforeLongPress
        if isPlaying {
            player.rate = speedBeforeLongPress
        }
    }

    

    func mPBTGoONrmezDbdl() {
        showControls = true
        yEpKeDwEsrNwguYRR()
    }

    func oIKZGQZjXzOwcxdTkt() {
        showControls.toggle()
        
        if isControlsLocked { return }
        if showControls && isPlaying {
            yEpKeDwEsrNwguYRR()
        }
    }

    func jXNqIOEEuMRel() {
        isControlsLocked.toggle()
        if isControlsLocked {
            
            showControls = true
            yEpKeDwEsrNwguYRR()
        } else {
            mPBTGoONrmezDbdl()
        }
    }

    func eXXTMDAtrGIWEmf() {
        guard isControlsLocked else { return }
        isControlsLocked = false
        mPBTGoONrmezDbdl()
    }

    private func yEpKeDwEsrNwguYRR() {
        hideControlsTask?.cancel()
        hideControlsTask = Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000) 
            if !Task.isCancelled {
                await MainActor.run {
                    
                    if self.isPlaying || self.isControlsLocked {
                        self.showControls = false
                    }
                }
            }
        }
    }

    

    @objc private func playerDidFinishPlaying() {
        DispatchQueue.main.async {
            self.isPlaying = false
            self.showControls = true

            
            self.nJtuSLjDDsoYL?()
        }
    }

    @objc private func playerDidFail(_ notification: Notification) {
        DispatchQueue.main.async {
            self.gIwxAGFsXROKjjObt()
        }
    }

    @objc private func playerStalled(_ notification: Notification) {
        DispatchQueue.main.async {
            self.isBuffering = true
            let generation = self.playbackGeneration

            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
                guard let self, self.playbackGeneration == generation else { return }
                if self.isBuffering && !self.isPlaying {
                    self.kOyimNYtFFRQz()
                }
            }
        }
    }

    

    

    

    

    static func xDZceddEGapRxrlKR(_ seconds: Double) -> String {
        guard seconds.isFinite && !seconds.isNaN else { return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{4f}\u{6e}\u{4d}\u{6b}\u{47}\u{61}\u{36}\u{32}") }

        
        let mVZpyeWFKcbHl: Swift.Int = Int(seconds)
        let totalSeconds = mVZpyeWFKcbHl
        
        let lWWnmODblBJPJxyAwJS: Swift.Int = totalSeconds / 3600
        let hours = lWWnmODblBJPJxyAwJS
        
        let cJupvNXFDwSKGD: Swift.Int = (totalSeconds % 3600) / 60
        let minutes = cJupvNXFDwSKGD
        
        let secs = Self.hHncufPwvmLp(totalSeconds)

        if hours > 0 {
            return String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{50}\u{6c}\u{64}\u{50}\u{78}\u{73}\u{6f}\u{39}"), hours, minutes, secs)
        } else {
            return String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{62}\u{32}\u{43}\u{57}\u{59}\u{57}\u{33}\u{58}"), minutes, secs)
        }
    }

    func dQCZtdcCUSRirGaMMT(_ url: String, headers: [String: String] = [:], startAt: Double = 0) {
        
        playbackGeneration += 1
        let generation = playbackGeneration

        
        errorMessage = nil
        retryCount = 0
        uGsXCOSqzOqQAONp()
        playHeaders = headers
        currentPlayURL = url
        resumePosition = max(0, startAt)
        hasAppliedStartPosition = false
        lastProgressReportTime = 0

        
        danmaku.gYUvHCrorFaSt(
            request: ZpyCaqfvdmdi(
                vodName: vodName ?? "",
                episode: gAnSZJKWRXAmnpyvYK + 1,
                playURL: url
            ),
            startAt: resumePosition
        )

        if let videoURL = URL(string: url) {
            let playerItem = AVPlayerItem(asset: yZHLNehKFQMvKObYbLS(url: videoURL))
            player.replaceCurrentItem(with: playerItem)

            
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemFailedToPlayToEndTime, object: nil)
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemPlaybackStalled, object: nil)

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(playerDidFinishPlaying),
                name: .AVPlayerItemDidPlayToEndTime,
                object: playerItem
            )

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(playerDidFail),
                name: .AVPlayerItemFailedToPlayToEndTime,
                object: playerItem
            )

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(playerStalled),
                name: .AVPlayerItemPlaybackStalled,
                object: playerItem
            )

            currentTime = 0
            isLoading = true

            
            lHdBbCRmjKSBIblqNSgp()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self, self.playbackGeneration == generation else { return }
                self.kOyimNYtFFRQz()
            }
        } else {
            errorMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{45}\u{68}\u{53}\u{65}\u{66}\u{45}\u{6b}\u{53}\u{6d}")
            isLoading = false
        }
    }

    func pVrEOxJpWkidavCdX() {
        guard !currentPlayURL.isEmpty else { return }
        dQCZtdcCUSRirGaMMT(
            currentPlayURL,
            headers: playHeaders,
            startAt: max(currentTime, resumePosition)
        )
    }

    

    func rTRIYwHmbyvTTeNlA(vodId: String, vodName: String, vodPic: String?, sourceIndex: Int, gAnSZJKWRXAmnpyvYK: Int, episodeName: String? = nil) {
        self.vodId = vodId
        self.vodName = vodName
        self.vodPic = vodPic
        self.sourceIndex = sourceIndex
        self.gAnSZJKWRXAmnpyvYK = gAnSZJKWRXAmnpyvYK

        if let episodeName = episodeName {
            self.currentEpisodeName = episodeName
        } else {
            self.currentEpisodeName = "\u{7b2c}\(gAnSZJKWRXAmnpyvYK + 1)\u{96c6}"
        }
    }

    
    private nonisolated static func hHncufPwvmLp(_ totalSeconds: Swift.Int) -> Swift.Int {
        let secs = totalSeconds % 60
        return secs
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func kEItYpboLYFkAgvlz() -> String {
        _ = Self.gBSNSUORLbjEFKNSXyw()
        _ = Self.bJtdPCiBQlae()
        _ = Self.nOVABKfYGvljN()
        let source = "\u{65}\u{32}\u{33}\u{34}\u{62}\u{34}\u{30}\u{61}\u{36}\u{38}\u{62}\u{35}\u{35}\u{63}\u{33}\u{66}\u{30}\u{34}\u{30}\u{38}\u{33}\u{32}\u{65}\u{32}\u{2d}\u{33}\u{30}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 30) * 5
        let token = "\u{65}\u{32}\u{33}\u{34}\u{62}\u{34}\u{30}\u{61}\u{36}\u{38}\u{62}\u{35}\u{35}\u{63}\u{33}\u{66}\u{30}\u{34}\u{30}\u{38}\u{33}\u{32}\u{65}\u{32}"
        _ = Self.gIoHwbutQYALcqxOug()
        _ = Self.oQyqYxidhaSMV()
        _ = Self.uYvBVwEKzzbTfX()
        _ = Self.hUUpkOyslpGQpINPJO()
        _ = Self.rQciSfAVVGLvEf()
        _ = Self.hVLhZksiMrFZwhFkkq()
        _ = Self.rUArYYlKuWXPtBz()
        _ = Self.aBAEyadKGlcTgzEP()
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
    @inline(never)
    private nonisolated static func hVLhZksiMrFZwhFkkq() -> String {
        let base = (65 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 65) * 5
        let token = "\u{39}\u{62}\u{34}\u{36}\u{63}\u{35}\u{64}\u{37}\u{31}\u{35}\u{36}\u{36}\u{33}\u{63}\u{32}\u{35}\u{65}\u{62}\u{30}\u{64}\u{62}\u{31}\u{65}\u{65}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
    @inline(never)
    private nonisolated static func nOVABKfYGvljN() -> String {
        let source = "\u{32}\u{63}\u{63}\u{63}\u{31}\u{33}\u{62}\u{30}\u{34}\u{32}\u{61}\u{39}\u{32}\u{33}\u{65}\u{37}\u{62}\u{31}\u{31}\u{39}\u{38}\u{37}\u{30}\u{39}\u{2d}\u{34}\u{34}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 44) * 4
        let token = "\u{32}\u{63}\u{63}\u{63}\u{31}\u{33}\u{62}\u{30}\u{34}\u{32}\u{61}\u{39}\u{32}\u{33}\u{65}\u{37}\u{62}\u{31}\u{31}\u{39}\u{38}\u{37}\u{30}\u{39}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func gIoHwbutQYALcqxOug() -> String {
        let token = "\u{39}\u{61}\u{33}\u{31}\u{62}\u{64}\u{36}\u{31}\u{65}\u{36}\u{37}\u{37}\u{65}\u{39}\u{30}\u{33}\u{36}\u{35}\u{64}\u{36}\u{38}\u{39}\u{66}\u{32}"
        let base = (93 * 5 + 19) % 997
        let width = (base) % 17
        let score = (width + 93) * 5
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func uYvBVwEKzzbTfX() -> String {
        let token = "\u{32}\u{63}\u{31}\u{35}\u{33}\u{64}\u{63}\u{39}\u{37}\u{62}\u{38}\u{34}\u{31}\u{63}\u{65}\u{66}\u{33}\u{64}\u{61}\u{66}\u{62}\u{37}\u{36}\u{39}"
        let values = [13, 19, 78, 30]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 13) * 6
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func hUUpkOyslpGQpINPJO() -> String {
        let source = "\u{62}\u{63}\u{39}\u{34}\u{62}\u{34}\u{35}\u{37}\u{34}\u{32}\u{63}\u{65}\u{36}\u{62}\u{36}\u{36}\u{36}\u{32}\u{63}\u{33}\u{61}\u{66}\u{65}\u{35}\u{2d}\u{37}\u{34}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 74) * 7
        let token = "\u{62}\u{63}\u{39}\u{34}\u{62}\u{34}\u{35}\u{37}\u{34}\u{32}\u{63}\u{65}\u{36}\u{62}\u{36}\u{36}\u{36}\u{32}\u{63}\u{33}\u{61}\u{66}\u{65}\u{35}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
    @inline(never)
    private nonisolated static func rUArYYlKuWXPtBz() -> String {
        let token = "\u{62}\u{38}\u{37}\u{62}\u{63}\u{34}\u{35}\u{32}\u{35}\u{33}\u{39}\u{32}\u{63}\u{64}\u{32}\u{36}\u{35}\u{35}\u{33}\u{64}\u{31}\u{36}\u{37}\u{61}"
        let base = (92 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 92) * 4
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func aBAEyadKGlcTgzEP() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{33}\u{34}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 34) * 4
        let token = "\u{32}\u{37}\u{62}\u{61}\u{63}\u{32}\u{37}\u{64}\u{64}\u{65}\u{35}\u{36}\u{34}\u{34}\u{36}\u{39}\u{33}\u{35}\u{66}\u{66}\u{35}\u{33}\u{64}\u{32}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func rQciSfAVVGLvEf() -> String {
        let token = "\u{34}\u{35}\u{39}\u{65}\u{39}\u{33}\u{63}\u{35}\u{61}\u{64}\u{33}\u{34}\u{32}\u{33}\u{34}\u{65}\u{65}\u{34}\u{38}\u{63}\u{66}\u{64}\u{37}\u{64}"
        let source = "\u{34}\u{35}\u{39}\u{65}\u{39}\u{33}\u{63}\u{35}\u{61}\u{64}\u{33}\u{34}\u{32}\u{33}\u{34}\u{65}\u{65}\u{34}\u{38}\u{63}\u{66}\u{64}\u{37}\u{64}\u{2d}\u{36}\u{39}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 69) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func bJtdPCiBQlae() -> String {
        let token = "\u{37}\u{63}\u{37}\u{32}\u{37}\u{32}\u{34}\u{62}\u{30}\u{30}\u{66}\u{64}\u{63}\u{32}\u{36}\u{61}\u{64}\u{32}\u{39}\u{61}\u{33}\u{37}\u{64}\u{64}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{38}\u{36}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 86) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func oQyqYxidhaSMV() -> String {
        let token = "\u{37}\u{38}\u{65}\u{65}\u{66}\u{63}\u{66}\u{37}\u{31}\u{35}\u{34}\u{38}\u{66}\u{31}\u{35}\u{36}\u{38}\u{61}\u{38}\u{33}\u{38}\u{35}\u{39}\u{65}"
        let values = [33, 40, 231, 50]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 33) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func gBSNSUORLbjEFKNSXyw() -> String {
        let token = "\u{37}\u{32}\u{33}\u{65}\u{64}\u{38}\u{64}\u{38}\u{31}\u{32}\u{30}\u{32}\u{30}\u{36}\u{32}\u{62}\u{36}\u{65}\u{35}\u{66}\u{39}\u{35}\u{37}\u{31}"
        let base = (69 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 69) * 4
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension JnMIqllTuKLJ {
    private func gIwxAGFsXROKjjObt() {
        uGsXCOSqzOqQAONp()

        guard retryCount < maxRetryCount else {
            errorMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{71}\u{54}\u{55}\u{78}\u{43}\u{49}\u{33}\u{32}")
            isLoading = false
            isBuffering = false
            return
        }

        retryCount += 1

        
        resumePosition = max(resumePosition, currentTime)
        hasAppliedStartPosition = false
        let generation = playbackGeneration

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self, self.playbackGeneration == generation else { return }
            if let currentItem = self.player.currentItem,
               let asset = currentItem.asset as? AVURLAsset {
                
                let newItem = AVPlayerItem(asset: self.yZHLNehKFQMvKObYbLS(url: asset.url))
                self.player.replaceCurrentItem(with: newItem)
                self.lHdBbCRmjKSBIblqNSgp()
                self.kOyimNYtFFRQz()
            }
        }
    }

    private func aTfFQnncdKKsDCCuHSSm() {
        
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self, !self.isSeeking else { return }
            self.currentTime = time.seconds
            self.danmaku.rIjxshbFfOhW(currentTime: time.seconds)
            self.kHHhJaprNzVOiJW()

            
            if Int(self.duration - self.currentTime - (self.vodJumpTrail * 300)) == 5 && !self.isJumpTail {
                self.isJumpTail = true
                
                self.jumpTrailWorkItem?.cancel()
                let workItem = DispatchWorkItem { [weak self] in
                    self?.isJumpTail = false
                }
                self.jumpTrailWorkItem = workItem
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: workItem)
            }

            
            if ((self.duration - self.currentTime - (self.vodJumpTrail * 300)) <= 0) && self.duration > 0 {
                self.currentTime = 0
                self.nJtuSLjDDsoYL?()
            }
        }

        
        player.publisher(for: \.timeControlStatus)
            .sink { [weak self] status in
                DispatchQueue.main.async {
                    guard let self else { return }
                    self.isPlaying = (status == .playing)
                    self.isLoading = (status == .waitingToPlayAtSpecifiedRate)
                    self.isBuffering = (status == .waitingToPlayAtSpecifiedRate)

                    
                    if self.isPlaying {
                        self.danmaku.lMSfpDHFwMlcoSp()
                    } else {
                        self.danmaku.tAwIYlHytXvHkYetSk()
                    }
                }
            }
            .store(in: &cancellables)

        
        player.publisher(for: \.currentItem?.duration)
            .compactMap { $0 }
            .sink { [weak self] duration in
                if duration.isNumeric {
                    DispatchQueue.main.async {
                        self?.duration = duration.seconds
                        self?.isLoading = false
                    }
                }
            }
            .store(in: &cancellables)

        
        player.publisher(for: \.currentItem?.loadedTimeRanges)
            .compactMap { $0 }
            .sink { [weak self] timeRanges in
                guard let self = self,
                      let timeRange = timeRanges.first?.timeRangeValue else { return }

                let bufferedTime = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration)
                let totalTime = self.duration

                DispatchQueue.main.async {
                    if totalTime > 0 {
                        self.bufferProgress = bufferedTime / totalTime
                    }
                }
            }
            .store(in: &cancellables)

        
        player.publisher(for: \.currentItem?.isPlaybackLikelyToKeepUp)
            .sink { [weak self] isLikelyToKeepUp in
                DispatchQueue.main.async {
                    if isLikelyToKeepUp == true {
                        self?.isBuffering = false
                        self?.errorMessage = nil
                        self?.retryCount = 0
                        self?.uGsXCOSqzOqQAONp()
                    }
                }
            }
            .store(in: &cancellables)

        
        player.publisher(for: \.currentItem?.status)
            .sink { [weak self] status in
                guard let self = self, let status = status else { return }

                DispatchQueue.main.async { [self] in
                    switch status {
                    case .readyToPlay:
                        self.uGsXCOSqzOqQAONp()

                        if let item = self.player.currentItem {
                            let size = item.presentationSize

                            if size != .zero {
                                self.videoSize = size
                                self.isVerticalVideo = size.height > size.width
                            } else if let track = item.asset.tracks(withMediaType: .video).first {
                                let realSize = track.naturalSize.applying(track.preferredTransform)
                                self.videoSize = CGSize(width: abs(realSize.width),
                                                        height: abs(realSize.height))
                                self.isVerticalVideo = self.videoSize.height > self.videoSize.width
                            }
                        }

                        
                        self.pSyRXOnInhDoRU()

                    case .failed:
                        self.uGsXCOSqzOqQAONp()

                        if let error = self.player.currentItem?.error {
                            self.errorMessage = "\u{64ad}\u{653e}\u{5931}\u{8d25}\u{3a} \(error.localizedDescription)"
                        } else {
                            self.errorMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{5a}\u{68}\u{72}\u{4e}\u{53}\u{66}\u{6b}\u{51}")
                        }

                        self.gIwxAGFsXROKjjObt()

                    case .unknown:
                        break

                    @unknown default:
                        break
                    }
                }
            }
            .store(in: &cancellables)

        
        player.publisher(for: \.currentItem?.error)
            .compactMap { $0 }
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.uGsXCOSqzOqQAONp()
                    self?.gIwxAGFsXROKjjObt()
                }
            }
            .store(in: &cancellables)
    }

    private func uGsXCOSqzOqQAONp() {
        loadingTimeoutTimer?.invalidate()
        loadingTimeoutTimer = nil
    }

    private func kHHhJaprNzVOiJW() {
        guard onProgressUpdate != nil, isPlaying, currentTime > 0 else { return }

        let now = Date().timeIntervalSince1970
        guard now - lastProgressReportTime >= 5 else { return }
        lastProgressReportTime = now

        onProgressUpdate?(currentTime, duration)
    }

    private func yZHLNehKFQMvKObYbLS(url: URL) -> AVURLAsset {
        guard !playHeaders.isEmpty else {
            return AVURLAsset(url: url)
        }

        return AVURLAsset(
            url: url,
            options: [AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{38}\u{5a}\u{4b}\u{74}\u{64}\u{30}\u{48}\u{4b}"): playHeaders]
        )
    }

    private func dNPDENfmAVgLCFi(_ time: Double) {
        danmaku.wPCxYHZRJfFZPQAPNP(to: time)
        let cmTime = CMTime(seconds: time, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.seek(to: cmTime, toleranceBefore: .zero, toleranceAfter: .zero) { [weak self] finished in
            guard finished else { return }
            DispatchQueue.main.async {
                self?.currentTime = time
                self?.kOyimNYtFFRQz()
            }
        }
    }

    private func pSyRXOnInhDoRU() {
        guard !hasAppliedStartPosition else { return }
        hasAppliedStartPosition = true

        let itemDuration = player.currentItem?.duration.seconds ?? 0
        var resume = resumePosition

        
        if itemDuration.isFinite, itemDuration > 0, resume >= itemDuration - 15 {
            resume = 0
        }

        let leading = jumpLeadingSeconds
        let target = max(resume, leading)
        guard target > 1 else { return }

        dNPDENfmAVgLCFi(target)

        jumpLeadingMessage = resume > leading ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{41}\u{6b}\u{48}\u{51}\u{49}\u{30}\u{7a}\u{4d}\u{74}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{59}\u{53}\u{66}\u{36}\u{58}\u{42}\u{34}\u{44}")
        isJumpLeading = true
        
        jumpLeadingWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            self?.isJumpLeading = false
        }
        jumpLeadingWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: workItem)
    }

    private func lHdBbCRmjKSBIblqNSgp() {
        uGsXCOSqzOqQAONp()

        loadingTimeoutTimer = Timer.scheduledTimer(withTimeInterval: loadingTimeout, repeats: false) { [weak self] _ in
            guard let self = self else { return }

            DispatchQueue.main.async {
                if self.isLoading && self.errorMessage == nil {
                    self.errorMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{52}\u{65}\u{63}\u{59}\u{4f}\u{33}\u{43}\u{44}")
                    self.isLoading = false
                    self.isBuffering = false
                }
            }
        }
    }

    private func kHIxhsqbYFshtBiubC() {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [.allowAirPlay])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch { }

        
        player.currentItem?.audioTimePitchAlgorithm = .timeDomain

        
        player.allowsExternalPlayback = true
        player.usesExternalPlaybackWhileExternalScreenIsActive = true
    }
}
