//
//  AHSourceEpisodeSelector.swift
//  LLVod
//

import SwiftUI

// MARK: - 播放源选择器（横屏）
struct AHSourceSelectorOverlay: View {
    let sources: [AHVodSourceLine]
    let selectedIndex: Int
    @Binding var isPresented: Bool
    var onSelect: (Int) -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea().onTapGesture { withAnimation { isPresented = false } }
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    HStack {
                        Text("选择播放源").font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                        Spacer()
                        Button(action: { withAnimation { isPresented = false } }) {
                            Image(systemName: "xmark").font(.system(size: 16, weight: .semibold)).foregroundColor(.white.opacity(0.7))
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    Divider().background(Color.white.opacity(0.2))
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(sources.indices, id: \.self) { index in
                                Button(action: { onSelect(index) }) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(sources[index].name.isEmpty ? "线路\(index + 1)" : sources[index].name)
                                                .font(.system(size: 16, weight: selectedIndex == index ? .semibold : .regular))
                                                .foregroundColor(.white)
                                        }
                                        Spacer()
                                        if selectedIndex == index {
                                            Image(systemName: "checkmark").font(.system(size: 16, weight: .bold)).foregroundColor(.green)
                                        }
                                    }
                                    .padding()
                                    .background(selectedIndex == index ? Color.white.opacity(0.15) : Color.clear)
                                }
                                if index != sources.count - 1 {
                                    Divider().background(Color.white.opacity(0.1))
                                }
                            }
                        }
                    }
                }
                .frame(width: 300)
                .background(Color.black.opacity(0.95))
                .cornerRadius(12)
                .padding(.trailing, 16)
            }
        }
    }
}

// MARK: - 集数选择器（横屏）
struct AHEpisodeSelectorOverlay: View {
    let episodes: [AHVodEpisode]
    let selectedIndex: Int
    @Binding var isPresented: Bool
    var onSelect: (Int) -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea().onTapGesture { withAnimation { isPresented = false } }
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    HStack {
                        Text("选择集数").font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                        Spacer()
                        Text("共\(episodes.count)集").font(.system(size: 14)).foregroundColor(.white.opacity(0.7)).padding(.trailing, 12)
                        Button(action: { withAnimation { isPresented = false } }) {
                            Image(systemName: "xmark").font(.system(size: 16, weight: .semibold)).foregroundColor(.white.opacity(0.7))
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    Divider().background(Color.white.opacity(0.2))
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 12)], spacing: 12) {
                            ForEach(episodes.indices, id: \.self) { index in
                                Button(action: { onSelect(index) }) {
                                    Text(episodes[index].title.isEmpty ? "第\(index + 1)集" : episodes[index].title)
                                        .font(.system(size: 14, weight: selectedIndex == index ? .semibold : .regular))
                                        .foregroundColor(selectedIndex == index ? .white : .white.opacity(0.9))
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                        .background(selectedIndex == index ? Color.green : Color.white.opacity(0.15))
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .frame(width: 400)
                .background(Color.black.opacity(0.95))
                .cornerRadius(12)
                .padding(.trailing, 16)
            }
        }
    }
}

// MARK: - 播放源选择器（竖屏）
struct AHPortraitSourceSelectorOverlay: View {
    let sources: [AHVodSourceLine]
    let selectedIndex: Int
    @Binding var isPresented: Bool
    var onSelect: (Int) -> Void

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.5).ignoresSafeArea().onTapGesture { withAnimation { isPresented = false } }
                VStack {
                    Spacer()
                    VStack(spacing: 0) {
                        HStack {
                            Text("选择播放源").font(.system(size: 16, weight: .semibold)).foregroundColor(.primary)
                            Spacer()
                            Button(action: { withAnimation { isPresented = false } }) {
                                Image(systemName: "xmark").font(.system(size: 16, weight: .semibold)).foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        Divider()
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(sources.indices, id: \.self) { index in
                                    Button(action: { onSelect(index) }) {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(sources[index].name.isEmpty ? "线路\(index + 1)" : sources[index].name)
                                                    .font(.system(size: 16, weight: selectedIndex == index ? .semibold : .regular))
                                                    .foregroundColor(.primary)
                                            }
                                            Spacer()
                                            if selectedIndex == index {
                                                Image(systemName: "checkmark").font(.system(size: 16, weight: .bold)).foregroundColor(.green)
                                            }
                                        }
                                        .padding()
                                    }
                                    if index != sources.count - 1 {
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxHeight: geometry.size.height * 0.5)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .padding()
                }
            }
        }
    }
}

// MARK: - 集数选择器（竖屏）
struct AHPortraitEpisodeSelectorOverlay: View {
    let episodes: [AHVodEpisode]
    let selectedIndex: Int
    @Binding var isPresented: Bool
    var onSelect: (Int) -> Void

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.5).ignoresSafeArea().onTapGesture { withAnimation { isPresented = false } }
                VStack {
                    Spacer()
                    VStack(spacing: 0) {
                        HStack {
                            Text("选择集数").font(.system(size: 16, weight: .semibold)).foregroundColor(.primary)
                            Spacer()
                            Text("共\(episodes.count)集").font(.system(size: 14)).foregroundColor(.secondary).padding(.trailing, 12)
                            Button(action: { withAnimation { isPresented = false } }) {
                                Image(systemName: "xmark").font(.system(size: 16, weight: .semibold)).foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        Divider()
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 12)], spacing: 12) {
                                ForEach(episodes.indices, id: \.self) { index in
                                    Button(action: { onSelect(index) }) {
                                        Text(episodes[index].title.isEmpty ? "第\(index + 1)集" : episodes[index].title)
                                            .font(.system(size: 14, weight: selectedIndex == index ? .semibold : .regular))
                                            .foregroundColor(selectedIndex == index ? .white : .primary)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 10)
                                            .background(selectedIndex == index ? Color.green : Color(UIColor.systemGray5))
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    .frame(maxHeight: geometry.size.height * 0.6)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .padding()
                }
            }
        }
    }
}
