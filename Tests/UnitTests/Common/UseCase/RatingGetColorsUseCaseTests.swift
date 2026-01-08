//
//  RatingGetColorsUseCaseTests.swift
//  SparkComponentRatingTests
//
//  Created by robin.lemaire on 08/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import Foundation
import XCTest
@testable import SparkComponentRating
@_spi(SI_SPI) import SparkThemingTesting

final class RatingGetColorsUseCaseTests: XCTestCase {

    // MARK: - Properties

    var sut: RatingGetColorsUseCase!
    var theme: ThemeGeneratedMock!

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        self.theme = ThemeGeneratedMock.mocked()
        self.sut = RatingGetColorsUseCase()
    }

    // MARK: - Tests Without IsPressed parameter

    func test_execute_without_isPressed_parameter() {
        // GIVEN / WHEN
        let colors = self.sut.execute(theme: self.theme)

        // THEN
        let expectedColors = RatingColors(
            filledStarTintColorToken: self.theme.colors.main.mainVariant,
            emptyStarTintColorToken: self.theme.colors.base.onSurface.opacity(self.theme.dims.dim3)
        )

        XCTAssertEqual(colors, expectedColors)
    }

    // MARK: - Tests With IsPressed parameter

    func test_execute_when_not_pressed() {
        // GIVEN / WHEN
        let colors = self.sut.execute(
            theme: self.theme,
            isPressed: false
        )

        // THEN
        let expectedColors = RatingColors(
            filledStarTintColorToken: self.theme.colors.main.mainVariant,
            emptyStarTintColorToken: self.theme.colors.base.onSurface.opacity(self.theme.dims.dim3)
        )

        XCTAssertEqual(colors, expectedColors)
    }

    func test_execute_when_pressed() {
        // GIVEN / WHEN
        let colors = self.sut.execute(
            theme: self.theme,
            isPressed: true
        )

        // THEN
        let expectedColors = RatingColors(
            filledStarTintColorToken: self.theme.colors.states.mainVariantPressed,
            emptyStarTintColorToken: self.theme.colors.base.onSurface.opacity(self.theme.dims.dim3)
        )

        XCTAssertEqual(colors, expectedColors)
    }
}
