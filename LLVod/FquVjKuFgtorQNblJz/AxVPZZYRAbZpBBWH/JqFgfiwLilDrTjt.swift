






import SwiftUI

struct IuzCapPBFfSecd: View {

    @StateObject private var viewModel = MwtIJArzcKlYsWOZmGX()
    @State private var showClearConfirm = false

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.cXRoKNnPRTAVzHs()

        Group {
            if viewModel.records.isEmpty {
                ScrollView {
                    emptyState
                        .frame(maxWidth: .infinity, minHeight: 420)
                }
                .refreshable {
                    await viewModel.xLkqOUyYVAazEnblFiM()
                }
            } else {
                List {
                    ForEach(viewModel.records) { record in
                        jFxuGxPalwVOZTkzvY(record)
                            .swipeActions {
                                Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{67}\u{41}\u{45}\u{63}\u{4d}\u{48}\u{48}\u{73}"), role: .destructive) {
                                    viewModel.oWKzczPjNSOgsc(record)
                                }
                            }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await viewModel.xLkqOUyYVAazEnblFiM()
                }
            }
        }
        .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{47}\u{6f}\u{74}\u{76}\u{72}\u{44}\u{6a}\u{32}"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showClearConfirm = true
                } label: {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{6b}\u{79}\u{6b}\u{6c}\u{74}\u{49}\u{33}\u{58}"))
                }
                .disabled(viewModel.records.isEmpty)
            }
        }
        .confirmationDialog(
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{78}\u{4e}\u{30}\u{5a}\u{41}\u{6e}\u{71}\u{64}"),
            isPresented: $showClearConfirm,
            titleVisibility: .visible
        ) {
            Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{41}\u{4a}\u{7a}\u{6c}\u{78}\u{61}\u{70}\u{68}"), role: .destructive) {
                viewModel.oEnPBtPyHwCHzUMmao()
            }
            Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{72}\u{65}\u{6d}\u{58}\u{42}\u{69}\u{55}\u{6b}"), role: .cancel) {}
        }
        .onAppear(perform: viewModel.mSRzzyEYfDoNlWGcNQj)
        .onReceive(NotificationCenter.default.publisher(for: .ahVodFavoriteDidChange)) { _ in
            viewModel.mSRzzyEYfDoNlWGcNQj()
        }
        .onReceive(NotificationCenter.default.publisher(for: .ahYunCloudDidMerge)) { _ in
            viewModel.mSRzzyEYfDoNlWGcNQj()
        }
        .ahHideTabBar()
    }

    

    


    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func cXRoKNnPRTAVzHs() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 53, "\u{65}\u{61}\u{73}\u{74}": 61, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 424]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 53) * 8
        let token = "\u{32}\u{39}\u{66}\u{65}\u{65}\u{34}\u{61}\u{38}\u{62}\u{66}\u{62}\u{62}\u{38}\u{39}\u{64}\u{36}\u{63}\u{62}\u{35}\u{62}\u{37}\u{32}\u{31}\u{33}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}



extension IuzCapPBFfSecd {
    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{4e}\u{38}\u{6b}\u{61}\u{6a}\u{4b}\u{4a}\u{71}"))
                .font(.system(size: 36))
                .foregroundColor(.secondary)
            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{6e}\u{47}\u{4c}\u{4a}\u{67}\u{5a}\u{49}\u{6d}"))
                .font(.headline)
            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{55}\u{67}\u{78}\u{64}\u{55}\u{62}\u{35}\u{76}"))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func jFxuGxPalwVOZTkzvY(_ record: OdvEclAbLCCnVQ) -> some View {
        NavigationLink {
            GsJOCBdoNInHfKqMeUj(route: record.route)
        } label: {
            HStack(spacing: 12) {
                EtXjBLbNYUbhXfeKeH(url: URL(string: record.pic))
                    .frame(width: 56, height: 78)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .background(Color.gray.opacity(0.08))

                VStack(alignment: .leading, spacing: 6) {
                    Text(record.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(2)

                    if !record.sourceName.isEmpty {
                        Text(record.sourceName)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(.vertical, 4)
        }
    }
}
