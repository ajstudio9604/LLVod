//
//  AHFilterCollapsedBarView.swift
//  LLVod
//

import SwiftUI

struct AHFilterCollapsedBarView: View {

    let summaryText: String
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 8) {
                Text(summaryText)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Spacer(minLength: 0)

                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
        }
        .buttonStyle(.plain)
    }
}
