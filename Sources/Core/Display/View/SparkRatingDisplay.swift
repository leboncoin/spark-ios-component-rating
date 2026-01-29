 //
//  SparkRatingDisplay.swift
//  SparkComponentRating
//
//  Created by robin.lemaire on 09/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkCommon

/// The ratings let users see a star rating for a user or experience.
///
/// The **value** passed in parameter must be between **0 and 5**.
///
/// You can also add a text or a label in the init.
///
/// ## Example of usage
///
/// ### Default (without text)
///
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///
///     var body: some View {
///         SparkRatingDisplay(value: 2.75)
///             .sparkTheme(self.theme)
///             .sparkRatingDisplaySize(.small)
///             .sparkRatingDisplayStars(.one)
///     }
/// }
/// ```
/// ### With text
///
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///
///     var body: some View {
///         SparkRatingDisplay(
///             value: 2.75,
///             text: "(2,75)"
///         )
///         .sparkTheme(self.theme)
///         .sparkRatingDisplaySize(.small)
///         .sparkRatingDisplayStars(.one)
///     }
/// }
/// ```
///
/// ### With Label
///
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///
///     var body: some View {
///         SparkRatingDisplay(
///             value: 2.75,
///             label: {
///                 VStack {
///                     Text("2").bold()
///                     Text("/")
///                     Text("5")
///                 }
///             }
///         )
///         .sparkTheme(self.theme)
///         .sparkRatingDisplaySize(.small)
///         .sparkRatingDisplayStars(.one)
///     }
/// }
/// ```
///
/// ## EnvironmentValues
///
/// This component use some EnvironmentValues :
/// - **theme** : ``sparkTheme(_:)`` (View extension)
/// - **size** : ``sparkRatingDisplaySize(_:)`` (View extension)
/// - **stars** : ``sparkRatingDisplayStars(_:)`` (View extension)
///
/// > If theses values are not set, default values will be applied.
///
/// > **YOU MUST PROVIDE ``sparkTheme(_:)``**
///
/// ## Accessibility
///
/// You must set an **accessibilityLabel** to give some context.
///
/// By default, the component set an localized **accessibilityValue**
/// with the current value and the number of stars :"1 out of 5" / "1 sur 5".
/// To override this value, you need to set a ne **accessibilityValue**.
///
/// ## Rendering
///
/// ### With .five star
///
/// ![Rating rendering.](rating_display_default.png)
///
/// ### With .one star
///
/// ![Rating rendering.](rating_display_one_star.png)
///
/// ### With .small size
///
/// ![Rating rendering.](rating_display_small_size.png)
///
/// ### With text
///
/// ![Rating rendering.](rating_display_with_text.png)
///
/// ### With label
///
/// ![Rating rendering.](rating_display_with_label.png)
///
public struct SparkRatingDisplay<Label>: View where Label: View {

    // MARK: - Properties

    private let value: Double
    private let label: () -> Label

    @Environment(\.theme) private var theme
    @Environment(\.ratingDisplaySize) private var size
    @Environment(\.ratingDisplayStars) private var stars

    @StateObject private var viewModel = RatingDisplayViewModel()

    // MARK: - Initialization

    /// Create a rating with a value.
    ///
    /// - Parameters:
    ///   - value: The Double value.
    ///   Must be between **0 and 5**.
    ///
    /// ## Example of usage
    ///
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///
    ///     var body: some View {
    ///         SparkRatingDisplay(value: 2.75)
    ///             .sparkTheme(self.theme)
    ///             .sparkRatingDisplaySize(.small)
    ///             .sparkRatingDisplayStars(.one)
    ///     }
    /// }
    /// ```
    ///
    /// ## Rendering
    ///
    /// ![Rating rendering.](rating_display_default.png)
    public init(value: Double) where Label == EmptyView {
        self.value = value
        self.label = { EmptyView() }
    }

    /// Create a rating with a value and a text positioned on the right.
    ///
    /// - Parameters:
    ///   - value: The Double value.
    ///   Must be between **0 and 5**.
    ///   - text: The text that describes the purpose of the rating.
    ///
    /// ## Example of usage
    ///
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///
    ///     var body: some View {
    ///         SparkRatingDisplay(
    ///             value: 2.75,
    ///             text: "(2,75)"
    ///         )
    ///         .sparkTheme(self.theme)
    ///         .sparkRatingDisplaySize(.small)
    ///         .sparkRatingDisplayStars(.one)
    ///     }
    /// }
    /// ```
    ///
    /// ## Rendering
    ///
    /// ![Rating rendering.](rating_display_with_text.png)
    public init(
        value: Double,
        text: String
    ) where Label == Text {
        self.value = value
        self.label = { Text(text) }
    }

    /// Create a rating with a value and a custom label positioned on the right.
    ///
    /// - Parameters:
    ///   - value: The Double value.
    ///   Must be between **0 and 5**.
    ///   - label: A view that describes the purpose of the rating.
    ///
    /// ## Example of usage
    ///
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///
    ///     var body: some View {
    ///         SparkRatingDisplay(
    ///             value: 2.75,
    ///             label: {
    ///                 VStack {
    ///                     Text("2").bold()
    ///                     Text("/")
    ///                     Text("5")
    ///                 }
    ///             }
    ///         )
    ///         .sparkTheme(self.theme)
    ///         .sparkRatingDisplaySize(.small)
    ///         .sparkRatingDisplayStars(.one)
    ///     }
    /// }
    /// ```
    ///
    /// ## Rendering
    ///
    /// ![Rating rendering.](rating_display_with_label.png)
    public init(
        value: Double,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.value = value
        self.label = label
    }

    // MARK: - Initialization

    public var body: some View {
        SparkHStack(spacing: self.viewModel.spacings.content) {
            SparkHStack(spacing: self.viewModel.spacings.stars) {
                ForEach((0...self.stars.rawValue - 1), id: \.self) { index in
                    let ratio = self.viewModel.getFillingRatio(
                        at: index,
                        count: self.stars.rawValue,
                        value: self.value
                    )

                    RatingStarView(
                        colors: self.viewModel.colors,
                        ratio: ratio
                    )
                    .sparkFrame(size: self.size.cgFloat)
                }
            }
            .accessibilityElement(children: .ignore)

            // Optional Text
            self.label()
                .font(self.viewModel.textStyle.fontToken)
                .foregroundStyle(self.viewModel.textStyle.colorToken)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(RatingDisplayAccessibilityIdentifier.view)
        .accessibilityValue(String.accessibilityValue(
            rating: self.value,
            numberOfStars: stars.rawValue
        ))
        .onAppear() {
            self.viewModel.setup(
                theme: self.theme.value,
                size: self.size
            )
        }
        .onChange(of: self.theme) { theme in
            self.viewModel.theme = theme.value
        }
        .onChange(of: self.size) { size in
            self.viewModel.size = size
        }
    }
}
