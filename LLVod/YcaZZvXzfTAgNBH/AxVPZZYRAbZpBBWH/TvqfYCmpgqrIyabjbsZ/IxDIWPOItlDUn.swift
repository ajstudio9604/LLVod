






import SwiftUI

struct EdkjhToMiNVs: View {

    @ObservedObject var viewModel: HjMioZPzBLELiDyx
    @FocusState.Binding var isFocused: Bool

    var body: some View {
        
        iKOZnjtoAHlabOPQKQ()
    }

    

    

    
    @ViewBuilder
    @inline(never)
    private func iKOZnjtoAHlabOPQKQ() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.kNKxKjrGyTNxNX()

        hWqEYGJRbBpoe
    }

    @ViewBuilder
    private var hWqEYGJRbBpoe: some View {
        VStack(spacing: 0) {
            gVPoiRLtgKajmaDP

            hOVhlRZEJCTUT

            wTrOGwnwSGfKaooar
        }
        .background(Color(.systemBackground))
    }


    @ViewBuilder
    private var wTrOGwnwSGfKaooar: some View {
        HStack(spacing: 12) {
                TextField(viewModel.inputPlaceholder, text: $viewModel.draft)
                    .font(.system(size: 15))
                    .disableAutocorrection(true)
                    .focused($isFocused)
                    .submitLabel(.send)
                    .onSubmit(send)

                Button(action: send) {
                    Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{4a}\u{41}\u{35}\u{69}\u{41}\u{78}\u{72}\u{5a}\u{31}"))
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)
                        .background(
                            Circle().fill(
                                viewModel.canSend
                                    ? UhQdrGVmfViYYgQaF.accent
                                    : UhQdrGVmfViYYgQaF.accent.opacity(0.4)
                            )
                        )
                }
                .buttonStyle(.plain)
                .disabled(!viewModel.canSend)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
    }

    @ViewBuilder
    private var gVPoiRLtgKajmaDP: some View {
        if let target = viewModel.replyTarget {
                xZWcjjQQqbklvyk(target)
            }
    }

    @ViewBuilder
    private var hOVhlRZEJCTUT: some View {
        Divider()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func kNKxKjrGyTNxNX() -> String {
        let values = [44, 51, 308, 61]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 44) * 7
        let token = "\u{30}\u{61}\u{38}\u{33}\u{65}\u{34}\u{35}\u{63}\u{34}\u{31}\u{64}\u{34}\u{36}\u{37}\u{37}\u{38}\u{61}\u{35}\u{39}\u{31}\u{61}\u{64}\u{30}\u{63}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}



extension EdkjhToMiNVs {
    private func send() {
        Task { await viewModel.send() }
    }

    private func xZWcjjQQqbklvyk(_ target: RvGGzFHfQwFzCOaegZ) -> some View {
        HStack(spacing: 8) {
            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{36}\u{62}\u{56}\u{53}\u{48}\u{77}\u{41}\u{54}\u{61}"))
                .font(.system(size: 12))

            Text("\u{56de}\u{590d} \(target.displayName)")
                .font(.system(size: 13))
                .lineLimit(1)

            Spacer(minLength: 12)

            Button {
                viewModel.aYIjzRyIaDHpSCzm()
            } label: {
                Text(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{44}\u{72}\u{65}\u{6d}\u{58}\u{42}\u{69}\u{55}\u{6b}"))
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.plain)
        }
        .foregroundColor(UhQdrGVmfViYYgQaF.accent)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(UhQdrGVmfViYYgQaF.accentSoft)
    }
}
