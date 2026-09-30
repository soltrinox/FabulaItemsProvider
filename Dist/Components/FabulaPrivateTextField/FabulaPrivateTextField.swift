//
//  FabulaPrivateTextField.swift
//  Dist/Components/FabulaPrivateTextField
//
//  Adapted from FabulaItemsProvider P99_DisableAutocorrection. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// `TextField` with autocorrection disabled and optional content-type hints.
public struct FabulaPrivateTextField: View {
    private let title: String
    @Binding private var text: String
    private let disableAutocorrection: Bool

    @Environment(\.fabulaTheme) private var theme

#if os(iOS)
    private let contentType: UITextContentType?
    private let autocapitalization: TextInputAutocapitalization

    public init(
        _ title: String,
        text: Binding<String>,
        textContentType: UITextContentType? = nil,
        textInputAutocapitalization: TextInputAutocapitalization = .never,
        disableAutocorrection: Bool = true
    ) {
        self.title = title
        self._text = text
        self.contentType = textContentType
        self.autocapitalization = textInputAutocapitalization
        self.disableAutocorrection = disableAutocorrection
    }
#else
    public init(
        _ title: String,
        text: Binding<String>,
        disableAutocorrection: Bool = true
    ) {
        self.title = title
        self._text = text
        self.disableAutocorrection = disableAutocorrection
    }
#endif

    public var body: some View {
        TextField(title, text: $text)
            .autocorrectionDisabled(disableAutocorrection)
#if os(iOS)
            .textInputAutocapitalization(autocapitalization)
            .textContentType(contentType)
#endif
            .foregroundStyle(theme.fore1)
    }
}
