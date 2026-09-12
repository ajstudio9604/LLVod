




import UIKit
import DanmakuKit

class NujFEwJswoAybIttNkV: DanmakuCell {

    required init(frame: CGRect) {
        // source-obfuscator:padding:v1
        _ = Self.aBxnLgpkNyTxgbqgPXAJ()

        super.init(frame: frame)
        backgroundColor = .clear
        isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError(AnIIRyTZZzTxkmgiDVYoJSk.dVYoJSkgSwBacunjUDdEpA("\u{73}\u{76}\u{59}\u{62}\u{66}\u{4b}\u{62}\u{30}\u{38}\u{58}"))
    }

    override func willDisplay() {
    }

    override func displaying(_ context: CGContext, _ size: CGSize, _ isCancelled: Bool) {
        guard let model = model as? AwkRoLwYAEJl else { return }
        let text = NSString(string: model.text)
        context.setLineWidth(1)
        context.setLineJoin(.round)
        context.setStrokeColor(UIColor.black.cgColor)
        context.saveGState()

        let attributes: [NSAttributedString.Key: Any] = [.font: model.font, .foregroundColor: model.color]
        text.draw(at: .zero, withAttributes: attributes)
        context.restoreGState()

        context.setTextDrawingMode(.fill)
        text.draw(at: .zero, withAttributes: attributes)
    }

    override func didDisplay(_ finished: Bool) {
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func aBxnLgpkNyTxgbqgPXAJ() -> String {
        _ = Self.gDCASnMsztckPgH()
        let token = "\u{64}\u{33}\u{38}\u{61}\u{38}\u{38}\u{63}\u{61}\u{35}\u{63}\u{62}\u{32}\u{65}\u{30}\u{64}\u{64}\u{34}\u{63}\u{39}\u{34}\u{38}\u{63}\u{31}\u{32}"
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{31}\u{30}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 10) * 3
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
    @inline(never)
    private nonisolated static func gDCASnMsztckPgH() -> String {
        let source = "\u{32}\u{35}\u{33}\u{37}\u{32}\u{66}\u{30}\u{35}\u{65}\u{63}\u{39}\u{64}\u{33}\u{32}\u{62}\u{30}\u{39}\u{32}\u{64}\u{38}\u{36}\u{38}\u{63}\u{39}\u{2d}\u{31}\u{36}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 16) * 9
        let token = "\u{32}\u{35}\u{33}\u{37}\u{32}\u{66}\u{30}\u{35}\u{65}\u{63}\u{39}\u{64}\u{33}\u{32}\u{62}\u{30}\u{39}\u{32}\u{64}\u{38}\u{36}\u{38}\u{63}\u{39}"
        switch score % 2 == 0 {
        case true:
            return token + String(score)
        case false:
            return String(score) + token
        }
    }
}

