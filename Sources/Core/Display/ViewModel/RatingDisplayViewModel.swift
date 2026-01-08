//
//  RatingDisplayViewModel.swift
//  SparkComponentRating
//
//  Created by robin.lemaire on 08/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

// sourcery: AutoPublisherTest, AutoViewModelStub
class RatingDisplayViewModel: RatingViewModel {

    // MARK: - Published Properties

    @Published private(set) var colors = RatingColors()
    @Published private(set) var spacing: CGFloat = .zero

    // MARK: - Properties

    var theme: (any Theme)? {
        didSet {
            guard !oldValue.equals(self.theme), self.alreadyUpdateAll else { return }

            self.setColors()
            self.setSpacing()
        }
    }

    var stars: RatingDisplayStars? {
        didSet {
            guard oldValue != self.stars, self.alreadyUpdateAll else { return }

            self.setSpacing()
        }
    }

    // MARK: - Private properties

    private var alreadyUpdateAll = false

    // MARK: - Use Case Properties

    private let getColorsUseCase: any RatingGetColorsUseCaseable
    private let getSpacingUseCase: any RatingDisplayGetSpacingUseCaseable

    // MARK: - Initialization

    init(
        getColorsUseCase: any RatingGetColorsUseCaseable = RatingGetColorsUseCase(),
        getSpacingUseCase: any RatingDisplayGetSpacingUseCaseable = RatingDisplayGetSpacingUseCase()
    ) {
        self.getColorsUseCase = getColorsUseCase
        self.getSpacingUseCase = getSpacingUseCase
    }

    // MARK: - Setup

    func setup(
        theme: any Theme,
        stars: RatingDisplayStars
    ) {
        self.theme = theme
        self.stars = stars

        self.setColors()
        self.setSpacing()

        self.alreadyUpdateAll = true
    }

    // MARK: - Private Setter

    private func setColors() {
        guard let theme else { return }

        self.colors = self.getColorsUseCase.execute(
            theme: theme
        )
    }

    private func setSpacing() {
        guard let theme, let stars else { return }

        self.spacing = self.getSpacingUseCase.execute(
            theme: theme,
            stars: stars
        )
    }
}
