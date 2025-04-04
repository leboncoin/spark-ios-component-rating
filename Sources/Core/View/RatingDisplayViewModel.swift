//
//  RatingDisplayViewModel.swift
//  SparkRating
//
//  Created by Michael Zimmermann on 17.11.23.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import Combine
import Foundation
import SparkTheming

/// A view model for the rating display.
final class RatingDisplayViewModel: ObservableObject {

    /// The current theme of which colors and sizes are dependent.
    var theme: Theme {
        didSet {
            self.colors = self.colorsUseCase.execute(theme: self.theme, intent: self.intent)
            self.ratingSize = self.sizeUseCase.execute(spacing: theme.layout.spacing, size: size)
        }
    }

    /// The current intent which describes colors.
    var intent: RatingIntent {
        didSet {
            guard self.intent != oldValue else { return }
            self.colors = self.colorsUseCase.execute(theme: self.theme, intent: self.intent)
        }
    }

    /// The display size of the rating
    var size: RatingDisplaySize {
        didSet {
            guard self.size != oldValue else { return }
            self.ratingSize = self.sizeUseCase.execute(spacing: theme.layout.spacing, size: size)
        }
    }

    /// The number of stars in the rating display
    var count: RatingStarsCount {
        didSet {
            guard self.count != oldValue else { return }
            self.updateRatingValue()
        }
    }

    /// The current rating value
    var rating: CGFloat {
        didSet {
            guard self.rating != oldValue else { return }
            self.updateRatingValue()
        }
    }

    // MARK: - Published variables
    /// The current selection / enabled state
    @Published var ratingState: RatingState
    /// The current defined colors
    @Published var colors: RatingColors
    /// Current size attributes
    @Published var ratingSize: RatingSizeAttributes
    /// The normalized rating value
    @Published var ratingValue: CGFloat

    // MARK: - Private variables
    private let colorsUseCase: RatingGetColorsUseCaseable
    private let sizeUseCase: RatingSizeAttributesUseCaseable

    // MARK: Initializer
    init(theme: Theme,
         intent: RatingIntent,
         size: RatingDisplaySize,
         count: RatingStarsCount,
         rating: CGFloat = 0.0,
         ratingState: RatingState = .standard,
         colorsUseCase: RatingGetColorsUseCaseable = RatingGetColorsUseCase(),
         sizeUseCase: RatingSizeAttributesUseCaseable = RatingSizeAttributesUseCase()
    ) {
        self.theme = theme
        self.intent = intent
        self.size = size
        self.colorsUseCase = colorsUseCase
        self.colors = colorsUseCase.execute(theme: theme, intent: intent, state: ratingState)
        self.sizeUseCase = sizeUseCase
        self.ratingSize = sizeUseCase.execute(spacing: theme.layout.spacing, size: size)
        self.ratingValue = count.ratingValue(rating)
        self.rating = rating
        self.count = count
        self.ratingState = ratingState
    }

    func updateState(isPressed: Bool) {
        self.ratingState.isPressed = isPressed
        self.colors = self.colorsUseCase.execute(
            theme: self.theme,
            intent: self.intent,
            state: self.ratingState)
    }

    @discardableResult
    func updateState(isEnabled: Bool) -> Self {
        guard self.ratingState.isEnabled != isEnabled else { return self }

        self.ratingState.isEnabled = isEnabled
        self.colors = self.colorsUseCase.execute(
            theme: self.theme,
            intent: self.intent,
            state: self.ratingState)

        return self
    }

    // MARK: - Private functions
    private func updateRatingValue() {
        self.ratingValue = self.count.ratingValue(self.rating)
    }
}

// MARK: - Private helpers
private extension RatingStarsCount {
    func ratingValue(_ rating: CGFloat) -> CGFloat {
        switch self {
        case .five: return rating
        case .one: return rating / 5.0
        }
    }
}
