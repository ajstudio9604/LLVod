//
//  AHMineView.swift
//  LLVod
//
//  个人中心（对应 Flutter pagev4.dart）
//

import SwiftUI

struct AHMineView: View {

    @ObservedObject private var auth = AHCommentAuthStore.shared
    @ObservedObject private var appConfig = AHAppConfig.shared
    @ObservedObject private var downloadManager = AHDownloadManager.shared
    @EnvironmentObject private var themeManager: ThemeManager

    @State private var historyCount = 0
    @State private var favoriteCount = 0
    @State private var showLogin = false
    @State private var showAccount = false
    @State private var showJoinUs = false
    @State private var shareItem: AHShareItem?
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

                    sectionTitle("常用功能")
                        .padding(.horizontal, 15)
                        .padding(.top, 20)

                    menuCard
                        .padding(.horizontal, 15)
                        .padding(.top, 8)
                        .padding(.bottom, contentBottomInset + 24)
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .ahTabRootIgnoreBottomSafeAreaIfNeeded()
            .refreshable {
                await syncHistoryAndFavorites()
            }
            .navigationTitle("我的")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AHSettingsView()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .sheet(isPresented: $showLogin) {
                AHCommentLoginSheet()
            }
            .sheet(isPresented: $showAccount) {
                AHMineAccountSheet()
            }
            .sheet(isPresented: $showJoinUs) {
                AHJoinUsSheet()
            }
            .sheet(item: $shareItem) { item in
                AHShareSheet(item: item)
            }
            .onAppear(perform: reloadCounters)
            .onReceive(NotificationCenter.default.publisher(for: .ahVodFavoriteDidChange)) { _ in
                favoriteCount = AHVodLocalStore.favorites().count
            }
            .onReceive(NotificationCenter.default.publisher(for: .ahVodPlayRecordDidChange)) { _ in
                historyCount = AHVodLocalStore.playRecords().count
            }
            .onReceive(NotificationCenter.default.publisher(for: .ahYunCloudDidMerge)) { _ in
                reloadCounters()
            }
            .task {
                await AHAppConfigService.ensureLoaded()
                _ = try? await AHSearchSubscriptionLoader.ensureLoaded()
                if auth.isLoggedIn {
                    await auth.refreshProfile()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ahTabRootBottomInsetProbe($bottomInset)
        .ahFixLayoutAfterRotation()
    }

    private var contentBottomInset: CGFloat {
        AHTabRootBottomLayout.contentBottomInset(measuredSafeAreaBottom: bottomInset)
    }

    // MARK: - 头像区域

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

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var avatar: some View {
        if let url = URL(string: auth.user?.avatarURL ?? ""),
           !(auth.user?.avatarURL ?? "").isEmpty {
            CachedAsyncImageView(url: url)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(themeManager.mainTheme.primary)
        }
    }

    private var displayName: String {
        auth.isLoggedIn ? (auth.user?.displayName ?? "用户") : "登 录"
    }

    private var displayBio: String {
        guard auth.isLoggedIn, let user = auth.user else { return "个性签名" }
        if !user.bio.isEmpty { return user.bio }
        if user.vip { return "会员" }
        if !user.title.isEmpty { return user.title }
        return "账号：\(user.account)"
    }

    // MARK: - 最近 / 收藏 / 下载

    private var statsRow: some View {
        HStack(spacing: 10) {
            NavigationLink {
                AHVodPlayHistoryView()
            } label: {
                AHMineStatCard(
                    title: "最近",
                    count: historyCount,
                    systemImage: "clock.arrow.circlepath",
                    tint: themeManager.mainTheme.primary
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                AHFavoriteListView()
            } label: {
                AHMineStatCard(
                    title: "收藏",
                    count: favoriteCount,
                    systemImage: "heart.fill",
                    tint: themeManager.mainTheme.primary
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                AHDownloadManagerView()
            } label: {
                AHMineStatCard(
                    title: "下载",
                    count: downloadManager.tasks.count,
                    systemImage: "arrow.down.circle.fill",
                    tint: themeManager.mainTheme.primary
                )
            }
            .buttonStyle(.plain)
        }
    }

    // MARK: - 常用功能

    private var menuItems: [AHMineMenuItem] {
        var items: [AHMineMenuItem] = [
            .init(title: "主题风格", systemImage: "paintpalette.fill", tint: Color(red: 0.95, green: 0.43, blue: 0.85)),
            .init(title: "漫画推荐", systemImage: "book.fill", tint: Color(red: 1.0, green: 0.55, blue: 0.2)),
            .init(title: "音乐推荐", systemImage: "music.note", tint: Color(red: 0.2, green: 0.72, blue: 0.9)),
            .init(title: "影视飞机群", systemImage: "paperplane.circle.fill", tint: Color(red: 0.2, green: 0.6, blue: 0.95)),
            .init(title: "分享APP", systemImage: "square.and.arrow.up.fill", tint: Color(red: 0.65, green: 0.44, blue: 1.0)),
            .init(title: "应用协议", systemImage: "doc.text.fill", tint: .indigo),
        ]

        if appConfig.canJoinCommunity {
            items.append(
                .init(title: "加入我们", systemImage: "person.3.fill", tint: .brown)
            )
        }

        return items
    }

    private var menuCard: some View {
        VStack(spacing: 0) {
            ForEach(Array(menuItems.enumerated()), id: \.element.id) { index, item in
                menuRow(item)

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

    @ViewBuilder
    private func menuRow(_ item: AHMineMenuItem) -> some View {
        switch item.title {
        case "主题风格":
            NavigationLink {
                AHThemePickerView()
            } label: {
                AHMineMenuRow(item: item)
            }
            .buttonStyle(.plain)

        case "应用协议":
            NavigationLink {
                AHAboutView()
            } label: {
                AHMineMenuRow(item: item)
            }
            .buttonStyle(.plain)

        case "分享APP":
            Button {
                shareApp()
            } label: {
                AHMineMenuRow(item: item)
            }
            .buttonStyle(.plain)

        case "漫画推荐":
            Button {
                AHOfficialLinks.open(AHOfficialLinks.comic)
            } label: {
                AHMineMenuRow(item: item)
            }
            .buttonStyle(.plain)

        case "音乐推荐":
            Button {
                AHOfficialLinks.open(AHOfficialLinks.music)
            } label: {
                AHMineMenuRow(item: item)
            }
            .buttonStyle(.plain)

        case "影视飞机群":
            Button {
                AHOfficialLinks.open(AHOfficialLinks.telegram)
            } label: {
                AHMineMenuRow(item: item)
            }
            .buttonStyle(.plain)

        case "加入我们":
            Button {
                showJoinUs = true
            } label: {
                AHMineMenuRow(item: item)
            }
            .buttonStyle(.plain)

        default:
            EmptyView()
        }
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.primary)
    }

    private func reloadCounters() {
        historyCount = AHVodLocalStore.playRecords().count
        favoriteCount = AHVodLocalStore.favorites().count
    }

    private func syncHistoryAndFavorites() async {
        guard auth.isLoggedIn else { return }
        await auth.refreshProfile()
        await AHYunCloudService.pullAndMerge()
        reloadCounters()
    }

    private func shareApp() {
        shareItem = .website()
    }
}

// MARK: - 小组件

private struct AHMineMenuItem: Identifiable {
    var id: String { title }
    let title: String
    let systemImage: String
    let tint: Color
}

private struct AHMineMenuRow: View {
    let item: AHMineMenuItem

    var body: some View {
        HStack(spacing: 13) {
            Image(systemName: item.systemImage)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(item.tint)
                .frame(width: 20)

            Text(item.title)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 13)
        .frame(height: 50)
        .contentShape(Rectangle())
    }
}

private struct AHMineStatCard: View {
    let title: String
    let count: Int
    let systemImage: String
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(title)
                    .font(.system(size: 14, weight: .bold))

                Spacer(minLength: 0)

                Image(systemName: systemImage)
                    .font(.system(size: 15, weight: .semibold))
            }

            Text("\(count)")
                .font(.system(size: 12, weight: .bold))
        }
        .foregroundColor(tint)
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(tint.opacity(0.12))
        )
    }
}

#Preview {
    AHMineView()
        .environmentObject(ThemeManager.shared)
}
