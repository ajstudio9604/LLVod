//
//  AHAirPlayButton.swift
//  LLVod
//

import SwiftUI
import AVKit

struct AHAirPlayButton: UIViewRepresentable {
    var tintColor: UIColor = .white
    var activeTintColor: UIColor = .systemGreen
    var prioritizesVideoDevices: Bool = true

    func makeUIView(context: Context) -> AVRoutePickerView {
        let routePickerView = AVRoutePickerView()
        routePickerView.tintColor = tintColor
        routePickerView.activeTintColor = activeTintColor
        routePickerView.prioritizesVideoDevices = prioritizesVideoDevices
        routePickerView.backgroundColor = .clear

        return routePickerView
    }

    func updateUIView(_ uiView: AVRoutePickerView, context: Context) {
        uiView.tintColor = tintColor
        uiView.activeTintColor = activeTintColor
        uiView.prioritizesVideoDevices = prioritizesVideoDevices
    }
}

struct AHCircularAirPlayButton: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black.opacity(0.4))
                .frame(width: 36, height: 36)

            AHAirPlayButton(
                tintColor: .white,
                activeTintColor: .systemGreen
            )
            .frame(width: 36, height: 36)
        }
    }
}

struct AHSquareAirPlayButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black.opacity(0.3))
                .frame(width: 44, height: 44)

            AHAirPlayButton(
                tintColor: .white,
                activeTintColor: .systemGreen
            )
            .frame(width: 44, height: 44)
        }
    }
}
