//
//  RatingDisplayViewModelTests.swift
//  SparkComponentRatingTests
//
//  Created by robin.lemaire on 08/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkComponentRating
@_spi(SI_SPI) @testable import SparkComponentRatingTesting
@_spi(SI_SPI) import SparkThemingTesting
@_spi(SI_SPI) import SparkTheming

final class RatingDisplayViewModelTests: XCTestCase {

    // MARK: - Initialization

    func test_initialization_shouldUseDefaultValues() {
        // GIVEN / WHEN
        let stub = Stub()

        // THEN
        XCTAssertNil(stub.viewModel.theme)
        XCTAssertNil(stub.viewModel.stars)

        XCTAssertEqualToExpected(
            on: stub,
            otherColors: RatingColors(),
            otherSpacing: 0
        )

        XCTAssertNotCalled(
            on: stub,
            getColorsUseCase: true,
            getSpacingUseCase: true
        )
    }

    // MARK: - Setup

    func test_setup_shouldCallAllUseCases() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        // WHEN
        viewModel.setup(stub: stub)

        // THEN
        XCTAssertEqualToExpected(on: stub)

        RatingGetColorsUseCaseableMockTest.XCTAssert(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            expectedReturnValue: stub.expectedColors
        )

        RatingDisplayGetSpacingUseCaseableMockTest.XCTAssert(
            stub.getSpacingUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            givenStars: stub.givenStars,
            expectedReturnValue: stub.expectedSpacing
        )

        XCTAssertNotCalled(on: stub)
    }

    // MARK: - Property Changes

    func test_themeChanged_shouldUpdateColorsAndSpacingOnly() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        viewModel.setup(stub: stub)
        stub.resetMockedData()

        let newTheme = ThemeGeneratedMock.mocked()

        // WHEN
        viewModel.theme = newTheme

        // THEN
        XCTAssertEqualToExpected(on: stub)

        RatingGetColorsUseCaseableMockTest.XCTAssert(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: newTheme,
            expectedReturnValue: stub.expectedColors
        )

        RatingDisplayGetSpacingUseCaseableMockTest.XCTAssert(
            stub.getSpacingUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: newTheme,
            givenStars: stub.givenStars,
            expectedReturnValue: stub.expectedSpacing
        )

        XCTAssertNotCalled(on: stub)
    }

    func test_starsChanged_shouldUpdateSpacingOnly() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        viewModel.setup(stub: stub)
        stub.resetMockedData()

        let newStars = RatingDisplayStars.one

        // WHEN
        viewModel.stars = newStars

        // THEN
        XCTAssertEqualToExpected(on: stub)

        RatingDisplayGetSpacingUseCaseableMockTest.XCTAssert(
            stub.getSpacingUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            givenStars: newStars,
            expectedReturnValue: stub.expectedSpacing
        )

        XCTAssertNotCalled(
            on: stub,
            getColorsUseCase: true
        )
    }

    func test_propertiesChanged_beforeSetup_shouldNotCallUseCases() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        // WHEN
        viewModel.theme = ThemeGeneratedMock.mocked()
        viewModel.stars = .one

        // THEN
        XCTAssertEqualToExpected(
            on: stub,
            otherColors: RatingColors(),
            otherSpacing: 0
        )

        XCTAssertNotCalled(
            on: stub,
            getColorsUseCase: true,
            getSpacingUseCase: true
        )
    }

    func test_propertiesChanged_withoutValueChange_shouldNotCallUseCases() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        viewModel.setup(stub: stub)
        stub.resetMockedData()

        // WHEN
        viewModel.theme = stub.givenTheme
        viewModel.stars = stub.givenStars

        // THEN
        XCTAssertEqualToExpected(on: stub)

        XCTAssertNotCalled(
            on: stub,
            getColorsUseCase: true,
            getSpacingUseCase: true
        )
    }

    func test_propertiesChanged_withNilValues_shouldNotCallUseCases() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        viewModel.setup(stub: stub)
        stub.resetMockedData()

        // WHEN
        viewModel.theme = nil
        viewModel.stars = nil

        // THEN
        XCTAssertEqualToExpected(on: stub)

        XCTAssertNotCalled(
            on: stub,
            getColorsUseCase: true,
            getSpacingUseCase: true
        )
    }
}

// MARK: - Stub

private final class Stub {

    // MARK: - Given

    let givenTheme = ThemeGeneratedMock.mocked()
    let givenStars: RatingDisplayStars = .five

    // MARK: - Expected

    let expectedColors = RatingColors()
    let expectedSpacing: CGFloat = 8.0
    let expectedFilling: RatingFilling = .halfFilled

    // MARK: - Use Case Mocks

    let getColorsUseCaseMock: RatingGetColorsUseCaseableGeneratedMock
    let getSpacingUseCaseMock: RatingDisplayGetSpacingUseCaseableGeneratedMock

    // MARK: - ViewModel

    let viewModel: RatingDisplayViewModel

    // MARK: - Initialization

    init() {
        let getColorsUseCaseMock = RatingGetColorsUseCaseableGeneratedMock()
        getColorsUseCaseMock.executeWithThemeReturnValue = self.expectedColors

        let getSpacingUseCaseMock = RatingDisplayGetSpacingUseCaseableGeneratedMock()
        getSpacingUseCaseMock.executeWithThemeAndStarsReturnValue = self.expectedSpacing

        self.viewModel = RatingDisplayViewModel(
            getColorsUseCase: getColorsUseCaseMock,
            getSpacingUseCase: getSpacingUseCaseMock
        )

        self.getColorsUseCaseMock = getColorsUseCaseMock
        self.getSpacingUseCaseMock = getSpacingUseCaseMock
    }

    // MARK: - Helpers

    func resetMockedData() {
        self.getColorsUseCaseMock.reset()
        self.getSpacingUseCaseMock.reset()
    }
}

// MARK: - Helpers

private extension RatingDisplayViewModel {

    func setup(stub: Stub) {
        self.setup(
            theme: stub.givenTheme,
            stars: stub.givenStars
        )
    }
}

private func XCTAssertNotCalled(
    on stub: Stub,
    getColorsUseCase: Bool = false,
    getSpacingUseCase: Bool = false
) {
    RatingGetColorsUseCaseableMockTest.XCTCalled(
        stub.getColorsUseCaseMock,
        executeWithThemeCalled: !getColorsUseCase
    )

    RatingDisplayGetSpacingUseCaseableMockTest.XCTCalled(
        stub.getSpacingUseCaseMock,
        executeWithThemeAndStarsCalled: !getSpacingUseCase
    )
}

private func XCTAssertEqualToExpected(
    on stub: Stub,
    otherColors: RatingColors? = nil,
    otherSpacing: CGFloat? = nil
) {
    let viewModel = stub.viewModel

    XCTAssertTrue(
        viewModel.colors == (otherColors ?? stub.expectedColors),
        "Wrong colors value"
    )
    XCTAssertEqual(
        viewModel.spacing,
        otherSpacing ?? stub.expectedSpacing,
        "Wrong spacing value"
    )
}
