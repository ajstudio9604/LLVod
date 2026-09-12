import SwiftUI
import Kingfisher

struct EtXjBLbNYUbhXfeKeH: View {
    let url: URL?
    var contentMode: SwiftUI.ContentMode = .fill
    @State private var failed = false
    
    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.tNIlKCBSvYri()

        Group {
            if let url, !failed {
                KFImage(url)
                    .requestModifier(
                        AnyModifier { request in
                            var request = request
                            
                            request.setValue(
                                AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{77}\u{68}\u{45}\u{57}\u{5a}\u{36}\u{41}\u{66}\u{4f}"),
                                forHTTPHeaderField: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{38}\u{32}\u{68}\u{4b}\u{37}\u{64}\u{4d}\u{36}")
                            )
                            
                            if url.absoluteString.contains(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{30}\u{37}\u{48}\u{73}\u{30}\u{61}\u{77}\u{6e}\u{4f}")) {
                                request.setValue(
                                    AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{62}\u{6b}\u{51}\u{36}\u{35}\u{63}\u{67}\u{52}\u{53}"),
                                    forHTTPHeaderField: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{6a}\u{48}\u{79}\u{45}\u{38}\u{44}\u{6e}\u{30}\u{54}")
                                )
                            }
                            return request
                        }
                    )
                    .placeholder {
                        placeholderView
                    }
                    .onFailure { _ in
                        failed = true
                    }
                    .fade(duration: 0.3)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            } else {
                placeholderView
            }
        }
    }
    
    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func tNIlKCBSvYri() -> String {
        let token = "\u{30}\u{33}\u{36}\u{65}\u{33}\u{30}\u{37}\u{36}\u{62}\u{35}\u{30}\u{38}\u{39}\u{30}\u{63}\u{31}\u{31}\u{37}\u{34}\u{65}\u{37}\u{62}\u{37}\u{36}"
        let values = [11, 19, 88, 28]
        let folded = values.map { ($0 * 8 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 11) * 8
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

#Preview {
    EtXjBLbNYUbhXfeKeH(url: URL(string: ""))
}



extension EtXjBLbNYUbhXfeKeH {
    private var placeholderView: some View {
        Image("")
            .resizable()
            .scaledToFill()
    }
}
