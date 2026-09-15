//
//  ProfileView.swift
//  LLVod
//
//  兼容旧入口，实际内容在 AHMineView
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        AHMineView()
    }
}

#Preview {
    ProfileView()
        .environmentObject(ThemeManager.shared)
}
