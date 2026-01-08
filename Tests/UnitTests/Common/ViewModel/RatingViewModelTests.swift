//
//  RatingViewModelTests.swift
//  SparkComponentRatingTests
//
//  Created by robin.lemaire on 08/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkComponentRating
@_spi(SI_SPI) @testable import SparkComponentRatingTesting

final class RatingViewModelTests: XCTestCase {

    // MARK: - Initialization

    func test_initialization_shouldUseDefaultValues() {
        // GIVEN / WHEN
        let stub = Stub()

        // THEN
        XCTAssertNotCalled(on: stub)
    }

    // MARK: - GetFilling

    func test_getFilling_shouldCallUseCase() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        // WHEN
        let result = viewModel.getFilling(
            at: stub.givenIndex,
            count: stub.givenCount,
            rating: stub.givenRating
        )

        // THEN
        XCTAssertEqual(result, stub.expectedFilling)

        XCTAssertEqual(stub.getFillingUseCaseMock.executeWithIndexAndCountAndRatingCallsCount, 1)

        RatingGetFillingUseCaseableMockTest.XCTAssert(
            stub.getFillingUseCaseMock,
            expectedNumberOfCalls: 1,
            givenIndex: stub.givenIndex,
            givenCount: stub.givenCount,
            givenRating: stub.givenRating,
            expectedReturnValue: stub.expectedFilling
        )
    }
}

// MARK: - Stub

private final class Stub {

    // MARK: - Given

    let givenIndex: Int = 0
    let givenCount: Int = 5
    let givenRating: Double = 3.5

    // MARK: - Expected

    let expectedFilling: RatingFilling = .halfFilled

    // MARK: - Use Case Mocks

    let getFillingUseCaseMock: RatingGetFillingUseCaseableGeneratedMock

    // MARK: - ViewModel

    let viewModel: RatingViewModel

    // MARK: - Initialization

    init() {
        let getFillingUseCaseMock = RatingGetFillingUseCaseableGeneratedMock()
        getFillingUseCaseMock.executeWithIndexAndCountAndRatingReturnValue = self.expectedFilling

        self.viewModel = RatingViewModel(getFillingUseCase: getFillingUseCaseMock)
        self.getFillingUseCaseMock = getFillingUseCaseMock
    }
}

// MARK: - Helpers

private func XCTAssertNotCalled(on stub: Stub) {
    XCTAssertEqual(stub.getFillingUseCaseMock.executeWithIndexAndCountAndRatingCallsCount, 0)
}
