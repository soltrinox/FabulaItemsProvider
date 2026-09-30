//
//  FabulaPickerRow.swift
//  Dist/Components/FabulaPickerRow
//
//  Adapted from FabulaItemsProvider P55_Picker. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// Labeled `Picker` with a production `Binding` selection.
public struct FabulaPickerRow<SelectionValue: Hashable, Content: View>: View {
    private let title: String
    @Binding private var selection: SelectionValue
    private let content: () -> Content

    @Environment(\.fabulaTheme) private var theme

    public init(
        _ title: String,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self._selection = selection
        self.content = content
    }

    public var body: some View {
        Picker(title, selection: $selection) {
            content()
        }
        .foregroundStyle(theme.fore1)
    }
}
