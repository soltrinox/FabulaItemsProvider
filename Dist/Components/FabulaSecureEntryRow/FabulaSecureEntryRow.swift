//
//  FabulaSecureEntryRow.swift
//  Dist/Components/FabulaSecureEntryRow
//
//  Adapted from FabulaItemsProvider P151_SecureField. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// Secure entry row. Never echoes or logs plaintext secrets.
/// Optional reveal shows text locally in-field only.
public struct FabulaSecureEntryRow: View {
    private let title: String
    private let prompt: String
    @Binding private var text: String
    private let allowsReveal: Bool

    @State private var isRevealed = false
    @Environment(\.fabulaTheme) private var theme

    public init(
        _ title: String,
        text: Binding<String>,
        prompt: String = "Password",
        allowsReveal: Bool = false
    ) {
        self.title = title
        self._text = text
        self.prompt = prompt
        self.allowsReveal = allowsReveal
    }

    public var body: some View {
        HStack(spacing: 12) {
            Text(title)
                .foregroundStyle(theme.fore1)
                .frame(minWidth: 72, alignment: .leading)

            Group {
                if allowsReveal && isRevealed {
                    TextField(prompt, text: $text)
                        .autocorrectionDisabled()
#if os(iOS)
                        .textInputAutocapitalization(.never)
                        .textContentType(.password)
#endif
                } else {
                    SecureField(prompt, text: $text)
#if os(iOS)
                        .textContentType(.password)
#endif
                }
            }
            .foregroundStyle(theme.fore1)

            if allowsReveal {
                Button {
                    isRevealed.toggle()
                } label: {
                    Image(systemName: isRevealed ? "eye.slash" : "eye")
                        .foregroundStyle(theme.fore2)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(isRevealed ? "Hide secret" : "Reveal secret locally")
            }
        }
        .accessibilityElement(children: .contain)
    }
}
