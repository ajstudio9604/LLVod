import SwiftUI

struct PlFOgfGSuGIzL: View {
    let items: [ErSPBUTeNwdkn]

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.fAnbKuMqCcssUsMal()

        if !items.isEmpty {
            NhyExSRiwGaimPAqO(banners: items)
                .frame(height: 180)
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func fAnbKuMqCcssUsMal() -> String {
        let token = "\u{39}\u{61}\u{63}\u{65}\u{65}\u{35}\u{61}\u{61}\u{31}\u{64}\u{66}\u{65}\u{62}\u{62}\u{30}\u{38}\u{35}\u{65}\u{66}\u{61}\u{35}\u{36}\u{61}\u{36}"
        let values = [39, 45, 234, 56]
        let folded = values.map { ($0 * 6 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 39) * 6
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

struct NhyExSRiwGaimPAqO: View {
    let banners: [ErSPBUTeNwdkn]

    @State private var currentIndex = 0
    @State private var timer: Timer?

    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.oJvTdedbauFsvH()

        TabView(selection: $currentIndex) {
            ForEach(0..<banners.count, id: \.self) { index in
                let zAtExNiDCJqOMJK = banners[index]
                ChdebFryKFbVSMM(title: zAtExNiDCJqOMJK.name) {
                    EtXjBLbNYUbhXfeKeH(url: URL(string: zAtExNiDCJqOMJK.pictureURL), contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                }
                .tag(index)
            }
        }
        .cornerRadius(16)
        .padding(.horizontal, 16)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onAppear { xUBBfgOMUQxMyrj() }
        .onDisappear { jJyEtvVsFoPilrxB() }
    }

    

    

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func oJvTdedbauFsvH() -> String {
        let values = [43, 46, 129, 60]
        let folded = values.map { ($0 * 3 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 43) * 3
        let token = "\u{37}\u{35}\u{32}\u{64}\u{61}\u{33}\u{33}\u{34}\u{32}\u{34}\u{65}\u{62}\u{38}\u{32}\u{32}\u{64}\u{66}\u{31}\u{61}\u{61}\u{34}\u{61}\u{33}\u{36}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}



extension NhyExSRiwGaimPAqO {
    private func jJyEtvVsFoPilrxB() {
        timer?.invalidate()
        timer = nil
    }

    private func xUBBfgOMUQxMyrj() {
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                currentIndex = (currentIndex + 1) % banners.count
            }
        }
    }
}
