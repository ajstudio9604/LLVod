




import SwiftUI
import AVKit

struct WlBnsZNHGTSAPwgqKA: View {
    @ObservedObject var viewModel: ZpTkIxBduVMMhMuv
    @ObservedObject var playerViewModel: JnMIqllTuKLJ
    @State private var showFullscreen = false
    @State private var showPortraitFullscreen = false

    var nJtuSLjDDsoYL: (() -> Void)? = nil
    var jToOJNXOUoFxpphRV: (() -> Void)? = nil
    var tKSlyefmTZuyeywQ: (() -> Void)? = nil

    
    var vodSources: [ZhopfUeTrMREiEzrLsF]? = nil
    var selectedSourceIndex: Int = 0
    var selectedEpisodeIndex: Int = 0
    var pVPjmypokUPUrIi: ((Int) -> Void)? = nil
    var fGJRqSaYcxdfUAeWor: ((Int) -> Void)? = nil

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.dXEtBjpRQSAbaq()

        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()

                
                NctjwAzulXZfiNP(player: playerViewModel.player, isFillScreen: playerViewModel.isVideoFillScreen)

                
                PyICjVseJPOCi(playerViewModel: playerViewModel)

                
                if playerViewModel.isBuffering && !playerViewModel.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{53}\u{59}\u{50}\u{61}\u{36}\u{76}\u{46}\u{62}"))
                            .foregroundColor(.white)
                            .font(.system(size: 14))

                        if playerViewModel.bufferProgress > 0 {
                            Text("\u{5df2}\u{7f13}\u{51b2} \(Int(playerViewModel.bufferProgress * 100))\u{25}")
                                .foregroundColor(.white.opacity(0.7))
                                .font(.system(size: 12))
                        }
                    }
                }

                
                if playerViewModel.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{6b}\u{67}\u{30}\u{36}\u{62}\u{63}\u{52}\u{4b}"))
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                }

                
                if playerViewModel.isLongPressing {
                    VStack {
                        Spacer()
                        HStack(spacing: 8) {
                            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{59}\u{4e}\u{53}\u{73}\u{39}\u{64}\u{49}\u{61}"))
                                .font(.system(size: 20))
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{6a}\u{77}\u{4e}\u{56}\u{46}\u{34}\u{47}\u{67}"))
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.green.opacity(0.9))
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.3), radius: 8)
                        Spacer().frame(height: 100)
                    }
                }

                
                if let error = playerViewModel.errorMessage {
                    IloJXzhjSQiLYLgJ(message: error) {
                        playerViewModel.pVrEOxJpWkidavCdX()
                    }
                }

                
                if playerViewModel.showControls {
                    YxJyPMfeqMoBRjWnl(
                        viewModel: playerViewModel,
                        nJtuSLjDDsoYL: nJtuSLjDDsoYL,
                        gMIXMlexquYCvG: {
                            if playerViewModel.isVerticalVideo {
                                showPortraitFullscreen = true
                            } else {
                                showFullscreen = true
                            }
                        }
                    )
                }
            }
            .contentShape(Rectangle())
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            playerViewModel.oIKZGQZjXzOwcxdTkt()
                        }
                    }
            )
        }
        .background(Color.black)
        .onAppear {
            
            playerViewModel.nJtuSLjDDsoYL = nJtuSLjDDsoYL
            playerViewModel.jToOJNXOUoFxpphRV = jToOJNXOUoFxpphRV
            playerViewModel.tKSlyefmTZuyeywQ = tKSlyefmTZuyeywQ
        }
        .ahFullscreen(isPresented: $showFullscreen) {
            WeROTUJUozFNcdi(
                vm: viewModel,
                viewModel: playerViewModel,
                vodSources: vodSources,
                selectedSourceIndex: selectedSourceIndex,
                selectedEpisodeIndex: selectedEpisodeIndex,
                pVPjmypokUPUrIi: pVPjmypokUPUrIi,
                fGJRqSaYcxdfUAeWor: fGJRqSaYcxdfUAeWor,
                nJtuSLjDDsoYL: nJtuSLjDDsoYL
            )
            .transition(.opacity.combined(with: .scale(scale: 0.95)))
        }
        .fullScreenCover(isPresented: $showPortraitFullscreen) {
            EeOqOvzCOimxHmZnH(
                vm: viewModel,
                viewModel: playerViewModel,
                vodSources: vodSources,
                selectedSourceIndex: selectedSourceIndex,
                selectedEpisodeIndex: selectedEpisodeIndex,
                pVPjmypokUPUrIi: pVPjmypokUPUrIi,
                fGJRqSaYcxdfUAeWor: fGJRqSaYcxdfUAeWor,
                nJtuSLjDDsoYL: nJtuSLjDDsoYL
            )
            .transition(.opacity.combined(with: .scale(scale: 0.95)))
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func dXEtBjpRQSAbaq() -> String {
        let token = "\u{64}\u{35}\u{31}\u{38}\u{39}\u{35}\u{66}\u{63}\u{39}\u{64}\u{35}\u{62}\u{34}\u{62}\u{36}\u{66}\u{33}\u{62}\u{66}\u{34}\u{39}\u{35}\u{35}\u{36}"
        let values = [79, 86, 553, 96]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 79) * 7
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}


struct NctjwAzulXZfiNP: UIViewControllerRepresentable {
    let player: AVPlayer
    let isFillScreen: Bool

    

    
}


struct YxJyPMfeqMoBRjWnl: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ
    var nJtuSLjDDsoYL: (() -> Void)?
    var gMIXMlexquYCvG: (() -> Void)?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        qEUQuKSUSwpPDjtPC()
    }

    
    @ViewBuilder
    @inline(never)
    private func qEUQuKSUSwpPDjtPC() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.cQNahJIowNBskd()

        hBhQAsnodSjOdUn
    }

    @ViewBuilder
    private var hBhQAsnodSjOdUn: some View {
        VStack {
            
            HStack(spacing: 12) {
                
                if let vodName = viewModel.vodName {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{54}\u{6e}\u{63}\u{75}\u{74}\u{44}\u{65}\u{55}"))
                                .foregroundColor(.white)
                            HStack {
                                Text(vodName)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                if let episodeName = viewModel.currentEpisodeName {
                                    Text(episodeName)
                                        .font(.system(size: 11))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                        }
                        .padding(.leading, 12)
                    }
                }

                Spacer()

                
                GfxWQZDjmtpuiBhQ(viewModel: viewModel)
                    .padding(.trailing, 16)
            }
            .padding(.top, 8)
            .padding(.bottom, 4)
            .background(
                LinearGradient(
                    colors: [Color.black.opacity(0.7), Color.clear],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )

            tSwOniSrhajbNpdaD

            
            if !viewModel.isPlaying {
                Button(action: { viewModel.kOyimNYtFFRQz() }) {
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.5))
                            .frame(width: 60, height: 60)
                        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{4c}\u{56}\u{5a}\u{4d}\u{66}\u{35}\u{70}\u{63}"))
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                }
            }

            Spacer()

            
            aORZuizkZgZnpxuHfA
        }
    }


    @ViewBuilder
    private var aORZuizkZgZnpxuHfA: some View {
        VStack(spacing: 5) {
                HStack(spacing: 0) {
                    
                    HStack(spacing: 0) {
                        
                        Button(action: { viewModel.dYFKZtYjXAWoU() }) {
                            Image(systemName: viewModel.isPlaying ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{70}\u{31}\u{50}\u{6a}\u{41}\u{35}\u{47}\u{70}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{59}\u{7a}\u{47}\u{78}\u{76}\u{4d}\u{45}\u{6b}"))
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .frame(width: 32, height: 35)
                        }

                        
                        if nJtuSLjDDsoYL != nil {
                            Button(action: { nJtuSLjDDsoYL?() }) {
                                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{45}\u{4e}\u{54}\u{59}\u{39}\u{59}\u{51}\u{55}"))
                                    .font(.system(size: 17))
                                    .foregroundColor(.white)
                                    .frame(width: 32, height: 35)
                            }
                        }
                    }

                    HStack(spacing: 4) {
                        Text(JnMIqllTuKLJ.xDZceddEGapRxrlKR(viewModel.currentTime))
                            .font(.system(size: 11, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                            .frame(minWidth: 38, alignment: .trailing)
                            .padding(.trailing, 4)

                        PdsLUdULFWnB(viewModel: viewModel)
                            .frame(maxWidth: .infinity, maxHeight: 20)

                        Text(JnMIqllTuKLJ.xDZceddEGapRxrlKR(viewModel.duration))
                            .font(.system(size: 11, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                            .frame(minWidth: 38, alignment: .leading)
                    }
                    .padding(.horizontal, 2)

                    
                    Button(action: { gMIXMlexquYCvG?() }) {
                        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{73}\u{71}\u{41}\u{31}\u{52}\u{33}\u{45}\u{33}"))
                            .font(.system(size: 17))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 35)
                    }
                }
                .padding(.bottom, 10)
            }
            .background(
                LinearGradient(
                    colors: [.clear, .black.opacity(0.8)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }

    @ViewBuilder
    private var tSwOniSrhajbNpdaD: some View {
        Spacer()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func cQNahJIowNBskd() -> String {
        let base = (81 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 81) * 2
        let token = "\u{62}\u{66}\u{31}\u{31}\u{31}\u{35}\u{38}\u{35}\u{30}\u{35}\u{38}\u{61}\u{39}\u{32}\u{35}\u{33}\u{35}\u{33}\u{33}\u{31}\u{64}\u{63}\u{38}\u{39}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
}

struct PdsLUdULFWnB: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @State private var isDragging = false
    @State private var dragProgress: Double = 0

    

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.sMEpxndNqSkaaMrIF()

        GeometryReader { geo in
            let width = geo.size.width
            let midY = geo.size.height / 2
            let progressX = width * progress

            ZStack {
                
                Capsule()
                    .fill(Color.white.opacity(0.3))
                    .frame(height: 3)
                    .position(x: width / 2, y: midY)

                
                Capsule()
                    .fill(Color.green)
                    .frame(width: progressX, height: 3)
                    .position(x: progressX / 2, y: midY)

                
                Circle()
                    .fill(Color.white)
                    .frame(width: isDragging ? 12 : 8,
                           height: isDragging ? 12 : 8)
                    .position(x: progressX, y: midY)
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        isDragging = true
                        let p = min(max(0, value.location.x / width), 1)
                        dragProgress = p
                        viewModel.currentTime = p * viewModel.duration
                    }
                    .onEnded { value in
                        let p = min(max(0, value.location.x / width), 1)
                        viewModel.seek(to: p * viewModel.duration)
                        isDragging = false
                    }
            )
        }
        .frame(height: 20)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func sMEpxndNqSkaaMrIF() -> String {
        let source = "\u{64}\u{62}\u{38}\u{64}\u{65}\u{34}\u{64}\u{30}\u{33}\u{30}\u{63}\u{61}\u{61}\u{32}\u{66}\u{62}\u{61}\u{66}\u{33}\u{30}\u{33}\u{61}\u{32}\u{62}\u{2d}\u{32}\u{37}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 27) * 7
        let token = "\u{64}\u{62}\u{38}\u{64}\u{65}\u{34}\u{64}\u{30}\u{33}\u{30}\u{63}\u{61}\u{61}\u{32}\u{66}\u{62}\u{61}\u{66}\u{33}\u{30}\u{33}\u{61}\u{32}\u{62}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}


struct AHSpeedSelectorView: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @Binding var isPresented: Bool

    var body: some View {
        
        tOJkCVXhunJOnkm()
    }

    
    @ViewBuilder
    @inline(never)
    private func tOJkCVXhunJOnkm() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.mZjwHEMDoNaBLIxM()

        dZhLGniCDMPOvBrfYvC
    }

    @ViewBuilder
    private var dZhLGniCDMPOvBrfYvC: some View {
        VStack {
            lRhKJHhDJAmxMBRRVIZc

            eSHZSnmqNEEfZVHoGZ
        }
        .background(
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
        )
    }


    @ViewBuilder
    private var eSHZSnmqNEEfZVHoGZ: some View {
        VStack(spacing: 0) {
                HStack {
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{77}\u{33}\u{5a}\u{6f}\u{31}\u{54}\u{4e}\u{33}\u{49}"))
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{4e}\u{4c}\u{37}\u{63}\u{4f}\u{66}\u{72}\u{65}"))
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
                .padding()

                Divider().background(Color.white.opacity(0.2))

                ForEach(viewModel.speedOptions, id: \.self) { speed in
                    Button(action: {
                        viewModel.cAFoAMFjpQoLTiYPpHbm(speed)
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        HStack {
                            Text("\(String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{78}\u{75}\u{6a}\u{71}\u{6f}\u{64}\u{79}\u{4e}"), speed))\u{78}")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            Spacer()
                            if viewModel.playbackSpeed == speed {
                                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{76}\u{76}\u{6e}\u{6a}\u{39}\u{61}\u{53}\u{33}"))
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.green)
                            }
                        }
                        .padding()
                        .background(viewModel.playbackSpeed == speed ? Color.white.opacity(0.1) : Color.clear)
                    }

                    if speed != viewModel.speedOptions.last {
                        Divider().background(Color.white.opacity(0.1))
                    }
                }
            }
            .background(Color.black.opacity(0.95))
            .cornerRadius(12)
            .padding()
    }

    @ViewBuilder
    private var lRhKJHhDJAmxMBRRVIZc: some View {
        Spacer()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mZjwHEMDoNaBLIxM() -> String {
        let base = (54 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 54) * 7
        let token = "\u{63}\u{34}\u{35}\u{32}\u{66}\u{35}\u{33}\u{66}\u{38}\u{66}\u{39}\u{37}\u{65}\u{38}\u{35}\u{35}\u{66}\u{34}\u{37}\u{38}\u{33}\u{38}\u{30}\u{65}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}



extension NctjwAzulXZfiNP {
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // source-obfuscator:padding:v1
        _ = Self.tBKdptYeRAdV()

        uiViewController.player = player
        uiViewController.videoGravity = isFillScreen ? .resizeAspectFill : .resizeAspect
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = isFillScreen ? .resizeAspectFill : .resizeAspect
        controller.view.backgroundColor = .black
        return controller
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func tBKdptYeRAdV() -> String {
        let token = "\u{33}\u{36}\u{39}\u{31}\u{39}\u{39}\u{62}\u{63}\u{34}\u{31}\u{34}\u{32}\u{38}\u{38}\u{37}\u{36}\u{34}\u{38}\u{34}\u{35}\u{61}\u{37}\u{63}\u{61}"
        let base = (67 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 67) * 4
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}


extension PdsLUdULFWnB {
    private var progress: Double {
        guard viewModel.duration > 0 else { return 0 }
        return isDragging
            ? dragProgress
            : viewModel.currentTime / viewModel.duration
    }
}
