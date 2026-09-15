//
//  AHAboutView.swift
//  LLVod
//
//  应用协议 / 关于，对应 Flutter GY
//

import SwiftUI

struct AHAboutView: View {

    var body: some View {
        List {
            Section {
                VStack(spacing: 10) {
                    Image(systemName: "play.rectangle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.accentColor)

                    Text(appName)
                        .font(.system(size: 18, weight: .bold))

                    Text("版本 \(appVersion)")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
            }

            Section("用户协议") {
                Text(agreementText)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Section("免责声明") {
                Text(disclaimerText)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("应用协议")
        .navigationBarTitleDisplayMode(.inline)
        .ahHideTabBar()
    }

    private var appName: String {
        "壹影视"
    }

    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
    }

    private var agreementText: String {
        """
        欢迎使用本应用。继续使用即表示你同意遵守当地法律法规，合理使用本应用提供的功能。请勿利用本应用从事任何违法违规活动。
        """
    }

    private var disclaimerText: String {
        """
        本应用中的影视资源均来自互联网公开接口与用户订阅源，本应用不存储、不提供任何视频文件。如有侵权内容，请联系相关资源方处理。使用过程中产生的网络流量与设备电量消耗由用户自行承担。
        """
    }
}
