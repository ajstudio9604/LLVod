




import Foundation

protocol AHVodDanmakuCellModel {

    var isPause: Bool { get set }

    var displayTime: Double { get set }

    var offsetTime: TimeInterval { get set }

    func calculateSize()

}

extension AHVodDanmakuCellModel {
    func calculateSize() {
        // source-obfuscator:padding:v1
        _ = Self.cHJhPCQnJeRwnzr()
}

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func cHJhPCQnJeRwnzr() -> String {
        let source = "\u{62}\u{38}\u{34}\u{35}\u{31}\u{64}\u{61}\u{36}\u{35}\u{33}\u{34}\u{65}\u{38}\u{33}\u{38}\u{38}\u{62}\u{66}\u{38}\u{31}\u{62}\u{36}\u{31}\u{32}\u{2d}\u{33}\u{39}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 39) * 9
        let token = "\u{62}\u{38}\u{34}\u{35}\u{31}\u{64}\u{61}\u{36}\u{35}\u{33}\u{34}\u{65}\u{38}\u{33}\u{38}\u{38}\u{62}\u{66}\u{38}\u{31}\u{62}\u{36}\u{31}\u{32}"
        let pieces = [token, String(score % 23)]
        var result = pieces.joined()
        if width > 4 {
            result = pieces.joined(separator: "\u{2d}")
        }
        return result
    }
}

