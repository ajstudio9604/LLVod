




import SwiftUI

struct FooTcfcqAdzSMaSBddG<Item: Identifiable>: View where Item.ID: Hashable {

    let items: [Item]
    @Binding var selectedIndex: Int
    let title: (Item) -> String
    let selectedFont: Font
    let normalFont: Font
    let onSelect: (Int) -> Void

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.wUxmCuAhZALeUpvgza()

        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        Button {
                            withAnimation(.easeInOut) {
                                selectedIndex = index
                                onSelect(index)
                                proxy.scrollTo(item.id, anchor: .center)
                            }
                        } label: {
                            VStack(spacing: 6) {
                                Text(title(item))
                                    .font(selectedIndex == index ? selectedFont : normalFont)
                                    .foregroundColor(selectedIndex == index ? .red : .gray)

                                Capsule()
                                    .fill(selectedIndex == index ? .red : .clear)
                                    .frame(width: 16, height: 3)
                            }
                        }
                        .id(item.id)
                        .padding(.top, 8)
                    }
                }
                .padding(.horizontal, 20)
            }
            .onAppear {
                DispatchQueue.main.async {
                    guard items.indices.contains(selectedIndex) else { return }
                    proxy.scrollTo(items[selectedIndex].id, anchor: .center)
                }
            }
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func wUxmCuAhZALeUpvgza() -> String {
        let token = "\u{34}\u{36}\u{32}\u{37}\u{62}\u{33}\u{61}\u{33}\u{66}\u{32}\u{35}\u{31}\u{31}\u{38}\u{37}\u{30}\u{30}\u{66}\u{64}\u{33}\u{63}\u{39}\u{38}\u{31}"
        let base = (75 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 75) * 9
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

