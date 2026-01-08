//
//  RatingViewModel.swift
//  SparkComponentRating
//
//  Created by robin.lemaire on 08/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

// sourcery: AutoPublisherTest, AutoViewModelStub
class RatingViewModel: ObservableObject {

    // MARK: - Use Case Properties

    private let getFillingUseCase: any RatingGetFillingUseCaseable

    // MARK: - Initialization

    init(getFillingUseCase: any RatingGetFillingUseCaseable = RatingGetFillingUseCase()) {
        self.getFillingUseCase = getFillingUseCase
    }

    // MARK: - Getter

    func getFilling(
        at index: Int,
        count: Int,
        rating: Double
    ) -> RatingFilling {
        self.getFillingUseCase.execute(
            index: index,
            count: count,
            rating: rating
        )
    }
}
