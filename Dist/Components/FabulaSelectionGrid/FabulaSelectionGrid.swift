//
//  FabulaSelectionGrid.swift
//  Dist/Components/FabulaSelectionGrid
//
//  Adapted from FabulaItemsProvider P131_LazyVGrid. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// `LazyVGrid` of selectable items driven by a `Binding`.
public struct FabulaSelectionGrid<Item: Hashable & Identifiable, Content: View>: View {
    private let items: [Item]
    @Binding private var selection: Item?
    private let columns: [GridItem]
    private let spacing: CGFloat
    private let cell: (Item, Bool) -> Content

    @Environment(\.fabulaTheme) private var theme

    public init(
        items: [Item],
        selection: Binding<Item?>,
        columns: [GridItem] = [GridItem(.adaptive(minimum: 72), spacing: 8)],
        spacing: CGFloat = 8,
        @ViewBuilder cell: @escaping (Item, Bool) -> Content
    ) {
        self.items = items
        self._selection = selection
        self.columns = columns
        self.spacing = spacing
        self.cell = cell
    }

    public var body: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(items) { item in
                let isSelected = selection == item
                Button {
                    selection = item
                } label: {
                    cell(item, isSelected)
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(isSelected ? .isSelected : [])
            }
        }
        .tint(theme.primary)
    }
}
