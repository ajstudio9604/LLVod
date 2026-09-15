//
//  AHSearchResultView.swift
//  LLVod
//

import SwiftUI

struct AHSearchResultView: View {

    let sourceNames: [String]
    let selectedSource: String?
    let results: [AHSearchResultItem]
    var isLoadingMoreSources: Bool = false
    var onSelectSource: (String) -> Void
    var onSelectItem: (AHSearchResultItem) -> Void

    @StateObject private var nativeAd = TADSelfRenderFeedHandle()

    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(alignment: .top, spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(sourceNames, id: \.self) { source in
                            Button {
                                onSelectSource(source)
                            } label: {
                                Text(source)
                                    .font(.system(size: 12.5, weight: .bold))
                                    .foregroundColor(
                                        selectedSource == source ? .red : .primary
                                    )
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 9)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(
                                                selectedSource == source
                                                    ? Color.red.opacity(0.12)
                                                    : Color(.secondarySystemBackground)
                                            )
                                    )
                            }
                            .buttonStyle(.plain)
                            .padding(.leading, 15)
                            .padding(.trailing, 5)
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, nativeAd.overlayHeight + bottomSafeInset)
                }
                .frame(width: 103)

                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(results) { item in
                            Button {
                                onSelectItem(item)
                            } label: {
                                AHSearchResultRowView(item: item)
                            }
                            .buttonStyle(.plain)
                        }

                        if isLoadingMoreSources {
                            HStack(spacing: 8) {
                                ProgressView()
                                Text("其余来源搜索中")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                        }
                    }
                    .padding(.bottom, nativeAd.overlayHeight + bottomSafeInset)
                }
            }

            TakuSelfRenderNativeAdView(
                adView: nativeAd.adView,
                extraBottom: bottomSafeInset
            ) {
                nativeAd.destroy()
            }
        }
        .task {
            nativeAd.load(placementID: TADConfigHandler.selfRenderFeedPlacementID)
        }
    }

    private var bottomSafeInset: CGFloat {
        max(currentWindow()?.safeAreaInsets.bottom ?? 20, 20)
    }
    
    private func currentWindow() -> UIWindow? {
        return AppWindow.current
    }
}

struct AHSearchResultRowView: View {

    let item: AHSearchResultItem

    var body: some View {
        HStack(alignment: .top, spacing: 7) {
            CachedAsyncImageView(url: URL(string: item.imageURL))
                .frame(width: 65, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.leading, 10)
                .padding(.vertical, 10)

            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text(item.sourceName)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.red)
                    .lineLimit(1)

                Text(item.status)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 18)
            .padding(.trailing, 10)
        }
        .frame(height: 110)
    }
}
