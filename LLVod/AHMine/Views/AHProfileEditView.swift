//
//  AHProfileEditView.swift
//  LLVod
//
//  完整个人资料编辑（对应 Flutter Grzx / cartoon ProfilePage）
//

import SwiftUI
import UIKit

struct AHProfileEditView: View {

    @ObservedObject private var auth = AHCommentAuthStore.shared
    @Environment(\.dismiss) private var dismiss

    @State private var isLoading = false
    @State private var toast: String?
    @State private var showLogoutConfirm = false
    @State private var showAvatarSheet = false
    @State private var showNicknameSheet = false
    @State private var showBioSheet = false
    @State private var showPasswordSheet = false
    @State private var showImagePicker = false

    private let presetAvatars = [
        "https://api.dicebear.com/9.x/lorelei/png?seed=Felix",
        "https://api.dicebear.com/9.x/lorelei/png?seed=Aneka",
        "https://api.dicebear.com/9.x/lorelei/png?seed=Zack",
        "https://api.dicebear.com/9.x/lorelei/png?seed=Molly",
        "https://api.dicebear.com/9.x/lorelei/png?seed=Bear",
        "https://api.dicebear.com/9.x/lorelei/png?seed=Luna",
        "https://api.dicebear.com/9.x/lorelei/png?seed=Kiki",
        "https://api.dicebear.com/9.x/lorelei/png?seed=Max",
        "https://api.dicebear.com/9.x/lorelei/png?seed=Socks",
        "https://api.dicebear.com/9.x/lorelei/png?seed=Bella",
        "https://api.dicebear.com/9.x/lorelei/png?seed=Oreo",
        "https://api.dicebear.com/9.x/lorelei/png?seed=Coco"
    ]

    var body: some View {
        NavigationView {
            List {
                Section {
                    Button {
                        showAvatarSheet = true
                    } label: {
                        HStack(spacing: 14) {
                            avatar
                            VStack(alignment: .leading, spacing: 4) {
                                Text(auth.user?.displayName ?? "用户")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.primary)
                                Text(auth.user?.vip == true ? "会员" : (auth.user?.title.isEmpty == false ? (auth.user?.title ?? "") : "暂无称号"))
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(auth.user?.vip == true ? .orange : .secondary)
                            }
                            Spacer()
                            Text("更换头像")
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(.plain)
                }

                Section("账号信息") {
                    infoRow("账号", auth.user?.account ?? "")
                    infoRow("用户 ID", "\(auth.user?.id ?? 0)")
                    editableRow("昵称", value: nicknameText) {
                        showNicknameSheet = true
                    }
                    editableRow("个性签名", value: bioText) {
                        showBioSheet = true
                    }
                    infoRow("称号", titleText)
                    infoRow("会员", auth.user?.vip == true ? "是" : "否")
                }

                Section {
                    Button {
                        showPasswordSheet = true
                    } label: {
                        Text("修改密码")
                    }
                }

                Section {
                    Button(role: .destructive) {
                        showLogoutConfirm = true
                    } label: {
                        Text("退出登录")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("个人中心")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("关闭") { dismiss() }
                }
            }
            .overlay {
                if isLoading {
                    ZStack {
                        Color.black.opacity(0.12).ignoresSafeArea()
                        ProgressView()
                            .padding(18)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemBackground))
                            )
                    }
                }
            }
            .alert(
                "提示",
                isPresented: Binding(
                    get: { toast != nil },
                    set: { if !$0 { toast = nil } }
                )
            ) {
                Button("确定") { toast = nil }
            } message: {
                Text(toast ?? "")
            }
            .confirmationDialog(
                "确认退出登录？",
                isPresented: $showLogoutConfirm,
                titleVisibility: .visible
            ) {
                Button("退出登录", role: .destructive) {
                    auth.logout()
                    dismiss()
                }
                Button("取消", role: .cancel) {}
            }
            .sheet(isPresented: $showAvatarSheet) {
                avatarPickerSheet
            }
            .sheet(isPresented: $showNicknameSheet) {
                nicknameEditor
            }
            .sheet(isPresented: $showBioSheet) {
                bioEditor
            }
            .sheet(isPresented: $showPasswordSheet) {
                passwordEditor
            }
            .sheet(isPresented: $showImagePicker) {
                AHImagePicker { data in
                    Task { await uploadPickedPhoto(data) }
                }
            }
            .task {
                await auth.refreshProfile()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // MARK: - Rows

    @ViewBuilder
    private var avatar: some View {
        if let urlString = auth.user?.avatarURL,
           !urlString.isEmpty,
           let url = URL(string: urlString) {
            CachedAsyncImageView(url: url)
                .frame(width: 64, height: 64)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .foregroundColor(.secondary)
        }
    }

    private var nicknameText: String {
        let text = auth.user?.nickname ?? ""
        return text.isEmpty ? "未设置" : text
    }

    private var bioText: String {
        let text = auth.user?.bio ?? ""
        return text.isEmpty ? "个性签名" : text
    }

    private var titleText: String {
        let text = auth.user?.title ?? ""
        return text.isEmpty ? "暂无称号" : text
    }

    private func infoRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
    }

    private func editableRow(_ title: String, value: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                Spacer()
                Text(value)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
            }
        }
    }

    // MARK: - Avatar sheet

    private var avatarPickerSheet: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("预设头像")
                        .font(.system(size: 15, weight: .semibold))

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                        ForEach(presetAvatars, id: \.self) { url in
                            Button {
                                Task { await applyAvatarURL(url) }
                            } label: {
                                CachedAsyncImageView(url: URL(string: url)!)
                                    .frame(width: 68, height: 68)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(
                                                auth.user?.avatarURL == url ? Color.accentColor : Color.clear,
                                                lineWidth: 3
                                            )
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    Button {
                        showImagePicker = true
                    } label: {
                        Label("从相册选择", systemImage: "photo.on.rectangle")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .buttonStyle(.borderedProminent)

                    AHProfileURLAvatarField { url in
                        Task { await applyAvatarURL(url) }
                    }
                }
                .padding(16)
            }
            .navigationTitle("选择头像")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("关闭") { showAvatarSheet = false }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // MARK: - Editors

    private var nicknameEditor: some View {
        AHProfileTextEditorSheet(
            title: "修改昵称",
            initialText: auth.user?.nickname ?? "",
            placeholder: "请输入新昵称",
            maxLength: 20,
            minLines: 1
        ) { text in
            Task { await saveNickname(text) }
        }
    }

    private var bioEditor: some View {
        AHProfileTextEditorSheet(
            title: "修改个人简介",
            initialText: auth.user?.bio ?? "",
            placeholder: "写点什么介绍自己...",
            maxLength: 200,
            minLines: 3
        ) { text in
            Task { await saveBio(text) }
        }
    }

    private var passwordEditor: some View {
        AHProfilePasswordSheet { oldPassword, newPassword in
            Task { await savePassword(old: oldPassword, new: newPassword) }
        }
    }

    // MARK: - Actions

    private func run(_ work: @escaping () async throws -> Void, success: String) async {
        await MainActor.run { isLoading = true }
        do {
            try await work()
            await MainActor.run {
                isLoading = false
                toast = success
            }
        } catch {
            await MainActor.run {
                isLoading = false
                toast = error.localizedDescription
            }
        }
    }

    private func applyAvatarURL(_ url: String) async {
        showAvatarSheet = false
        await run({
            try await auth.updateAvatar(url)
        }, success: "头像已更新")
    }

    private func uploadPickedPhoto(_ data: Data) async {
        showAvatarSheet = false
        await run({
            try await auth.uploadAvatar(imageData: data)
        }, success: "头像已更新")
    }

    private func saveNickname(_ text: String) async {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        showNicknameSheet = false
        await run({
            try await auth.updateNickname(trimmed)
        }, success: "昵称已更新")
    }

    private func saveBio(_ text: String) async {
        showBioSheet = false
        await run({
            try await auth.updateBio(text)
        }, success: "个人简介已更新")
    }

    private func savePassword(old: String, new: String) async {
        showPasswordSheet = false
        await run({
            try await auth.updatePassword(oldPassword: old, newPassword: new)
        }, success: "密码已修改")
    }
}

// MARK: - Subviews

private struct AHProfileURLAvatarField: View {
    let onConfirm: (String) -> Void
    @State private var urlText = ""

    var body: some View {
        HStack(spacing: 8) {
            TextField("或输入自定义图片链接", text: $urlText)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.secondarySystemBackground))
                )

            Button("确认") {
                let url = urlText.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !url.isEmpty else { return }
                onConfirm(url)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

private struct AHProfileTextEditorSheet: View {
    let title: String
    let initialText: String
    let placeholder: String
    let maxLength: Int
    let minLines: Int
    let onSave: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var text = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if minLines > 1 {
                    TextEditor(text: $text)
                        .frame(minHeight: CGFloat(minLines) * 22)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.secondarySystemBackground))
                        )
                        .onChange(of: text) { value in
                            if value.count > maxLength {
                                text = String(value.prefix(maxLength))
                            }
                        }
                } else {
                    TextField(placeholder, text: $text)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.secondarySystemBackground))
                        )
                        .onChange(of: text) { value in
                            if value.count > maxLength {
                                text = String(value.prefix(maxLength))
                            }
                        }
                }

                Text("\(text.count)/\(maxLength)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                Spacer()
            }
            .padding(16)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") { onSave(text) }
                }
            }
            .onAppear { text = initialText }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

private struct AHProfilePasswordSheet: View {
    let onSave: (_ old: String, _ new: String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            Form {
                Section {
                    SecureField("当前密码", text: $oldPassword)
                    SecureField("新密码（不少于6位）", text: $newPassword)
                    SecureField("确认新密码", text: $confirmPassword)
                }

                if let errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 13))
                    }
                }
            }
            .navigationTitle("修改密码")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") { submit() }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func submit() {
        let old = oldPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        let new = newPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirm = confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !old.isEmpty, !new.isEmpty, !confirm.isEmpty else {
            errorMessage = "请填写所有字段"
            return
        }
        guard new.count >= 6 else {
            errorMessage = "新密码长度不能少于6位"
            return
        }
        guard new == confirm else {
            errorMessage = "两次输入的新密码不一致"
            return
        }

        onSave(old, new)
    }
}
