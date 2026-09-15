//
//  AirPlayButton.swift
//  GreenVideoMan
//
//  Created by MasterLee on 2025/11/4.
//

import SwiftUI
import AVKit

struct AirPlayButton: UIViewRepresentable {
    var tintColor: UIColor = .white
    var activeTintColor: UIColor = .systemGreen
    var prioritizesVideoDevices: Bool = true
    
    func makeUIView(context: Context) -> AVRoutePickerView {
        let routePickerView = AVRoutePickerView()
        routePickerView.tintColor = tintColor
        routePickerView.activeTintColor = activeTintColor
        routePickerView.prioritizesVideoDevices = prioritizesVideoDevices
        
        // 设置按钮样式
        routePickerView.backgroundColor = .clear
        
        return routePickerView
    }
    
    func updateUIView(_ uiView: AVRoutePickerView, context: Context) {
        uiView.tintColor = tintColor
        uiView.activeTintColor = activeTintColor
        uiView.prioritizesVideoDevices = prioritizesVideoDevices
    }
}

struct CircularAirPlayButton: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black.opacity(0.4))
                .frame(width: 36, height: 36)
            
            AirPlayButton(
                tintColor: .white,
                activeTintColor: .systemGreen
            )
            .frame(width: 36, height: 36)
        }
    }
}

struct SquareAirPlayButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black.opacity(0.3))
                .frame(width: 44, height: 44)
            
            AirPlayButton(
                tintColor: .white,
                activeTintColor: .systemGreen
            )
            .frame(width: 44, height: 44)
        }
    }
}

#Preview("Circular") {
    ZStack {
        Color.black
        CircularAirPlayButton()
    }
}

#Preview("Square") {
    ZStack {
        Color.black
        SquareAirPlayButton()
    }
}

