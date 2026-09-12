




import SwiftUI
import AVKit

struct TjYNRlbUDwKHwnxHx: UIViewRepresentable {
    var tintColor: UIColor = .white
    var activeTintColor: UIColor = .systemGreen
    var prioritizesVideoDevices: Bool = true

    

    func updateUIView(_ uiView: AVRoutePickerView, context: Context) {
        // source-obfuscator:padding:v1
        _ = Self.hZrqEaZVoNyejKR()

        uiView.tintColor = tintColor
        uiView.activeTintColor = activeTintColor
        uiView.prioritizesVideoDevices = prioritizesVideoDevices
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func hZrqEaZVoNyejKR() -> String {
        let base = (30 * 6 + 19) % 997
        let width = (base) % 17
        let score = (width + 30) * 6
        let token = "\u{36}\u{38}\u{35}\u{36}\u{35}\u{33}\u{37}\u{31}\u{32}\u{64}\u{62}\u{64}\u{33}\u{30}\u{32}\u{36}\u{39}\u{36}\u{61}\u{61}\u{32}\u{39}\u{37}\u{38}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}

struct AHCircularAirPlayButton: View {
    var body: some View {
        
        bTlLCoCQLTsLRbQ()
    }

    
    @ViewBuilder
    @inline(never)
    private func bTlLCoCQLTsLRbQ() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.gDQzVhINTSEI()

        cZTkpGeJYOqfVl
    }

    @ViewBuilder
    private var cZTkpGeJYOqfVl: some View {
        ZStack {
            nNHzfqiuGlEpvNGZqK

            kVQqLrLaHDUReC
        }
    }


    @ViewBuilder
    private var kVQqLrLaHDUReC: some View {
        TjYNRlbUDwKHwnxHx(
                tintColor: .white,
                activeTintColor: .systemGreen
            )
            .frame(width: 36, height: 36)
    }

    @ViewBuilder
    private var nNHzfqiuGlEpvNGZqK: some View {
        Circle()
                .fill(Color.black.opacity(0.4))
                .frame(width: 36, height: 36)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func gDQzVhINTSEI() -> String {
        let token = "\u{39}\u{63}\u{64}\u{62}\u{35}\u{37}\u{34}\u{35}\u{33}\u{39}\u{66}\u{36}\u{63}\u{38}\u{61}\u{63}\u{62}\u{62}\u{30}\u{37}\u{34}\u{39}\u{37}\u{34}"
        let base = (96 * 4 + 19) % 997
        let width = (base) % 17
        let score = (width + 96) * 4
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
}

struct AHSquareAirPlayButton: View {
    var body: some View {
        
        uOQAfcFVfovvVbe()
    }

    
    @ViewBuilder
    @inline(never)
    private func uOQAfcFVfovvVbe() -> some View {
        // source-obfuscator:padding:v1
        let _ = Self.mZGIveauWlctaQZdhdv()

        vDHpUOtNqXEx
    }

    @ViewBuilder
    private var vDHpUOtNqXEx: some View {
        ZStack {
            yYTtrJVIalVkza

            oAGCcJCUxbSlqWsyaC
        }
    }


    @ViewBuilder
    private var oAGCcJCUxbSlqWsyaC: some View {
        TjYNRlbUDwKHwnxHx(
                tintColor: .white,
                activeTintColor: .systemGreen
            )
            .frame(width: 44, height: 44)
    }

    @ViewBuilder
    private var yYTtrJVIalVkza: some View {
        RoundedRectangle(cornerRadius: 8)
                .fill(Color.black.opacity(0.3))
                .frame(width: 44, height: 44)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func mZGIveauWlctaQZdhdv() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{32}\u{37}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 27) * 2
        let token = "\u{35}\u{61}\u{34}\u{64}\u{30}\u{31}\u{65}\u{38}\u{61}\u{63}\u{34}\u{65}\u{31}\u{37}\u{31}\u{38}\u{62}\u{66}\u{33}\u{34}\u{38}\u{33}\u{35}\u{38}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}



extension TjYNRlbUDwKHwnxHx {
    func makeUIView(context: Context) -> AVRoutePickerView {
        let routePickerView = AVRoutePickerView()
        routePickerView.tintColor = tintColor
        routePickerView.activeTintColor = activeTintColor
        routePickerView.prioritizesVideoDevices = prioritizesVideoDevices
        routePickerView.backgroundColor = .clear

        return routePickerView
    }
}
