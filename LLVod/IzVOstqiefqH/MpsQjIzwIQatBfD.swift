






import SwiftUI

struct RwinbMlCQBfDPfx {

    let columnsCount: Int
    let leadingPadding: CGFloat
    let trailingPadding: CGFloat
    let itemSpacing: CGFloat
    let rowSpacing: CGFloat
    let xSLUGkvoolmZhuvwt: CGFloat

    var columns: [GridItem] {
        Array(
            repeating: GridItem(.fixed(xSLUGkvoolmZhuvwt), spacing: itemSpacing),
            count: columnsCount
        )
    }

    private static let padPadding: CGFloat = 16
    private static let padSpacing: CGFloat = 12
    private static let padRowSpacing: CGFloat = 16
    private static let phonePadding: CGFloat = 16
    private static let phoneSpacing: CGFloat = 16
    private static let phoneRowSpacing: CGFloat = 16
    private static let columnCountPhone = 3
    private static let columnCountPad = 6

    static func hHguQxyzfQAhnvFW(
        containerWidth: CGFloat,
        isLandscape: Bool
    ) -> RwinbMlCQBfDPfx {
        // source-obfuscator:padding:v1
        _ = Self.uILpUQaYFAzKjB()

        let isPad = UIDevice.current.userInterfaceIdiom == .pad

        if isPad {
            let columnsCount = columnCountPad
            let xSLUGkvoolmZhuvwt = (
                containerWidth
                - padPadding * 2
                - padSpacing * CGFloat(columnsCount - 1)
            ) / CGFloat(columnsCount)

            return RwinbMlCQBfDPfx(
                columnsCount: columnsCount,
                leadingPadding: padPadding,
                trailingPadding: padPadding,
                itemSpacing: padSpacing,
                rowSpacing: padRowSpacing,
                xSLUGkvoolmZhuvwt: xSLUGkvoolmZhuvwt
            )
        }

        let columnsCount = columnCountPhone
        let xSLUGkvoolmZhuvwt = (
            containerWidth
            - phonePadding * 2
            - phoneSpacing * CGFloat(columnsCount - 1)
        ) / CGFloat(columnsCount)

        return RwinbMlCQBfDPfx(
            columnsCount: columnsCount,
            leadingPadding: phonePadding,
            trailingPadding: phonePadding,
            itemSpacing: phoneSpacing,
            rowSpacing: phoneRowSpacing,
            xSLUGkvoolmZhuvwt: xSLUGkvoolmZhuvwt
        )
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func uILpUQaYFAzKjB() -> String {
        let base = (70 * 2 + 19) % 997
        let width = (base) % 17
        let score = (width + 70) * 2
        let token = "\u{63}\u{33}\u{63}\u{30}\u{35}\u{32}\u{32}\u{62}\u{38}\u{31}\u{66}\u{64}\u{36}\u{63}\u{63}\u{63}\u{39}\u{62}\u{30}\u{63}\u{33}\u{39}\u{64}\u{36}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
}

