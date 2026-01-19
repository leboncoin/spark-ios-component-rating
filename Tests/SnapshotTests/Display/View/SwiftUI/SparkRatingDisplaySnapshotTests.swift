//
//  SparkRatingDisplaySnapshotTests.swift
//  SparkComponentRatingDisplayTests
//
//  Created by robin.lemaire on 12/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import SparkComponentRating
@_spi(SI_SPI) import SparkCommonSnapshotTesting
import SparkTheming
import SparkTheme
import SwiftUI

final class SparkRatingDisplaySnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: any Theme = SparkTheme.shared

    // MARK: - Tests

    func test() throws {
        let scenarios = RatingDisplayScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration()

            for configuration in configurations {

                let view = self.component(configuration)
                    .sparkTheme(self.theme)
                    .sparkRatingDisplaySize(configuration.size)
                    .sparkRatingDisplayStars(configuration.stars)
                    .padding(.horizontal, self.horizontalPadding(configuration: configuration))
                    .padding(.vertical, 4)
                    .background(.background)
                    .fixedSize()

                self.assertSnapshot(
                    matching: view,
                    named: configuration.name,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    testName: configuration.testName,
                    forDocumentation: scenario.isDocumentation
                )
            }
        }
    }

    @ViewBuilder
    private func component(_ configuration: RatingDisplayConfigurationSnapshotTests) -> some View {
        switch configuration.text {
        case .withoutText:
            SparkRatingDisplay(value: configuration.value.rawValue)
        case .text:
            SparkRatingDisplay(
                value: configuration.value.rawValue,
                text: configuration.value.formattedValue + "/5"
            )
        case .customText:
            SparkRatingDisplay(
                value: configuration.value.rawValue,
                label: {
                    Group {
                        Text(configuration.value.formattedValue)
                            .bold()
                            .foregroundColor(.blue) +
                        Text("/5")
                    }
                }
            )
        }
    }

    // MARK: - Helpers

    private func horizontalPadding(configuration: RatingDisplayConfigurationSnapshotTests) -> CGFloat {
        return switch (configuration.stars, configuration.size) {
        case (.one, _): 4
        case (_, .small): 10
        case (_, .medium): 12
        case (_, .large): 12
        default: 0
        }
    }
}
