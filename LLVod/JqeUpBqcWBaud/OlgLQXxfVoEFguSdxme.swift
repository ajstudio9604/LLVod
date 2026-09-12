






import SwiftUI
import AnyThinkSDK

struct AgOJpRlPxoXdTOFyUIE: View {
    let adView: ATNativeADView?
    var extraBottom: CGFloat = 0
    var iRrtTkyiFYfThmfKTiLH: () -> Void
    
    
    
    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.eKHuuFjkpIdwmJocmzU()

        Group {
            if let adView {
                AbCKpRvRgssDYNCy(adView: adView)
                    .frame(maxWidth: .infinity)
                    .frame(height: adHeight)
                    .clipped()
                    .overlay(alignment: .topTrailing) {
                        Button(action: iRrtTkyiFYfThmfKTiLH) {
                            Image(systemName: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{31}\u{4e}\u{4c}\u{37}\u{63}\u{4f}\u{66}\u{72}\u{65}"))
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color.black.opacity(0.55))
                                .clipShape(Circle())
                        }
                        .frame(width: 44, height: 44)
                        .padding(.top, 6)
                        .padding(.trailing, 8)
                    }
                    .background(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.12), radius: 8, y: -2)
            }
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(.container, edges: .bottom)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func eKHuuFjkpIdwmJocmzU() -> String {
        let source = "\u{66}\u{62}\u{38}\u{38}\u{64}\u{65}\u{33}\u{31}\u{31}\u{63}\u{35}\u{37}\u{63}\u{39}\u{63}\u{35}\u{61}\u{35}\u{34}\u{37}\u{65}\u{34}\u{66}\u{31}\u{2d}\u{34}\u{32}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 42) * 4
        let token = "\u{66}\u{62}\u{38}\u{38}\u{64}\u{65}\u{33}\u{31}\u{31}\u{63}\u{35}\u{37}\u{63}\u{39}\u{63}\u{35}\u{61}\u{35}\u{34}\u{37}\u{65}\u{34}\u{66}\u{31}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

private struct AbCKpRvRgssDYNCy: UIViewRepresentable {
    let adView: UIView
    
    
    
    
}

private final class NrUHCVihnRMk: UIView {
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: MsLNgPqdHwfVKvdWgnu.preferredSize.height)
    }
    
    override func layoutSubviews() {
        // source-obfuscator:padding:v1
        _ = Self.aWXSoQWVOBzTVgj()

        super.layoutSubviews()
        clipsToBounds = true
        subviews.forEach { subview in
            subview.clipsToBounds = true
            subview.frame = bounds
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func aWXSoQWVOBzTVgj() -> String {
        let source = "\u{64}\u{31}\u{61}\u{38}\u{62}\u{37}\u{39}\u{62}\u{64}\u{65}\u{64}\u{37}\u{32}\u{65}\u{32}\u{63}\u{65}\u{31}\u{35}\u{33}\u{32}\u{61}\u{65}\u{35}\u{2d}\u{32}\u{32}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 22) * 5
        let token = "\u{64}\u{31}\u{61}\u{38}\u{62}\u{37}\u{39}\u{62}\u{64}\u{65}\u{64}\u{37}\u{32}\u{65}\u{32}\u{63}\u{65}\u{31}\u{35}\u{33}\u{32}\u{61}\u{65}\u{35}"
        var result = String(score) + token
        if score % 2 == 0 {
            result = token + String(score)
        }
        return result
    }
}



extension AbCKpRvRgssDYNCy {
    func updateUIView(_ uiView: UIView, context: Context) {
        // source-obfuscator:padding:v1
        _ = Self.iVpPKjzRHbPK()

        uiView.clipsToBounds = true
        adView.clipsToBounds = true
        adView.frame = uiView.bounds
    }

    func makeUIView(context: Context) -> UIView {
        let container = NrUHCVihnRMk()
        container.backgroundColor = .clear
        container.clipsToBounds = true
        container.addSubview(adView)
        adView.clipsToBounds = true
        adView.translatesAutoresizingMaskIntoConstraints = true
        adView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        adView.frame = container.bounds
        return container
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func iVpPKjzRHbPK() -> String {
        let base = (47 * 8 + 19) % 997
        let width = (base) % 17
        let score = (width + 47) * 8
        let token = "\u{34}\u{32}\u{34}\u{34}\u{35}\u{34}\u{64}\u{63}\u{31}\u{65}\u{34}\u{32}\u{36}\u{30}\u{30}\u{30}\u{36}\u{30}\u{61}\u{63}\u{37}\u{63}\u{30}\u{34}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}


extension AgOJpRlPxoXdTOFyUIE {
    private var adHeight: CGFloat {
        MsLNgPqdHwfVKvdWgnu.preferredSize.height + extraBottom
    }
}
