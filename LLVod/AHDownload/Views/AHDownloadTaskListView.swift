//
//  AHDownloadTaskListView.swift
//  LLVod
//
//  下载管理的弹窗外壳，内容与首页进入的下载管理一致
//

import SwiftUI

struct AHDownloadTaskListView: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            AHDownloadManagerView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("关闭") { dismiss() }
                    }
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AHLocalPlayback: Identifiable {
    let id = UUID()
    let url: URL
    var title: String = ""
    var episodeTitle: String = ""
}
