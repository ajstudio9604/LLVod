






import SwiftUI

struct ZaVAewsOhzFEKeYU: View {

    let title: String
    let tab: LlGgqVbCItHWtVdKDJJ.Tab

    @StateObject private var manager = VtLaWtyuDAGv.shared
    @State private var playback: WslnzaAplxZpZ?

    var body: some View {
        List {
            ForEach(tasks) { task in
                zMJtlZkMbUQBrbBLh(task)
                    .swipeActions {
                        Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{67}\u{41}\u{45}\u{63}\u{4d}\u{48}\u{48}\u{73}"), role: .destructive) {
                            manager.oJVdWBtphiEb(task.id)
                        }
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        
        .ahFullscreen(item: $playback) { playback in
            GduwHCgAgYWAT(
                url: playback.url,
                title: playback.title,
                episodeTitle: playback.episodeTitle
            )
        }
        .ahHideTabBar()
    }

    

    

    

    @ViewBuilder
    private func jOgqBuFUIQsVVrwt(_ task: BuzGDNFYICiuDwSREHYV) -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.rTTrcjUPabqhWx()

        switch task.status {
        case .completed:
            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{6e}\u{64}\u{46}\u{4b}\u{75}\u{55}\u{50}\u{57}"))
                .font(.system(size: 22))
                .foregroundColor(.green)

        case .downloading, .pending:
            Button {
                manager.pKJqQZabvvKlPodAj(task.id)
            } label: {
                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{53}\u{6f}\u{42}\u{62}\u{32}\u{70}\u{41}\u{50}\u{51}"))
                    .font(.system(size: 22))
            }
            .buttonStyle(.plain)

        case .paused, .failed:
            Button {
                manager.bOXcvjqKWRDaUnJFcnj(task.id)
            } label: {
                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{41}\u{34}\u{6f}\u{57}\u{6f}\u{53}\u{75}\u{4c}\u{5a}"))
                    .font(.system(size: 22))
            }
            .buttonStyle(.plain)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func rTTrcjUPabqhWx() -> String {
        let token = "\u{34}\u{38}\u{30}\u{62}\u{34}\u{30}\u{61}\u{31}\u{37}\u{38}\u{61}\u{38}\u{66}\u{36}\u{62}\u{62}\u{36}\u{62}\u{62}\u{31}\u{31}\u{65}\u{30}\u{32}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{37}\u{34}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 74) * 6
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}



extension ZaVAewsOhzFEKeYU {
    private func qCclagFjHVqTIgVh(_ task: BuzGDNFYICiuDwSREHYV) -> String {
        if task.errorMessage != nil, task.status == .failed {
            return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{55}\u{44}\u{6a}\u{65}\u{64}\u{62}\u{76}\u{33}")
        }

        guard task.totalSegments > 0 else { return task.status.text }
        return "\(task.status.text) \(task.completedSegments)\u{2f}\(task.totalSegments)"
    }

    private var tasks: [BuzGDNFYICiuDwSREHYV] {
        manager.tasks.filter {
            guard $0.title == title else { return false }
            return tab == .completed ? $0.status == .completed : $0.status != .completed
        }
    }

    private func zMJtlZkMbUQBrbBLh(_ task: BuzGDNFYICiuDwSREHYV) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(task.subtitle)
                    .font(.system(size: 14, weight: .medium))
                    .lineLimit(1)

                if task.status == .completed {
                    Text(LlKdecruirFxhTQho.completed.text)
                        .font(.system(size: 12))
                        .foregroundColor(.green)
                } else {
                    ProgressView(value: task.progress)
                        .tint(.blue)

                    Text(qCclagFjHVqTIgVh(task))
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }

            Spacer(minLength: 0)

            jOgqBuFUIQsVVrwt(task)
        }
        .padding(.vertical, 6)
        .contentShape(Rectangle())
        .onTapGesture {
            guard task.status == .completed,
                  let url = manager.zRBjfffAUJxPKZexhDlM(for: task) else { return }
            playback = WslnzaAplxZpZ(
                url: url,
                title: task.title,
                episodeTitle: task.subtitle
            )
        }
    }
}
