//
//  AHVodDanmakuBridge.swift
//  LLVod
//
//  把 AHDanmakuService 接到播放器的 AHDanmakuSource 注入点上。
//  播放器只知道「影片名 + 集索引」，弹幕接口还需要源标识名、订阅、集地址，
//  这些由详情页在换源换集时写进 context。
//

import Foundation

struct AHVodDanmakuContext {
    var title: String
    var sourceTag: String
    var zypath: String
    var episodeTitle: String
    var episodePath: String
    var playURL: String
    var episodeIndex: Int = 0
}

enum AHVodDanmakuBridge {

    private(set) static var context = AHVodDanmakuContext(
        title: "",
        sourceTag: "",
        zypath: "",
        episodeTitle: "",
        episodePath: "",
        playURL: ""
    )

    private static var installed = false

    static func update(_ context: AHVodDanmakuContext) {
        self.context = context
    }

    static func updatePlayURL(_ url: String) {
        context.playURL = url
    }

    static func install() {
        guard !installed else { return }
        installed = true

        AHDanmakuSource.provider = { request, completion in
            var context = AHVodDanmakuBridge.context
            if !request.vodName.isEmpty {
                context.title = request.vodName
            }
            // 离线播放没有详情页写过上下文，这两项只能取播放器给的
            if !request.playURL.isEmpty {
                context.playURL = request.playURL
            }
            if context.episodeIndex <= 0 {
                context.episodeIndex = request.episode
            }

            Task {
                let items = await AHDanmakuService.fetchDanmaku(context: context)
                await MainActor.run {
                    completion(items)
                }
            }
        }

        AHDanmakuSource.sender = { request, completion in
            let context = AHVodDanmakuBridge.context

            Task {
                let result = await AHDanmakuService.send(context: context, request: request)
                await MainActor.run {
                    completion(result)
                }
            }
        }
    }
}
