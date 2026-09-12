








import SwiftUI

private struct ZrEVQGoOzEsxLOv: PreferenceKey {
    static var defaultValue: CGFloat = .greatestFiniteMagnitude

    
}

struct NfWpekezXewNpoHEBIt: View {

    let playlist: YxdUIQGhxKMxKzMYnmOS

    @StateObject private var viewModel: QfLEdEoSrGGFjtnVbRGR
    @Environment(\.presentationMode) private var presentationMode
    @State private var isBarCollapsed = false
    @State private var hasMeasuredHeader = false

    private let headerHeight: CGFloat = 180
    private let barHeight: CGFloat = 44

    init(playlist: YxdUIQGhxKMxKzMYnmOS) {
        // source-obfuscator:padding:v1
        _ = Self.jInkCsqVtnQdv()

        self.playlist = playlist
        _viewModel = StateObject(
            wrappedValue: QfLEdEoSrGGFjtnVbRGR(
                playlistID: playlist.id,
                expectedCount: playlist.itemsCount
            )
        )
    }

    var body: some View {
        GeometryReader { proxy in
            
            let safeTop = proxy.safeAreaInsets.top

            ZStack(alignment: .top) {
                nLshAElckCRlq(
                    containerWidth: proxy.size.width,
                    containerHeight: proxy.size.height,
                    safeTop: safeTop
                )

                vNrLrkvMVmZIeBavOR(safeTop: safeTop)
            }
            .ignoresSafeArea(.container, edges: .top)
        }
        .background(Color(.systemBackground))
        .ahHideNavigationBar()
        .ahHideTabBar()
        .task {
            await viewModel.zGFkkXBnrgUq()
        }
        .ahInlineError(message: viewModel.errorMessage, isLoading: viewModel.isLoading || viewModel.isLoadingMore) {
            await viewModel.kXEBrljsQlYp()
        }
    }

    

    private func nDLgOSwNqdiGxa(width: CGFloat, safeTop: CGFloat) -> some View {
        let height = headerHeight + safeTop

        return ZStack {
            EtXjBLbNYUbhXfeKeH(url: URL(string: headerImageURL))
                .frame(width: width, height: height)
                
                .blur(radius: 6, opaque: true)

            
            LinearGradient(
                colors: [
                    Color.black.opacity(0.28),
                    Color.black.opacity(0.12),
                    Color.black.opacity(0.3)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .frame(width: width, height: height)
        .clipped()
        .background(headerBottomReader)
    }

    

    

    

    

    @ViewBuilder
    private func gLWeiloEIFaM(
        containerWidth: CGFloat,
        isLandscape: Bool
    ) -> some View {
        if viewModel.isLoading && viewModel.items.isEmpty {
            ProgressView(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{49}\u{65}\u{6c}\u{63}\u{57}\u{4a}\u{54}\u{31}"))
                .frame(maxWidth: .infinity)
                .frame(minHeight: 320)
        } else if viewModel.items.isEmpty {
            emptyState
        } else {
            vEaKvxCSurMohcvdnPm(containerWidth: containerWidth, isLandscape: isLandscape)
        }
    }

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func jInkCsqVtnQdv() -> String {
        let values = [25, 32, 175, 42]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 25) * 7
        let token = "\u{66}\u{31}\u{64}\u{34}\u{37}\u{31}\u{38}\u{62}\u{62}\u{37}\u{65}\u{37}\u{32}\u{35}\u{66}\u{64}\u{37}\u{31}\u{39}\u{37}\u{62}\u{33}\u{63}\u{65}"
        _ = Self.lWKSYKcATtIPTPSA()
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
    @inline(never)
    private nonisolated static func lWKSYKcATtIPTPSA() -> String {
        let values = [77, 84, 539, 94]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 77) * 7
        let token = "\u{65}\u{34}\u{32}\u{36}\u{35}\u{38}\u{66}\u{61}\u{34}\u{35}\u{38}\u{65}\u{37}\u{62}\u{31}\u{34}\u{63}\u{30}\u{64}\u{32}\u{61}\u{62}\u{32}\u{66}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

#Preview {
    NavigationView {
        NfWpekezXewNpoHEBIt(
            playlist: YxdUIQGhxKMxKzMYnmOS(
                id: "\u{45}\u{43}\u{36}\u{35}\u{41}\u{43}\u{4c}\u{35}\u{59}",
                title: "\u{32}\u{30}\u{32}\u{36}\u{5e74}\u{30}\u{38}\u{6708}\u{5b9a}\u{6863}\u{70ed}\u{95e8}\u{7535}\u{5f71}\u{63a8}\u{8350}",
                coverURL: "",
                headerBgImage: "",
                itemsCount: 40
            )
        )
    }
}



extension ZrEVQGoOzEsxLOv {
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        // source-obfuscator:padding:v1
        _ = Self.cHjtOBWtCHksEQgfH()

        value = min(value, nextValue())
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func cHjtOBWtCHksEQgfH() -> String {
        let values = [26, 29, 78, 43]
        let folded = values.map { ($0 * 3 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 26) * 3
        let token = "\u{36}\u{61}\u{35}\u{66}\u{62}\u{64}\u{30}\u{37}\u{39}\u{61}\u{62}\u{38}\u{61}\u{39}\u{37}\u{35}\u{30}\u{38}\u{65}\u{63}\u{37}\u{32}\u{30}\u{63}"
        let pieces = [token, String(score % 23)]
        switch width > 4 {
        case true:
            return pieces.joined(separator: "\u{2d}")
        case false:
            return pieces.joined()
        }
    }
}


extension NfWpekezXewNpoHEBIt {
    private func nLshAElckCRlq(
        containerWidth: CGFloat,
        containerHeight: CGFloat,
        safeTop: CGFloat
    ) -> some View {
        ScrollView {
            VStack(spacing: 0) {
                nDLgOSwNqdiGxa(width: containerWidth, safeTop: safeTop)

                gLWeiloEIFaM(
                    containerWidth: containerWidth,
                    isLandscape: containerWidth > containerHeight
                )
            }
        }
        .onPreferenceChange(ZrEVQGoOzEsxLOv.self) { headerBottom in
            
            let collapsed = headerBottom <= safeTop + barHeight

            
            
            if !collapsed {
                hasMeasuredHeader = true
            }

            guard hasMeasuredHeader, collapsed != isBarCollapsed else { return }

            withAnimation(.easeInOut(duration: 0.2)) {
                isBarCollapsed = collapsed
            }
        }
    }

    private func vEaKvxCSurMohcvdnPm(
        containerWidth: CGFloat,
        isLandscape: Bool
    ) -> some View {
        
        let layout = RwinbMlCQBfDPfx.hHguQxyzfQAhnvFW(
            containerWidth: containerWidth,
            isLandscape: isLandscape
        )

        return Group {
            LazyVGrid(columns: layout.columns, spacing: layout.rowSpacing) {
                ForEach(viewModel.items) { item in
                    OawsHVdaYNMQmC(
                        item: item,
                        xSLUGkvoolmZhuvwt: layout.xSLUGkvoolmZhuvwt
                    )
                    .task {
                        await viewModel.qEfkyEQMmVhijBWNiW(currentItem: item)
                    }
                }
            }
            .padding(.leading, layout.leadingPadding)
            .padding(.trailing, layout.trailingPadding)
            .padding(.top, 10)
            .padding(.bottom, 16)

            if viewModel.isLoadingMore {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
            }
        }
    }

    private var headerBottomReader: some View {
        GeometryReader { geometry in
            Color.clear.preference(
                key: ZrEVQGoOzEsxLOv.self,
                value: geometry.frame(in: .global).maxY
            )
        }
    }

    private var headerImageURL: String {
        playlist.headerBgImage.isEmpty ? playlist.coverURL : playlist.headerBgImage
    }

    private func vNrLrkvMVmZIeBavOR(safeTop: CGFloat) -> some View {
        HStack(spacing: 0) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{54}\u{6e}\u{63}\u{75}\u{74}\u{44}\u{65}\u{55}"))
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: barHeight, height: barHeight)
            }

            Spacer(minLength: 4)

            Text(playlist.title)
                .font(.system(size: 15, weight: .bold))
                .lineLimit(1)

            Spacer(minLength: 4)

            
            Color.clear
                .frame(width: barHeight, height: barHeight)
        }
        .foregroundColor(isBarCollapsed ? .primary : .white)
        .frame(height: barHeight)
        .padding(.top, safeTop)
        .background(barBackground)
    }

    @ViewBuilder
    private var barBackground: some View {
        if isBarCollapsed {
            VStack(spacing: 0) {
                Color(.systemBackground)
                Divider()
            }
        } else {
            Color.clear
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{51}\u{4d}\u{79}\u{41}\u{6f}\u{35}\u{52}\u{63}"))
                .font(.system(size: 36))
                .foregroundColor(.secondary)

            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{58}\u{33}\u{77}\u{37}\u{52}\u{51}\u{39}\u{54}"))
                .font(.headline)

            Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{35}\u{62}\u{74}\u{46}\u{43}\u{4c}\u{6d}\u{30}")) {
                Task { await viewModel.yGMvBnGFDWcUloceenha() }
            }
            .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 320)
    }
}
