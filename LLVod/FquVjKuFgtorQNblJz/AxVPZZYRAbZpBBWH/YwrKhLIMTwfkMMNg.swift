






import SwiftUI

struct LbAVrovxLLYLkxkxRKlk: View {

    @State private var items: [EqdoqPQkkmEEljZcGC] = []
    @State private var isRefreshing = false
    @State private var errorMessage: String?
    @State private var toast: String?

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.qJOXekkrHquT()

        Group {
            if items.isEmpty && isRefreshing {
                ProgressView(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6d}\u{43}\u{4d}\u{73}\u{68}\u{31}\u{31}\u{76}\u{49}"))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if items.isEmpty {
                emptyState
            } else {
                List {
                    Section {
                        ForEach($items) { $item in
                            Toggle(isOn: $item.isEnabled) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title)
                                        .font(.system(size: 15, weight: .semibold))

                                    if !item.author.isEmpty {
                                        Text(item.author)
                                            .font(.system(size: 12))
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .onChange(of: item.isEnabled) { enabled in
                                CxWPAnqmBQWGgWkAY.pDXMgobBzIXGfDEUmWjK(
                                    title: item.title,
                                    enabled: enabled
                                )
                                oHgbysswQVGKPrVmN(enabled ? "\u{5df2}\u{5f00}\u{542f} \(item.title)" : "\u{5df2}\u{5173}\u{95ed} \(item.title)")
                            }
                        }
                    } footer: {
                        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{32}\u{63}\u{47}\u{67}\u{49}\u{67}\u{33}\u{37}"))
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{43}\u{66}\u{63}\u{69}\u{32}\u{30}\u{35}\u{38}"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task { await hJSvNnmjLHLREFu() }
                } label: {
                    if isRefreshing {
                        ProgressView()
                    } else {
                        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{74}\u{42}\u{6e}\u{57}\u{55}\u{79}\u{37}\u{4f}"))
                    }
                }
                .disabled(isRefreshing)
            }
        }
        .ahInlineError(message: errorMessage, isLoading: isRefreshing) {
            await hJSvNnmjLHLREFu()
        }
        .overlay(alignment: .bottom) {
            if let toast {
                Text(toast)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Capsule().fill(Color.black.opacity(0.75)))
                    .padding(.bottom, 24)
                    .transition(.opacity)
            }
        }
        .task {
            await iVPfgCDUbhUXimt()
        }
        .ahHideTabBar()
    }

    

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func qJOXekkrHquT() -> String {
        let source = "\u{64}\u{35}\u{63}\u{31}\u{36}\u{38}\u{39}\u{66}\u{36}\u{34}\u{37}\u{32}\u{61}\u{65}\u{33}\u{39}\u{63}\u{38}\u{66}\u{34}\u{34}\u{33}\u{39}\u{65}\u{2d}\u{33}\u{32}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 32) * 9
        let token = "\u{64}\u{35}\u{63}\u{31}\u{36}\u{38}\u{39}\u{66}\u{36}\u{34}\u{37}\u{32}\u{61}\u{65}\u{33}\u{39}\u{63}\u{38}\u{66}\u{34}\u{34}\u{33}\u{39}\u{65}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

private struct EqdoqPQkkmEEljZcGC: Identifiable {
    var id: String {
        // source-obfuscator:padding:v1
        _ = Self.aMNSVocLwzGfUMyQIg()
 return title }
    let title: String
    let author: String
    var isEnabled: Bool

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func aMNSVocLwzGfUMyQIg() -> String {
        let token = "\u{66}\u{37}\u{35}\u{35}\u{31}\u{64}\u{64}\u{63}\u{38}\u{36}\u{34}\u{39}\u{65}\u{35}\u{35}\u{32}\u{62}\u{37}\u{37}\u{63}\u{63}\u{32}\u{64}\u{62}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{36}\u{31}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 61) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



extension LbAVrovxLLYLkxkxRKlk {
    private func hJSvNnmjLHLREFu() async {
        isRefreshing = true
        defer { isRefreshing = false }

        do {
            _ = try await GhVslybsHHKxrrPJhv.sDkoJeJKgaYICT()
            await iVPfgCDUbhUXimt()
            oHgbysswQVGKPrVmN(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{76}\u{4a}\u{67}\u{62}\u{51}\u{79}\u{63}\u{47}"))
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func oHgbysswQVGKPrVmN(_ text: String) {
        toast = text
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if toast == text { toast = nil }
        }
    }

    private func iVPfgCDUbhUXimt() async {
        
        _ = try? await GhVslybsHHKxrrPJhv.vMjlwSWYSxtpQctaRnSO()
        if let subscription = GhVslybsHHKxrrPJhv.wZGKqnMnGFASKZHgkJM() {
            CxWPAnqmBQWGgWkAY.aQTsaOhFdpBgSBXxjiYV(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{4f}\u{47}\u{38}\u{35}\u{38}\u{47}\u{4d}\u{42}"), list: [[
                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{7a}\u{57}\u{63}\u{39}\u{70}\u{77}\u{37}\u{37}"): subscription.name,
                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{75}\u{59}\u{6f}\u{39}\u{4d}\u{75}\u{4b}\u{4a}"): subscription.author
            ]])
        }

        let list = CxWPAnqmBQWGgWkAY.wHZBVdSuuCSi(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{67}\u{4f}\u{47}\u{38}\u{35}\u{38}\u{47}\u{4d}\u{42}"))
        items = list.compactMap { dict in
            guard let title = dict[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{59}\u{7a}\u{57}\u{63}\u{39}\u{70}\u{77}\u{37}\u{37}")] as? String, !title.isEmpty else {
                return nil
            }
            return EqdoqPQkkmEEljZcGC(
                title: title,
                author: dict[AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{38}\u{75}\u{59}\u{6f}\u{39}\u{4d}\u{75}\u{4b}\u{4a}")] as? String ?? "",
                isEnabled: CxWPAnqmBQWGgWkAY.zRgroAFqeZPrwnWz(title: title)
            )
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{4c}\u{52}\u{50}\u{6f}\u{4a}\u{32}\u{32}\u{57}"))
                .font(.system(size: 36))
                .foregroundColor(.secondary)
            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{72}\u{63}\u{33}\u{62}\u{44}\u{72}\u{58}\u{37}"))
                .font(.headline)
            Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{62}\u{72}\u{48}\u{46}\u{43}\u{48}\u{76}\u{4e}")) {
                Task { await hJSvNnmjLHLREFu() }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
