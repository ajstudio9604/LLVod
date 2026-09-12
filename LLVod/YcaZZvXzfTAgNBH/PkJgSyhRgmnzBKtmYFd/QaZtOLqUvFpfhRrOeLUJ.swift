






import Foundation

struct FwWkbRgDQxhZSfi: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let index: Int

    static func == (lhs: FwWkbRgDQxhZSfi, rhs: FwWkbRgDQxhZSfi) -> Bool {
        lhs.id == rhs.id && lhs.text == rhs.text && lhs.index == rhs.index
    }
}

