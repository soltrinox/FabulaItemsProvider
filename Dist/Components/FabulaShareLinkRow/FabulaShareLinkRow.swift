//
//  FabulaShareLinkRow.swift
//  Dist/Components/FabulaShareLinkRow
//
//  Adapted from FabulaItemsProvider P268_ShareSheet. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// Thin `ShareLink` wrapper for a caller-supplied, already-verified URL.
/// Does not embed third-party destinations.
public struct FabulaShareLinkRow: View {
    private let title: String
    private let url: URL
    private let subject: String?
    private let message: String?

    @Environment(\.fabulaTheme) private var theme

    public init(
        _ title: String = "Share",
        url: URL,
        subject: String? = nil,
        message: String? = nil
    ) {
        self.title = title
        self.url = url
        self.subject = subject
        self.message = message
    }

    public var body: some View {
        ShareLink(
            item: url,
            subject: subject.map(Text.init),
            message: message.map(Text.init)
        ) {
            Label(title, systemImage: "square.and.arrow.up")
                .foregroundStyle(theme.primary)
        }
        .accessibilityLabel(title)
    }
}

/// ShareLink row for a verified `Transferable` / string item without a hardcoded destination.
public struct FabulaShareTextRow: View {
    private let title: String
    private let text: String

    @Environment(\.fabulaTheme) private var theme

    public init(_ title: String = "Share", text: String) {
        self.title = title
        self.text = text
    }

    public var body: some View {
        ShareLink(item: text) {
            Label(title, systemImage: "square.and.arrow.up")
                .foregroundStyle(theme.primary)
        }
        .accessibilityLabel(title)
    }
}
