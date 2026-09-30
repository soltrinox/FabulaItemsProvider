//
//  FabulaDisclosureSection.swift
//  Dist/Components/FabulaDisclosureSection
//
//  Adapted from FabulaItemsProvider P59_DisclosureGroup. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// `DisclosureGroup` with an explicit `Binding` for expansion state.
public struct FabulaDisclosureSection<Label: View, Content: View>: View {
    @Binding private var isExpanded: Bool
    private let label: () -> Label
    private let content: () -> Content

    @Environment(\.fabulaTheme) private var theme

    public init(
        isExpanded: Binding<Bool>,
        @ViewBuilder label: @escaping () -> Label,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isExpanded = isExpanded
        self.label = label
        self.content = content
    }

    public var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            content()
                .foregroundStyle(theme.fore1)
        } label: {
            label()
                .foregroundStyle(theme.fore1)
        }
        .tint(theme.primary)
        .animation(.easeInOut, value: isExpanded)
    }
}

public extension FabulaDisclosureSection where Label == Text {
    init(
        _ title: String,
        isExpanded: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(isExpanded: isExpanded, label: { Text(title) }, content: content)
    }
}
