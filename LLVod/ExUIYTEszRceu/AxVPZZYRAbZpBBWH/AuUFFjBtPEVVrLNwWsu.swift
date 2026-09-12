




import SwiftUI

struct DxFuXEXLZARkWtNVnB: View {

    let items: [String]
    let keyword: String
    var onSelect: (String) -> Void

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.vCsrTUFwYPSXGWIqd()

        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(items, id: \.self) { item in
                    Button {
                        onSelect(item)
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{49}\u{66}\u{32}\u{52}\u{4c}\u{74}\u{31}\u{50}\u{76}"))
                                .font(.system(size: 18))
                                .foregroundColor(.primary)

                            CvIUmWDEhqVPqUXNM(
                                text: item,
                                searchContent: keyword
                            )

                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 15)
                        .frame(height: 45)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)

                    Divider()
                        .padding(.leading, 41)
                }
            }
        }
        .background(Color(.systemBackground))
        .ahDismissKeyboardOnScroll()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func vCsrTUFwYPSXGWIqd() -> String {
        let token = "\u{63}\u{65}\u{36}\u{39}\u{34}\u{32}\u{34}\u{62}\u{62}\u{33}\u{30}\u{64}\u{65}\u{31}\u{61}\u{32}\u{31}\u{32}\u{31}\u{32}\u{65}\u{32}\u{37}\u{32}"
        let base = (31 * 7 + 19) % 997
        let width = (base) % 17
        let score = (width + 31) * 7
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

