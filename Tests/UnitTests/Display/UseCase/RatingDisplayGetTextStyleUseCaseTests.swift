//
//  RatingDisplayGetTextStyleUseCaseTests.swift
//  SparkComponentRatingTests
//
//  Created by robin.lemaire on 14/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import Foundation
import XCTest
@testable import SparkComponentRating
@_spi(SI_SPI) import SparkThemingTesting

final class RatingDisplayGetTextStyleUseCaseTests: XCTestCase {

    // MARK: - Properties

    var sut: RatingDisplayGetTextStyleUseCase!
    var theme: ThemeGeneratedMock!

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        self.theme = ThemeGeneratedMock.mocked()
        self.sut = RatingDisplayGetTextStyleUseCase()
    }

    // MARK: - Tests

    func test_execute_with_small_size() {
        // GIVEN / WHEN
        let textStyle = self.sut.execute(
            theme: self.theme,
            size: .small
        )

        // THEN
        let expectedTextStyle = RatingDisplayTextStyle(
            fontToken: self.theme.typography.body2Highlight,
            colorToken: self.theme.colors.base.onSurface
        )

        XCTAssertEqual(textStyle, expectedTextStyle)
    }

    func test_execute_with_medium_size() {
        // GIVEN / WHEN
        let textStyle = self.sut.execute(
            theme: self.theme,
            size: .medium
        )

        // THEN
        let expectedTextStyle = RatingDisplayTextStyle(
            fontToken: self.theme.typography.body1Highlight,
            colorToken: self.theme.colors.base.onSurface
        )

        XCTAssertEqual(textStyle, expectedTextStyle)
    }

    func test_execute_with_large_size() {
        // GIVEN / WHEN
        let textStyle = self.sut.execute(
            theme: self.theme,
            size: .large
        )

        // THEN
        let expectedTextStyle = RatingDisplayTextStyle(
            fontToken: self.theme.typography.display3,
            colorToken: self.theme.colors.base.onSurface
        )

        XCTAssertEqual(textStyle, expectedTextStyle)
    }

    func test_execute_with_deprecated_input_case_for_undefined_size() {
        // GIVEN
        let customSize: RatingDisplaySize = .input

        // WHEN
        let textStyle = self.sut.execute(
            theme: self.theme,
            size: customSize
        )

        // THEN
        let expectedTextStyle = RatingDisplayTextStyle(
            fontToken: self.theme.typography.display3,
            colorToken: self.theme.colors.base.onSurface
        )

        XCTAssertEqual(textStyle, expectedTextStyle)
    }
}
