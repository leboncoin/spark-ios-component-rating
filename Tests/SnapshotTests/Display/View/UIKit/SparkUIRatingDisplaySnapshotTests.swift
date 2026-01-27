//
//  SparkUIRatingDisplaySnapshotTests.swift
//  SparkComponentRatingDisplayTests
//
//  Created by robin.lemaire on 12/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import SparkComponentRating
@_spi(SI_SPI) import SparkCommonSnapshotTesting
@_spi(SI_SPI) import SparkCommon
import SparkTheming
import SparkTheme

final class SparkUIRatingDisplaySnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: any Theme = SparkTheme.shared

    // MARK: - Tests

    func test() throws {
        let scenarios = RatingDisplayScenarioSnapshotTests.allCases.filter {
            $0 != .documentation
        }

        for scenario in scenarios {
            let configurations = scenario.configuration()

            for configuration in configurations {
                let view: SparkUIRatingDisplay = .init(
                    theme: self.theme
                )
                view.value = configuration.value.rawValue
                view.size = configuration.size
                view.stars = configuration.stars
                view.text(configuration: configuration)

                let backgroundView = UIView()
                backgroundView.backgroundColor = .systemBackground
                backgroundView.translatesAutoresizingMaskIntoConstraints = false
                backgroundView.addSubview(view)
                NSLayoutConstraint.stickEdges(
                    from: view,
                    to: backgroundView,
                    insets: .init(all: 4)
                )

                self.assertSnapshot(
                    matching: backgroundView,
                    named: configuration.name,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    testName: configuration.testName
                )
            }
        }
    }
}

// MARK: - Extension

private extension SparkUIRatingDisplay {

    func text(configuration: RatingDisplayConfigurationSnapshotTests) {
        switch configuration.text {
        case .customText:
            let customAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.blue,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]

            let attributedString = NSMutableAttributedString(
                string: "\(configuration.value.formattedValue)/5"
            )
            attributedString.addAttributes(
                customAttributes,
                range: .init(location: 0, length: 1)
            )

            self.attributedText = attributedString
        default:
            self.text = configuration.text.text
        }
    }
}
