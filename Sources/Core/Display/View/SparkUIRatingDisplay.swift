//
//  SparkUIRatingDisplay.swift
//  SparkComponentRating
//
//  Created by robin.lemaire on 13/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import UIKit
import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming
import Combine

/// A rating visually represents the completion status of a task or process.
///
/// ## Context
///
/// The **value** passed in parameter must be between **0 and 5**.
///
/// ## Example of usage
///
/// ```swift
/// let theme: SparkTheming.Theme = MyTheme()
///
/// let ratingDisplay = SparkUIRatingDisplay(theme: theme)
/// ratingDisplay.value = 3.76
/// ratingDisplay.size = .large
/// ratingDisplay.stars = .one
/// ratingDisplay.text = "(3,76)"
/// self.addSubview(ratingDisplay)
/// ```
///
/// ## Accessibility
///
/// By default, the accessibility value corresponding to the percentage of the value (Eg : **40%** for 0.4).
/// To override this value, you need to set a new **accessibilityValue**.
///
/// You also must set an **accessibilityLabel** to provide some context on the purpose of the component.
///
/// ## Rendering
///
/// ### With .five star
///
/// ![Rating rendering.](rating_diplay_default.png)
///
/// ### With .one star
///
/// ![Rating rendering.](rating_diplay_one_star.png)
///
/// ### With .small size
///
/// ![Rating rendering.](rating_diplay_small_size.png)
///
/// ### With text
///
/// ![Rating rendering.](rating_diplay_with_text.png)
///
/// ### With attributedText
///
/// ![Rating rendering.](rating_diplay_with_label.png)
///
public final class SparkUIRatingDisplay: UIView {

    // MARK: - Components

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.starsStackView,
            self.textLabel
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var starsStackView: RatingStarsUIStackView = {
        let view = RatingStarsUIStackView(viewModel: self.viewModel)
        view.colors = self.viewModel.colors
        view.size = self.size.cgFloat
        view.contentSpacing = self.viewModel.spacings.stars
        view.stars = self.stars.rawValue
        view.value = self.value
        return view
    }()

    /// The UILabel used to display the rating text.
    ///
    /// Please **do not set a text/attributedText** in this label but use
    /// the ``text`` and ``attributedText`` directly on the ``SparkUIRatingDisplay``.
    public var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = RatingDisplayAccessibilityIdentifier.text
        label.setContentCompressionResistancePriority(
            .required,
            for: .vertical
        )
        label.setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )
        label.isHidden = true
        return label
    }()

    // MARK: - Public Properties

    /// The spark theme of the rating.
    public var theme: any Theme {
        didSet {
            self.viewModel.theme = self.theme
        }
    }

    /// The size of the rating.
    /// Check the ``RatingDisplaySize`` to see the **default** value.
    public lazy var size: RatingDisplaySize = .default {
        didSet {
            self.viewModel.size = self.size
            self.starsStackView.size = self.size.cgFloat
        }
    }

    /// The number of stars of the rating.
    /// Check the ``RatingDisplayStars`` to see the **default** value.
    public var stars: RatingDisplayStars = .default {
        didSet {
            self.starsStackView.stars = self.stars.rawValue
        }
    }

    /// The indicator value of the rating.
    /// note: Value **MUST** be into 0 and 5.
    public var value: Double = 0 {
        didSet {
            self.starsStackView.value = self.value
            self.updateAccessibilityValue()
        }
    }

    /// The text of the rating. Displayed to the right of the stars.
    /// Text can be nil, in this case, no text is displayed.
    public var text: String? {
        get {
            self.textLabel.text
        }
        set {
            self.textLabel.text(newValue)
            self.accessibilityLabel = newValue
        }
    }

    /// The attributedText of the rating. Displayed to the right of the stars.
    /// Text can be nil, in this case, no text is displayed.
    public var attributedText: NSAttributedString? {
        get {
            self.textLabel.attributedText
        }
        set {
            self.textLabel.attributedText(newValue)
            self.accessibilityLabel = newValue?.string
        }
    }

    // MARK: - Private Properties

    private let viewModel = RatingDisplayViewModel()

    private var subscriptions = Set<AnyCancellable>()

    @LimitedScaledUIMetric private var contentSpacing: CGFloat = 0

    // MARK: - Initialization

    /// Create a rating display.
    ///
    /// - Parameters:
    ///   - theme: The current theme.
    ///
    /// Implementation example :
    /// ```swift
    /// let theme: SparkTheming.Theme = MyTheme()
    ///
    /// let ratingDisplay = SparkUIRatingDisplay(theme: theme)
    /// ratingDisplay.value = 3.76
    /// ratingDisplay.size = .large
    /// ratingDisplay.stars = .one
    /// ratingDisplay.text = "(3,76)"
    /// self.addSubview(ratingDisplay)
    /// ```
    ///
    /// ## Rendering
    ///
    /// ![Rating rendering.](rating_diplay_default.png)
    public init(theme: any Theme) {
        self.theme = theme

        super.init(frame: .zero)

        // Setup
        self.setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - View setup

    func setupView() {
        // Add subviews
        self.addSubview(self.contentStackView)

        // View properties
        self.backgroundColor = .clear

        // Updates UI
        self.updateSpacing()

        // Setup constraints
        self.setupConstraints()

        // Setup subscriptions
        self.setupSubscriptions()

        // Setup Accessibility
        self.setupAccessibility()

        // Load view model
        self.viewModel.setup(
            theme: self.theme,
            size: self.size
        )
    }

    // MARK: - Constraints

    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.setupContentViewConstraints()
    }

    private func setupContentViewConstraints() {
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.stickEdges(
            from: self.contentStackView,
            to: self
        )
    }

    // MARK: - Accessibility

    private func setupAccessibility() {
        self.isAccessibilityElement = true
        self.accessibilityIdentifier = RatingDisplayAccessibilityIdentifier.view
        self.updateAccessibilityValue()
    }

    private func updateAccessibilityValue() {
        self.accessibilityValue = String.accessibilityValue(
            rating: self.value,
            numberOfStars: self.stars.rawValue
        )
    }

    // MARK: - Update UI

    private func updateSpacing() {
        self.contentStackView.spacing = self.contentSpacing
    }

    // MARK: - Subscribe

    func setupSubscriptions() {
        // Colors
        self.viewModel.$colors.subscribe(in: &self.subscriptions) { [weak self] colors in
            guard let self else { return }

            self.starsStackView.colors = colors
        }

        // Spacings
        self.viewModel.$spacings.subscribe(in: &self.subscriptions) { [weak self] spacings in
            guard let self else { return }

            self._contentSpacing = .init(wrappedValue: spacings.content)
            self._contentSpacing.update(traitCollection: self.traitCollection)

            self.starsStackView.contentSpacing = spacings.stars

            self.updateSpacing()
        }

        // TextStyle
        self.viewModel.$textStyle.subscribe(in: &self.subscriptions) { [weak self] textStyle in
            guard let self else { return }

            self.textLabel.textColor(textStyle.colorToken)
            self.textLabel.font(textStyle.fontToken)
        }
    }

    // MARK: - Trait Collection

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._contentSpacing.update(traitCollection: self.traitCollection)
        self.updateSpacing()
    }
}
