







import SwiftUI

enum YcpXYLtySGuJT {

    
}

extension View {

    func ahTabRootIgnoreBottomSafeAreaIfNeeded() -> some View {
        // source-obfuscator:padding:v1
        _ = Self.rESrgbUJfpiMbzQKm()

        return ignoresSafeArea(.container, edges: .bottom)
    }

    func ahTabRootBottomInsetProbe(_ bottomInset: Binding<CGFloat>) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .allowsHitTesting(false)
                    .onAppear {
                        bottomInset.wrappedValue = proxy.safeAreaInsets.bottom
                    }
                    .onChange(of: proxy.safeAreaInsets.bottom) { newValue in
                        bottomInset.wrappedValue = newValue
                    }
            }
            .allowsHitTesting(false)
        )
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func rESrgbUJfpiMbzQKm() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 64, "\u{65}\u{61}\u{73}\u{74}": 68, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 256]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 64) * 4
        let token = "\u{37}\u{66}\u{36}\u{62}\u{61}\u{35}\u{33}\u{63}\u{65}\u{61}\u{39}\u{66}\u{61}\u{64}\u{35}\u{64}\u{34}\u{65}\u{62}\u{36}\u{31}\u{64}\u{33}\u{35}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}



extension YcpXYLtySGuJT {
    static func gLYARkqVpIreHVTq(measuredSafeAreaBottom: CGFloat) -> CGFloat {
        // source-obfuscator:padding:v1
        _ = Self.uKYSUQoCXuMffMfn()

        return max(measuredSafeAreaBottom, 16)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func uKYSUQoCXuMffMfn() -> String {
        let token = "\u{35}\u{35}\u{64}\u{64}\u{31}\u{36}\u{32}\u{61}\u{37}\u{37}\u{30}\u{61}\u{35}\u{35}\u{64}\u{63}\u{65}\u{64}\u{63}\u{61}\u{39}\u{36}\u{34}\u{30}"
        let base = (63 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 63) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}
