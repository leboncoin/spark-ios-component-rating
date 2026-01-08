//
//  RatingColorsTests.swift
//  SparkComponentRatingTests
//
//  Created by robin.lemaire on 08/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SwiftUI
import XCTest
@testable import SparkComponentRating
@_spi(SI_SPI) import SparkTheming
@_spi(SI_SPI) import SparkThemingTesting

final class RatingColorsTests: XCTestCase {

    // MARK: - Tests

    func test_default_initialization() {
        // GIVEN / WHEN
        let colors = RatingColors()

        // THEN
        XCTAssertTrue(colors.filledStarTintColorToken.equals(ColorTokenClear()))
        XCTAssertTrue(colors.emptyStarTintColorToken.equals(ColorTokenClear()))
    }

    func test_equality_when_same_colors() {
        // GIVEN / WHEN
        let filledStarToken = ColorTokenGeneratedMock.random()
        let emptyStarToken = ColorTokenGeneratedMock.random()

        let colors1 = RatingColors(
            filledStarTintColorToken: filledStarToken,
            emptyStarTintColorToken: emptyStarToken
        )

        let colors2 = RatingColors(
            filledStarTintColorToken: filledStarToken,
            emptyStarTintColorToken: emptyStarToken
        )

        // THEN
        XCTAssertEqual(colors1, colors2)
    }

    func test_inequality_when_different_filled_star_colors() {
        // GIVEN / WHEN
        let filledStarToken1 = ColorTokenGeneratedMock.random()
        let filledStarToken2 = ColorTokenGeneratedMock.random()
        let emptyStarToken = ColorTokenGeneratedMock.random()

        let colors1 = RatingColors(
            filledStarTintColorToken: filledStarToken1,
            emptyStarTintColorToken: emptyStarToken
        )

        let colors2 = RatingColors(
            filledStarTintColorToken: filledStarToken2,
            emptyStarTintColorToken: emptyStarToken
        )

        // THEN
        XCTAssertNotEqual(colors1, colors2)
    }

    func test_inequality_when_different_empty_star_colors() {
        // GIVEN / WHEN
        let filledStarToken = ColorTokenGeneratedMock.random()
        let emptyStarToken1 = ColorTokenGeneratedMock.random()
        let emptyStarToken2 = ColorTokenGeneratedMock.random()

        let colors1 = RatingColors(
            filledStarTintColorToken: filledStarToken,
            emptyStarTintColorToken: emptyStarToken1
        )

        let colors2 = RatingColors(
            filledStarTintColorToken: filledStarToken,
            emptyStarTintColorToken: emptyStarToken2
        )

        // THEN
        XCTAssertNotEqual(colors1, colors2)
    }
}
