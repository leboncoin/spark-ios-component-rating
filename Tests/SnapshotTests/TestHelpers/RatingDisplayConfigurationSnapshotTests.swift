//
//  RatingDisplayConfigurationSnapshotTests.swift
//  SparkRatingSnapshotTests
//
//  Created by Michael Zimmermann on 20.11.23.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import Foundation
import UIKit
@testable import SparkRating
@_spi(SI_SPI) import SparkCommonSnapshotTesting

struct RatingDisplayConfigurationSnapshotTests {

    // MARK: - Properties

    let scenario: RatingDisplayScenarioSnapshotTests

    let rating: CGFloat
    let size: RatingDisplaySize
    let count: RatingStarsCount
    let intent = RatingIntent.main

    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    // MARK: - Getter

    func testName() -> String {
        return [
            "\(self.scenario.rawValue)",
            "\(self.intent)",
            "\(self.size)",
            "\(self.count)",
            "\(self.rating)"
        ].joined(separator: "-")
    }
}
