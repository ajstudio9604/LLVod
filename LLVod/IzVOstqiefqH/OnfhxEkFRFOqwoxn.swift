






import SwiftUI
import AVKit

struct JlAKwsloBviBIeMNvub: UIViewRepresentable {
    var tintColor: UIColor = .white
    var activeTintColor: UIColor = .systemGreen
    var prioritizesVideoDevices: Bool = true
    
    
    
    func updateUIView(_ uiView: AVRoutePickerView, context: Context) {
        // source-obfuscator:padding:v1
        _ = Self.oJwBzlbRJJWyFZmTTyX()

        uiView.tintColor = tintColor
        uiView.activeTintColor = activeTintColor
        uiView.prioritizesVideoDevices = prioritizesVideoDevices
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func oJwBzlbRJJWyFZmTTyX() -> String {
        let token = "\u{61}\u{39}\u{32}\u{37}\u{31}\u{38}\u{61}\u{33}\u{31}\u{61}\u{62}\u{65}\u{66}\u{33}\u{33}\u{31}\u{34}\u{37}\u{36}\u{64}\u{62}\u{66}\u{64}\u{30}"
        let base = (9 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 9) * 8
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

struct EhzjuvnuhqCJwij: View {
    var body: some View {
        
        lEsqjUjgdOjobChohAz()
    }

    
    @ViewBuilder
    @inline(never)
    private func lEsqjUjgdOjobChohAz() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.sPhTHwPZjnVOSVHKw()

        kSroZjWRnmfPqEvzWo
    }

    @ViewBuilder
    private var kSroZjWRnmfPqEvzWo: some View {
        ZStack {
            wOoVEmgNnHThmSOVKy
            
            oKMHKMtsUFBTdQo
        }
    }


    @ViewBuilder
    private var wOoVEmgNnHThmSOVKy: some View {
        Circle()
                .fill(Color.black.opacity(0.4))
                .frame(width: 36, height: 36)
    }

    @ViewBuilder
    private var oKMHKMtsUFBTdQo: some View {
        JlAKwsloBviBIeMNvub(
                tintColor: .white,
                activeTintColor: .systemGreen
            )
            .frame(width: 36, height: 36)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func sPhTHwPZjnVOSVHKw() -> String {
        let token = "\u{36}\u{39}\u{65}\u{66}\u{65}\u{30}\u{64}\u{38}\u{38}\u{37}\u{34}\u{30}\u{36}\u{37}\u{31}\u{36}\u{32}\u{33}\u{30}\u{62}\u{30}\u{61}\u{37}\u{32}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 17, "\u{65}\u{61}\u{73}\u{74}": 26, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 153]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 17) * 9
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}

struct RcXVabmsOSMnoME: View {
    var body: some View {
        
        aTngxNcsjGkXsekQKt()
    }

    
    @ViewBuilder
    @inline(never)
    private func aTngxNcsjGkXsekQKt() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.kWhzvxfCsHAho()

        qFZVDfErLRHg
    }

    @ViewBuilder
    private var qFZVDfErLRHg: some View {
        ZStack {
            oSbMqfvRjRuJsTwQ
            
            cLTdPBuyLKqKgrc
        }
    }


    @ViewBuilder
    private var oSbMqfvRjRuJsTwQ: some View {
        RoundedRectangle(cornerRadius: 8)
                .fill(Color.black.opacity(0.3))
                .frame(width: 44, height: 44)
    }

    @ViewBuilder
    private var cLTdPBuyLKqKgrc: some View {
        JlAKwsloBviBIeMNvub(
                tintColor: .white,
                activeTintColor: .systemGreen
            )
            .frame(width: 44, height: 44)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func kWhzvxfCsHAho() -> String {
        let values = [48, 52, 192, 65]
        let folded = values.map { ($0 * 4 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 48) * 4
        let token = "\u{36}\u{66}\u{37}\u{32}\u{35}\u{32}\u{61}\u{65}\u{63}\u{66}\u{35}\u{30}\u{30}\u{33}\u{31}\u{33}\u{37}\u{38}\u{32}\u{38}\u{66}\u{64}\u{66}\u{32}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
}

#Preview("\u{43}\u{69}\u{72}\u{63}\u{75}\u{6c}\u{61}\u{72}") {
    ZStack {
        Color.black
        EhzjuvnuhqCJwij()
    }
}

#Preview("\u{53}\u{71}\u{75}\u{61}\u{72}\u{65}") {
    ZStack {
        Color.black
        RcXVabmsOSMnoME()
    }
}




extension JlAKwsloBviBIeMNvub {
    func makeUIView(context: Context) -> AVRoutePickerView {
        let routePickerView = AVRoutePickerView()
        routePickerView.tintColor = tintColor
        routePickerView.activeTintColor = activeTintColor
        routePickerView.prioritizesVideoDevices = prioritizesVideoDevices
        
        
        routePickerView.backgroundColor = .clear
        
        return routePickerView
    }
}
