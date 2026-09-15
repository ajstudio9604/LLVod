//
//  AHChannelVerifyView.swift
//  LLVod
//
//  编号功能：用户输入 → 校验 → 保存业务数据 → 进入相关功能
//

import SwiftUI

struct AHChannelVerifyView: View {

    @ObservedObject private var channelStore = ChannelStore.shared
    
    @State private var input = ""
    @State private var showFeature = false
    @State private var errorMessage: String?
    @FocusState private var isFieldFocused: Bool

    var body: some View {
        VStack(spacing: 16) {
            Text("")
                .font(.headline)

            TextField("", text: $input)
                .keyboardType(.default)
                .textFieldStyle(.roundedBorder)
                .focused($isFieldFocused)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 240)

            Button("") {
                isFieldFocused = false
                handleContinue()
            }
            .buttonStyle(.borderedProminent)
            .disabled(normalizedInput.isEmpty)

            if let errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundColor(.red)
            }

            NavigationLink(
                destination: ChannelFeatureView(channel: normalizedInput),
                isActive: $showFeature
            ) {
                EmptyView()
            }
            .hidden()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        .onTapGesture {
            isFieldFocused = false
        }
        .onAppear {
            if let saved = channelStore.channel {
                input = saved
            }
        }
    }

    private var normalizedInput: String {
        input.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func handleContinue() {
        
        guard channelStore.isValid(normalizedInput) else {
            errorMessage = "请输入有效编号"
            return
        }
        channelStore.save(normalizedInput)

        errorMessage = nil
        showFeature = true
    }
}

struct ChannelFeatureView: View {
    let channel: String

    var body: some View {
        VStack {
            Text("")
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
