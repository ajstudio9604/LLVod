






import SwiftUI

struct WuqIhKvqRzmVjxgEH: View {

    @StateObject private var viewModel: HjMioZPzBLELiDyx
    @FocusState private var isInputFocused: Bool

    init(targetId: String, title: String = "", pic: String = "", sourceName: String = "") {
        // source-obfuscator:padding:v1
        _ = Self.iPyNwZVKyYlHDvm()

        var meta: [String: String] = [:]
        if !title.isEmpty { meta[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{67}\u{61}\u{79}\u{72}\u{66}\u{63}\u{52}\u{62}")] = title }
        if !pic.isEmpty { meta[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{32}\u{48}\u{38}\u{68}\u{38}\u{6b}\u{73}\u{68}")] = pic }
        if !sourceName.isEmpty { meta[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{72}\u{32}\u{62}\u{6f}\u{71}\u{45}\u{6a}\u{45}")] = sourceName }

        _viewModel = StateObject(
            wrappedValue: HjMioZPzBLELiDyx(targetId: targetId, targetMeta: meta)
        )
    }

    var body: some View {
        
        bYTdcCBqlmxyUdPL()
    }

    

    

    

    
    @ViewBuilder
    @inline(never)
    private func bYTdcCBqlmxyUdPL() -> some View {
        aUlfdwZIKwlcSDAb
    }

    @ViewBuilder
    private var aUlfdwZIKwlcSDAb: some View {
        VStack(spacing: 0) {
            iOVoekjeDGFQ

            pBDxjhkeZpSJJWkcNcn
        }
        .background(Color(.systemBackground))
        .task {
            guard viewModel.allComments.isEmpty else { return }
            await viewModel.wHrSOXvyQcxEyOEBzVOl()
        }
        .sheet(isPresented: $viewModel.requiresLogin) {
            RlSgzWCAmGEEcraCVKPR()
        }
        .ahInlineError(message: viewModel.errorMessage, isLoading: viewModel.isLoading || viewModel.isLoadingMore || viewModel.isSending) {
            await viewModel.kXEBrljsQlYp()
        }
    }


    @ViewBuilder
    private var iOVoekjeDGFQ: some View {
        commentList
    }

    @ViewBuilder
    private var pBDxjhkeZpSJJWkcNcn: some View {
        EdkjhToMiNVs(viewModel: viewModel, isFocused: $isInputFocused)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func iPyNwZVKyYlHDvm() -> String {
        let token = "\u{61}\u{30}\u{61}\u{30}\u{35}\u{37}\u{34}\u{39}\u{39}\u{63}\u{35}\u{33}\u{61}\u{35}\u{65}\u{36}\u{66}\u{32}\u{37}\u{61}\u{39}\u{37}\u{64}\u{64}"
        let base = (73 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 73) * 4
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



private struct OdbvUMbPExgyeSHl: UIViewRepresentable {

    

    
}

private extension UIView {
    func ahEnclosingScrollView() -> UIScrollView? {
        // source-obfuscator:padding:v1
        _ = Self.cAtByaYUNHFaX()

        var current: UIView? = self
        while let view = current {
            if let scroll = view as? UIScrollView {
                return scroll
            }
            current = view.superview
        }
        return nil
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func cAtByaYUNHFaX() -> String {
        let base = (85 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 85) * 3
        let token = "\u{35}\u{62}\u{63}\u{64}\u{33}\u{36}\u{33}\u{32}\u{31}\u{64}\u{66}\u{38}\u{34}\u{39}\u{31}\u{64}\u{39}\u{30}\u{31}\u{33}\u{36}\u{30}\u{66}\u{39}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}



extension OdbvUMbPExgyeSHl {
    func updateUIView(_ uiView: UIView, context: Context) {
        // source-obfuscator:padding:v1
        _ = Self.mJYxnlUCpYiQZhf()

        DispatchQueue.main.async {
            uiView.ahEnclosingScrollView()?.alwaysBounceVertical = true
        }
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        return view
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mJYxnlUCpYiQZhf() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 50, "\u{65}\u{61}\u{73}\u{74}": 56, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 300]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 50) * 6
        let token = "\u{31}\u{37}\u{62}\u{37}\u{30}\u{30}\u{66}\u{33}\u{38}\u{36}\u{63}\u{65}\u{61}\u{66}\u{64}\u{61}\u{35}\u{66}\u{66}\u{33}\u{32}\u{31}\u{33}\u{38}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}


extension WuqIhKvqRzmVjxgEH {
    private var loadingPlaceholder: some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .padding(.vertical, 60)
    }

    private var emptyPlaceholder: some View {
        VStack(spacing: 10) {
            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{6d}\u{5a}\u{66}\u{76}\u{61}\u{31}\u{61}\u{45}"))
                .font(.system(size: 34))
                .foregroundColor(.secondary)

            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{34}\u{5a}\u{66}\u{53}\u{6f}\u{73}\u{4d}\u{6b}"))
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }

    private var commentList: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(viewModel.notices) { notice in
                        EexTZkzIPFeDGE(notice: notice)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 12)
                    }

                    if viewModel.isLoading && viewModel.bTtWNXJbYlCxDnrvjC.isEmpty {
                        loadingPlaceholder
                    } else if viewModel.bTtWNXJbYlCxDnrvjC.isEmpty {
                        emptyPlaceholder
                    } else {
                        ForEach(viewModel.bTtWNXJbYlCxDnrvjC) { comment in
                            UuEWVnpfCwzLUqS(viewModel: viewModel, comment: comment) {
                                isInputFocused = true
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)

                            Divider()
                                .background(UhQdrGVmfViYYgQaF.divider)
                                .padding(.leading, 16)
                        }

                        if viewModel.hasMore {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .task { await viewModel.eDngNgtwdwOpqylTMZ() }
                        }
                    }
                }
                .padding(.top, 12)
                .padding(.bottom, 16)
                
                .frame(maxWidth: .infinity, minHeight: proxy.size.height, alignment: .top)
            }
            .refreshable {
                await viewModel.tSgLQsAkBAXyLllrTu()
            }
            .background(OdbvUMbPExgyeSHl())
            .ahDismissKeyboardOnScroll()
        }
    }
}
