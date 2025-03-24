//
//  RatingDisplayViewSnapshotTests.swift
//  SparkRatingSnapshotTests
//
//  Created by Michael Zimmermann on 05.12.23.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import XCTest
import UIKit
@testable import SparkRating
@_spi(SI_SPI) import SparkCommonSnapshotTesting
import SparkTheming
import SparkTheme

final class RatingDisplayViewSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = RatingDisplayScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration(isSwiftUIComponent: true)
            for configuration in configurations {
                let view = RatingDisplayView(
                    theme: self.theme,
                    intent: .main,
                    rating: configuration.rating
                )

                self.assertSnapshot(
                    matching: view,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    testName: configuration.testName()
                )
            }
        }
    }
}
