






import SwiftUI

struct LqUDQhwcxcSugC: View {

    @ObservedObject var viewModel: ZpTkIxBduVMMhMuv
    @ObservedObject var playerViewModel: JnMIqllTuKLJ

    var body: some View {
        
        rOHgVhGWsFgeYL()
    }

    
    @ViewBuilder
    @inline(never)
    private func rOHgVhGWsFgeYL() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.oYazGcLpsWoRyxpq()

        bGMyRpnTIFfHCQJ
    }

    @ViewBuilder
    private var bGMyRpnTIFfHCQJ: some View {
        ZStack {
            jESeJnSjbfRpFSdY

            
            sMArGdJNPjRcy
        }
    }


    @ViewBuilder
    private var jESeJnSjbfRpFSdY: some View {
        WlBnsZNHGTSAPwgqKA(
                viewModel: viewModel,
                playerViewModel: playerViewModel,
                nJtuSLjDDsoYL: {
                    viewModel.mHfHuTKsqafNvGdUppAC()
                },
                vodSources: viewModel.payload?.sourceLines,
                selectedSourceIndex: viewModel.selectedLineIndex,
                selectedEpisodeIndex: viewModel.selectedEpisodeIndex,
                pVPjmypokUPUrIi: { newSourceIndex in
                    viewModel.bNzBuUHgEWITV(at: newSourceIndex)
                },
                fGJRqSaYcxdfUAeWor: { newEpisodeIndex in
                    viewModel.hLPhZeKAHTPW(at: newEpisodeIndex)
                }
            )
    }

    @ViewBuilder
    private var sMArGdJNPjRcy: some View {
        if viewModel.isResolvingPlayURL {
                ZStack {
                    Color.black.opacity(0.6)
                    ProgressView(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{4c}\u{43}\u{53}\u{69}\u{65}\u{64}\u{51}\u{70}"))
                        .tint(.white)
                        .foregroundColor(.white)
                }
            } else if viewModel.resolvedPlayURL.isEmpty && !viewModel.playStatusMessage.isEmpty {
                ZStack {
                    Color.black.opacity(0.6)

                    VStack(spacing: 8) {
                        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{48}\u{78}\u{6a}\u{4b}\u{6a}\u{72}\u{4e}\u{75}"))
                            .font(.system(size: 36))
                            .foregroundColor(.white.opacity(0.8))

                        Text(viewModel.playStatusMessage)
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)

                        if viewModel.playStatusMessage != AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{5a}\u{30}\u{4f}\u{61}\u{4e}\u{4f}\u{71}\u{41}") {
                            Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{69}\u{67}\u{72}\u{57}\u{33}\u{6c}\u{75}\u{7a}")) {
                                viewModel.pXPfGHRFEwYOapqxFw()
                            }
                            .font(.footnote)
                            .foregroundColor(.white)
                        }
                    }
                }
            }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func oYazGcLpsWoRyxpq() -> String {
        let token = "\u{30}\u{61}\u{65}\u{31}\u{36}\u{32}\u{34}\u{36}\u{38}\u{32}\u{63}\u{35}\u{36}\u{37}\u{62}\u{61}\u{30}\u{37}\u{61}\u{65}\u{36}\u{31}\u{32}\u{33}"
        let base = (64 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 64) * 8
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

