//
//  AHPlayerFeedbackView.swift
//  LLVod
//

import SwiftUI

struct AHPlayerFeedbackView: View {
    enum FeedbackType {
        case none
        case brightness(CGFloat)
        case volume(Float)
        case seek(forward: Bool, time: String)
    }

    let type: FeedbackType

    var body: some View {
        Group {
            switch type {
            case .none:
                EmptyView()
            case .brightness(let value):
                feedbackContent(icon: "sun.max.fill", value: value, text: "亮度")
            case .volume(let value):
                feedbackContent(icon: value > 0 ? "speaker.wave.2.fill" : "speaker.slash.fill", value: CGFloat(value), text: "音量")
            case .seek(let forward, let time):
                seekFeedbackContent(icon: forward ? "goforward" : "gobackward", time: time)
            }
        }
        .padding()
        .background(Color.black.opacity(0.6))
        .cornerRadius(12)
        .foregroundColor(.white)
        .transition(.opacity.animation(.easeInOut(duration: 0.2)))
    }

    private func feedbackContent(icon: String, value: CGFloat, text: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 32))
            Text("\(text) \(Int(value * 100))%")
                .font(.system(size: 14, weight: .medium))
            ProgressView(value: value, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle(tint: .white))
                .frame(width: 120)
        }
    }

    private func seekFeedbackContent(icon: String, time: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 32))
            Text(time)
                .font(.system(size: 16, weight: .bold))
        }
    }
}
