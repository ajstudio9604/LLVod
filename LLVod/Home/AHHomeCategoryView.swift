//
//  AHHomeCategoryView.swift
//  LLVod
//
//  Created by minusapple on 2026/7/17.
//

import SwiftUI

struct AHHomeCategoryView: View {

    @ObservedObject var viewModel: HomeApiViewModel

    let mode: Int
    var bottomInset: CGFloat = 0

    // 同 HomeTemplateView：导航容器由外层 AHHomeView 提供；
    // ViewModel 也由外层共享，避免每个分类 tab 各打一遍同样的接口
    var body: some View {
        Group {
            if viewModel.isLoading && displayItems.isEmpty {
                ProgressView("正在加载")
            } else {
                contentView
            }
        }
        .task {
            await viewModel.loadIfNeeded()
        }
        .refreshable {
            await viewModel.getHttp()
        }
        .alert(
            "提示",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { value in
                    if !value {
                        viewModel.errorMessage = nil
                    }
                }
            )
        ) {
            Button("确定") {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }

    private var displayItems: [HotMediaItem] {
        switch mode {
        case 1:
            return viewModel.hotTVList
        case 2:
            return viewModel.hotMovieList
        case 3:
            return viewModel.hotAnimeList
        case 4:
            return viewModel.hotVarietyList
        default:
            return []
        }
    }

    private var contentView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                LazyVGrid(
                    columns: phoneColumns,
                    alignment: .center,
                    spacing: 16
                ) {
                    ForEach(Array(displayItems)) { item in
                        MediaCardView(item: item)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, bottomInset + 16)
            .padding(.top, 12)
        }
    }

    private var phoneColumns: [GridItem] {
        Array(
            repeating: GridItem(
                .fixed(120),
                spacing: 12,
                alignment: .top
            ),
            count: 3
        )
    }
}
