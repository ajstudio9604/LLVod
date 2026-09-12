




import SwiftUI
import AVKit

struct WeROTUJUozFNcdi: View {

    @ObservedObject var vm: ZpTkIxBduVMMhMuv
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @Environment(\.dismiss) private var dismiss
    @State private var showSpeedSelector = false
    @State private var showSourceSelector = false
    @State private var showEpisodeSelector = false
    @State private var showDanmukuSettingSelector = false
    @State private var showJumpLeadTraliSelector = false
    @State private var danmuHint: String?

    @FocusState private var inputFocused: Bool

    var vodSources: [ZhopfUeTrMREiEzrLsF]?
    var selectedSourceIndex: Int
    var selectedEpisodeIndex: Int
    var pVPjmypokUPUrIi: ((Int) -> Void)?
    var fGJRqSaYcxdfUAeWor: ((Int) -> Void)?
    var nJtuSLjDDsoYL: (() -> Void)?

    init(vm: ZpTkIxBduVMMhMuv,
         viewModel: JnMIqllTuKLJ,
         vodSources: [ZhopfUeTrMREiEzrLsF]? = nil,
         selectedSourceIndex: Int = 0,
         selectedEpisodeIndex: Int = 0,
         pVPjmypokUPUrIi: ((Int) -> Void)? = nil,
         fGJRqSaYcxdfUAeWor: ((Int) -> Void)? = nil,
         nJtuSLjDDsoYL: (() -> Void)? = nil) {
        // source-obfuscator:padding:v1
        _ = Self.iMSosTBKhyHShLv()

        self._vm = ObservedObject(wrappedValue: vm)
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.vodSources = vodSources
        self.selectedSourceIndex = selectedSourceIndex
        self.selectedEpisodeIndex = selectedEpisodeIndex
        self.pVPjmypokUPUrIi = pVPjmypokUPUrIi
        self.fGJRqSaYcxdfUAeWor = fGJRqSaYcxdfUAeWor
        self.nJtuSLjDDsoYL = nJtuSLjDDsoYL
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()

                
                NctjwAzulXZfiNP(player: viewModel.player, isFillScreen: viewModel.isVideoFillScreen)
                    .frame(width: geometry.size.width, height: geometry.size.height)

                
                PyICjVseJPOCi(playerViewModel: viewModel)

                
                SlMltbQexsiVDANdqt(playerViewModel: viewModel)

                
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

                
                if viewModel.isJumpLeading {
                    VStack {
                        Text(viewModel.jumpLeadingMessage)
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

                
                if viewModel.isJumpTail {
                    VStack {
                        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6d}\u{58}\u{31}\u{30}\u{6e}\u{4f}\u{50}\u{74}\u{41}"))
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

                
                if viewModel.showDanmuInput {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            yXGdEGxztejNObJ()
                        }
                }

                
                if viewModel.isBuffering && !viewModel.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{53}\u{59}\u{50}\u{61}\u{36}\u{76}\u{46}\u{62}"))
                            .foregroundColor(.white)
                            .font(.system(size: 14))

                        if viewModel.bufferProgress > 0 {
                            Text("\u{5df2}\u{7f13}\u{51b2} \(Int(viewModel.bufferProgress * 100))\u{25}")
                                .foregroundColor(.white.opacity(0.7))
                                .font(.system(size: 12))
                        }
                    }
                }

                
                if viewModel.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{6b}\u{67}\u{30}\u{36}\u{62}\u{63}\u{52}\u{4b}"))
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                }

                
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

                
                if viewModel.showControls {
                    if viewModel.isControlsLocked {
                        InkkQyWgNlSkevCo(viewModel: viewModel)
                    } else {
                        FqNEfDFacZfUE(
                            viewModel: viewModel,
                            showSpeedSelector: $showSpeedSelector,
                            showSourceSelector: $showSourceSelector,
                            showEpisodeSelector: $showEpisodeSelector,
                            showDanmukuSettingSelector: $showDanmukuSettingSelector,
                            showJumpLeadTrailSelector: $showJumpLeadTraliSelector,
                            hasMultipleSources: (vodSources?.count ?? 0) > 1,
                            hasMultipleEpisodes: true,
                            canSendDanmaku: !vm.route.zypath.isEmpty,
                            nJtuSLjDDsoYL: nJtuSLjDDsoYL,
                            rZCneqmdCEJrySni: {
                                viewModel.eXXTMDAtrGIWEmf()
                                dismiss()
                            }
                        )

                        InkkQyWgNlSkevCo(viewModel: viewModel)
                    }
                }

                
                if showDanmukuSettingSelector {
                    HqplsCRajUVzXTLgJc(
                        viewModel: viewModel,
                        isPresented: $showDanmukuSettingSelector
                    )
                }

                
                if showJumpLeadTraliSelector {
                    AwwYjYJsWudkizvI(
                        viewModel: viewModel,
                        isPresented: $showJumpLeadTraliSelector
                    )
                }

                
                if showSpeedSelector {
                    WnojIfABCUmc(
                        viewModel: viewModel,
                        isPresented: $showSpeedSelector
                    )
                }

                
                if showSourceSelector, let sources = vodSources {
                    HpGKsqoyNddO(
                        sources: sources,
                        selectedIndex: selectedSourceIndex,
                        isPresented: $showSourceSelector,
                        onSelect: { index in
                            pVPjmypokUPUrIi?(index)
                            showSourceSelector = false
                        }
                    )
                }

                if let danmuHint {
                    Text(danmuHint)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(8)
                        .transition(.opacity)
                }

                
                if showEpisodeSelector,
                   let sources = vodSources,
                   selectedSourceIndex < sources.count {
                    KujckIcRmNqyXaeUA(
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
            .onChange(of: viewModel.requestFocusDanmuInput) { value in
                inputFocused = value
            }
            .onChange(of: inputFocused) { focused in
                if !focused {
                    viewModel.requestFocusDanmuInput = false
                }
            }
            .contentShape(Rectangle())
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.oIKZGQZjXzOwcxdTkt()
                        }
                    }
            )
        }
        .navigationBarHidden(true)
        .statusBar(hidden: true)
        .ignoresSafeArea()
        .onDisappear {
            viewModel.eXXTMDAtrGIWEmf()
        }
        .safeAreaInset(edge: .bottom) {
            if viewModel.showDanmuInput, !viewModel.isControlsLocked {
                XzOxjEesqqPjZetp(
                    viewModel: viewModel,
                    text: $viewModel.danmuText,
                    dLnboKpVAomNIUgzxV: sOOXtshUJJmeFhmj
                )
                .focused($inputFocused)
                .transition(.move(edge: .bottom))
            }
        }
    }

    

    

    private func aISaLHKxHLnTbJaAXtK(text: String) {
        guard viewModel.danmuText.isEmpty else { return }
        viewModel.danmuText = text
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func iMSosTBKhyHShLv() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 5, "\u{65}\u{61}\u{73}\u{74}": 8, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 15]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 5) * 3
        let token = "\u{31}\u{38}\u{65}\u{64}\u{30}\u{33}\u{62}\u{35}\u{62}\u{30}\u{64}\u{62}\u{38}\u{32}\u{61}\u{32}\u{36}\u{38}\u{63}\u{33}\u{32}\u{66}\u{65}\u{63}"
        _ = Self.aRqBByhrzFsovEjLE()
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
    @inline(never)
    private nonisolated static func aRqBByhrzFsovEjLE() -> String {
        let token = "\u{63}\u{32}\u{66}\u{32}\u{38}\u{32}\u{31}\u{38}\u{66}\u{32}\u{39}\u{61}\u{33}\u{38}\u{37}\u{33}\u{63}\u{30}\u{31}\u{61}\u{38}\u{62}\u{34}\u{65}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 93, "\u{65}\u{61}\u{73}\u{74}": 102, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 837]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 93) * 9
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

struct InkkQyWgNlSkevCo: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ

    var body: some View {
        
        tZxMPtyIiFbxnttCImsm()
    }

    
    @ViewBuilder
    @inline(never)
    private func tZxMPtyIiFbxnttCImsm() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.zHAtkLGqMyVtXf()

        oZeKcZDzuUHNC
    }

    @ViewBuilder
    private var oZeKcZDzuUHNC: some View {
        HStack {
            gNqsbqhDhBmhnqS

            pZnjyefEmJTVpxKJy
        }
        .padding(.leading, 28)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .allowsHitTesting(true)
    }


    @ViewBuilder
    private var gNqsbqhDhBmhnqS: some View {
        Button {
                viewModel.jXNqIOEEuMRel()
            } label: {
                Image(systemName: viewModel.isControlsLocked ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{44}\u{79}\u{32}\u{74}\u{66}\u{4c}\u{56}\u{62}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{6f}\u{73}\u{79}\u{33}\u{53}\u{4d}\u{70}\u{45}"))
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.black.opacity(0.45))
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
    }

    @ViewBuilder
    private var pZnjyefEmJTVpxKJy: some View {
        Spacer()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func zHAtkLGqMyVtXf() -> String {
        let token = "\u{31}\u{35}\u{33}\u{39}\u{66}\u{36}\u{38}\u{34}\u{35}\u{36}\u{62}\u{35}\u{31}\u{34}\u{33}\u{37}\u{63}\u{65}\u{65}\u{63}\u{65}\u{39}\u{30}\u{61}"
        let source = "\u{31}\u{35}\u{33}\u{39}\u{66}\u{36}\u{38}\u{34}\u{35}\u{36}\u{62}\u{35}\u{31}\u{34}\u{33}\u{37}\u{63}\u{65}\u{65}\u{63}\u{65}\u{39}\u{30}\u{61}\u{2d}\u{39}\u{35}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 95) * 9
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

struct XzOxjEesqqPjZetp: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @Binding var text: String
    var dLnboKpVAomNIUgzxV: () -> Void

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.iGvdwkthYgcEWVP()

        VStack {
            HStack(spacing: 12) {
                TextField(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{46}\u{72}\u{50}\u{54}\u{69}\u{74}\u{77}\u{6a}"), text: $text)
                    .textFieldStyle(.roundedBorder)

                Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{67}\u{57}\u{64}\u{4c}\u{61}\u{32}\u{6d}\u{32}")) {
                    dLnboKpVAomNIUgzxV()
                }
                .disabled(text.trimmingCharacters(in: .whitespaces).isEmpty)
            }

            TwGVsgeDqNFGQOpl(viewModel: viewModel)
        }
        .padding()
        .background(.ultraThinMaterial)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func iGvdwkthYgcEWVP() -> String {
        let token = "\u{34}\u{65}\u{32}\u{38}\u{33}\u{65}\u{36}\u{33}\u{37}\u{64}\u{36}\u{63}\u{65}\u{33}\u{35}\u{61}\u{63}\u{65}\u{31}\u{62}\u{39}\u{30}\u{37}\u{63}"
        let values = [31, 36, 155, 48]
        let folded = values.map { ($0 * 5 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 31) * 5
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

struct TwGVsgeDqNFGQOpl: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.cZyGELtfTQHiRVMwUaII()

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(BekLjtVkGtRK.colors, id: \.self) { hex in
                    let isSelected = viewModel.danmuColor == hex

                    Button {
                        viewModel.danmuColor = hex
                    } label: {
                        Circle()
                            .fill(Color(JqhDhPCYGghMxEot.xEUbBNxtHscM(hex)))
                            .frame(width: 28, height: 28)
                            .overlay(
                                Circle().stroke(
                                    Color.white.opacity(isSelected ? 1 : 0.25),
                                    lineWidth: isSelected ? 2 : 1
                                )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func cZyGELtfTQHiRVMwUaII() -> String {
        let token = "\u{65}\u{61}\u{66}\u{37}\u{30}\u{61}\u{30}\u{36}\u{66}\u{36}\u{36}\u{65}\u{31}\u{36}\u{32}\u{36}\u{31}\u{62}\u{65}\u{33}\u{64}\u{36}\u{64}\u{33}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 54, "\u{65}\u{61}\u{73}\u{74}": 56, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 108]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 54) * 2
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}


struct FqNEfDFacZfUE: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @ObservedObject private var appConfig = KxKjCCiFrdtCTwJh.shared
    @Binding var showSpeedSelector: Bool
    @Binding var showSourceSelector: Bool
    @Binding var showEpisodeSelector: Bool
    @Binding var showDanmukuSettingSelector: Bool
    @Binding var showJumpLeadTrailSelector: Bool
    var hasMultipleSources: Bool
    var hasMultipleEpisodes: Bool
    var canSendDanmaku: Bool = true
    var nJtuSLjDDsoYL: (() -> Void)?
    var rZCneqmdCEJrySni: () -> Void

    var body: some View {
        
        fZSedrlMMiGHXzkX()
    }

    
    @ViewBuilder
    @inline(never)
    private func fZSedrlMMiGHXzkX() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.dSDhrHEYrWGVgAg()

        tBfHeDPNhzYYIY
    }

    @ViewBuilder
    private var tBfHeDPNhzYYIY: some View {
        VStack(spacing: 0) {
            
            uCAerCujFvEgnzZn

            aWuVKjKqtkThVqTYMfGf

            
            if !viewModel.isPlaying && !viewModel.isLoading {
                Button(action: { viewModel.kOyimNYtFFRQz() }) {
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.4))
                            .frame(width: 80, height: 80)

                        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{4c}\u{56}\u{5a}\u{4d}\u{66}\u{35}\u{70}\u{63}"))
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                }
            }

            kSMTolGqbEgzUQauag

            
            qMMvKaPQvToSf
        }
    }


    @ViewBuilder
    private var qMMvKaPQvToSf: some View {
        VStack(spacing: 12) {
                
                HStack(spacing: 12) {
                    Text(JnMIqllTuKLJ.xDZceddEGapRxrlKR(viewModel.currentTime))
                        .font(.system(size: 13, weight: .medium, design: .monospaced))
                        .foregroundColor(.white)
                        .frame(minWidth: 38, alignment: .trailing)

                    NtJNBYrQUPOQSXE(viewModel: viewModel)
                        .frame(height: 30)

                    Text(JnMIqllTuKLJ.xDZceddEGapRxrlKR(viewModel.duration))
                        .font(.system(size: 13, weight: .medium, design: .monospaced))
                        .foregroundColor(.white)
                        .frame(minWidth: 38, alignment: .leading)
                }
                .padding(.horizontal, 16)

                
                HStack {
                    
                    GlrurcnpVfBx(
                        icon: viewModel.isPlaying ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{70}\u{31}\u{50}\u{6a}\u{41}\u{35}\u{47}\u{70}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{59}\u{7a}\u{47}\u{78}\u{76}\u{4d}\u{45}\u{6b}"),
                        action: { viewModel.dYFKZtYjXAWoU() }
                    )

                    
                    if nJtuSLjDDsoYL != nil {
                        GlrurcnpVfBx(
                            icon: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{45}\u{4e}\u{54}\u{59}\u{39}\u{59}\u{51}\u{55}"),
                            action: {
                                nJtuSLjDDsoYL?()
                            }
                        )
                    }

                    
                    if appConfig.isDanmakuAvailable {
                        
                        GlrurcnpVfBx(icon: viewModel.showDanmaku ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{43}\u{4f}\u{36}\u{4d}\u{31}\u{62}\u{6d}\u{63}\u{39}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{79}\u{49}\u{64}\u{7a}\u{52}\u{41}\u{56}\u{58}")) {
                            viewModel.xYqUbCpkItlCrDvHhPDZ()
                        }

                        
                        if viewModel.showDanmaku {
                            GlrurcnpVfBx(icon: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{78}\u{33}\u{46}\u{43}\u{32}\u{6f}\u{4f}\u{65}\u{78}")) {
                                withAnimation {
                                    showDanmukuSettingSelector.toggle()
                                }
                            }
                        }

                        
                        if viewModel.showDanmaku, canSendDanmaku, appConfig.canSendDanmaku {
                            GlrurcnpVfBx(icon: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{50}\u{6c}\u{41}\u{6f}\u{44}\u{74}\u{46}\u{74}")) {
                                viewModel.qLHUiAJQTzSjKr()
                            }
                        }
                    }

                    Spacer()

                    
                    Button(action: {
                        withAnimation {
                            showJumpLeadTrailSelector.toggle()
                        }
                    }) {
                        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{37}\u{56}\u{6b}\u{64}\u{69}\u{65}\u{59}\u{4a}\u{34}"))
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                    }

                    
                    Button(action: {
                        withAnimation {
                            showSpeedSelector.toggle()
                        }
                    }) {
                        HStack(spacing: 4) {
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{39}\u{78}\u{54}\u{6d}\u{6c}\u{4a}\u{61}\u{70}"))
                                .font(.system(size: 14, weight: .medium))
                            Text("\(String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{69}\u{58}\u{38}\u{66}\u{77}\u{78}\u{4a}\u{6c}"), viewModel.playbackSpeed))\u{78}")
                                .font(.system(size: 13, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                    }

                    
                    if hasMultipleSources {
                        Button(action: {
                            showSourceSelector = true
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{38}\u{74}\u{78}\u{75}\u{76}\u{68}\u{65}\u{30}"))
                                    .font(.system(size: 14))
                                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{33}\u{47}\u{61}\u{68}\u{4a}\u{56}\u{55}\u{77}"))
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                        }
                    }

                    
                    if hasMultipleEpisodes {
                        Button(action: {
                            showEpisodeSelector = true
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{6e}\u{7a}\u{50}\u{38}\u{69}\u{43}\u{39}\u{68}"))
                                    .font(.system(size: 14))
                                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{79}\u{54}\u{4d}\u{66}\u{39}\u{31}\u{51}\u{79}"))
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
            .background(
                LinearGradient(
                    colors: [Color.clear, Color.black.opacity(0.8)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }

    @ViewBuilder
    private var aWuVKjKqtkThVqTYMfGf: some View {
        Spacer()
    }

    @ViewBuilder
    private var kSMTolGqbEgzUQauag: some View {
        Spacer()
    }

    @ViewBuilder
    private var uCAerCujFvEgnzZn: some View {
        HStack(spacing: 12) {
                
                Button(action: rZCneqmdCEJrySni) {
                    HStack(spacing: 6) {
                        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{54}\u{6e}\u{63}\u{75}\u{74}\u{44}\u{65}\u{55}"))
                            .font(.system(size: 16, weight: .semibold))

                        
                        if let vodName = viewModel.vodName {
                            Text(vodName)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .lineLimit(1)

                            if let episodeName = viewModel.currentEpisodeName {
                                Text(episodeName)
                                    .font(.system(size: 12))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .cornerRadius(8)
                }

                Spacer()

                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.aPivqpogPnbla()
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.white.opacity(0.15))
                            .frame(width: 40, height: 40)

                        Image(systemName: viewModel.isVideoFillScreen ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{52}\u{41}\u{33}\u{4b}\u{7a}\u{5a}\u{61}\u{64}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{73}\u{71}\u{41}\u{31}\u{52}\u{33}\u{45}\u{33}"))
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
                .padding(.trailing, 12)

                
                GfxWQZDjmtpuiBhQ(viewModel: viewModel, square: true)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .background(
                LinearGradient(
                    colors: [Color.black.opacity(0.7), Color.clear],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func dSDhrHEYrWGVgAg() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 52, "\u{65}\u{61}\u{73}\u{74}": 59, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 364]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 52) * 7
        let token = "\u{62}\u{35}\u{39}\u{31}\u{33}\u{33}\u{39}\u{63}\u{31}\u{37}\u{62}\u{65}\u{37}\u{65}\u{33}\u{66}\u{34}\u{36}\u{32}\u{39}\u{32}\u{32}\u{33}\u{38}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
}


struct NtJNBYrQUPOQSXE: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @State private var isDragging = false
    @State private var dragProgress: Double = 0

    

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.pFzpkLdZgzCKbrJiNVrz()

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
                    .frame(width: isDragging ? 16 : 12,
                           height: isDragging ? 16 : 12)
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
        .frame(height: 24)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func pFzpkLdZgzCKbrJiNVrz() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{37}\u{32}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 72) * 6
        let token = "\u{63}\u{33}\u{65}\u{62}\u{66}\u{39}\u{38}\u{38}\u{30}\u{61}\u{66}\u{39}\u{65}\u{66}\u{66}\u{35}\u{32}\u{61}\u{30}\u{39}\u{30}\u{38}\u{65}\u{65}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}


struct GlrurcnpVfBx: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.gBVRTedVqSgB()

        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 38, height: 38)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func gBVRTedVqSgB() -> String {
        let token = "\u{64}\u{39}\u{39}\u{64}\u{38}\u{33}\u{65}\u{36}\u{30}\u{61}\u{64}\u{31}\u{63}\u{39}\u{30}\u{65}\u{36}\u{61}\u{65}\u{32}\u{39}\u{34}\u{63}\u{30}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{36}\u{31}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 61) * 5
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}


struct WnojIfABCUmc: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @Binding var isPresented: Bool

    var body: some View {
        
        hMtPUGtIXuji()
    }

    
    @ViewBuilder
    @inline(never)
    private func hMtPUGtIXuji() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.tBOrLDePQvuZPTj()

        qBrnkhJnDiMVBwtiyyg
    }

    @ViewBuilder
    private var qBrnkhJnDiMVBwtiyyg: some View {
        HStack {
            cFhSMsLaSJQSaqa

            jUCpprnFoFVBMMqpC
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
    private var jUCpprnFoFVBMMqpC: some View {
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
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding()
                .background(Color.white.opacity(0.1))

                Divider().background(Color.white.opacity(0.2))

                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.speedOptions, id: \.self) { speed in
                            Button(action: {
                                viewModel.cAFoAMFjpQoLTiYPpHbm(speed)
                                withAnimation {
                                    isPresented = false
                                }
                            }) {
                                HStack {
                                    Text(String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{34}\u{63}\u{6f}\u{61}\u{37}\u{37}\u{7a}\u{4d}"), speed))
                                        .font(.system(size: 16, weight: viewModel.playbackSpeed == speed ? .semibold : .regular))
                                        .foregroundColor(.white)
                                    Spacer()
                                    if viewModel.playbackSpeed == speed {
                                        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{76}\u{76}\u{6e}\u{6a}\u{39}\u{61}\u{53}\u{33}"))
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.green)
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
            }
            .frame(width: 250)
            .background(Color.black.opacity(0.95))
            .cornerRadius(12)
            .padding(.trailing, 16)
    }

    @ViewBuilder
    private var cFhSMsLaSJQSaqa: some View {
        Spacer()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func tBOrLDePQvuZPTj() -> String {
        let values = [53, 60, 371, 70]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 53) * 7
        let token = "\u{64}\u{34}\u{61}\u{32}\u{39}\u{36}\u{66}\u{62}\u{65}\u{66}\u{31}\u{39}\u{66}\u{36}\u{30}\u{38}\u{33}\u{63}\u{65}\u{64}\u{64}\u{64}\u{34}\u{37}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}


struct AwwYjYJsWudkizvI: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @Binding var isPresented: Bool

    var body: some View {
        
        gOzzaHapNthXFktTYvv()
    }

    
    @ViewBuilder
    @inline(never)
    private func gOzzaHapNthXFktTYvv() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.qBuEDaHAYPFFVvSDVg()

        mXgwASXQNofvAigDnNBb
    }

    @ViewBuilder
    private var mXgwASXQNofvAigDnNBb: some View {
        HStack {
            wSNoVqgAJFVZABObRkHd

            oGszUovbJPEDjjfpYnjs
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
    private var wSNoVqgAJFVZABObRkHd: some View {
        Spacer()
    }

    @ViewBuilder
    private var oGszUovbJPEDjjfpYnjs: some View {
        VStack(spacing: 0) {
                HStack {
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{65}\u{48}\u{6c}\u{49}\u{38}\u{66}\u{45}\u{77}"))
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)

                    Spacer()
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{4e}\u{4c}\u{37}\u{63}\u{4f}\u{66}\u{72}\u{65}"))
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding()
                .background(Color.white.opacity(0.1))

                Divider().background(Color.white.opacity(0.2))

                VStack {
                    ScrollView {
                        HStack {
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{70}\u{6d}\u{47}\u{78}\u{56}\u{54}\u{73}\u{54}"))
                                .font(.system(size: 14))
                                .foregroundColor(Color(uiColor: UIColor.lightGray))
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16))

                        
                        HStack {
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{57}\u{4f}\u{77}\u{41}\u{4a}\u{38}\u{6b}\u{67}"))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                            Text(String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{35}\u{78}\u{6f}\u{64}\u{45}\u{73}\u{65}\u{46}"), Int(viewModel.vodJumpLeading * 300)))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                        }
                        .padding(.trailing, 16)

                        OdqlqcHcdCgx(onChanged: { value in
                            viewModel.tNaglWAxxypHTI(time: value)
                        }, defaultValue: $viewModel.vodJumpLeading)

                        
                        HStack {
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{37}\u{70}\u{30}\u{74}\u{57}\u{66}\u{4e}\u{62}\u{53}"))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                            Text(String(format: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{35}\u{78}\u{6f}\u{64}\u{45}\u{73}\u{65}\u{46}"), Int(viewModel.vodJumpTrail * 300)))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                        }
                        .padding(.trailing, 16)

                        OdqlqcHcdCgx(onChanged: { value in
                            viewModel.qAMgkoWPhDHC(time: value)
                        }, defaultValue: $viewModel.vodJumpTrail)

                        Spacer()
                    }
                }

                Spacer()
            }
            .frame(width: 300)
            .background(Color.black.opacity(0.95))
            .cornerRadius(12)
            .padding(.trailing, 16)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qBuEDaHAYPFFVvSDVg() -> String {
        let source = "\u{37}\u{64}\u{36}\u{34}\u{39}\u{66}\u{36}\u{34}\u{38}\u{63}\u{64}\u{35}\u{61}\u{34}\u{38}\u{61}\u{65}\u{37}\u{61}\u{66}\u{39}\u{33}\u{39}\u{65}\u{2d}\u{38}\u{37}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 87) * 3
        let token = "\u{37}\u{64}\u{36}\u{34}\u{39}\u{66}\u{36}\u{34}\u{38}\u{63}\u{64}\u{35}\u{61}\u{34}\u{38}\u{61}\u{65}\u{37}\u{61}\u{66}\u{39}\u{33}\u{39}\u{65}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}


struct HqplsCRajUVzXTLgJc: View {
    @ObservedObject var viewModel: JnMIqllTuKLJ
    @Binding var isPresented: Bool

    var body: some View {
        
        uCzWFFpbLxBS()
    }

    
    @ViewBuilder
    @inline(never)
    private func uCzWFFpbLxBS() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.gTrqvITReQDwhl()

        rNXGEuPvhxDaNfx
    }

    @ViewBuilder
    private var rNXGEuPvhxDaNfx: some View {
        HStack {
            nCPayUjhyvtluCe

            cADYRqTCpHodAGmzw
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
    private var cADYRqTCpHodAGmzw: some View {
        VStack(spacing: 0) {
                HStack {
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{72}\u{36}\u{62}\u{65}\u{33}\u{75}\u{54}\u{46}"))
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{4e}\u{4c}\u{37}\u{63}\u{4f}\u{66}\u{72}\u{65}"))
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding()
                .background(Color.white.opacity(0.1))

                Divider().background(Color.white.opacity(0.2))

                VStack {
                    ScrollView {
                        
                        HStack {
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{37}\u{65}\u{70}\u{67}\u{31}\u{42}\u{70}\u{43}"))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                        }

                        TwGVsgeDqNFGQOpl(viewModel: viewModel)

                        
                        HStack {
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{7a}\u{76}\u{77}\u{73}\u{75}\u{33}\u{45}\u{54}"))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                        }

                        PdRcaYNKpAiMPmiLT(vm: viewModel)

                        
                        HStack {
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{6d}\u{52}\u{45}\u{6b}\u{58}\u{7a}\u{75}\u{52}"))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                        }

                        OdqlqcHcdCgx(onChanged: { value in
                            viewModel.danmakuArea = value
                        }, defaultValue: $viewModel.danmakuArea)

                        
                        HStack {
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{39}\u{38}\u{4a}\u{45}\u{79}\u{59}\u{67}\u{71}"))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                        }

                        OdqlqcHcdCgx(onChanged: { value in
                            viewModel.danmakuSpeed = value
                        }, defaultValue: $viewModel.danmakuSpeed)

                        
                        HStack {
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{61}\u{39}\u{71}\u{43}\u{4a}\u{55}\u{39}\u{4a}"))
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 0))
                            Spacer()
                        }

                        OdqlqcHcdCgx(onChanged: { value in
                            viewModel.danmakuOpacity = value
                        }, defaultValue: $viewModel.danmakuOpacity)

                        Spacer()
                    }
                }

                Spacer()
            }
            .frame(width: 300)
            .background(Color.black.opacity(0.95))
            .cornerRadius(12)
            .padding(.trailing, 16)
    }

    @ViewBuilder
    private var nCPayUjhyvtluCe: some View {
        Spacer()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func gTrqvITReQDwhl() -> String {
        let token = "\u{35}\u{34}\u{61}\u{64}\u{63}\u{31}\u{32}\u{35}\u{65}\u{62}\u{34}\u{34}\u{33}\u{63}\u{66}\u{34}\u{39}\u{62}\u{36}\u{36}\u{33}\u{37}\u{63}\u{36}"
        let values = [3, 11, 24, 20]
        let folded = values.map { ($0 * 8 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 3) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

struct OdqlqcHcdCgx: View {
    @State private var isDragging = false
    @State var dragProgress: Double = 0
    let onChanged: (Double) -> Void
    @Binding var defaultValue: Double

    

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.dTkCTjKBXuHD()

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
                    .frame(width: isDragging ? 16 : 12,
                           height: isDragging ? 16 : 12)
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
                    }
                    .onEnded { _ in
                        isDragging = false
                        onChanged(dragProgress)
                    }
            )
        }
        .frame(height: 24)
        .padding(.horizontal, 16)
        .onAppear {
            dragProgress = defaultValue
        }
        .onChange(of: defaultValue) { newValue in
            
            if !isDragging {
                dragProgress = newValue
            }
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func dTkCTjKBXuHD() -> String {
        let base = (57 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 57) * 9
        let token = "\u{64}\u{62}\u{64}\u{31}\u{64}\u{64}\u{62}\u{66}\u{65}\u{64}\u{32}\u{63}\u{35}\u{36}\u{32}\u{37}\u{64}\u{39}\u{63}\u{63}\u{39}\u{36}\u{37}\u{34}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}

struct PdRcaYNKpAiMPmiLT: View {
    @ObservedObject var vm: JnMIqllTuKLJ

    var body: some View {
        
        pAhSZzSElneYNkIJJV()
    }

    
    @ViewBuilder
    @inline(never)
    private func pAhSZzSElneYNkIJJV() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.aRILDLNxLTeEbiPDd()

        cOVEMQPLLAyAOACsZESq
    }

    @ViewBuilder
    private var cOVEMQPLLAyAOACsZESq: some View {
        HStack {
            pQWECRodrrpixdZAHdEh
            hGwTmxpAmwYfENo
        }
        .padding(.horizontal, 16)
    }


    @ViewBuilder
    private var hGwTmxpAmwYfENo: some View {
        Spacer()
    }

    @ViewBuilder
    private var pQWECRodrrpixdZAHdEh: some View {
        ForEach(vm.fontSizeOptions, id: \.self) { fontSize in
                QboOIqfmYocq(
                    fontSize: CGFloat(fontSize),
                    isSelected: vm.danmuFontSize == fontSize
                ) {
                    vm.danmuFontSize = fontSize
                }
            }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func aRILDLNxLTeEbiPDd() -> String {
        let base = (82 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 82) * 2
        let token = "\u{36}\u{65}\u{30}\u{39}\u{36}\u{37}\u{35}\u{35}\u{38}\u{32}\u{39}\u{34}\u{30}\u{30}\u{30}\u{37}\u{62}\u{33}\u{63}\u{38}\u{32}\u{33}\u{33}\u{61}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}

struct QboOIqfmYocq: View {
    let fontSize: CGFloat
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.mCDeSCjEwlPGStq()

        Button(action: action) {
            Text("\u{41}")
                .font(.system(size: fontSize, weight: isSelected ? .semibold : .regular))
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.white)
        }
        .background(isSelected ? Color.white.opacity(0.15) : Color.clear)
        .cornerRadius(4)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mCDeSCjEwlPGStq() -> String {
        let token = "\u{32}\u{34}\u{61}\u{66}\u{63}\u{38}\u{32}\u{62}\u{63}\u{64}\u{30}\u{61}\u{65}\u{31}\u{32}\u{65}\u{62}\u{62}\u{37}\u{31}\u{35}\u{32}\u{65}\u{35}"
        let source = "\u{32}\u{34}\u{61}\u{66}\u{63}\u{38}\u{32}\u{62}\u{63}\u{64}\u{30}\u{61}\u{65}\u{31}\u{32}\u{65}\u{62}\u{62}\u{37}\u{31}\u{35}\u{32}\u{65}\u{35}\u{2d}\u{37}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 7) * 2
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension NtJNBYrQUPOQSXE {
    private var progress: Double {
        guard viewModel.duration > 0 else { return 0 }
        return isDragging
        ? dragProgress
        : viewModel.currentTime / viewModel.duration
    }
}


extension OdqlqcHcdCgx {
    private var progress: Double {
        return dragProgress
    }
}


extension WeROTUJUozFNcdi {
    private func sOOXtshUJJmeFhmj() {
        let text = viewModel.danmuText.trimmingCharacters(in: .whitespacesAndNewlines)
        let colorHex = viewModel.danmuColor
        viewModel.danmuText = ""
        yXGdEGxztejNObJ()

        guard !text.isEmpty else { return }

        guard LkzXORcEdLaolfAi.canSend, let sender = UvBxBoMIYrRWck.sender else {
            jIrvotynpisnsfzupH(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{78}\u{4f}\u{76}\u{72}\u{30}\u{35}\u{4a}\u{50}\u{65}"))
            return
        }

        let request = NyEntjjjOoTtEDgfOvhY(
            vodName: vm.payload?.title ?? vm.route.name,
            episode: vm.selectedEpisodeIndex + 1,
            text: text,
            colorHex: colorHex,
            time: viewModel.currentTime
        )

        sender(request) { result in
            switch result {
            case .success:
                
                viewModel.danmaku.wSpabVaTsqoMXBk(text: text, colorHex: colorHex)
                jIrvotynpisnsfzupH(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{37}\u{67}\u{71}\u{58}\u{71}\u{6f}\u{72}\u{5a}"))

            case .rejected(let reason):
                 
                
                aISaLHKxHLnTbJaAXtK(text: text)
                jIrvotynpisnsfzupH(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{63}\u{32}\u{55}\u{66}\u{4c}\u{47}\u{4c}\u{72}"))

            case .failed:
                aISaLHKxHLnTbJaAXtK(text: text)
                jIrvotynpisnsfzupH(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{52}\u{53}\u{32}\u{71}\u{55}\u{6a}\u{4e}\u{6e}"))
            }
        }
    }

    private func jIrvotynpisnsfzupH(_ message: String) {
        withAnimation { danmuHint = message }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                guard danmuHint == message else { return }
                danmuHint = nil
            }
        }
    }

    private func yXGdEGxztejNObJ() {
        withAnimation {
            viewModel.showDanmuInput = false
        }
    }
}
