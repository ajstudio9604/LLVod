






import SwiftUI

struct RlSgzWCAmGEEcraCVKPR: View {

    @ObservedObject private var auth = NvCczyBSOghG.shared
    @Environment(\.dismiss) private var dismiss

    @State private var isRegistering = false
    @State private var account = ""
    @State private var password = ""
    @State private var nickname = ""
    @State private var isSubmitting = false
    @State private var errorMessage: String?

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.vGVzjnznjwZLRaYffV()

        NavigationView {
            VStack(spacing: 18) {
                Picker("", selection: $isRegistering) {
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{39}\u{54}\u{6f}\u{64}\u{39}\u{39}\u{43}\u{42}")).tag(false)
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6e}\u{6e}\u{53}\u{50}\u{4f}\u{65}\u{77}\u{33}\u{61}")).tag(true)
                }
                .pickerStyle(.segmented)

                VStack(spacing: 12) {
                    tASzYjpvKRtnIXd(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4b}\u{69}\u{76}\u{6b}\u{56}\u{79}\u{59}\u{6c}\u{4e}"), text: $account)

                    SecureField(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{6a}\u{42}\u{7a}\u{47}\u{71}\u{50}\u{67}\u{7a}"), text: $password)
                        .font(.system(size: 15))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.secondarySystemBackground))
                        )

                    if isRegistering {
                        tASzYjpvKRtnIXd(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{43}\u{48}\u{6c}\u{69}\u{49}\u{6f}\u{37}\u{4b}\u{36}"), text: $nickname)
                    }
                }

                if errorMessage != nil {
                    Button {
                        kXvfeaBhrEUJyQiRZb()
                    } label: {
                        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{51}\u{53}\u{72}\u{49}\u{49}\u{69}\u{34}\u{4a}\u{74}"))
                            .font(.system(size: 13))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .buttonStyle(.plain)
                    .disabled(isSubmitting)
                }

                Button(action: kXvfeaBhrEUJyQiRZb) {
                    HStack(spacing: 8) {
                        if isSubmitting {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }

                        Text(isRegistering ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{77}\u{47}\u{62}\u{4c}\u{73}\u{71}\u{74}\u{73}\u{41}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{39}\u{54}\u{6f}\u{64}\u{39}\u{39}\u{43}\u{42}"))
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(canSubmit ? UhQdrGVmfViYYgQaF.accent : UhQdrGVmfViYYgQaF.accent.opacity(0.4))
                    )
                }
                .buttonStyle(.plain)
                .disabled(!canSubmit)

                Spacer()
            }
            .padding(16)
            .navigationTitle(isRegistering ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{42}\u{6d}\u{77}\u{75}\u{62}\u{4f}\u{55}\u{6c}\u{61}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{66}\u{34}\u{71}\u{36}\u{53}\u{4d}\u{64}\u{44}"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{6a}\u{77}\u{42}\u{70}\u{64}\u{77}\u{6c}\u{70}")) { dismiss() }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func vGVzjnznjwZLRaYffV() -> String {
        let token = "\u{38}\u{30}\u{63}\u{66}\u{66}\u{61}\u{64}\u{35}\u{39}\u{61}\u{36}\u{33}\u{36}\u{33}\u{32}\u{62}\u{66}\u{36}\u{62}\u{66}\u{33}\u{31}\u{35}\u{39}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{36}\u{36}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 66) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension RlSgzWCAmGEEcraCVKPR {
    private var canSubmit: Bool {
        !isSubmitting
            && !account.trimmingCharacters(in: .whitespaces).isEmpty
            && password.count >= 6
    }

    private func kXvfeaBhrEUJyQiRZb() {
        guard canSubmit else { return }

        isSubmitting = true
        errorMessage = nil

        Task {
            do {
                let trimmedAccount = account.trimmingCharacters(in: .whitespaces)

                if isRegistering {
                    try await auth.iLPsNCIOPlcMBRFHanQ(
                        account: trimmedAccount,
                        password: password,
                        nickname: nickname.trimmingCharacters(in: .whitespaces)
                    )
                } else {
                    try await auth.rGJbcIWyUjWv(account: trimmedAccount, password: password)
                }

                isSubmitting = false
                dismiss()
            } catch {
                isSubmitting = false
                errorMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{5a}\u{51}\u{55}\u{6b}\u{48}\u{32}\u{47}\u{78}\u{4c}")
            }
        }
    }

    private func tASzYjpvKRtnIXd(_ placeholder: String, text: Binding<String>) -> some View {
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
}
