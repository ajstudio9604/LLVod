//
//  AHPosterGridLayout.swift
//  LLVod
//
//  三列海报网格的尺寸计算，分类页和片单专辑页共用同一套，改一处两边同步
//

import SwiftUI

struct AHPosterGridLayout {

    let columnsCount: Int
    let leadingPadding: CGFloat
    let trailingPadding: CGFloat
    let itemSpacing: CGFloat
    let rowSpacing: CGFloat
    let itemWidth: CGFloat

    var columns: [GridItem] {
        Array(
            repeating: GridItem(.fixed(itemWidth), spacing: itemSpacing),
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

    static func metrics(
        containerWidth: CGFloat,
        isLandscape: Bool
    ) -> AHPosterGridLayout {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad

        if isPad {
            let columnsCount = columnCountPad
            let itemWidth = (
                containerWidth
                - padPadding * 2
                - padSpacing * CGFloat(columnsCount - 1)
            ) / CGFloat(columnsCount)

            return AHPosterGridLayout(
                columnsCount: columnsCount,
                leadingPadding: padPadding,
                trailingPadding: padPadding,
                itemSpacing: padSpacing,
                rowSpacing: padRowSpacing,
                itemWidth: itemWidth
            )
        }

        let columnsCount = columnCountPhone
        let itemWidth = (
            containerWidth
            - phonePadding * 2
            - phoneSpacing * CGFloat(columnsCount - 1)
        ) / CGFloat(columnsCount)

        return AHPosterGridLayout(
            columnsCount: columnsCount,
            leadingPadding: phonePadding,
            trailingPadding: phonePadding,
            itemSpacing: phoneSpacing,
            rowSpacing: phoneRowSpacing,
            itemWidth: itemWidth
        )
    }
}
