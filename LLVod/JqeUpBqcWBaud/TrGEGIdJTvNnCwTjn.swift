






import SwiftUI
import AnyThinkSDK

struct BxuOFgsEHjaIsyPT: View {
    var postion: Int = 0
    @State private var adView: ATNativeADView? = nil
    @State private var adHeight: CGFloat = 0
    
    @State private var feedFlowProvider: any TADFeedFlowLoading = CuzGbbVgtuqcwNtCnREc()
    
    var body: some View {
        // source-obfuscator:padding:v1
        let _ = Self.uLMCQLbNnlFLSj()

        VStack {
            if let adView = adView {
                TgaIuuHqoJtUqwVq(adView: adView, height: $adHeight)
                    .frame(height: adHeight)
                    .padding(.horizontal, 16)
                    .animation(.easeInOut, value: adHeight)
            }
        }
        .onAppear(perform: uUeWCSvBngAtuxib)
    }

    
    
  

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func uLMCQLbNnlFLSj() -> String {
        let token = "\u{39}\u{34}\u{63}\u{64}\u{32}\u{39}\u{30}\u{63}\u{33}\u{36}\u{64}\u{34}\u{30}\u{65}\u{31}\u{36}\u{63}\u{33}\u{61}\u{39}\u{64}\u{61}\u{38}\u{30}"
        let values = [61, 70, 549, 78]
        let folded = values.map { ($0 * 9 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 61) * 9
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
}

private struct TgaIuuHqoJtUqwVq: UIViewRepresentable {
    let adView: UIView
    @Binding var height: CGFloat
    
    
    
    
    
    
    
    class WwWlHkOYdjJBw: NSObject {
        @Binding var height: CGFloat
        
        init(height: Binding<CGFloat>) {
            _height = height
        }
        
        override func observeValue(forKeyPath keyPath: String?,
                                   of object: Any?,
                                   change: [NSKeyValueChangeKey : Any]?,
                                   context: UnsafeMutableRawPointer?) {
            let view = object as? ATNativeADView
            self.height = view!.bounds.height
        }
    }
}



extension TgaIuuHqoJtUqwVq {
    func updateUIView(_ uiView: UIView, context: Context) {
        // source-obfuscator:padding:v1
        _ = Self.bVLapIiIxDJzpbdOkIj()

        
    }

    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        container.backgroundColor = .clear
        
        container.addSubview(adView)
        adView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            adView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            adView.topAnchor.constraint(equalTo: container.topAnchor),
            adView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        adView.addObserver(context.coordinator,
                           forKeyPath: AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{39}\u{39}\u{70}\u{4f}\u{68}\u{71}\u{6d}\u{57}\u{6c}"),
                           options: [.new, .initial],
                           context: nil)
        
        return container
    }

    func makeCoordinator() -> WwWlHkOYdjJBw {
        WwWlHkOYdjJBw(height: $height)
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func bVLapIiIxDJzpbdOkIj() -> String {
        let source = "\u{63}\u{39}\u{66}\u{64}\u{35}\u{62}\u{37}\u{33}\u{35}\u{62}\u{64}\u{35}\u{37}\u{36}\u{36}\u{32}\u{39}\u{34}\u{61}\u{64}\u{33}\u{32}\u{36}\u{38}\u{2d}\u{33}\u{30}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 30) * 8
        let token = "\u{63}\u{39}\u{66}\u{64}\u{35}\u{62}\u{37}\u{33}\u{35}\u{62}\u{64}\u{35}\u{37}\u{36}\u{36}\u{32}\u{39}\u{34}\u{61}\u{64}\u{33}\u{32}\u{36}\u{38}"
        var result = token + "\u{2d}" + String(score)
        if score > 24 {
            result = String(token.prefix(12)) + String(score % 31)
        }
        return result
    }
}


extension BxuOFgsEHjaIsyPT {
    private func uUeWCSvBngAtuxib() {
        feedFlowProvider.loadFeedFlow(
            placementID: AxQkIqFofIHnj.templateFeedPlacementID,
            position: postion
        ) { pst, type, view in
            if pst == postion, type == .success {
                DispatchQueue.main.async {
                    guard let view = view as? ATNativeADView else { return }
                    self.adHeight = view.bounds.height
                    self.adView = view
                }
            }
            
            if pst == postion, type == .didClose {
                DispatchQueue.main.async {
                    self.adHeight = 0
                    self.adView = nil
                }
            }
        }
    }
}
