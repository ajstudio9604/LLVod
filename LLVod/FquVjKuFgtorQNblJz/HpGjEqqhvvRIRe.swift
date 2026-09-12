






import SwiftUI

struct UswfVlIylKVJmgOnqrP: View {

    @ObservedObject private var auth = NvCczyBSOghG.shared
    @ObservedObject private var appConfig = KxKjCCiFrdtCTwJh.shared
    @ObservedObject private var downloadManager = VtLaWtyuDAGv.shared
    @EnvironmentObject private var themeManager: CbyiPVoRONUJO

    @StateObject private var dashboard = UwjMrioxegABN()
    @State private var showLogin = false
    @State private var showAccount = false
    @State private var showJoinUs = false
    @State private var shareItem: UbgpmyeixVTwzjLUu?
    @State private var bottomInset: CGFloat = 0

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    userHeader
                        .padding(.top, 8)

                    statsRow
                        .padding(.horizontal, 16)
                        .padding(.top, 18)

                    dASsNlQHMbOFTTkbTVX(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{70}\u{47}\u{6e}\u{44}\u{6b}\u{65}\u{35}\u{51}"))
                        .padding(.horizontal, 15)
                        .padding(.top, 20)

                    menuCard
                        .padding(.horizontal, 15)
                        .padding(.top, 8)
                        .padding(.bottom, gLYARkqVpIreHVTq + 24)
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .ahTabRootIgnoreBottomSafeAreaIfNeeded()
            .refreshable {
                await dashboard.pSxnZiMJYzMzVeneE(auth: auth)
            }
            .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{37}\u{46}\u{69}\u{6c}\u{45}\u{66}\u{4c}\u{45}\u{38}"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        MsnWYgNQvCobBfvI()
                    } label: {
                        Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{78}\u{33}\u{46}\u{43}\u{32}\u{6f}\u{4f}\u{65}\u{78}"))
                    }
                }
            }
            .sheet(isPresented: $showLogin) {
                RlSgzWCAmGEEcraCVKPR()
            }
            .sheet(isPresented: $showAccount) {
                ZvImKTgihBICNfI()
            }
            .sheet(isPresented: $showJoinUs) {
                MfNftjWZkgXxeMIE()
            }
            .sheet(item: $shareItem) { item in
                FeRnqrmGJsspQCDWqx(item: item)
            }
            .onAppear(perform: dashboard.bQnmSxSNgtYxQxo)
            .onReceive(NotificationCenter.default.publisher(for: .ahVodFavoriteDidChange)) { _ in
                dashboard.bQnmSxSNgtYxQxo()
            }
            .onReceive(NotificationCenter.default.publisher(for: .ahVodPlayRecordDidChange)) { _ in
                dashboard.bQnmSxSNgtYxQxo()
            }
            .onReceive(NotificationCenter.default.publisher(for: .ahYunCloudDidMerge)) { _ in
                dashboard.bQnmSxSNgtYxQxo()
            }
            .task {
                await dashboard.prepare(auth: auth)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ahTabRootBottomInsetProbe($bottomInset)
        .ahFixLayoutAfterRotation()
    }

    

    

    

    @ViewBuilder
    private var avatar: some View {
        if let url = URL(string: auth.user?.avatarURL ?? ""),
           !(auth.user?.avatarURL ?? "").isEmpty {
            EtXjBLbNYUbhXfeKeH(url: url)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        } else {
            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{57}\u{44}\u{32}\u{51}\u{63}\u{65}\u{69}\u{4f}\u{37}"))
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(themeManager.mainTheme.primary)
        }
    }

    

    

    

    

    

    

    

    @ViewBuilder
    private func oBVberuuSxxDlwptq(_ item: KgTqymHXNDqljvOVTsUr) -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.gJVjsOknRlJZtjEVuwO()

        switch item.title {
        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{36}\u{33}\u{65}\u{36}\u{52}\u{4b}\u{64}\u{79}"):
            NavigationLink {
                IifzfbsOFvhbweHJz()
            } label: {
                FnUGIoYQJAvu(item: item)
            }
            .buttonStyle(.plain)

        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{64}\u{61}\u{53}\u{43}\u{4f}\u{55}\u{6d}\u{41}"):
            NavigationLink {
                FtzWJAzIyqXYwl()
            } label: {
                FnUGIoYQJAvu(item: item)
            }
            .buttonStyle(.plain)

        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{42}\u{78}\u{61}\u{39}\u{4a}\u{53}\u{62}\u{5a}"):
            Button {
                lRUnFOsSJImFFwFYrGZN()
            } label: {
                FnUGIoYQJAvu(item: item)
            }
            .buttonStyle(.plain)

        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{63}\u{41}\u{76}\u{55}\u{35}\u{42}\u{35}\u{62}"):
            Button {
                RovJYbgHizJRPfPhjl.yZjmwCpuOULEzoEJ(RovJYbgHizJRPfPhjl.comic)
            } label: {
                FnUGIoYQJAvu(item: item)
            }
            .buttonStyle(.plain)

        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{59}\u{37}\u{53}\u{54}\u{52}\u{6a}\u{4c}\u{77}"):
            Button {
                RovJYbgHizJRPfPhjl.yZjmwCpuOULEzoEJ(RovJYbgHizJRPfPhjl.music)
            } label: {
                FnUGIoYQJAvu(item: item)
            }
            .buttonStyle(.plain)

        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{46}\u{35}\u{38}\u{66}\u{36}\u{65}\u{39}\u{36}"):
            Button {
                RovJYbgHizJRPfPhjl.yZjmwCpuOULEzoEJ(RovJYbgHizJRPfPhjl.telegram)
            } label: {
                FnUGIoYQJAvu(item: item)
            }
            .buttonStyle(.plain)

        case AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{66}\u{4b}\u{73}\u{6a}\u{34}\u{41}\u{49}\u{59}\u{66}"):
            Button {
                showJoinUs = true
            } label: {
                FnUGIoYQJAvu(item: item)
            }
            .buttonStyle(.plain)

        default:
            EmptyView()
        }
    }

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func gJVjsOknRlJZtjEVuwO() -> String {
        let token = "\u{36}\u{31}\u{39}\u{39}\u{34}\u{62}\u{32}\u{32}\u{64}\u{37}\u{31}\u{66}\u{30}\u{30}\u{38}\u{31}\u{37}\u{32}\u{63}\u{39}\u{65}\u{39}\u{31}\u{31}"
        let base = (43 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 43) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

#Preview {
    UswfVlIylKVJmgOnqrP()
        .environmentObject(CbyiPVoRONUJO.shared)
}



extension UswfVlIylKVJmgOnqrP {
    private var menuItems: [KgTqymHXNDqljvOVTsUr] {
        var items: [KgTqymHXNDqljvOVTsUr] = [
            .init(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{36}\u{33}\u{65}\u{36}\u{52}\u{4b}\u{64}\u{79}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{6b}\u{49}\u{4f}\u{51}\u{56}\u{62}\u{6c}\u{4b}"), tint: Color(red: 0.95, green: 0.43, blue: 0.85)),
            .init(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{47}\u{63}\u{41}\u{76}\u{55}\u{35}\u{42}\u{35}\u{62}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{71}\u{50}\u{55}\u{4b}\u{39}\u{4a}\u{48}\u{62}\u{53}"), tint: Color(red: 1.0, green: 0.55, blue: 0.2)),
            .init(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{59}\u{37}\u{53}\u{54}\u{52}\u{6a}\u{4c}\u{77}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{69}\u{6d}\u{4e}\u{67}\u{43}\u{37}\u{6f}\u{50}"), tint: Color(red: 0.2, green: 0.72, blue: 0.9)),
            .init(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{46}\u{35}\u{38}\u{66}\u{36}\u{65}\u{39}\u{36}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{33}\u{67}\u{4a}\u{55}\u{64}\u{67}\u{45}\u{56}\u{4c}"), tint: Color(red: 0.2, green: 0.6, blue: 0.95)),
            .init(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{42}\u{78}\u{61}\u{39}\u{4a}\u{53}\u{62}\u{5a}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{36}\u{4a}\u{55}\u{72}\u{6d}\u{30}\u{66}\u{72}"), tint: Color(red: 0.65, green: 0.44, blue: 1.0)),
            .init(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{64}\u{61}\u{53}\u{43}\u{4f}\u{55}\u{6d}\u{41}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{54}\u{73}\u{43}\u{4f}\u{61}\u{72}\u{35}\u{5a}"), tint: .indigo),
        ]

        if appConfig.canJoinCommunity {
            items.append(
                .init(title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{66}\u{4b}\u{73}\u{6a}\u{34}\u{41}\u{49}\u{59}\u{66}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{6e}\u{67}\u{65}\u{52}\u{6b}\u{6a}\u{71}\u{32}"), tint: .brown)
            )
        }

        return items
    }

    private var displayName: String {
        auth.isLoggedIn ? (auth.user?.displayName ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{38}\u{45}\u{41}\u{34}\u{63}\u{4d}\u{57}\u{37}")) : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{55}\u{54}\u{4a}\u{49}\u{44}\u{73}\u{65}\u{77}\u{30}")
    }

    private func lRUnFOsSJImFFwFYrGZN() {
        shareItem = .yIwIPIfCujElqafLOp()
    }

    private var menuCard: some View {
        VStack(spacing: 0) {
            ForEach(Array(menuItems.enumerated()), id: \.element.id) { index, item in
                oBVberuuSxxDlwptq(item)

                if index < menuItems.count - 1 {
                    Divider()
                        .padding(.leading, 46)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemBackground))
        )
    }

    private func dASsNlQHMbOFTTkbTVX(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.primary)
    }

    private var statsRow: some View {
        HStack(spacing: 10) {
            NavigationLink {
                AlGGPacYEqCQramum()
            } label: {
                FwyGMtyAOsbxHubZxjl(
                    title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{54}\u{54}\u{66}\u{70}\u{4b}\u{74}\u{70}\u{61}"),
                    count: dashboard.historyCount,
                    systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{36}\u{51}\u{34}\u{65}\u{4d}\u{37}\u{31}\u{7a}"),
                    tint: themeManager.mainTheme.primary
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                IuzCapPBFfSecd()
            } label: {
                FwyGMtyAOsbxHubZxjl(
                    title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{6a}\u{69}\u{45}\u{6e}\u{58}\u{75}\u{76}\u{44}"),
                    count: dashboard.favoriteCount,
                    systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{57}\u{37}\u{6e}\u{47}\u{6d}\u{4d}\u{59}\u{50}\u{64}"),
                    tint: themeManager.mainTheme.primary
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                LlGgqVbCItHWtVdKDJJ()
            } label: {
                FwyGMtyAOsbxHubZxjl(
                    title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{63}\u{6f}\u{66}\u{6f}\u{34}\u{61}\u{48}\u{37}\u{42}"),
                    count: downloadManager.tasks.count,
                    systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{4d}\u{30}\u{73}\u{77}\u{62}\u{4c}\u{68}\u{42}"),
                    tint: themeManager.mainTheme.primary
                )
            }
            .buttonStyle(.plain)
        }
    }

    private var displayBio: String {
        guard auth.isLoggedIn, let user = auth.user else { return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{55}\u{51}\u{62}\u{63}\u{62}\u{37}\u{79}\u{4a}") }
        if !user.bio.isEmpty { return user.bio }
        if user.vip { return AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{6b}\u{30}\u{72}\u{63}\u{45}\u{51}\u{62}\u{64}") }
        if !user.title.isEmpty { return user.title }
        return "\u{8d26}\u{53f7}\u{ff1a}\(user.account)"
    }

    private var gLYARkqVpIreHVTq: CGFloat {
        YcpXYLtySGuJT.gLYARkqVpIreHVTq(measuredSafeAreaBottom: bottomInset)
    }

    private var userHeader: some View {
        Button {
            if auth.isLoggedIn {
                showAccount = true
            } else {
                showLogin = true
            }
        } label: {
            HStack(spacing: 12) {
                avatar

                VStack(alignment: .leading, spacing: 4) {
                    Text(displayName)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    Text(displayBio)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }

                Spacer(minLength: 0)

                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{6b}\u{71}\u{39}\u{45}\u{73}\u{6e}\u{7a}\u{4a}"))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
