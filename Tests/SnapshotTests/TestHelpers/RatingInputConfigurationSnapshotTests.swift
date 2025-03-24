//
//  RatingInputConfigurationSnapshotTests.swift
//  SparkRatingUnitTests
//
//  Created by Michael Zimmermann on 30.11.23.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import Foundation
import UIKit
@testable import SparkRating
@_spi(SI_SPI) import SparkCommonSnapshotTesting

struct RatingInputConfigurationSnapshotTests {

    // MARK: - Properties

    let scenario: RatingInputScenarioSnapshotTests

    let rating: CGFloat
    let intent = RatingIntent.main

    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]
    let state: RatingInputState

    // MARK: - Getter

    func testName() -> String {
        return [
            "\(self.scenario.rawValue)",
            "\(self.intent)",
            "\(self.rating)",
            "\(self.state)"
        ].joined(separator: "-")
    }
}

enum RatingInputState: CaseIterable {
    case enabled
    case disabled
    case pressed
}
