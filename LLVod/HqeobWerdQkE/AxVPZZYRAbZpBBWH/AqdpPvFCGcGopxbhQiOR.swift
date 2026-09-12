




import SwiftUI

struct DfIRdUTggrRRKIWQO: View {

    let options: [String]
    let selectedIndex: Int
    let onSelect: (Int) -> Void

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.jRpxcrNHVdthWoSP()

        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                        Button {
                            onSelect(index)
                            withAnimation(.easeInOut) {
                                proxy.scrollTo(index, anchor: .center)
                            }
                        } label: {
                            Text(option)
                                .font(.system(
                                    size: selectedIndex == index ? 12.5 : 12,
                                    weight: .bold
                                ))
                                .foregroundColor(
                                    selectedIndex == index ? .red : .primary
                                )
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 7)
                                        .fill(
                                            selectedIndex == index
                                                ? Color.red.opacity(0.12)
                                                : Color.clear
                                        )
                                )
                        }
                        .id(index)
                    }
                }
                .padding(.leading, 12)
                .padding(.trailing, 8)
            }
            .onAppear {
                DispatchQueue.main.async {
                    proxy.scrollTo(selectedIndex, anchor: .center)
                }
            }
            .onChange(of: selectedIndex) { index in
                withAnimation(.easeInOut) {
                    proxy.scrollTo(index, anchor: .center)
                }
            }
        }
        .frame(height: 38)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func jRpxcrNHVdthWoSP() -> String {
        let values = [18, 23, 90, 35]
        let folded = values.map { ($0 * 5 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 18) * 5
        let token = "\u{63}\u{65}\u{65}\u{35}\u{64}\u{66}\u{35}\u{63}\u{35}\u{38}\u{32}\u{39}\u{63}\u{35}\u{35}\u{30}\u{62}\u{62}\u{62}\u{33}\u{33}\u{32}\u{34}\u{64}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}

