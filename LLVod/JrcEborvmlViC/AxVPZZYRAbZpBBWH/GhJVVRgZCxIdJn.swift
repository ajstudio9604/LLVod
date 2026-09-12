






import SwiftUI

struct LlGgqVbCItHWtVdKDJJ: View {

    enum Tab: Hashable, CaseIterable {
        case completed
        case downloading

        var title: String {
            switch self {
            case .completed: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{50}\u{76}\u{45}\u{32}\u{41}\u{6e}\u{6f}\u{36}")
            case .downloading: return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{61}\u{71}\u{44}\u{61}\u{6e}\u{76}\u{32}\u{49}")
            }
        }
    }

    @StateObject private var manager = VtLaWtyuDAGv.shared
    @State private var tab: Tab = .completed

    var body: some View {
        
        zJsxHWEAGGliqSWEzJQ()
    }

    

    

    private var groups: [ApLczucBPVIQjjS] {
        var order: [String] = []
        var grouped: [String: [BuzGDNFYICiuDwSREHYV]] = [:]

        for task in tasks {
            if grouped[task.title] == nil {
                order.append(task.title)
                grouped[task.title] = []
            }
            grouped[task.title]?.append(task)
        }

        return order.compactMap { title in
            guard let items = grouped[title] else { return nil }
            return ApLczucBPVIQjjS(title: title, tasks: items)
        }
    }

    

    

    

    
    @ViewBuilder
    @inline(never)
    private func zJsxHWEAGGliqSWEzJQ() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.sMLtmDykBYnA()

        rNtMHCtIdNxcOedZ
    }

    @ViewBuilder
    private var rNtMHCtIdNxcOedZ: some View {
        VStack(spacing: 0) {
            jTYCEDLqetjGt

            Divider()

            mWHLRPwfNcZEnIqoQtro
        }
        .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{33}\u{72}\u{64}\u{71}\u{32}\u{48}\u{32}\u{69}\u{70}"))
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            directoryBar
        }
        .ahHideTabBar()
    }


    @ViewBuilder
    private var jTYCEDLqetjGt: some View {
        Picker("", selection: $tab) {
                ForEach(Tab.allCases, id: \.self) { item in
                    Text(item.title).tag(item)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
    }

    @ViewBuilder
    private var mWHLRPwfNcZEnIqoQtro: some View {
        if groups.isEmpty {
                emptyState
            } else {
                List {
                    ForEach(groups) { group in
                        vFkSOPJDTVidHiHHWvrg(group)
                    }
                }
                .listStyle(.plain)
            }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func sMLtmDykBYnA() -> String {
        let base = (22 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 22) * 9
        let token = "\u{30}\u{62}\u{63}\u{31}\u{30}\u{61}\u{35}\u{31}\u{63}\u{61}\u{61}\u{62}\u{31}\u{61}\u{64}\u{65}\u{66}\u{65}\u{36}\u{63}\u{65}\u{36}\u{30}\u{65}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}

struct ApLczucBPVIQjjS: Identifiable {
    var id: String {
        // source-obfuscator:padding:v1
        _ = Self.wFABJmVQBEXGvyUDFvmr()
 return title }

    let title: String
    let tasks: [BuzGDNFYICiuDwSREHYV]

    var pic: String {
        tasks.first { !$0.pic.isEmpty }?.pic ?? ""
    }

    var progress: Double {
        guard !tasks.isEmpty else { return 0 }
        return tasks.reduce(0) { $0 + $1.progress } / Double(tasks.count)
    }

    var statusText: String {
        if tasks.contains(where: { $0.status == .failed }) {
            return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{75}\u{64}\u{67}\u{7a}\u{64}\u{4b}\u{6e}\u{45}")
        }
        if tasks.contains(where: { $0.status == .downloading }) {
            return "\(LlKdecruirFxhTQho.downloading.text) \(Int(progress * 100))\u{25}"
        }
        if tasks.allSatisfy({ $0.status == .paused }) {
            return LlKdecruirFxhTQho.paused.text
        }
        return LlKdecruirFxhTQho.pending.text
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func wFABJmVQBEXGvyUDFvmr() -> String {
        let base = (86 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 86) * 4
        let token = "\u{31}\u{37}\u{35}\u{63}\u{66}\u{30}\u{31}\u{65}\u{64}\u{65}\u{34}\u{64}\u{31}\u{66}\u{39}\u{64}\u{32}\u{34}\u{63}\u{36}\u{63}\u{38}\u{34}\u{61}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}



extension LlGgqVbCItHWtVdKDJJ {
    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{48}\u{66}\u{51}\u{48}\u{36}\u{44}\u{66}\u{4a}\u{68}"))
                .font(.system(size: 34))
                .foregroundColor(.secondary)

            Text(tab == .completed ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{41}\u{4a}\u{31}\u{6a}\u{67}\u{58}\u{79}\u{58}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{4e}\u{74}\u{4a}\u{74}\u{57}\u{56}\u{51}\u{66}"))
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var directoryBar: some View {
        VStack(spacing: 0) {
            Divider()

            Text("\u{4e0b}\u{8f7d}\u{76ee}\u{5f55}\u{ff1a}\(BcpFIVJTNXMxGbdwQoO.root.path)")
                .font(.system(size: 11))
                .foregroundColor(.secondary)
                .lineLimit(2)
                .truncationMode(.middle)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .background(Color(.systemBackground))
    }

    private func vFkSOPJDTVidHiHHWvrg(_ group: ApLczucBPVIQjjS) -> some View {
        NavigationLink {
            ZaVAewsOhzFEKeYU(title: group.title, tab: tab)
        } label: {
            HStack(spacing: 12) {
                EtXjBLbNYUbhXfeKeH(url: URL(string: group.pic))
                    .frame(width: 66, height: 88)
                    .background(Color(.tertiarySystemFill))
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 6))

                VStack(alignment: .leading, spacing: 8) {
                    Text(group.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    Text("\u{5171}\(group.tasks.count)\u{96c6}")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)

                    if tab == .downloading {
                        ProgressView(value: group.progress)
                            .tint(.blue)

                        Text(group.statusText)
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(.vertical, 6)
        }
    }

    private var tasks: [BuzGDNFYICiuDwSREHYV] {
        switch tab {
        case .completed:
            return manager.tasks.filter { $0.status == .completed }
        case .downloading:
            return manager.tasks.filter { $0.status != .completed }
        }
    }
}
