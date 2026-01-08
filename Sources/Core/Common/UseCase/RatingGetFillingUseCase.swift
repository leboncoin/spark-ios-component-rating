//
//  RatingGetFillingUseCase.swift
//  SparkComponentRating
//
//  Created by robin.lemaire on 07/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import Foundation

// sourcery: AutoMockable, AutoMockTest
protocol RatingGetFillingUseCaseable {
    func execute(
        index: Int,
        count: Int,
        rating: Double
    ) -> RatingFilling
}

final class RatingGetFillingUseCase: RatingGetFillingUseCaseable {

    // MARK: - Methods

    func execute(
        index: Int,
        count: Int,
        rating: Double
    ) -> RatingFilling {

        let ratio: Double = if count == 1 { // One Star
            rating / 5
        } else if rating > 0 && rating >= Double(index + 1) {
            1
        } else {
            rating - Double(index)
        }

        switch ratio {
        case 0.25..<0.75:
            return .halfFilled
        case 0.75...:
            return .filled
        default:
            return .empty
        }
    }
}
