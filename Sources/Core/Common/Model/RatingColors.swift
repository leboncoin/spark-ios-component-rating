//
//  RatingColors.swift
//  SparkComponentRating
//
//  Created by robin.lemaire on 07/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

@_spi(SI_SPI) import SparkTheming

struct RatingColors: Equatable {

    // MARK: - Properties

    var filledStarTintColorToken: any ColorToken = ColorTokenClear()
    var emptyStarTintColorToken: any ColorToken = ColorTokenClear()
}

// MARK: Hashable & Equatable

extension RatingColors {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.filledStarTintColorToken)
        hasher.combine(self.emptyStarTintColorToken)
    }

    static func == (lhs: RatingColors, rhs: RatingColors) -> Bool {
        return lhs.filledStarTintColorToken.equals(rhs.filledStarTintColorToken) &&
        lhs.emptyStarTintColorToken.equals(rhs.emptyStarTintColorToken)
    }
}
