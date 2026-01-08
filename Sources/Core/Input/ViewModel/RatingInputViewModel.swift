//
//  RatingInputViewModel.swift
//  SparkComponentRating
//
//  Created by robin.lemaire on 08/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

// sourcery: AutoPublisherTest, AutoViewModelStub
class RatingInputViewModel: RatingViewModel {

    // MARK: - Published Properties

    @Published private(set) var colors = RatingColors()
    @Published private(set) var dim: CGFloat = .zero
    @Published private(set) var spacing: CGFloat = .zero

    // MARK: - Properties

    var theme: (any Theme)? {
        didSet {
            guard !oldValue.equals(self.theme), self.alreadyUpdateAll else { return }

            self.setColors()
            self.setDim()
            self.setSpacing()
        }
    }

    var isEnabled: Bool? {
        didSet {
            guard oldValue != self.isEnabled, self.alreadyUpdateAll else { return }

            self.setDim()
        }
    }

    var isPressed: Bool = false {
        didSet {
            guard oldValue != self.isPressed, self.alreadyUpdateAll else { return }

            self.setColors()
        }
    }

    // MARK: - Private properties

    private var alreadyUpdateAll = false

    // MARK: - Use Case Properties

    private let getColorsUseCase: any RatingGetColorsUseCaseable
    private let getDimUseCase: any RatingInputGetDimUseCaseable
    private let getSpacingUseCase: any RatingInputGetSpacingUseCaseable

    // MARK: - Initialization

    init(
        getColorsUseCase: any RatingGetColorsUseCaseable = RatingGetColorsUseCase(),
        getDimUseCase: any RatingInputGetDimUseCaseable = RatingInputGetDimUseCase(),
        getSpacingUseCase: any RatingInputGetSpacingUseCaseable = RatingInputGetSpacingUseCase()
    ) {
        self.getColorsUseCase = getColorsUseCase
        self.getDimUseCase = getDimUseCase
        self.getSpacingUseCase = getSpacingUseCase
    }

    // MARK: - Setup

    func setup(
        theme: any Theme,
        isEnabled: Bool
    ) {
        self.theme = theme
        self.isEnabled = isEnabled

        self.setColors()
        self.setDim()
        self.setSpacing()

        self.alreadyUpdateAll = true
    }

    // MARK: - Private Setter

    private func setColors() {
        guard let theme else { return }

        self.colors = self.getColorsUseCase.execute(
            theme: theme,
            isPressed: self.isPressed
        )
    }

    private func setDim() {
        guard let theme, let isEnabled else { return }

        self.dim = self.getDimUseCase.execute(
            theme: theme,
            isEnabled: isEnabled
        )
    }

    private func setSpacing() {
        guard let theme else { return }

        self.spacing = self.getSpacingUseCase.execute(
            theme: theme
        )
    }
}
