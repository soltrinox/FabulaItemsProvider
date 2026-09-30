//
//  FabulaFormSection.swift
//  Dist/Components/FabulaFormSection
//
//  Adapted from FabulaItemsProvider P121_Form. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// Grouped `Form` / `Section` wrapper with title and content builder.
public struct FabulaFormSection<Content: View>: View {
    private let title: String?
    private let footer: String?
    private let content: () -> Content

    @Environment(\.fabulaTheme) private var theme

    public init(
        _ title: String? = nil,
        footer: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.footer = footer
        self.content = content
    }

    public var body: some View {
        Section {
            content()
        } header: {
            if let title {
                Text(title)
                    .foregroundStyle(theme.fore2)
            }
        } footer: {
            if let footer {
                Text(footer)
                    .foregroundStyle(theme.fore2.opacity(0.8))
            }
        }
    }
}
