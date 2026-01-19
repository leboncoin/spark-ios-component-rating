//
//  RatingDisplayScenarioSnapshotTests.swift
//  SparkComponentRatingDisplaySnapshotTests
//
//  Created by robin.lemaire on 12/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

@testable import SparkComponentRating
@_spi(SI_SPI) import SparkCommonSnapshotTesting
@_spi(SI_SPI) import SparkCommonTesting
import UIKit
import SwiftUI

enum RatingDisplayScenarioSnapshotTests: String, CaseIterable {
    case test1
    case test2
    case test3
    case test4
    case test5
    case documentation

    // MARK: - Properties

    var isDocumentation: Bool {
        self == .documentation
    }

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration() -> [RatingDisplayConfigurationSnapshotTests] {
        switch self {
        case .test1:
            return self.test1()
        case .test2:
            return self.test2()
        case .test3:
            return self.test3()
        case .test4:
            return self.test4()
        case .test5:
            return self.test5()
        case .documentation:
            return self.documentation()
        }
    }

    // MARK: - Scenarios

    /// Test 1
    ///
    /// Description: To test all sizes
    ///
    /// Content:
    ///  - size: all
    ///  - stars: default
    ///  - value: default
    ///  - text: default
    ///  - mode: default
    ///  - size: default
    private func test1() -> [RatingDisplayConfigurationSnapshotTests] {
        let sizes = RatingDisplaySize.allCases

        return sizes.map { size in
            .init(
                scenario: self,
                size: size
            )
        }
    }

    /// Test 2
    ///
    /// Description: To test all stars with all values
    ///
    /// Content:
    ///  - size: default
    ///  - stars: all
    ///  - value: all
    ///  - text: default
    ///  - mode: default
    ///  - size: default
    private func test2() -> [RatingDisplayConfigurationSnapshotTests] {
        let stars = RatingDisplayStars.allCases
        let values = RatingValues.allCases

        return stars.flatMap { stars in
            values.map { value in
                    .init(
                        scenario: self,
                        stars: stars,
                        value: value
                    )
            }
        }
    }

    /// Test 3
    ///
    /// Description: To test all content
    ///
    /// Content:
    ///  - size: default
    ///  - stars: default
    ///  - value: default
    ///  - text: all
    ///  - mode: default
    ///  - size: default
    private func test3() -> [RatingDisplayConfigurationSnapshotTests] {
        let texts = RatingDisplayText.allCases

        return texts.map { text in
                .init(
                    scenario: self,
                    text: text
                )
        }
    }

    /// Test 4
    ///
    /// Description: To test light/dark
    ///
    /// Content:
    ///  - size: default
    ///  - stars: default
    ///  - value: default
    ///  - text: text
    ///  - mode: all
    ///  - size: default
    private func test4() -> [RatingDisplayConfigurationSnapshotTests] {
        return [
            .init(
                scenario: self,
                text: .text,
                modes: Constants.Modes.all
            )
        ]
    }

    /// Test 5
    ///
    /// Description: To all a11y sizes
    ///
    /// Content:
    ///  - size: default
    ///  - stars: default
    ///  - value: default
    ///  - text: text
    ///  - mode: default
    ///  - size: all
    private func test5() -> [RatingDisplayConfigurationSnapshotTests] {
        return [
            .init(
                scenario: self,
                text: .text,
                sizes: Constants.Sizes.all
            )
        ]
    }

    // MARK: - Documentation

    // Used to generate screenshot for Documentation
    private func documentation() -> [RatingDisplayConfigurationSnapshotTests] {
        var items: [RatingDisplayConfigurationSnapshotTests] = []

        // Default
        items.append(.init(
            scenario: self,
            documentationName: "default"
        ))

        // One Star
        items.append(.init(
            scenario: self,
            stars: .one,
            documentationName: "one_star"
        ))

        // Small size
        items.append(.init(
            scenario: self,
            size: .small,
            documentationName: "small_size"
        ))

        // Texts
        let texts: [RatingDisplayText] = [
            .text,
            .customText
        ]

        items.append(contentsOf: texts.map {
            .init(
                scenario: self,
                text: $0,
                documentationName: $0.documentationName
            )
        })

        return items
    }
}
