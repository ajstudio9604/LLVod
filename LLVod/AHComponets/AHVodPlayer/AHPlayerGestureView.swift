//
//  AHPlayerGestureView.swift
//  LLVod
//

import SwiftUI
import AVKit
import MediaPlayer

struct AHPlayerGestureView: View {
    @ObservedObject var playerViewModel: AHVideoPlayerViewModel

    // 手势状态
    @State private var gestureStartLocation: CGPoint = .zero
    @State private var gestureTranslation: CGSize = .zero
    @State private var currentGesture: GestureType = .none

    // 亮度/音量
    @State private var startBrightness: CGFloat = UIScreen.main.brightness
    @State private var startVolume: Float = AVAudioSession.sharedInstance().outputVolume

    // 进度
    @State private var startTime: Double = 0
    @State private var seekOffset: Double = 0

    // 反馈视图
    @State private var feedbackType: AHPlayerFeedbackView.FeedbackType = .none
    @State private var feedbackHideTask: Task<Void, Never>?
    @State private var longPressTask: DispatchWorkItem?

    enum GestureType {
        case none, seeking, changingBrightness, changingVolume
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black.opacity(0.001)) // 手势捕捉层
                .gesture(dragGesture)
                .onLongPressGesture(
                    minimumDuration: 0.35,
                    maximumDistance: 20,
                    pressing: { isPressing in
                        guard !playerViewModel.isControlsLocked else { return }
                        if isPressing {
                            // 延迟 0.35s 才进入 2 倍速，避免点按误触
                            let task = DispatchWorkItem { playerViewModel.startLongPressSpeed() }
                            longPressTask?.cancel()
                            longPressTask = task
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: task)
                        } else {
                            longPressTask?.cancel()
                            longPressTask = nil
                            playerViewModel.endLongPressSpeed()
                        }
                    },
                    perform: { }
                )
                .allowsHitTesting(!playerViewModel.isControlsLocked)

            // 视觉反馈层
            AHPlayerFeedbackView(type: feedbackType)
        }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                guard !playerViewModel.isControlsLocked else { return }
                feedbackHideTask?.cancel()

                if currentGesture == .none {
                    gestureStartLocation = value.startLocation
                    startTime = playerViewModel.currentTime
                    startBrightness = UIScreen.main.brightness
                    startVolume = AVAudioSession.sharedInstance().outputVolume

                    if abs(value.translation.width) > abs(value.translation.height) {
                        currentGesture = .seeking
                    } else {
                        if value.startLocation.x < UIScreen.main.bounds.width / 2 {
                            currentGesture = .changingBrightness
                        } else {
                            currentGesture = .changingVolume
                        }
                    }
                }

                gestureTranslation = value.translation

                switch currentGesture {
                case .seeking:
                    handleSeekingChanged()
                case .changingBrightness:
                    handleBrightnessChanged()
                case .changingVolume:
                    handleVolumeChanged()
                case .none:
                    break
                }
            }
            .onEnded { _ in
                guard !playerViewModel.isControlsLocked else {
                    currentGesture = .none
                    return
                }
                if currentGesture == .seeking {
                    playerViewModel.seek(to: startTime + seekOffset)
                }

                showFeedbackTemporarily()

                currentGesture = .none
                gestureTranslation = .zero
                seekOffset = 0
            }
    }

    // MARK: - 手势处理逻辑

    private func handleSeekingChanged() {
        let totalDuration = playerViewModel.duration
        guard totalDuration > 0 else { return }

        let maxSeekOffset = totalDuration / 3
        let offset = (gestureTranslation.width / UIScreen.main.bounds.width) * maxSeekOffset
        seekOffset = offset

        let targetTime = max(0, min(startTime + seekOffset, totalDuration))
        let timeString = AHVideoPlayerViewModel.formatTime(targetTime)
        feedbackType = .seek(forward: seekOffset >= 0, time: timeString)
    }

    private func handleBrightnessChanged() {
        let verticalTranslation = -gestureTranslation.height
        let change = verticalTranslation / 200
        let newBrightness = min(max(startBrightness + change, 0), 1)
        UIScreen.main.brightness = newBrightness

        feedbackType = .brightness(newBrightness)
    }

    private func handleVolumeChanged() {
        let verticalTranslation = -gestureTranslation.height
        let change = Float(verticalTranslation / 200)
        let newVolume = min(max(startVolume + change, 0), 1)

        let volumeView = MPVolumeView()
        if let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider {
            DispatchQueue.main.async {
                slider.value = newVolume
            }
        }

        feedbackType = .volume(newVolume)
    }

    private func showFeedbackTemporarily() {
        feedbackHideTask?.cancel()
        feedbackHideTask = Task {
            try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5秒
            if !Task.isCancelled {
                await MainActor.run {
                    self.feedbackType = .none
                }
            }
        }
    }
}
