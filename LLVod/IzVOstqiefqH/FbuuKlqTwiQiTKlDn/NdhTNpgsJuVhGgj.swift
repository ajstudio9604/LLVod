










import UIKit
import DanmakuKit

final class EuKOKJCXJKnobPMs: UIView {

    let danmakuView = DanmakuView()

    private var laidOutSize: CGSize = .zero

    override init(frame: CGRect) {
        // source-obfuscator:padding:v1
        _ = Self.fKvpJqXfCeCxf()

        super.init(frame: frame)

        isUserInteractionEnabled = false
        addSubview(danmakuView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{59}\u{62}\u{66}\u{4b}\u{62}\u{30}\u{38}\u{58}"))
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        danmakuView.frame = bounds

        guard bounds.size != laidOutSize else { return }

        let isResize = laidOutSize != .zero
        laidOutSize = bounds.size

        
        if isResize {
            danmakuView.clean()
        }

        danmakuView.recalculateTracks()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func fKvpJqXfCeCxf() -> String {
        let base = (62 * 9 + 19) % 997
        let width = (base) % 17
        let score = (width + 62) * 9
        let token = "\u{64}\u{61}\u{33}\u{36}\u{37}\u{37}\u{63}\u{36}\u{62}\u{33}\u{33}\u{63}\u{37}\u{66}\u{34}\u{63}\u{66}\u{38}\u{65}\u{66}\u{32}\u{34}\u{36}\u{38}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}

