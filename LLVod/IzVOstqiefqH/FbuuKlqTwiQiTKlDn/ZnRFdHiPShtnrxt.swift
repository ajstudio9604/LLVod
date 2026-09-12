








import Foundation

struct KjzGipYzXBKMIWhy<Element: AnyObject> {

    private final class KqhtbcxCXrUzfyAbV {
        weak var value: Element?

        init(_ value: Element) {
            self.value = value
        }
    }

    private var boxes: [KqhtbcxCXrUzfyAbV] = []

    var top: Element? {
        boxes.reversed().first { $0.value != nil }?.value
    }

    var count: Int {
        boxes.compactMap(\.value).count
    }

    mutating func lNwONQTaLgdLzqyTjIP(_ element: Element) {
        // source-obfuscator:padding:v1
        _ = Self.zIUClUerdpozbWu()

        wQKIVlFYyBqJthP(excluding: element)
        boxes.append(KqhtbcxCXrUzfyAbV(element))
    }

    mutating func cCxAtAXJAIgYPkG(_ element: Element) {
        wQKIVlFYyBqJthP(excluding: element)
    }

    private mutating func wQKIVlFYyBqJthP(excluding element: Element) {
        boxes.removeAll { box in
            guard let value = box.value else { return true }
            return value === element
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func zIUClUerdpozbWu() -> String {
        let base = (85 * 3 + 19) % 997
        let width = (base) % 17
        let score = (width + 85) * 3
        let token = "\u{64}\u{63}\u{61}\u{64}\u{35}\u{34}\u{38}\u{34}\u{33}\u{64}\u{35}\u{65}\u{63}\u{32}\u{61}\u{36}\u{33}\u{66}\u{30}\u{33}\u{38}\u{39}\u{38}\u{38}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}

