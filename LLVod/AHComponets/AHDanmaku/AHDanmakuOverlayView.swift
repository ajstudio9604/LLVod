//
//  AHDanmakuOverlayView.swift
//  LLVod
//

import SwiftUI
import DanmakuKit

struct AHDanmakuContentView: UIViewRepresentable {
    let manager: AHDanmakuManager
    let isLandscape: Bool

    final class Coordinator {
        let manager: AHDanmakuManager

        init(manager: AHDanmakuManager) {
            self.manager = manager
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(manager: manager)
    }

    func makeUIView(context: Context) -> AHDanmakuHostView {
        let host = AHDanmakuHostView()
        let view = host.danmakuView

        view.enableBottomDanmaku = true
        view.enableTopDanmaku = true
        view.isOverlap = false

        manager.controller.attach(view: view)

        return host
    }

    func updateUIView(_ uiView: AHDanmakuHostView, context: Context) {
        manager.controller.ensureActive(view: uiView.danmakuView)
    }

    static func dismantleUIView(_ uiView: AHDanmakuHostView, coordinator: Coordinator) {
        coordinator.manager.controller.detach(view: uiView.danmakuView)
    }
}

struct AHDanmakuOverlayView: View {
    @ObservedObject var playerViewModel: AHVideoPlayerViewModel

    private var danmakuManager: AHDanmakuManager { playerViewModel.danmaku }

    var body: some View {
        GeometryReader { _ in
            ZStack {
                AHDanmakuContentView(
                    manager: danmakuManager,
                    isLandscape: true
                )
            }
            .clipped()
            .allowsHitTesting(false)
            .onAppear {
                playerViewModel.danmakuArea = danmakuManager.danmakuArea
                playerViewModel.danmakuSpeed = danmakuManager.danmakuSpeed
                playerViewModel.danmakuOpacity = danmakuManager.danmakuOpacity
                playerViewModel.danmuFontSize = danmakuManager.danmakuFontSize
                playerViewModel.showDanmaku = danmakuManager.enabled
            }
            .onChange(of: playerViewModel.showDanmaku) { _ in
                danmakuManager.enabled = playerViewModel.showDanmaku
                if playerViewModel.showDanmaku {
                    danmakuManager.play()
                } else {
                    danmakuManager.clear()
                }
            }
            .onChange(of: playerViewModel.danmuFontSize) { _ in
                danmakuManager.update(danmuFontSize: CGFloat(playerViewModel.danmuFontSize))
            }
            .onChange(of: playerViewModel.danmakuOpacity) { _ in
                danmakuManager.update(opacity: playerViewModel.danmakuOpacity)
            }
            .onChange(of: playerViewModel.danmakuArea) { _ in
                danmakuManager.update(area: playerViewModel.danmakuArea)
            }
            .onChange(of: playerViewModel.danmakuSpeed) { _ in
                danmakuManager.update(speed: playerViewModel.danmakuSpeed)
            }
        }
    }
}
