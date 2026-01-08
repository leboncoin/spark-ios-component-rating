//
//  RatingDisplayGetSpacingUseCase.swift
//  SparkComponentRating
//
//  Created by robin.lemaire on 07/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SparkTheming
import Foundation

// sourcery: AutoMockable, AutoMockTest
protocol RatingDisplayGetSpacingUseCaseable {
    // sourcery: theme = "Identical"
    func execute(
        theme: any Theme,
        stars: RatingDisplayStars
    ) -> CGFloat
}

final class RatingDisplayGetSpacingUseCase: RatingDisplayGetSpacingUseCaseable {

    // MARK: - Methods

    func execute(
        theme: any Theme,
        stars: RatingDisplayStars
    ) -> CGFloat {
        let spacing = theme.layout.spacing

        return switch stars {
        case .one: spacing.none
        case .five: spacing.small
        }
    }
}
