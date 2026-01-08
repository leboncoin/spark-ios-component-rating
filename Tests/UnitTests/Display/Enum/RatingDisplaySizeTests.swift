//
//  RatingDisplaySizeTests.swift
//  SparkComponentRatingTests
//
//  Created by robin.lemaire on 08/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkComponentRating

final class RatingDisplaySizeTests: XCTestCase {

    // MARK: - Tests

    func test_default_is_medium() {
        // GIVEN / WHEN / THEN
        XCTAssertEqual(RatingDisplaySize.default, .medium)
    }

    func test_raw_values() {
        // GIVEN / WHEN / THEN
        XCTAssertEqual(RatingDisplaySize.small.rawValue, 12)
        XCTAssertEqual(RatingDisplaySize.medium.rawValue, 16)
    }

    func test_all_cases_only_includes_non_deprecated() {
        // GIVEN / WHEN
        let allCases = RatingDisplaySize.allCases

        // THEN
        XCTAssertEqual(allCases.count, 2)
        XCTAssertTrue(allCases.contains(.small))
        XCTAssertTrue(allCases.contains(.medium))
        XCTAssertFalse(allCases.contains(.large))
        XCTAssertFalse(allCases.contains(.input))
    }

    func test_initialization_from_raw_value() {
        // GIVEN / WHEN / THEN
        XCTAssertEqual(RatingDisplaySize(rawValue: 12), .small)
        XCTAssertEqual(RatingDisplaySize(rawValue: 16), .medium)
        XCTAssertEqual(RatingDisplaySize(rawValue: 24), .large)
        XCTAssertEqual(RatingDisplaySize(rawValue: 40), .input)
        XCTAssertNil(RatingDisplaySize(rawValue: 999))
    }
}
