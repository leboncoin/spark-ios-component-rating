//
//  RatingColors.swift
//  SparkRating
//
//  Created by michael.zimmermann on 09.11.23.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import Foundation
import SparkTheming

struct RatingColors: Equatable {
    var fillColor: any ColorToken
    var strokeColor: any ColorToken
    var opacity: CGFloat

    static func == (lhs: RatingColors, rhs: RatingColors) -> Bool {
        return lhs.fillColor.equals(rhs.fillColor) &&
        lhs.strokeColor.equals(rhs.strokeColor) &&
        lhs.opacity == rhs.opacity
    }
}
