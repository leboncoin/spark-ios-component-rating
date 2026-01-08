//
//  RatingGetColorsUseCase.swift
//  SparkComponentRating
//
//  Created by robin.lemaire on 07/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable, AutoMockTest
protocol RatingGetColorsUseCaseable {
    // sourcery: theme = "Identical"
    func execute(theme: any Theme) -> RatingColors

    // sourcery: theme = "Identical"
    func execute(
        theme: any Theme,
        isPressed: Bool
    ) -> RatingColors
}

struct RatingGetColorsUseCase: RatingGetColorsUseCaseable {

    func execute(theme: any Theme) -> RatingColors {
        return self.execute(
            theme: theme,
            isPressed: false
        )
    }

    func execute(
        theme: any Theme,
        isPressed: Bool
    ) -> RatingColors {
        let colors = theme.colors

        let filledColorToken = isPressed ? colors.states.mainVariantPressed : colors.main.mainVariant

        return .init(
            filledStarTintColorToken: filledColorToken,
            emptyStarTintColorToken: colors.base.onSurface.opacity(theme.dims.dim3)
        )
    }
}
