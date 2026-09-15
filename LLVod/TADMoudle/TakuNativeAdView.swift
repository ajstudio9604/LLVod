//
//  TakuNativeAdView.swift
//  GreenVideoMan
//
//  Created by MasterLee on 2025/11/8.
//

import SwiftUI
import AnyThinkSDK

struct TakuNativeAdView: View {
    var postion: Int = 0
    @State private var adView: ATNativeADView? = nil
    @State private var adHeight: CGFloat = 0
    
    @State private var feedFlowProvider: TADFeedFlowHandle = TADFeedFlowHandle()
    
    var body: some View {
        VStack {
            if let adView = adView {
                NativeAdContainer(adView: adView, height: $adHeight)
                    .frame(height: adHeight)
                    .padding(.horizontal, 16)
                    .animation(.easeInOut, value: adHeight)
            }
        }
        .onAppear(perform: loadAd)
    }

    private func loadAd() {
        feedFlowProvider.feedFlowCompleted = { pst, type, view in
            if pst == postion, type == .success {
                DispatchQueue.main.async {
                    self.adHeight = view!.bounds.height
                    self.adView = view as! ATNativeADView
                }
            }
            
            if pst == postion, type == .didClose {
                DispatchQueue.main.async {
                    self.adHeight = 0
                    self.adView = nil
                }
            }
        }
        feedFlowProvider.showFeedFlow(adId: "b6a7c49676cac4", position: postion)
    }
    
  
}

private struct NativeAdContainer: UIViewRepresentable {
    let adView: UIView
    @Binding var height: CGFloat
    
    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        container.backgroundColor = .clear
        
        container.addSubview(adView)
        adView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            adView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            adView.topAnchor.constraint(equalTo: container.topAnchor),
            adView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        adView.addObserver(context.coordinator,
                           forKeyPath: "frame",
                           options: [.new, .initial],
                           context: nil)
        
        return container
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(height: $height)
    }
    
    class Coordinator: NSObject {
        @Binding var height: CGFloat
        
        init(height: Binding<CGFloat>) {
            _height = height
        }
        
        override func observeValue(forKeyPath keyPath: String?,
                                   of object: Any?,
                                   change: [NSKeyValueChangeKey : Any]?,
                                   context: UnsafeMutableRawPointer?) {
            let view = object as? ATNativeADView
            self.height = view!.bounds.height
        }
    }
}
