







import SwiftUI
import AVKit

struct OwmOcioMOhpdNlAn: View {

    let title: String
    let videoURL: String

    @Environment(\.dismiss) private var dismiss
    @StateObject private var searcher = GxLNiTSFFttFzE()
    @State private var toast: String?
    @State private var castingName: String?

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.eSOGayfhXsYGTJPPygP()

        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    airPlaySection
                    dlnaSection
                    helpCard
                    troubleCard
                }
                .padding(16)
                .padding(.bottom, 24)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{31}\u{50}\u{4e}\u{37}\u{31}\u{64}\u{53}\u{4d}"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{6a}\u{77}\u{42}\u{70}\u{64}\u{77}\u{6c}\u{70}")) { dismiss() }
                }
            }
            .overlay(alignment: .bottom) {
                if let toast {
                    Text(toast)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.black.opacity(0.78))
                        .cornerRadius(8)
                        .padding(.bottom, 24)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear { searcher.start() }
        .onDisappear { searcher.iHmynqYkTljlgUbv() }
    }

    

    

    private var helpCard: some View {
        sVEMXrsOdvLvOLOjVJ(
            title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{79}\u{37}\u{49}\u{73}\u{71}\u{64}\u{47}\u{57}"),
            body: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{68}\u{6e}\u{65}\u{7a}\u{46}\u{43}\u{77}\u{47}")
        )
    }

    

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func eSOGayfhXsYGTJPPygP() -> String {
        let token = "\u{36}\u{34}\u{38}\u{66}\u{37}\u{31}\u{37}\u{66}\u{63}\u{62}\u{33}\u{33}\u{38}\u{63}\u{34}\u{34}\u{38}\u{31}\u{34}\u{37}\u{36}\u{61}\u{30}\u{30}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 94, "\u{65}\u{61}\u{73}\u{74}": 100, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 564]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 94) * 6
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

struct GfxWQZDjmtpuiBhQ: View {

    @ObservedObject var viewModel: JnMIqllTuKLJ
    var square: Bool = false

    @State private var showSheet = false

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.jDcLjBLVpEdHIhnk()

        Button {
            viewModel.uLwHRkCOHkdcio()
            showSheet = true
        } label: {
            ZStack {
                if square {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 44, height: 44)
                } else {
                    Circle()
                        .fill(Color.black.opacity(0.4))
                        .frame(width: 36, height: 36)
                }

                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{75}\u{41}\u{54}\u{7a}\u{50}\u{72}\u{53}\u{65}"))
                    .font(.system(size: square ? 16 : 14, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showSheet) {
            OwmOcioMOhpdNlAn(
                title: castTitle,
                videoURL: viewModel.currentPlayURL
            )
        }
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func jDcLjBLVpEdHIhnk() -> String {
        let token = "\u{30}\u{35}\u{37}\u{30}\u{64}\u{37}\u{62}\u{33}\u{31}\u{65}\u{37}\u{33}\u{63}\u{35}\u{35}\u{64}\u{38}\u{61}\u{37}\u{61}\u{36}\u{34}\u{39}\u{38}"
        let values = [55, 60, 275, 72]
        let folded = values.map { ($0 * 5 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 55) * 5
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension OwmOcioMOhpdNlAn {
    private var troubleCard: some View {
        sVEMXrsOdvLvOLOjVJ(
            title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{52}\u{35}\u{50}\u{4f}\u{52}\u{72}\u{48}\u{52}"),
            body: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{55}\u{63}\u{32}\u{54}\u{76}\u{67}\u{7a}\u{45}")
        )
    }

    private func jZQLKloedGEfPH(to device: FdlUJqWMcQTOI) async {
        let url = videoURL.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !url.isEmpty else {
            oHgbysswQVGKPrVmN(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{4f}\u{49}\u{34}\u{4f}\u{68}\u{64}\u{46}\u{67}"))
            return
        }
        if MmFhbrLqPylfz.yDULAPGplPIQSewvhMuf(url) || url.hasPrefix(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{50}\u{31}\u{4d}\u{32}\u{4e}\u{6b}\u{34}\u{77}")) {
            oHgbysswQVGKPrVmN(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{77}\u{32}\u{52}\u{53}\u{65}\u{79}\u{62}\u{7a}"))
            return
        }

        castingName = device.name
        let error = await searcher.kHOJnVbHlQVRXxNou(to: device, url: url, title: title)
        castingName = nil

        if let error {
            oHgbysswQVGKPrVmN(error)
        } else {
            oHgbysswQVGKPrVmN("\u{5df2}\u{6295}\u{5c4f}\u{5230} \(device.name)")
        }
    }

    private func oHgbysswQVGKPrVmN(_ text: String) {
        withAnimation { toast = text }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                if toast == text { toast = nil }
            }
        }
    }

    private var airPlaySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4c}\u{62}\u{71}\u{61}\u{4f}\u{76}\u{73}\u{46}\u{30}"))
                .font(.system(size: 14, weight: .bold))

            HStack(spacing: 12) {
                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{75}\u{41}\u{54}\u{7a}\u{50}\u{72}\u{53}\u{65}"))
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                    .frame(width: 28)

                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{54}\u{77}\u{66}\u{70}\u{45}\u{78}\u{38}\u{6a}"))
                    .font(.system(size: 14, weight: .medium))

                Spacer()

                TjYNRlbUDwKHwnxHx(
                    tintColor: .label,
                    activeTintColor: .systemGreen
                )
                .frame(width: 36, height: 36)
            }
            .padding(.horizontal, 14)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemBackground))
            )
        }
    }

    private var dlnaSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{78}\u{6d}\u{35}\u{55}\u{65}\u{48}\u{68}\u{6b}"))
                    .font(.system(size: 14, weight: .bold))

                if searcher.isSearching {
                    ProgressView()
                        .scaleEffect(0.7)
                }
            }

            if searcher.devices.isEmpty {
                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{71}\u{56}\u{53}\u{6c}\u{4d}\u{6f}\u{52}\u{35}"))
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
            } else {
                VStack(spacing: 0) {
                    ForEach(searcher.devices) { device in
                        Button {
                            Task { await jZQLKloedGEfPH(to: device) }
                        } label: {
                            HStack {
                                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{46}\u{62}\u{71}\u{77}\u{48}\u{7a}\u{63}\u{64}"))
                                    .foregroundColor(.primary)
                                Text(device.name)
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                                Spacer()
                                if castingName == device.name {
                                    ProgressView()
                                        .scaleEffect(0.8)
                                } else {
                                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{6b}\u{71}\u{39}\u{45}\u{73}\u{6e}\u{7a}\u{4a}"))
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.horizontal, 14)
                            .frame(height: 48)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .disabled(castingName != nil)

                        if device.id != searcher.devices.last?.id {
                            Divider().padding(.leading, 48)
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemBackground))
                )
            }
        }
    }

    private func sVEMXrsOdvLvOLOjVJ(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
            Text(body)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.secondarySystemBackground))
        )
    }
}


extension GfxWQZDjmtpuiBhQ {
    private var castTitle: String {
        var parts: [String] = []
        if let name = viewModel.vodName, !name.isEmpty { parts.append(name) }
        if let episode = viewModel.currentEpisodeName, !episode.isEmpty { parts.append(episode) }
        return parts.isEmpty ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{57}\u{37}\u{71}\u{74}\u{36}\u{77}\u{55}\u{53}\u{43}") : parts.joined(separator: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{35}\u{76}\u{70}\u{72}\u{5a}\u{76}\u{30}\u{30}"))
    }
}
