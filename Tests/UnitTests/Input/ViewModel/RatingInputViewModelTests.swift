//
//  RatingInputViewModelTests.swift
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

final class RatingInputViewModelTests: XCTestCase {

    // MARK: - Initialization

    func test_initialization_shouldUseDefaultValues() {
        // GIVEN / WHEN
        let stub = Stub()

        // THEN
        XCTAssertNil(stub.viewModel.theme)
        XCTAssertNil(stub.viewModel.isEnabled)
        XCTAssertFalse(stub.viewModel.isPressed)

        XCTAssertEqualToExpected(
            on: stub,
            otherColors: RatingColors(),
            otherDim: 0,
            otherSpacing: 0
        )

        XCTAssertNotCalled(
            on: stub,
            getColorsUseCase: true,
            getDimUseCase: true,
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
            givenIsPressed: stub.givenIsPressed,
            expectedReturnValue: stub.expectedColors
        )

        RatingInputGetDimUseCaseableMockTest.XCTAssert(
            stub.getDimUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            givenIsEnabled: stub.givenIsEnabled,
            expectedReturnValue: stub.expectedDim
        )

        RatingInputGetSpacingUseCaseableMockTest.XCTAssert(
            stub.getSpacingUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            expectedReturnValue: stub.expectedSpacing
        )

        XCTAssertNotCalled(on: stub)
    }

    // MARK: - Property Changes

    func test_themeChanged_shouldUpdateColorsAndDimAndSpacing() {
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
            givenIsPressed: stub.givenIsPressed,
            expectedReturnValue: stub.expectedColors
        )

        RatingInputGetDimUseCaseableMockTest.XCTAssert(
            stub.getDimUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: newTheme,
            givenIsEnabled: stub.givenIsEnabled,
            expectedReturnValue: stub.expectedDim
        )

        RatingInputGetSpacingUseCaseableMockTest.XCTAssert(
            stub.getSpacingUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: newTheme,
            expectedReturnValue: stub.expectedSpacing
        )

        XCTAssertNotCalled(on: stub)
    }

    func test_isEnabledChanged_shouldUpdateDimOnly() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        viewModel.setup(stub: stub)
        stub.resetMockedData()

        let newIsEnabled = !stub.givenIsEnabled

        // WHEN
        viewModel.isEnabled = newIsEnabled

        // THEN
        XCTAssertEqualToExpected(on: stub)

        RatingInputGetDimUseCaseableMockTest.XCTAssert(
            stub.getDimUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            givenIsEnabled: newIsEnabled,
            expectedReturnValue: stub.expectedDim
        )

        XCTAssertNotCalled(
            on: stub,
            getColorsUseCase: true,
            getSpacingUseCase: true
        )
    }

    func test_isPressedChanged_shouldUpdateColorsOnly() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        viewModel.setup(stub: stub)
        stub.resetMockedData()

        let newIsPressed = !stub.givenIsPressed

        // WHEN
        viewModel.isPressed = newIsPressed

        // THEN
        XCTAssertEqualToExpected(on: stub)

        RatingGetColorsUseCaseableMockTest.XCTAssert(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            givenIsPressed: newIsPressed,
            expectedReturnValue: stub.expectedColors
        )

        XCTAssertNotCalled(
            on: stub,
            getDimUseCase: true,
            getSpacingUseCase: true
        )
    }

    func test_propertiesChanged_beforeSetup_shouldNotCallUseCases() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        // WHEN
        viewModel.theme = ThemeGeneratedMock.mocked()
        viewModel.isEnabled = !stub.givenIsEnabled
        viewModel.isPressed = !stub.givenIsPressed

        // THEN
        XCTAssertEqualToExpected(
            on: stub,
            otherColors: RatingColors(),
            otherDim: 0,
            otherSpacing: 0
        )

        XCTAssertNotCalled(
            on: stub,
            getColorsUseCase: true,
            getDimUseCase: true,
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
        viewModel.isEnabled = stub.givenIsEnabled
        viewModel.isPressed = stub.givenIsPressed

        // THEN
        XCTAssertEqualToExpected(on: stub)

        XCTAssertNotCalled(
            on: stub,
            getColorsUseCase: true,
            getDimUseCase: true,
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
        viewModel.isEnabled = nil

        // THEN
        XCTAssertEqualToExpected(on: stub)

        XCTAssertNotCalled(
            on: stub,
            getColorsUseCase: true,
            getDimUseCase: true,
            getSpacingUseCase: true
        )
    }
}

// MARK: - Stub

private final class Stub {

    // MARK: - Given

    let givenTheme = ThemeGeneratedMock.mocked()
    let givenIsEnabled: Bool = true
    let givenIsPressed: Bool = false

    // MARK: - Expected

    let expectedColors = RatingColors()
    let expectedDim: CGFloat = 0.0
    let expectedSpacing: CGFloat = 12.0

    // MARK: - Use Case Mocks

    let getColorsUseCaseMock: RatingGetColorsUseCaseableGeneratedMock
    let getDimUseCaseMock: RatingInputGetDimUseCaseableGeneratedMock
    let getSpacingUseCaseMock: RatingInputGetSpacingUseCaseableGeneratedMock

    // MARK: - ViewModel

    let viewModel: RatingInputViewModel

    // MARK: - Initialization

    init() {
        let getColorsUseCaseMock = RatingGetColorsUseCaseableGeneratedMock()
        getColorsUseCaseMock.executeWithThemeAndIsPressedReturnValue = self.expectedColors

        let getDimUseCaseMock = RatingInputGetDimUseCaseableGeneratedMock()
        getDimUseCaseMock.executeWithThemeAndIsEnabledReturnValue = self.expectedDim

        let getSpacingUseCaseMock = RatingInputGetSpacingUseCaseableGeneratedMock()
        getSpacingUseCaseMock.executeWithThemeReturnValue = self.expectedSpacing

        self.viewModel = RatingInputViewModel(
            getColorsUseCase: getColorsUseCaseMock,
            getDimUseCase: getDimUseCaseMock,
            getSpacingUseCase: getSpacingUseCaseMock
        )

        self.getColorsUseCaseMock = getColorsUseCaseMock
        self.getDimUseCaseMock = getDimUseCaseMock
        self.getSpacingUseCaseMock = getSpacingUseCaseMock
    }

    // MARK: - Helpers

    func resetMockedData() {
        self.getColorsUseCaseMock.reset()
        self.getDimUseCaseMock.reset()
        self.getSpacingUseCaseMock.reset()
    }
}

// MARK: - Helpers

private extension RatingInputViewModel {

    func setup(stub: Stub) {
        self.setup(
            theme: stub.givenTheme,
            isEnabled: stub.givenIsEnabled
        )
    }
}

private func XCTAssertNotCalled(
    on stub: Stub,
    getColorsUseCase: Bool = false,
    getDimUseCase: Bool = false,
    getSpacingUseCase: Bool = false
) {
    RatingGetColorsUseCaseableMockTest.XCTCalled(
        stub.getColorsUseCaseMock,
        executeWithThemeAndIsPressedCalled: !getColorsUseCase
    )

    RatingInputGetDimUseCaseableMockTest.XCTCalled(
        stub.getDimUseCaseMock,
        executeWithThemeAndIsEnabledCalled: !getDimUseCase
    )

    RatingInputGetSpacingUseCaseableMockTest.XCTCalled(
        stub.getSpacingUseCaseMock,
        executeWithThemeCalled: !getSpacingUseCase
    )
}

private func XCTAssertEqualToExpected(
    on stub: Stub,
    otherColors: RatingColors? = nil,
    otherDim: CGFloat? = nil,
    otherSpacing: CGFloat? = nil
) {
    let viewModel = stub.viewModel

    XCTAssertTrue(
        viewModel.colors == (otherColors ?? stub.expectedColors),
        "Wrong colors value"
    )
    XCTAssertEqual(
        viewModel.dim,
        otherDim ?? stub.expectedDim,
        "Wrong dim value"
    )
    XCTAssertEqual(
        viewModel.spacing,
        otherSpacing ?? stub.expectedSpacing,
        "Wrong spacing value"
    )
}
