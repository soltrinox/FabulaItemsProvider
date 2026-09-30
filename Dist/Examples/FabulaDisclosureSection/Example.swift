//
//  Example.swift
//  Dist/Examples/FabulaDisclosureSection
//
//  Adapted from FabulaItemsProvider P59_DisclosureGroup. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaDisclosureSectionExample: View {
    @State private var expanded = true

    var body: some View {
        List {
            FabulaDisclosureSection("Details", isExpanded: $expanded) {
                Text("Item A")
                Text("Item B")
            }
        }
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaDisclosureSection") {
    FabulaDisclosureSectionExample()
}

struct FabulaDisclosureSectionExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaDisclosureSectionExample()
    }
}
