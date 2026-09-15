//
//  AHCommentLoginSheet.swift
//  LLVod
//
//  发表评论需要登录，这里提供最小可用的登录 / 注册入口
//

import SwiftUI

struct AHCommentLoginSheet: View {

    @ObservedObject private var auth = AHCommentAuthStore.shared
    @Environment(\.dismiss) private var dismiss

    @State private var isRegistering = false
    @State private var account = ""
    @State private var password = ""
    @State private var nickname = ""
    @State private var isSubmitting = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 18) {
                Picker("", selection: $isRegistering) {
                    Text("登录").tag(false)
                    Text("注册").tag(true)
                }
                .pickerStyle(.segmented)

                VStack(spacing: 12) {
                    inputField("手机号或邮箱", text: $account)

                    SecureField("密码，至少 6 位", text: $password)
                        .font(.system(size: 15))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.secondarySystemBackground))
                        )

                    if isRegistering {
                        inputField("昵称，可不填", text: $nickname)
                    }
                }

                if let errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 13))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Button(action: submit) {
                    HStack(spacing: 8) {
                        if isSubmitting {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }

                        Text(isRegistering ? "注册并登录" : "登录")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(canSubmit ? AHCommentPalette.accent : AHCommentPalette.accent.opacity(0.4))
                    )
                }
                .buttonStyle(.plain)
                .disabled(!canSubmit)

                Spacer()
            }
            .padding(16)
            .navigationTitle(isRegistering ? "注册账号" : "登录后发表评论")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("关闭") { dismiss() }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func inputField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .font(.system(size: 15))
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.secondarySystemBackground))
            )
    }

    private var canSubmit: Bool {
        !isSubmitting
            && !account.trimmingCharacters(in: .whitespaces).isEmpty
            && password.count >= 6
    }

    private func submit() {
        guard canSubmit else { return }

        isSubmitting = true
        errorMessage = nil

        Task {
            do {
                let trimmedAccount = account.trimmingCharacters(in: .whitespaces)

                if isRegistering {
                    try await auth.register(
                        account: trimmedAccount,
                        password: password,
                        nickname: nickname.trimmingCharacters(in: .whitespaces)
                    )
                } else {
                    try await auth.login(account: trimmedAccount, password: password)
                }

                isSubmitting = false
                dismiss()
            } catch {
                isSubmitting = false
                errorMessage = error.localizedDescription
            }
        }
    }
}
