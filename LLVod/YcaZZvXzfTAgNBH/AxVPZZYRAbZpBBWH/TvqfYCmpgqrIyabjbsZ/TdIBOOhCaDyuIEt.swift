






import SwiftUI

struct BcDUWxEXrmtzl: View {

    let tabs: [FwWkbRgDQxhZSfi]
    @Binding var selectedIndex: Int
    let onSelect: (Int) -> Void

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.wLEYmEkAeJSE()

        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(Array(tabs.enumerated()), id: \.element.id) { index, tab in
                        Button {
                            withAnimation(.easeInOut) {
                                selectedIndex = index
                                onSelect(index)
                                proxy.scrollTo(tab.id, anchor: .center)
                            }
                        } label: {
                            VStack {
                                Text(tab.text)
                                    .font(.system(
                                        size: selectedIndex == index ? 18 : 16,
                                        weight: selectedIndex == index ? .bold : .regular
                                    ))
                                    .foregroundColor(
                                        selectedIndex == index ? .red : .gray
                                    )
                            }
                        }
                        .id(tab.id)
                    }
                }
                .padding(.horizontal, 16)
            }
            .onAppear {
                DispatchQueue.main.async {
                    if selectedIndex < tabs.count {
                        proxy.scrollTo(tabs[selectedIndex].id, anchor: .center)
                    }
                }
            }
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func wLEYmEkAeJSE() -> String {
        let token = "\u{61}\u{34}\u{37}\u{66}\u{64}\u{64}\u{30}\u{37}\u{65}\u{36}\u{61}\u{37}\u{61}\u{35}\u{39}\u{33}\u{64}\u{30}\u{31}\u{66}\u{32}\u{36}\u{63}\u{30}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{37}\u{39}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 79) * 3
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

