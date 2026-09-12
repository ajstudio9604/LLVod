




import SwiftUI

struct VueBqSzEmitezfpnfEjd: View {

    let sourceNames: [String]
    let selectedSource: String?
    let results: [PzPGBfDtzkHPSRROQs]
    var isLoadingMoreSources: Bool = false
    var jToOJNXOUoFxpphRV: (String) -> Void
    var iBIIhStwTQlQUkVLH: (PzPGBfDtzkHPSRROQs) -> Void

    @StateObject private var nativeAd = BmUoiIUjoJIrI()

    var body: some View {
        
        jCctAhMbDVfUq()
    }

    
    
    

    
    @ViewBuilder
    @inline(never)
    private func jCctAhMbDVfUq() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.lNYGJIFgqzjGGEJBWY()

        oPcOgEmlillwNeRld
    }

    @ViewBuilder
    private var oPcOgEmlillwNeRld: some View {
        ZStack(alignment: .bottom) {
            gSTFWjqjcFiDbUzK

            pDvcPsznngaKKIwPaO
        }
        .task {
            nativeAd.pRPnGIFVxDFp(placementID: AxQkIqFofIHnj.selfRenderFeedPlacementID)
        }
    }


    @ViewBuilder
    private var pDvcPsznngaKKIwPaO: some View {
        AgOJpRlPxoXdTOFyUIE(
                adView: nativeAd.adView,
                extraBottom: bottomSafeInset
            ) {
                nativeAd.destroy()
            }
    }

    @ViewBuilder
    private var gSTFWjqjcFiDbUzK: some View {
        HStack(alignment: .top, spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(sourceNames, id: \.self) { source in
                            Button {
                                jToOJNXOUoFxpphRV(source)
                            } label: {
                                Text(source)
                                    .font(.system(size: 12.5, weight: .bold))
                                    .foregroundColor(
                                        selectedSource == source ? .red : .primary
                                    )
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 9)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(
                                                selectedSource == source
                                                    ? Color.red.opacity(0.12)
                                                    : Color(.secondarySystemBackground)
                                            )
                                    )
                            }
                            .buttonStyle(.plain)
                            .padding(.leading, 15)
                            .padding(.trailing, 5)
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, nativeAd.overlayHeight + bottomSafeInset)
                }
                .frame(width: 103)

                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(results) { item in
                            Button {
                                iBIIhStwTQlQUkVLH(item)
                            } label: {
                                GrVBteJPEnxq(item: item)
                            }
                            .buttonStyle(.plain)
                        }

                        if isLoadingMoreSources {
                            HStack(spacing: 8) {
                                ProgressView()
                                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{6d}\u{48}\u{49}\u{4a}\u{72}\u{59}\u{6e}\u{41}"))
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                        }
                    }
                    .padding(.bottom, nativeAd.overlayHeight + bottomSafeInset)
                }
            }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func lNYGJIFgqzjGGEJBWY() -> String {
        let token = "\u{38}\u{65}\u{62}\u{61}\u{63}\u{61}\u{38}\u{62}\u{62}\u{64}\u{32}\u{63}\u{65}\u{31}\u{38}\u{65}\u{32}\u{61}\u{35}\u{38}\u{30}\u{31}\u{32}\u{32}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{32}\u{32}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 22) * 3
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

struct GrVBteJPEnxq: View {

    let item: PzPGBfDtzkHPSRROQs

    var body: some View {
        
        oYJNfotwMDhmTwFFmhjO()
    }

    
    @ViewBuilder
    @inline(never)
    private func oYJNfotwMDhmTwFFmhjO() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.xGLyKvsswMnjAxg()

        qKMjOMlfVuwQtoCjI
    }

    @ViewBuilder
    private var qKMjOMlfVuwQtoCjI: some View {
        HStack(alignment: .top, spacing: 7) {
            wYZhIvpQpXhbrR

            jUkDREMEIIKdRdLkUx
        }
        .frame(height: 110)
    }


    @ViewBuilder
    private var jUkDREMEIIKdRdLkUx: some View {
        VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text(item.sourceName)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.red)
                    .lineLimit(1)

                Text(item.status)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 18)
            .padding(.trailing, 10)
    }

    @ViewBuilder
    private var wYZhIvpQpXhbrR: some View {
        EtXjBLbNYUbhXfeKeH(url: URL(string: item.imageURL))
                .frame(width: 65, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.leading, 10)
                .padding(.vertical, 10)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func xGLyKvsswMnjAxg() -> String {
        let token = "\u{64}\u{66}\u{64}\u{63}\u{35}\u{30}\u{34}\u{35}\u{65}\u{39}\u{31}\u{66}\u{30}\u{33}\u{32}\u{39}\u{66}\u{32}\u{33}\u{64}\u{30}\u{30}\u{66}\u{33}"
        let base = (33 * 6 + 19) % 997
        let width = (base) % 17
        let score = (width + 33) * 6
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



extension VueBqSzEmitezfpnfEjd {
    private func nKupveTLDqClbp() -> UIWindow? {
        return EbnwEtXYNYcIQpXISuB.current
    }

    private var bottomSafeInset: CGFloat {
        max(nKupveTLDqClbp()?.safeAreaInsets.bottom ?? 20, 20)
    }
}
