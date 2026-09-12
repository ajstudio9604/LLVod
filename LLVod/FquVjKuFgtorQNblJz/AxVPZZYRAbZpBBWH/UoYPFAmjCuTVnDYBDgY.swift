






import SwiftUI
import UIKit

struct MelISYOibLzzntRZdcKc: View {

    @ObservedObject private var auth = NvCczyBSOghG.shared
    @Environment(\.dismiss) private var dismiss

    @State private var isLoading = false
    @State private var toast: String?
    @State private var retryAction: (() -> Void)?
    @State private var showLogoutConfirm = false
    @State private var showAvatarSheet = false
    @State private var showNicknameSheet = false
    @State private var showBioSheet = false
    @State private var showPasswordSheet = false
    @State private var showImagePicker = false

    private let presetAvatars = [
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4f}\u{32}\u{35}\u{6b}\u{4e}\u{38}\u{41}\u{63}\u{74}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{4c}\u{4c}\u{66}\u{70}\u{53}\u{62}\u{4e}\u{63}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{41}\u{72}\u{52}\u{4d}\u{4f}\u{4b}\u{74}\u{37}\u{43}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{73}\u{56}\u{63}\u{6c}\u{59}\u{6f}\u{47}\u{52}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{79}\u{36}\u{6d}\u{52}\u{39}\u{4a}\u{62}\u{6b}\u{62}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4f}\u{39}\u{72}\u{52}\u{64}\u{55}\u{65}\u{78}\u{4d}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{74}\u{52}\u{55}\u{30}\u{39}\u{66}\u{35}\u{76}\u{77}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{31}\u{67}\u{35}\u{31}\u{77}\u{66}\u{70}\u{75}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{69}\u{34}\u{64}\u{6e}\u{72}\u{55}\u{76}\u{6d}\u{66}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{56}\u{73}\u{43}\u{62}\u{63}\u{52}\u{6c}\u{59}\u{49}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{59}\u{62}\u{32}\u{4a}\u{35}\u{6e}\u{61}\u{48}"),
        AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{59}\u{42}\u{37}\u{71}\u{55}\u{50}\u{66}\u{45}")
    ]

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.jWCkHmrCjanC()

        NavigationView {
            List {
                Section {
                    Button {
                        showAvatarSheet = true
                    } label: {
                        HStack(spacing: 14) {
                            avatar
                            VStack(alignment: .leading, spacing: 4) {
                                Text(auth.user?.displayName ?? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{38}\u{45}\u{41}\u{34}\u{63}\u{4d}\u{57}\u{37}"))
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.primary)
                                Text(auth.user?.vip == true ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{6b}\u{30}\u{72}\u{63}\u{45}\u{51}\u{62}\u{64}") : (auth.user?.title.isEmpty == false ? (auth.user?.title ?? "") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{38}\u{6b}\u{4d}\u{49}\u{7a}\u{53}\u{79}\u{42}")))
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(auth.user?.vip == true ? .orange : .secondary)
                            }
                            Spacer()
                            Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{42}\u{57}\u{35}\u{53}\u{78}\u{4b}\u{7a}\u{33}"))
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{6b}\u{71}\u{39}\u{45}\u{73}\u{6e}\u{7a}\u{4a}"))
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(.plain)
                }

                Section(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{52}\u{74}\u{43}\u{37}\u{76}\u{72}\u{4f}\u{34}\u{65}")) {
                    kTWqSEZnfuKgfpFXZq(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{46}\u{4c}\u{33}\u{77}\u{34}\u{64}\u{62}\u{39}\u{57}"), auth.user?.account ?? "")
                    kTWqSEZnfuKgfpFXZq(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{54}\u{4d}\u{67}\u{59}\u{6a}\u{55}\u{63}\u{35}\u{74}"), "\(auth.user?.id ?? 0)")
                    kBfxhXJhzzjTDxu(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4e}\u{31}\u{72}\u{69}\u{68}\u{69}\u{35}\u{55}\u{4e}"), value: nicknameText) {
                        showNicknameSheet = true
                    }
                    kBfxhXJhzzjTDxu(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{55}\u{51}\u{62}\u{63}\u{62}\u{37}\u{79}\u{4a}"), value: bioText) {
                        showBioSheet = true
                    }
                    kTWqSEZnfuKgfpFXZq(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{78}\u{45}\u{51}\u{77}\u{73}\u{4f}\u{5a}\u{6e}\u{6e}"), titleText)
                    kTWqSEZnfuKgfpFXZq(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{6b}\u{30}\u{72}\u{63}\u{45}\u{51}\u{62}\u{64}"), auth.user?.vip == true ? "\u{662f}" : "\u{5426}")
                }

                Section {
                    Button {
                        showPasswordSheet = true
                    } label: {
                        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{38}\u{42}\u{5a}\u{58}\u{69}\u{77}\u{34}\u{64}"))
                    }
                }

                Section {
                    Button(role: .destructive) {
                        showLogoutConfirm = true
                    } label: {
                        Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{76}\u{6e}\u{31}\u{50}\u{74}\u{55}\u{36}\u{6c}"))
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{4d}\u{33}\u{50}\u{6b}\u{35}\u{73}\u{61}\u{37}"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{6a}\u{77}\u{42}\u{70}\u{64}\u{77}\u{6c}\u{70}")) { dismiss() }
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
            .overlay(alignment: .bottom) {
                if let toast {
                    Button {
                        if let retryAction {
                            retryAction()
                        } else {
                            self.toast = nil
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(toast)
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                            Text(retryAction == nil ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{75}\u{79}\u{67}\u{51}\u{79}\u{59}\u{4f}\u{56}\u{54}") : AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{69}\u{67}\u{72}\u{57}\u{33}\u{6c}\u{75}\u{7a}"))
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(Color.accentColor)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(14)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
            }
            .confirmationDialog(
                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{56}\u{78}\u{6f}\u{33}\u{42}\u{43}\u{79}\u{63}"),
                isPresented: $showLogoutConfirm,
                titleVisibility: .visible
            ) {
                Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{76}\u{6e}\u{31}\u{50}\u{74}\u{55}\u{36}\u{6c}"), role: .destructive) {
                    auth.xUsPntoIkOfxiTZq()
                    dismiss()
                }
                Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{72}\u{65}\u{6d}\u{58}\u{42}\u{69}\u{55}\u{6b}"), role: .cancel) {}
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
                UjTWoTolvyir { data in
                    Task { await qTDerrsmCyHj(data) }
                }
            }
            .task {
                await auth.eCfZrdvNkkITIDCYyZaR()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    

    

    

    

    

    

    

    

    

    

    

    

    private var passwordEditor: some View {
        CuHnwzWcDJtxqCkFiUyN { oldPassword, newPassword in
            Task { await aHjfroGcrSYEQeUu(old: oldPassword, new: newPassword) }
        }
    }

    

    

    

    

    

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func jWCkHmrCjanC() -> String {
        _ = Self.nKAVgvFFgCvfvzTpza()
        let values = [14, 17, 42, 31]
        let folded = values.map { ($0 * 3 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 14) * 3
        let token = "\u{64}\u{38}\u{31}\u{33}\u{35}\u{62}\u{62}\u{39}\u{63}\u{36}\u{34}\u{31}\u{32}\u{65}\u{64}\u{38}\u{37}\u{32}\u{65}\u{34}\u{64}\u{64}\u{39}\u{35}"
        _ = Self.uORPkEOCbxpDKOP()
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
    @inline(never)
    private nonisolated static func uORPkEOCbxpDKOP() -> String {
        let token = "\u{38}\u{38}\u{65}\u{65}\u{32}\u{31}\u{63}\u{62}\u{31}\u{34}\u{63}\u{35}\u{64}\u{64}\u{37}\u{66}\u{37}\u{34}\u{61}\u{33}\u{31}\u{66}\u{61}\u{31}"
        let base = (8 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 8) * 3
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func nKAVgvFFgCvfvzTpza() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{37}\u{32}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 72) * 8
        let token = "\u{34}\u{34}\u{36}\u{31}\u{66}\u{35}\u{63}\u{30}\u{32}\u{32}\u{30}\u{32}\u{30}\u{65}\u{36}\u{66}\u{37}\u{35}\u{36}\u{34}\u{65}\u{30}\u{39}\u{61}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}



private struct RhvYfarUIOdFR: View {
    let eJUpagJkvjWJwD: (String) -> Void
    @State private var urlText = ""

    var body: some View {
        
        fEhUlIhTFTRjcOHi()
    }

    
    @ViewBuilder
    @inline(never)
    private func fEhUlIhTFTRjcOHi() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.yGOFveqdSMZUIieep()

        nHoVEcMPPDJQ
    }

    @ViewBuilder
    private var nHoVEcMPPDJQ: some View {
        HStack(spacing: 8) {
            wZNPDqTlbNeKShd

            zKuKTjCdMLTViM
        }
    }


    @ViewBuilder
    private var zKuKTjCdMLTViM: some View {
        Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{4d}\u{58}\u{52}\u{33}\u{42}\u{7a}\u{53}\u{66}")) {
                let url = urlText.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !url.isEmpty else { return }
                eJUpagJkvjWJwD(url)
            }
            .buttonStyle(.borderedProminent)
    }

    @ViewBuilder
    private var wZNPDqTlbNeKShd: some View {
        TextField(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{57}\u{4d}\u{34}\u{72}\u{49}\u{6a}\u{46}\u{4a}\u{32}"), text: $urlText)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.secondarySystemBackground))
                )
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func yGOFveqdSMZUIieep() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{31}\u{35}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 15) * 9
        let token = "\u{37}\u{30}\u{66}\u{31}\u{32}\u{39}\u{66}\u{64}\u{36}\u{37}\u{66}\u{32}\u{31}\u{37}\u{34}\u{62}\u{62}\u{36}\u{35}\u{35}\u{34}\u{63}\u{61}\u{61}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}

private struct LdsvUYDrxCBQ: View {
    let title: String
    let initialText: String
    let placeholder: String
    let maxLength: Int
    let minLines: Int
    let lScgpyIaybrcGztlS: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var text = ""

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.kPXrAvXcKDSCOyNk()

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

                Text("\(text.count)\u{2f}\(maxLength)")
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
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{72}\u{65}\u{6d}\u{58}\u{42}\u{69}\u{55}\u{6b}")) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{54}\u{4b}\u{57}\u{73}\u{68}\u{71}\u{31}\u{37}")) { lScgpyIaybrcGztlS(text) }
                }
            }
            .onAppear { text = initialText }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func kPXrAvXcKDSCOyNk() -> String {
        let token = "\u{37}\u{65}\u{31}\u{31}\u{35}\u{39}\u{35}\u{33}\u{34}\u{31}\u{38}\u{64}\u{34}\u{65}\u{65}\u{63}\u{63}\u{64}\u{37}\u{66}\u{36}\u{30}\u{32}\u{36}"
        let source = "\u{37}\u{65}\u{31}\u{31}\u{35}\u{39}\u{35}\u{33}\u{34}\u{31}\u{38}\u{64}\u{34}\u{65}\u{65}\u{63}\u{63}\u{64}\u{37}\u{66}\u{36}\u{30}\u{32}\u{36}\u{2d}\u{37}\u{35}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 75) * 2
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

private struct CuHnwzWcDJtxqCkFiUyN: View {
    let lScgpyIaybrcGztlS: (_ old: String, _ new: String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String?

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.mCzAmfUUwDajqm()

        NavigationView {
            Form {
                Section {
                    SecureField(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{67}\u{73}\u{36}\u{74}\u{61}\u{4e}\u{48}\u{6c}"), text: $oldPassword)
                    SecureField(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{5a}\u{76}\u{66}\u{61}\u{6c}\u{59}\u{70}\u{7a}\u{6a}"), text: $newPassword)
                    SecureField(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6f}\u{34}\u{74}\u{47}\u{67}\u{74}\u{41}\u{37}\u{61}"), text: $confirmPassword)
                }

                if let errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 13))
                    }
                }
            }
            .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6c}\u{38}\u{42}\u{5a}\u{58}\u{69}\u{77}\u{34}\u{64}"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{72}\u{65}\u{6d}\u{58}\u{42}\u{69}\u{55}\u{6b}")) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{61}\u{54}\u{4b}\u{57}\u{73}\u{68}\u{71}\u{31}\u{37}")) { kXvfeaBhrEUJyQiRZb() }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mCzAmfUUwDajqm() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 67, "\u{65}\u{61}\u{73}\u{74}": 70, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 201]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 67) * 3
        let token = "\u{30}\u{38}\u{30}\u{30}\u{39}\u{34}\u{62}\u{63}\u{38}\u{63}\u{64}\u{33}\u{34}\u{35}\u{31}\u{39}\u{33}\u{35}\u{61}\u{37}\u{31}\u{62}\u{33}\u{32}"
        guard score > 24 else {
            return token + "\u{2d}" + String(score)
        }
        return String(token.prefix(12)) + String(score % 31)
    }
}



extension CuHnwzWcDJtxqCkFiUyN {
    private func kXvfeaBhrEUJyQiRZb() {
        let old = oldPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        let new = newPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirm = confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !old.isEmpty, !new.isEmpty, !confirm.isEmpty else {
            errorMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{64}\u{61}\u{6a}\u{55}\u{4f}\u{61}\u{46}\u{4f}\u{30}")
            return
        }
        guard new.count >= 6 else {
            errorMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{68}\u{58}\u{39}\u{67}\u{5a}\u{6d}\u{32}\u{51}\u{47}")
            return
        }
        guard new == confirm else {
            errorMessage = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{70}\u{39}\u{33}\u{37}\u{56}\u{5a}\u{4d}\u{58}\u{38}")
            return
        }

        lScgpyIaybrcGztlS(old, new)
    }
}


extension MelISYOibLzzntRZdcKc {
    private var avatarPickerSheet: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{6f}\u{4c}\u{68}\u{36}\u{38}\u{63}\u{4e}\u{4e}"))
                        .font(.system(size: 15, weight: .semibold))

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                        ForEach(presetAvatars, id: \.self) { url in
                            Button {
                                Task { await aXswDIfirUjph(url) }
                            } label: {
                                EtXjBLbNYUbhXfeKeH(url: URL(string: url)!)
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
                        Label(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{35}\u{4b}\u{43}\u{79}\u{6d}\u{61}\u{77}\u{5a}\u{45}"), systemImage: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{50}\u{67}\u{72}\u{52}\u{68}\u{6f}\u{57}\u{6d}\u{4f}"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .buttonStyle(.borderedProminent)

                    RhvYfarUIOdFR { url in
                        Task { await aXswDIfirUjph(url) }
                    }
                }
                .padding(16)
            }
            .navigationTitle(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{49}\u{6c}\u{78}\u{41}\u{71}\u{4a}\u{30}\u{76}"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6b}\u{6a}\u{77}\u{42}\u{70}\u{64}\u{77}\u{6c}\u{70}")) { showAvatarSheet = false }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func kTWqSEZnfuKgfpFXZq(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
    }

    private func vEtJtFxUoKfYQE(_ text: String) async {
        showBioSheet = false
        await yEGOGsuDrdMVvNqOCH({
            try await auth.jCOAeYiiAczWSnlvoLgm(text)
        }, success: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{67}\u{49}\u{4d}\u{54}\u{50}\u{62}\u{6d}\u{70}"), retry: {
            Task { await vEtJtFxUoKfYQE(text) }
        })
    }

    @ViewBuilder
    private var avatar: some View {
        if let urlString = auth.user?.avatarURL,
           !urlString.isEmpty,
           let url = URL(string: urlString) {
            EtXjBLbNYUbhXfeKeH(url: url)
                .frame(width: 64, height: 64)
                .clipShape(Circle())
        } else {
            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{57}\u{44}\u{32}\u{51}\u{63}\u{65}\u{69}\u{4f}\u{37}"))
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .foregroundColor(.secondary)
        }
    }

    private func kBfxhXJhzzjTDxu(_ title: String, value: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                Spacer()
                Text(value)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{73}\u{6b}\u{71}\u{39}\u{45}\u{73}\u{6e}\u{7a}\u{4a}"))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
            }
        }
    }

    private var nicknameEditor: some View {
        LdsvUYDrxCBQ(
            title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{79}\u{4e}\u{39}\u{45}\u{63}\u{49}\u{61}\u{61}\u{73}"),
            initialText: auth.user?.nickname ?? "",
            placeholder: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{72}\u{37}\u{39}\u{61}\u{63}\u{58}\u{56}\u{6b}"),
            maxLength: 20,
            minLines: 1
        ) { text in
            Task { await qWisDuSAWGvrGD(text) }
        }
    }

    private var bioEditor: some View {
        LdsvUYDrxCBQ(
            title: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4d}\u{30}\u{6d}\u{65}\u{63}\u{43}\u{46}\u{43}\u{62}"),
            initialText: auth.user?.bio ?? "",
            placeholder: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{72}\u{32}\u{67}\u{4e}\u{33}\u{35}\u{6d}\u{51}\u{79}"),
            maxLength: 200,
            minLines: 3
        ) { text in
            Task { await vEtJtFxUoKfYQE(text) }
        }
    }

    private var bioText: String {
        let text = auth.user?.bio ?? ""
        return text.isEmpty ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{65}\u{55}\u{51}\u{62}\u{63}\u{62}\u{37}\u{79}\u{4a}") : text
    }

    private func yEGOGsuDrdMVvNqOCH(
        _ work: @escaping () async throws -> Void,
        success: String,
        retry: @escaping () -> Void
    ) async {
        await MainActor.run {
            isLoading = true
            toast = nil
            retryAction = nil
        }
        do {
            try await work()
            await MainActor.run {
                isLoading = false
                toast = success
                retryAction = nil
            }
        } catch {
            await MainActor.run {
                isLoading = false
                toast = AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{58}\u{74}\u{32}\u{52}\u{65}\u{61}\u{46}\u{46}\u{67}")
                retryAction = retry
            }
        }
    }

    private func qTDerrsmCyHj(_ data: Data) async {
        showAvatarSheet = false
        await yEGOGsuDrdMVvNqOCH({
            try await auth.fYPvGMYYHemPGnvj(imageData: data)
        }, success: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{52}\u{74}\u{70}\u{5a}\u{36}\u{4f}\u{6a}\u{71}\u{63}"), retry: {
            Task { await qTDerrsmCyHj(data) }
        })
    }

    private func qWisDuSAWGvrGD(_ text: String) async {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        showNicknameSheet = false
        await yEGOGsuDrdMVvNqOCH({
            try await auth.xNGwzTnETmLdbVOs(trimmed)
        }, success: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{34}\u{6e}\u{6c}\u{64}\u{34}\u{63}\u{5a}\u{33}\u{75}"), retry: {
            Task { await qWisDuSAWGvrGD(trimmed) }
        })
    }

    private var nicknameText: String {
        let text = auth.user?.nickname ?? ""
        return text.isEmpty ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{5a}\u{71}\u{4d}\u{78}\u{78}\u{38}\u{67}\u{5a}\u{79}") : text
    }

    private func aHjfroGcrSYEQeUu(old: String, new: String) async {
        showPasswordSheet = false
        await yEGOGsuDrdMVvNqOCH({
            try await auth.uFeeBuyrqIeAGHvlPiss(oldPassword: old, newPassword: new)
        }, success: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{49}\u{38}\u{42}\u{41}\u{4e}\u{78}\u{78}\u{66}"), retry: {
            Task { await aHjfroGcrSYEQeUu(old: old, new: new) }
        })
    }

    private func aXswDIfirUjph(_ url: String) async {
        showAvatarSheet = false
        await yEGOGsuDrdMVvNqOCH({
            try await auth.rIgOnXERfukMSzhqVr(url)
        }, success: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{52}\u{74}\u{70}\u{5a}\u{36}\u{4f}\u{6a}\u{71}\u{63}"), retry: {
            Task { await aXswDIfirUjph(url) }
        })
    }

    private var titleText: String {
        let text = auth.user?.title ?? ""
        return text.isEmpty ? AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{32}\u{38}\u{6b}\u{4d}\u{49}\u{7a}\u{53}\u{79}\u{42}") : text
    }
}
