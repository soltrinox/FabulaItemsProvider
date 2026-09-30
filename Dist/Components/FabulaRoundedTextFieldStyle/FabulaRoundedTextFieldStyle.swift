//
//  FabulaRoundedTextFieldStyle.swift
//  Dist/Components/FabulaRoundedTextFieldStyle
//
//  Adapted from FabulaItemsProvider P259_TextFieldStyle. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// Rounded `TextFieldStyle` filled from `fabulaTheme` tokens.
public struct FabulaRoundedTextFieldStyle: TextFieldStyle {
    @Environment(\.fabulaTheme) private var theme
    private let cornerRadius: CGFloat
    private let horizontalPadding: CGFloat
    private let verticalPadding: CGFloat

    public init(
        cornerRadius: CGFloat = 10,
        horizontalPadding: CGFloat = 12,
        verticalPadding: CGFloat = 10
    ) {
        self.cornerRadius = cornerRadius
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .foregroundStyle(theme.fore1)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(theme.back2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(theme.bar1, lineWidth: 1)
            )
    }
}

public extension View {
    func fabulaRoundedTextFieldStyle(
        cornerRadius: CGFloat = 10
    ) -> some View {
        textFieldStyle(FabulaRoundedTextFieldStyle(cornerRadius: cornerRadius))
    }
}
