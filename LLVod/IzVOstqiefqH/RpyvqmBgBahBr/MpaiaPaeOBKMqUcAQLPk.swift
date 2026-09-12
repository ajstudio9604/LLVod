




import SwiftUI
import AVKit

struct EeOqOvzCOimxHmZnH: View {
    @ObservedObject var vm: ZpTkIxBduVMMhMuv
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @Environment(\.dismiss) private var dismiss
    @State private var showSpeedSelector = false
    @State private var showSourceSelector = false
    @State private var showEpisodeSelector = false

    var vodSources: [ZhopfUeTrMREiEzrLsF]?
    var selectedSourceIndex: Int
    var selectedEpisodeIndex: Int
    var pVPjmypokUPUrIi: ((Int) -> Void)?
    var fGJRqSaYcxdfUAeWor: ((Int) -> Void)?
    var nJtuSLjDDsoYL: (() -> Void)?

    var body: some View {
        
        iBcBENCshUqFfiTqCZJZ()
    }

    
    @ViewBuilder
    @inline(never)
    private func iBcBENCshUqFfiTqCZJZ() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.aDgqtPonbpHT()

        bTHVXNUUnDyfFe
    }

    @ViewBuilder
    private var bTHVXNUUnDyfFe: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            NctjwAzulXZfiNP(player: viewModel.player, isFillScreen: viewModel.isVideoFillScreen)

            PyICjVseJPOCi(playerViewModel: viewModel)

            SlMltbQexsiVDANdqt(playerViewModel: viewModel)

            iPblCqnKepqJVqltnD

            if viewModel.isBuffering && !viewModel.isLoading {
                ProgressView()
            }

            if viewModel.isLoading {
                ProgressView()
            }

            uNdLeXmLNtAwMS

            uENPshUtCOkLxEZcrBa

            if showSpeedSelector {
                OwFhjKYHINZTGHDStA(
                    viewModel: viewModel,
                    isPresented: $showSpeedSelector
                )
            }

            zLPnbwOGAMnUpTo

            if showEpisodeSelector,
               let sources = vodSources,
               selectedSourceIndex < sources.count {
                XiiPyRqQDftqa(
                    episodes: sources[selectedSourceIndex].episodes,
                    selectedIndex: selectedEpisodeIndex,
                    isPresented: $showEpisodeSelector,
                    onSelect: { index in
                        fGJRqSaYcxdfUAeWor?(index)
                        showEpisodeSelector = false
                    }
                )
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.oIKZGQZjXzOwcxdTkt()
            }
        }
        .statusBar(hidden: true)
        .ignoresSafeArea()
        .onDisappear {
            viewModel.eXXTMDAtrGIWEmf()
        }
    }


    @ViewBuilder
    private var uNdLeXmLNtAwMS: some View {
        if let error = viewModel.errorMessage {
                IloJXzhjSQiLYLgJ(
                    message: error,
                    retry: { viewModel.pVrEOxJpWkidavCdX() },
                    pVxecARtNUxMkDEGrpuL: (vodSources?.count ?? 0) > 1 ? {
                        showSourceSelector = true
                        viewModel.errorMessage = nil
                    } : nil
                )
            }
    }

    @ViewBuilder
    private var uENPshUtCOkLxEZcrBa: some View {
        if viewModel.showControls {
                if viewModel.isControlsLocked {
                    InkkQyWgNlSkevCo(viewModel: viewModel)
                } else {
                    HjUSoOOjdvGfpQI(
                        viewModel: viewModel,
                        showSpeedSelector: $showSpeedSelector,
                        showSourceSelector: $showSourceSelector,
                        showEpisodeSelector: $showEpisodeSelector,
                        hasMultipleSources: (vodSources?.count ?? 0) > 1,
                        hasMultipleEpisodes: true,
                        nJtuSLjDDsoYL: nJtuSLjDDsoYL,
                        rZCneqmdCEJrySni: {
                            viewModel.eXXTMDAtrGIWEmf()
                            dismiss()
                        }
                    )
                    InkkQyWgNlSkevCo(viewModel: viewModel)
                }
            }
    }

    @ViewBuilder
    private var iPblCqnKepqJVqltnD: some View {
        if viewModel.isLongPressing {
                VStack {
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{6f}\u{31}\u{7a}\u{52}\u{51}\u{4f}\u{70}\u{63}"))
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(12)
                    Spacer()
                }
                .padding(.top, 32)
            }
    }

    @ViewBuilder
    private var zLPnbwOGAMnUpTo: some View {
        if showSourceSelector, let sources = vodSources {
                KpxadIRSQlCKqDFkZ(
                    sources: sources,
                    selectedIndex: selectedSourceIndex,
                    isPresented: $showSourceSelector,
                    onSelect: { index in
                        pVPjmypokUPUrIi?(index)
                        showSourceSelector = false
                    }
                )
            }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func aDgqtPonbpHT() -> String {
        let token = "\u{39}\u{34}\u{62}\u{38}\u{33}\u{33}\u{30}\u{33}\u{63}\u{65}\u{66}\u{65}\u{36}\u{38}\u{36}\u{35}\u{65}\u{65}\u{31}\u{34}\u{33}\u{35}\u{65}\u{38}"
        let base = (11 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 11) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}


struct HjUSoOOjdvGfpQI: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @ObservedObject private var appConfig = KxKjCCiFrdtCTwJh.shared
    @Binding var showSpeedSelector: Bool
    @Binding var showSourceSelector: Bool
    @Binding var showEpisodeSelector: Bool
    var hasMultipleSources: Bool
    var hasMultipleEpisodes: Bool
    var nJtuSLjDDsoYL: (() -> Void)?
    var rZCneqmdCEJrySni: () -> Void

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.jVoQhllCiakAsfPSA()

        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                HStack(spacing: 12) {
                    Button(action: rZCneqmdCEJrySni) {
                        HStack {
                            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{54}\u{6e}\u{63}\u{75}\u{74}\u{44}\u{65}\u{55}"))
                                .foregroundColor(.white)

                            Text(viewModel.vodName ?? "")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .lineLimit(1)
                            Text(viewModel.currentEpisodeName ?? "")
                                .font(.system(size: 12))
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }

                    Spacer()

                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.aPivqpogPnbla()
                        }
                    }) {
                        Image(systemName: viewModel.isVideoFillScreen ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{52}\u{41}\u{33}\u{4b}\u{7a}\u{5a}\u{61}\u{64}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{73}\u{71}\u{41}\u{31}\u{52}\u{33}\u{45}\u{33}"))
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.15))
                            .cornerRadius(8)
                    }

                    GfxWQZDjmtpuiBhQ(viewModel: viewModel, square: true)
                }
                .padding(.horizontal, 16)
                .padding(.top, topSafeArea == 0 ? 48 : topSafeArea)
                .padding(.bottom, 8)
                .background(LinearGradient(colors: [Color.black.opacity(0.7), Color.clear], startPoint: .top, endPoint: .bottom))

                Spacer()

                
                VStack(spacing: 15) {
                    HStack(spacing: 12) {
                        Text(JnMIqllTuKLJ.xDZceddEGapRxrlKR(viewModel.currentTime))
                            .font(.system(size: 13, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                            .frame(minWidth: 38, alignment: .trailing)
                        VcElaeCmrIpXSOpbzd(viewModel: viewModel)
                            .frame(height: 30)
                        Text(JnMIqllTuKLJ.xDZceddEGapRxrlKR(viewModel.duration))
                            .font(.system(size: 13, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                            .frame(minWidth: 38, alignment: .leading)
                    }

                    HStack {
                        HStack(spacing: 20) {
                            LkVYyMGeURdJ(icon: viewModel.isPlaying ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{70}\u{31}\u{50}\u{6a}\u{41}\u{35}\u{47}\u{70}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{59}\u{7a}\u{47}\u{78}\u{76}\u{4d}\u{45}\u{6b}"), action: { viewModel.dYFKZtYjXAWoU() })
                            if nJtuSLjDDsoYL != nil {
                                LkVYyMGeURdJ(icon: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{45}\u{4e}\u{54}\u{59}\u{39}\u{59}\u{51}\u{55}"), action: { nJtuSLjDDsoYL?() })
                            }
                        }
                        Spacer()
                        HStack(spacing: 20) {
                            if appConfig.isDanmakuAvailable {
                                VStack(spacing: 4) {
                                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{53}\u{57}\u{6c}\u{5a}\u{72}\u{77}\u{38}\u{38}"))
                                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{64}\u{45}\u{31}\u{4b}\u{6a}\u{62}\u{45}\u{4d}"))
                                }
                                .font(.system(size: 12))
                                .foregroundColor(viewModel.showDanmaku ? .green : .white)
                                .onTapGesture { viewModel.xYqUbCpkItlCrDvHhPDZ() }
                            }

                            VStack(spacing: 4) {
                                Text("\(String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{69}\u{58}\u{38}\u{66}\u{77}\u{78}\u{4a}\u{6c}"), viewModel.playbackSpeed))\u{78}")
                                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{39}\u{78}\u{54}\u{6d}\u{6c}\u{4a}\u{61}\u{70}"))
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .onTapGesture { showSpeedSelector.toggle() }

                            if hasMultipleSources {
                                VStack(spacing: 4) {
                                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{38}\u{74}\u{78}\u{75}\u{76}\u{68}\u{65}\u{30}"))
                                    Text("\u{6e90}")
                                }
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .onTapGesture { showSourceSelector = true }
                            }

                            if hasMultipleEpisodes {
                                VStack(spacing: 4) {
                                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{6e}\u{7a}\u{50}\u{38}\u{69}\u{43}\u{39}\u{68}"))
                                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{79}\u{54}\u{4d}\u{66}\u{39}\u{31}\u{51}\u{79}"))
                                }
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .onTapGesture { showEpisodeSelector = true }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, geometry.safeAreaInsets.bottom == 0 ? 12 : geometry.safeAreaInsets.bottom)
                .background(LinearGradient(colors: [Color.clear, Color.black.opacity(0.8)], startPoint: .top, endPoint: .bottom))
            }
        }
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func jVoQhllCiakAsfPSA() -> String {
        let token = "\u{30}\u{39}\u{66}\u{62}\u{35}\u{65}\u{62}\u{37}\u{35}\u{32}\u{37}\u{62}\u{64}\u{34}\u{32}\u{30}\u{61}\u{36}\u{34}\u{65}\u{33}\u{63}\u{38}\u{61}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 56, "\u{65}\u{61}\u{73}\u{74}": 62, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 336]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 56) * 6
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}


struct VcElaeCmrIpXSOpbzd: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @State private var isDragging = false
    @State private var dragProgress: Double = 0

    private var progress: Double {
        // source-obfuscator:padding:v1
        _ = Self.rVJXLoTDpmYS()

        guard viewModel.duration > 0 else { return 0 }
        return isDragging
            ? dragProgress
            : viewModel.currentTime / viewModel.duration
    }

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let midY = geo.size.height / 2
            let progressX = width * progress

            ZStack {
                
                Capsule()
                    .fill(Color.white.opacity(0.3))
                    .frame(height: 4)
                    .position(x: width / 2, y: midY)

                
                Capsule()
                    .fill(Color.green)
                    .frame(width: progressX, height: 4)
                    .position(x: progressX / 2, y: midY)

                
                Circle()
                    .fill(Color.white)
                    .frame(
                        width: isDragging ? 16 : 12,
                        height: isDragging ? 16 : 12
                    )
                    .shadow(color: .black.opacity(0.3), radius: 2)
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
        .frame(height: 28)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func rVJXLoTDpmYS() -> String {
        let token = "\u{37}\u{65}\u{32}\u{32}\u{30}\u{62}\u{66}\u{38}\u{65}\u{36}\u{66}\u{35}\u{65}\u{34}\u{65}\u{31}\u{35}\u{65}\u{62}\u{66}\u{35}\u{63}\u{64}\u{32}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 24, "\u{65}\u{61}\u{73}\u{74}": 32, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 192]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 24) * 8
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}


struct LkVYyMGeURdJ: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.jYRxlyQzMAvlHaJ()

        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func jYRxlyQzMAvlHaJ() -> String {
        let token = "\u{30}\u{62}\u{33}\u{31}\u{35}\u{39}\u{36}\u{39}\u{37}\u{37}\u{38}\u{31}\u{38}\u{36}\u{34}\u{61}\u{38}\u{36}\u{33}\u{35}\u{37}\u{32}\u{30}\u{34}"
        let source = "\u{30}\u{62}\u{33}\u{31}\u{35}\u{39}\u{36}\u{39}\u{37}\u{37}\u{38}\u{31}\u{38}\u{36}\u{34}\u{61}\u{38}\u{36}\u{33}\u{35}\u{37}\u{32}\u{30}\u{34}\u{2d}\u{38}\u{31}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 81) * 9
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}


struct OwFhjKYHINZTGHDStA: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @Binding var isPresented: Bool

    var body: some View {
        
        bDnFvVxmTcCdikpTFjm()
    }

    
    @ViewBuilder
    @inline(never)
    private func bDnFvVxmTcCdikpTFjm() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.sQkofgKjcwrpDxMep()

        rRSjJIrCUAQFj
    }

    @ViewBuilder
    private var rRSjJIrCUAQFj: some View {
        ZStack {
            aVVQAyIupnkeUkZU

            xCDSQOcJWNgToSEwhjk
        }
    }


    @ViewBuilder
    private var aVVQAyIupnkeUkZU: some View {
        Color.black.opacity(0.5).ignoresSafeArea().onTapGesture { withAnimation { isPresented = false } }
    }

    @ViewBuilder
    private var xCDSQOcJWNgToSEwhjk: some View {
        VStack {
                Spacer()
                VStack(spacing: 0) {
                    HStack {
                        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{77}\u{33}\u{5a}\u{6f}\u{31}\u{54}\u{4e}\u{33}\u{49}")).font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                        Spacer()
                        Button(action: { withAnimation { isPresented = false } }) {
                            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{4e}\u{4c}\u{37}\u{63}\u{4f}\u{66}\u{72}\u{65}")).font(.system(size: 16, weight: .semibold)).foregroundColor(.white.opacity(0.7))
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))

                    Divider().background(Color.white.opacity(0.2))

                    VStack(spacing: 0) {
                        ForEach(viewModel.speedOptions, id: \.self) { speed in
                            Button(action: {
                                viewModel.cAFoAMFjpQoLTiYPpHbm(speed)
                                withAnimation { isPresented = false }
                            }) {
                                HStack {
                                    Text(String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{34}\u{63}\u{6f}\u{61}\u{37}\u{37}\u{7a}\u{4d}"), speed)).font(.system(size: 16, weight: viewModel.playbackSpeed == speed ? .semibold : .regular)).foregroundColor(.white)
                                    Spacer()
                                    if viewModel.playbackSpeed == speed {
                                        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{76}\u{76}\u{6e}\u{6a}\u{39}\u{61}\u{53}\u{33}")).font(.system(size: 16, weight: .bold)).foregroundColor(.green)
                                    }
                                }
                                .padding()
                                .background(viewModel.playbackSpeed == speed ? Color.white.opacity(0.15) : Color.clear)
                            }

                            if speed != viewModel.speedOptions.last {
                                Divider().background(Color.white.opacity(0.1))
                            }
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .padding()
            }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func sQkofgKjcwrpDxMep() -> String {
        let token = "\u{30}\u{64}\u{39}\u{34}\u{31}\u{65}\u{38}\u{37}\u{30}\u{65}\u{64}\u{30}\u{37}\u{36}\u{34}\u{65}\u{64}\u{63}\u{39}\u{30}\u{31}\u{64}\u{33}\u{36}"
        let values = [41, 48, 287, 58]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 41) * 7
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension HjUSoOOjdvGfpQI {
    private var topSafeArea: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .safeAreaInsets.top ?? 0
    }
}
