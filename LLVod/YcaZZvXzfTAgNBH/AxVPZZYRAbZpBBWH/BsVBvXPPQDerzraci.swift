






import SwiftUI

struct AlGGPacYEqCQramum: View {

    @State private var records: [BujroaRaxIvHZD] = []
    @State private var showClearConfirm = false

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.dBQOjZzeskdsxig()

        Group {
            if records.isEmpty {
                ScrollView {
                    emptyState
                        .frame(maxWidth: .infinity, minHeight: 420)
                }
                .refreshable {
                    await xLkqOUyYVAazEnblFiM()
                }
            } else {
                List {
                    ForEach(records) { record in
                        mUrkAtFjwaxPayHXk(record)
                            .swipeActions {
                                Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{67}\u{41}\u{45}\u{63}\u{4d}\u{48}\u{48}\u{73}"), role: .destructive) {
                                    yCLiXJltJMPDjqoddGo(record)
                                }
                            }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await xLkqOUyYVAazEnblFiM()
                }
            }
        }
        .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{46}\u{65}\u{61}\u{79}\u{59}\u{49}\u{50}\u{30}"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showClearConfirm = true
                } label: {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{6b}\u{79}\u{6b}\u{6c}\u{74}\u{49}\u{33}\u{58}"))
                }
                .disabled(records.isEmpty)
            }
        }
        .confirmationDialog(
            AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{37}\u{68}\u{39}\u{55}\u{6a}\u{6e}\u{35}\u{6f}\u{6f}"),
            isPresented: $showClearConfirm,
            titleVisibility: .visible
        ) {
            Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{41}\u{4a}\u{7a}\u{6c}\u{78}\u{61}\u{70}\u{68}"), role: .destructive) {
                VpsTjWCCHlvCyDErLHD.cCIOUpggoqrbtCjzLoXy()
                records = []
            }
            Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{72}\u{65}\u{6d}\u{58}\u{42}\u{69}\u{55}\u{6b}"), role: .cancel) {}
        }
        .onAppear(perform: vJhoAKbxZQijN)
        .onReceive(NotificationCenter.default.publisher(for: .ahYunCloudDidMerge)) { _ in
            vJhoAKbxZQijN()
        }
        .onReceive(NotificationCenter.default.publisher(for: .ahVodPlayRecordDidChange)) { _ in
            vJhoAKbxZQijN()
        }
        .ahHideTabBar()
    }

    

    

    

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{36}\u{51}\u{34}\u{65}\u{4d}\u{37}\u{31}\u{7a}"))
                .font(.system(size: 34))
                .foregroundColor(.secondary)

            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{41}\u{41}\u{35}\u{69}\u{39}\u{75}\u{47}\u{6a}"))
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func dBQOjZzeskdsxig() -> String {
        _ = Self.fRpNETnjZdxYwEz()
        let token = "\u{61}\u{62}\u{30}\u{37}\u{37}\u{66}\u{66}\u{39}\u{30}\u{62}\u{30}\u{34}\u{37}\u{66}\u{64}\u{64}\u{62}\u{30}\u{32}\u{61}\u{30}\u{65}\u{38}\u{30}"
        let base = (74 * 6 + 19) % 997
        let width = (base) % 17
        let score = (width + 74) * 6
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func fRpNETnjZdxYwEz() -> String {
        let token = "\u{66}\u{31}\u{34}\u{30}\u{65}\u{39}\u{31}\u{62}\u{39}\u{31}\u{37}\u{34}\u{34}\u{63}\u{36}\u{32}\u{31}\u{63}\u{63}\u{37}\u{66}\u{65}\u{64}\u{32}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 93, "\u{65}\u{61}\u{73}\u{74}": 101, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 744]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 93) * 8
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



extension AlGGPacYEqCQramum {
    private func xLkqOUyYVAazEnblFiM() async {
        await QoHoDspsGYUdeDIUYRh.zBMRnbLmKJgTfUQtw()
        vJhoAKbxZQijN()
    }

    private func yCLiXJltJMPDjqoddGo(_ record: BujroaRaxIvHZD) {
        VpsTjWCCHlvCyDErLHD.iJasuwRgIhIVBYkIPfbZ(record)
        records.removeAll { $0.id == record.id }
    }

    private func kKaCmVbFCRbVzeen(_ record: BujroaRaxIvHZD) -> some View {
        EtXjBLbNYUbhXfeKeH(url: URL(string: record.pic))
            .frame(width: 104, height: 64)
            .background(Color(.tertiarySystemFill))
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(alignment: .bottomTrailing) {
                if record.position > 0 {
                    Text(JnMIqllTuKLJ.xDZceddEGapRxrlKR(record.position))
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color.black.opacity(0.6))
                        )
                        .padding(4)
                }
            }
    }

    private func mUrkAtFjwaxPayHXk(_ record: BujroaRaxIvHZD) -> some View {
        NavigationLink {
            GsJOCBdoNInHfKqMeUj(route: record.route, resumeRecord: record)
        } label: {
            HStack(spacing: 12) {
                kKaCmVbFCRbVzeen(record)

                VStack(alignment: .leading, spacing: 6) {
                    Text(record.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    if !record.sourceName.isEmpty {
                        HStack(spacing: 3) {
                            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{30}\u{58}\u{56}\u{62}\u{76}\u{33}\u{57}\u{52}"))
                                .font(.system(size: 10))
                                .foregroundColor(.orange)

                            Text(record.sourceName)
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                        }
                    }

                    if !record.episodeTitle.isEmpty {
                        Text("\u{89c2}\u{770b}\u{81f3}\u{ff1a}\(record.episodeTitle)")
                            .font(.system(size: 12))
                            .foregroundColor(.green)
                            .lineLimit(1)
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(.vertical, 4)
        }
    }

    private func vJhoAKbxZQijN() {
        records = VpsTjWCCHlvCyDErLHD.cYyLErIbRxSxfOj()
    }
}
