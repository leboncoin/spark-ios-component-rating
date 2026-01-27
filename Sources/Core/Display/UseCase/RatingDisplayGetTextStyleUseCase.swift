//
//  RatingDisplayGetTextStyleUseCase.swift
//  SparkComponentRating
//
//  Created by robin.lemaire on 07/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SparkTheming
import Foundation

// sourcery: AutoMockable, AutoMockTest
protocol RatingDisplayGetTextStyleUseCaseable {
    // sourcery: theme = "Identical"
    func execute(
        theme: any Theme,
        size: RatingDisplaySize
    ) -> RatingDisplayTextStyle
}

final class RatingDisplayGetTextStyleUseCase: RatingDisplayGetTextStyleUseCaseable {

    // MARK: - Methods

    func execute(
        theme: any Theme,
        size: RatingDisplaySize
    ) -> RatingDisplayTextStyle {
        let typography = theme.typography

        let fontToken = switch size {
        case .small: typography.body2Highlight
        case .medium: typography.body1Highlight
        case .large: typography.display3
        case .input: typography.display3
        }

        return .init(
            fontToken: fontToken,
            colorToken: theme.colors.base.onSurface
        )
    }
}
