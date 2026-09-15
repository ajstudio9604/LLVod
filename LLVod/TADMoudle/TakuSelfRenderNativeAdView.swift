//
//  TakuSelfRenderNativeAdView.swift
//  LLVod
//
//  搜索结果页底部自渲染信息流图层
//

import SwiftUI
import AnyThinkSDK

struct TakuSelfRenderNativeAdView: View {
    let adView: ATNativeADView?
    var extraBottom: CGFloat = 0
    var onClose: () -> Void
    
    private var adHeight: CGFloat {
        TADSelfRenderView.preferredSize.height + extraBottom
    }
    
    var body: some View {
        Group {
            if let adView {
                SelfRenderAdContainer(adView: adView)
                    .frame(maxWidth: .infinity)
                    .frame(height: adHeight)
                    .clipped()
                    .overlay(alignment: .topTrailing) {
                        Button(action: onClose) {
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color.black.opacity(0.55))
                                .clipShape(Circle())
                        }
                        .frame(width: 44, height: 44)
                        .padding(.top, 6)
                        .padding(.trailing, 8)
                    }
                    .background(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.12), radius: 8, y: -2)
            }
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

private struct SelfRenderAdContainer: UIViewRepresentable {
    let adView: UIView
    
    func makeUIView(context: Context) -> UIView {
        let container = ClippedAdHostView()
        container.backgroundColor = .clear
        container.clipsToBounds = true
        container.addSubview(adView)
        adView.clipsToBounds = true
        adView.translatesAutoresizingMaskIntoConstraints = true
        adView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        adView.frame = container.bounds
        return container
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        uiView.clipsToBounds = true
        adView.clipsToBounds = true
        adView.frame = uiView.bounds
    }
}

private final class ClippedAdHostView: UIView {
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: TADSelfRenderView.preferredSize.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        subviews.forEach { subview in
            subview.clipsToBounds = true
            subview.frame = bounds
        }
    }
}
