//
//  RatingGetFillingUseCaseTests.swift
//  SparkComponentRatingTests
//
//  Created by robin.lemaire on 08/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import Foundation
import XCTest
@testable import SparkComponentRating

final class RatingGetFillingUseCaseTests: XCTestCase {

    // MARK: - Properties

    var sut: RatingGetFillingUseCase!

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        self.sut = RatingGetFillingUseCase()
    }

    // MARK: - Tests - Single Star

    func test_execute_single_star_empty() {
        // GIVEN
        typealias Scenario = (
            givenRating: CGFloat,
            expectedFilling: RatingFilling
        )

        let scenarios: [Scenario] = [
            (0, .empty),
            (0.5, .empty),
            (1, .empty),
            (1.5, .halfFilled),
            (2, .halfFilled),
            (2.5, .halfFilled),
            (3, .halfFilled),
            (3.5, .halfFilled),
            (4, .filled),
            (4.5, .filled),
            (5, .filled),
            (5.5, .filled)
        ]

        for scenario in scenarios {
            let filling = self.sut.execute(
                index: 0,
                count: 1,
                rating: scenario.givenRating
            )

            // THEN
            XCTAssertEqual(
                filling,
                scenario.expectedFilling,
                "Wrong filled when rating is equals to \(scenario.givenRating)"
            )
        }
    }

    // MARK: - Tests - Multiple Stars - Filled

    func test_execute_multiple_stars_with_index_is_0() {
        // GIVEN
        typealias Scenario = (
            givenRating: CGFloat,
            expectedFilling: RatingFilling
        )

        let scenarios: [Scenario] = [
            (0, .empty),
            (0.24, .empty),
            (0.25, .halfFilled),
            (0.5, .halfFilled),
            (0.74, .halfFilled),
            (0.75, .filled),
            (1, .filled)
        ]

        for scenario in scenarios {
            let filling = self.sut.execute(
                index: 0,
                count: 5,
                rating: scenario.givenRating
            )

            // THEN
            XCTAssertEqual(
                filling,
                scenario.expectedFilling,
                "Wrong filled when rating is equals to \(scenario.givenRating)"
            )
        }
    }

    func test_execute_multiple_stars_with_index_is_1() {
        // GIVEN
        typealias Scenario = (
            givenRating: CGFloat,
            expectedFilling: RatingFilling
        )

        let scenarios: [Scenario] = [
            (0, .empty),
            (0.24, .empty),
            (0.25, .empty),
            (0.5, .empty),
            (0.74, .empty),
            (0.75, .empty),

            (1, .empty),
            (1.24, .empty),
            (1.25, .halfFilled),
            (1.5, .halfFilled),
            (1.74, .halfFilled),
            (1.75, .filled),
            (2, .filled)
        ]

        for scenario in scenarios {
            let filling = self.sut.execute(
                index: 1,
                count: 5,
                rating: scenario.givenRating
            )

            // THEN
            XCTAssertEqual(
                filling,
                scenario.expectedFilling,
                "Wrong filled when rating is equals to \(scenario.givenRating)"
            )
        }
    }

    func test_execute_multiple_stars_with_index_is_1_and_count_is_2() {
        // GIVEN
        typealias Scenario = (
            givenRating: CGFloat,
            expectedFilling: RatingFilling
        )

        let scenarios: [Scenario] = [
            (0, .empty),
            (0.24, .empty),
            (0.25, .empty),
            (0.5, .empty),
            (0.74, .empty),
            (0.75, .empty),

            (1, .empty),
            (1.24, .empty),
            (1.25, .halfFilled),
            (1.5, .halfFilled),
            (1.74, .halfFilled),
            (1.75, .filled),

            (2, .filled),
            (3, .filled),
            (4, .filled),
            (5.5, .filled),
        ]

        for scenario in scenarios {
            let filling = self.sut.execute(
                index: 1,
                count: 2,
                rating: scenario.givenRating
            )

            // THEN
            XCTAssertEqual(
                filling,
                scenario.expectedFilling,
                "Wrong filled when rating is equals to \(scenario.givenRating)"
            )
        }
    }
}
