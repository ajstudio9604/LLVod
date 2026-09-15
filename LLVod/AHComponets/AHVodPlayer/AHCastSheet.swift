//
//  AHCastSheet.swift
//  LLVod
//
//  投屏面板，对应 Flutter dlna.dart：
//  AirPlay 走系统路由选择；DLNA 设备 SSDP 搜索后点选投屏。
//

import SwiftUI
import AVKit

struct AHCastSheet: View {

    let title: String
    let videoURL: String

    @Environment(\.dismiss) private var dismiss
    @StateObject private var searcher = AHDlnaSearcher()
    @State private var toast: String?
    @State private var castingName: String?

    var body: some View {
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
            .navigationTitle("投屏")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("关闭") { dismiss() }
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
        .onDisappear { searcher.stop() }
    }

    private var airPlaySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("AirPlay")
                .font(.system(size: 14, weight: .bold))

            HStack(spacing: 12) {
                Image(systemName: "airplayvideo")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                    .frame(width: 28)

                Text("隔空播放 / Apple TV")
                    .font(.system(size: 14, weight: .medium))

                Spacer()

                AHAirPlayButton(
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
                Text("投屏搜索中")
                    .font(.system(size: 14, weight: .bold))

                if searcher.isSearching {
                    ProgressView()
                        .scaleEffect(0.7)
                }
            }

            if searcher.devices.isEmpty {
                Text("正在搜索局域网中的 DLNA 设备…")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
            } else {
                VStack(spacing: 0) {
                    ForEach(searcher.devices) { device in
                        Button {
                            Task { await cast(to: device) }
                        } label: {
                            HStack {
                                Image(systemName: "tv")
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
                                    Image(systemName: "chevron.right")
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

    private var helpCard: some View {
        tipCard(
            title: "使用帮助",
            body: """
            1.打开智能电视或盒子，确认电视/盒子与手机连接同一个WiFi
            2.在上方设备列表中，选择投屏设备，即可开始投屏
            """
        )
    }

    private var troubleCard: some View {
        tipCard(
            title: "找不到想投屏的设备?请检查:",
            body: """
            1.电视/盒子与手机没有连接在同一个WiFi，或者手机可能连接了4G/5G网络;
            2.电视/盒子机型老旧，不支持DLNA/AirPlay投射协议，建议在电视上安装“乐播投屏”进行投射;
            3.局域网中存在多个路由器，建议手机与设备处于同一路由器的Wifi环境;
            4.iOS设备需要允许访问本地网络以扫描，在手机设置中找到本App,将本地网络权限打开;
            """
        )
    }

    private func tipCard(title: String, body: String) -> some View {
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

    private func cast(to device: AHDlnaDevice) async {
        let url = videoURL.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !url.isEmpty else {
            showToast("当前没有可投屏的播放地址")
            return
        }
        if AHLocalMediaServer.isLocalURL(url) || url.hasPrefix("file://") {
            showToast("本地视频请使用上方 AirPlay 投屏")
            return
        }

        castingName = device.name
        let error = await searcher.cast(to: device, url: url, title: title)
        castingName = nil

        if let error {
            showToast(error)
        } else {
            showToast("已投屏到 \(device.name)")
        }
    }

    private func showToast(_ text: String) {
        withAnimation { toast = text }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                if toast == text { toast = nil }
            }
        }
    }
}

struct AHCastButton: View {

    @ObservedObject var viewModel: AHVideoPlayerViewModel
    var square: Bool = false

    @State private var showSheet = false

    var body: some View {
        Button {
            viewModel.pause()
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

                Image(systemName: "airplayvideo")
                    .font(.system(size: square ? 16 : 14, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showSheet) {
            AHCastSheet(
                title: castTitle,
                videoURL: viewModel.currentPlayURL
            )
        }
    }

    private var castTitle: String {
        var parts: [String] = []
        if let name = viewModel.vodName, !name.isEmpty { parts.append(name) }
        if let episode = viewModel.currentEpisodeName, !episode.isEmpty { parts.append(episode) }
        return parts.isEmpty ? "视频" : parts.joined(separator: " - ")
    }
}
