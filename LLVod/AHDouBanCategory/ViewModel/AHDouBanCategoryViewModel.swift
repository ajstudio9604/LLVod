//
//  AHDouBanCategoryViewModel.swift
//  LLVod
//

import Foundation
import Combine

@MainActor
final class AHDouBanCategoryViewModel: ObservableObject {

    let tabs: [AHDouBanTabItem] = [
        AHDouBanTabItem(title: "全部", category: "all"),
        AHDouBanTabItem(title: "精选", category: "selected"),
        AHDouBanTabItem(title: "经典", category: "classical"),
        AHDouBanTabItem(title: "高分", category: "high_score"),
        AHDouBanTabItem(title: "榜单", category: "movie_list"),
        AHDouBanTabItem(title: "主题", category: "topic"),
        AHDouBanTabItem(title: "韩国", category: "korea"),
        AHDouBanTabItem(title: "欧美", category: "western"),
    ]

    private var pieceViewModels: [String: AHDouBanPieceViewModel] = [:]

    func pieceViewModel(for tab: AHDouBanTabItem) -> AHDouBanPieceViewModel {
        if let existing = pieceViewModels[tab.category] {
            return existing
        }

        let viewModel = AHDouBanPieceViewModel(category: tab.category)
        pieceViewModels[tab.category] = viewModel
        return viewModel
    }
}
