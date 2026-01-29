//
//  RatingDisplayConfigurationSnapshotTests.swift
//  SparkComponentRatingDisplayTests
//
//  Created by robin.lemaire on 12/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

@testable import SparkComponentRating
@_spi(SI_SPI) import SparkCommonSnapshotTesting
import XCTest

struct RatingDisplayConfigurationSnapshotTests {

    // MARK: - Properties

    let scenario: RatingDisplayScenarioSnapshotTests

    var size: RatingDisplaySize = .default
    var stars: RatingDisplayStars = .default
    var text: RatingDisplayText = .default
    var value: RatingValues = .default

    var modes: [ComponentSnapshotTestMode] = ComponentSnapshotTestConstants.Modes.default
    var sizes: [UIContentSizeCategory] = ComponentSnapshotTestConstants.Sizes.default

    // MARK: - Name

    var name: String {
        guard self.documentationName == nil else {
            return ""
        }

        return [
            "\(self.stars)" + "Stars",
            "\(self.size)" + "Size",
            "ValueIs" + self.value.formattedValue,
            self.text.name
        ]
            .compactMap { $0 }
            .joined(separator: "-")
    }

    var testName: String {
        return if let documentationName {
            "rating_display_" + documentationName
        } else {
            self.scenario.rawValue
        }
    }

    var documentationName: String?
}

// MARK: - Enum

enum RatingDisplayText: String, CaseIterable {
    case withoutText
    case text
    case customText

    static var `default`: Self = .withoutText

    var name: String? {
        self == .withoutText ? nil : self.rawValue
    }

    var text: String? {
        switch self {
        case .withoutText: nil
        case .text: "My Text"
        case .customText: nil
        }
    }

    var documentationName: String {
        switch self {
        case .withoutText: ""
        case .text: "with_text"
        case .customText: "with_label"
        }
    }
}
