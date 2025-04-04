//
//  StarView.swift
//  SparkRating
//
//  Created by Michael Zimmermann on 04.12.23.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import SwiftUI

/// StarView is a single SwiftUI Star.
/// The star may have a rating value which should be in the range [0...1]
struct StarView: View {
    // MARK: Private variables
    private let rating: CGFloat
    private let lineWidth: CGFloat
    private let borderColor: Color
    private let fillColor: Color
    private let star: StarShape

    // MARK: - Initializer
    /// Create a StarUIView with the following parameters
    ///
    /// - Parameters:
    /// - rating: the value of the rating. This should be a number in the range [0...1]
    /// - fillMode: the fill mode of the start. The star will be filled according to the rating and the fillMode.
    /// - borderColor: The color of the border of the unfilled part of the star.
    /// - fillColor: The color of the filled part of the star.
    /// - configuration: StarConfiguration. The default = `default`.
    init(
        rating: CGFloat = StarDefaults.rating,
        fillMode: StarFillMode = .half,
        lineWidth: CGFloat = StarDefaults.lineWidth,
        borderColor: Color,
        fillColor: Color,
        configuration: StarConfiguration = .default
    ) {
        self.rating = fillMode.rating(of: rating)
        self.lineWidth = lineWidth
        self.borderColor = borderColor
        self.fillColor = fillColor
        self.star = StarShape(configuration: configuration)
    }

    // MARK: - View
    var body: some View {
        if self.rating <= 0 {
            star.stroke(self.borderColor, lineWidth: self.lineWidth)
                .accessibilityValue("0.0")
        } else if self.rating >= 1 {
            star.stroke(self.fillColor, lineWidth: self.lineWidth)
                .overlay{
                    star.fill(self.fillColor)
                }
                .accessibilityValue("1.0")
        } else {
            if #available(iOS 17.0, *) {
                self.newVersion()
                    .accessibilityValue("\(self.rating)")
            } else {
                self.oldVersion()
                    .accessibilityValue("\(self.rating)")
            }
        }
    }

    // MARK: - Private functions
    @available(iOS 17.0, *)
    @ViewBuilder
    private func newVersion() -> some View {
        self.star.stroke(self.borderColor, lineWidth: self.lineWidth)
            .overlay {
                self.background()
                    .mask {
                        self.star
                            .stroke(self.fillColor, lineWidth: self.lineWidth)
                            .fill(self.fillColor)
                    }
            }
    }

    @ViewBuilder
    private func oldVersion() -> some View {
        self.star.stroke(self.borderColor, lineWidth: self.lineWidth)
            .overlay {
                self.background()
                    .mask {
                        self.star.stroke(self.fillColor, lineWidth: self.lineWidth)
                    }
            }
            .overlay {
                self.background()
                    .mask {
                        self.star.fill(self.fillColor)
                    }
            }
    }

    @ViewBuilder
    func background() -> some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(self.fillColor)
                    .frame(width: self.ratingPercent(width: geometry.size.width))
                Rectangle()
                    .fill(Color.clear)
            }
        }
    }

    private func ratingPercent(width: CGFloat) -> CGFloat {
        return width * self.rating
    }
}

struct StarView_Previews: PreviewProvider {
    static var previews: some View {
        StarView(rating: 0.4,
                 fillMode: .half,
                 lineWidth: 2.0,
                 borderColor: .gray,
                 fillColor: .purple,
                 configuration: .default)
        .frame(width: 100, height: 100)
    }
}
