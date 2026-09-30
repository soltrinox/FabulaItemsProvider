//
//  Example.swift
//  Dist/Examples/FabulaSelectionGrid
//
//  Adapted from FabulaItemsProvider P131_LazyVGrid. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

private struct FabulaGridDemoItem: Identifiable, Hashable {
    let id: Int
    let title: String
}

struct FabulaSelectionGridExample: View {
    @State private var selection: FabulaGridDemoItem? = nil
    private let items = (0..<8).map { FabulaGridDemoItem(id: $0, title: "\($0)") }

    var body: some View {
        FabulaSelectionGrid(items: items, selection: $selection) { item, selected in
            Text(item.title)
                .frame(maxWidth: .infinity, minHeight: 56)
                .background(selected ? Color.orange.opacity(0.35) : Color.gray.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .padding()
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaSelectionGrid") {
    FabulaSelectionGridExample()
}

struct FabulaSelectionGridExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaSelectionGridExample()
    }
}
