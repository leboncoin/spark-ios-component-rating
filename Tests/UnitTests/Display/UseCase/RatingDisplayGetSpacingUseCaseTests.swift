//
//  RatingDisplayGetSpacingUseCaseTests.swift
//  SparkComponentRatingTests
//
//  Created by robin.lemaire on 08/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import Foundation
import XCTest
@testable import SparkComponentRating
@_spi(SI_SPI) import SparkTheming
@_spi(SI_SPI) import SparkThemingTesting

final class RatingDisplayGetSpacingUseCaseTests: XCTestCase {

    // MARK: - Properties

    var sut: RatingDisplayGetSpacingUseCase!
    var theme: ThemeGeneratedMock!

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        self.theme = ThemeGeneratedMock.mocked()
        self.sut = RatingDisplayGetSpacingUseCase()
    }

    // MARK: - Tests

    func test_execute_when_stars_is_one_returns_none_spacing() {
        // GIVEN
        let expectedSpacing = self.theme.layout.spacing.none

        // WHEN
        let result = self.sut.execute(
            theme: self.theme,
            stars: .one
        )

        // THEN
        XCTAssertEqual(result, expectedSpacing)
    }

    func test_execute_when_stars_is_five_returns_small_spacing() {
        // GIVEN
        let expectedSpacing = self.theme.layout.spacing.small

        // WHEN
        let result = self.sut.execute(
            theme: self.theme,
            stars: .five
        )

        // THEN
        XCTAssertEqual(result, expectedSpacing)
    }

    func test_execute_uses_correct_theme_spacing_for_one_star() {
        // GIVEN / WHEN
        let result = self.sut.execute(
            theme: self.theme,
            stars: .one
        )

        // THEN
        XCTAssertEqual(result, self.theme.layout.spacing.none)
    }

    func test_execute_uses_correct_theme_spacing_for_five_stars() {
        // GIVEN / WHEN
        let result = self.sut.execute(
            theme: self.theme,
            stars: .five
        )

        // THEN
        XCTAssertEqual(result, self.theme.layout.spacing.small)
    }
}
