//
//  AHVodDetailSearchBarView.swift
//  LLVod
//
//  详情页分页标签右侧的搜索入口
//

import SwiftUI

struct AHVodDetailSearchBarView: View {

    var placeholder: String = "请输入关键字"
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: "magnifyingglass")
                Text(placeholder)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)

                Spacer()
            }
            .padding(.horizontal, 10)
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
    }
}
