//
//  Example.swift
//  Dist/Examples/FabulaFormSection
//
//  Adapted from FabulaItemsProvider P121_Form. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaFormSectionExample: View {
    @State private var notify = true
    @State private var receipts = false

    var body: some View {
        Form {
            FabulaFormSection("Notifications", footer: "Synthetic preferences only.") {
                Toggle("Play sounds", isOn: $notify)
                Toggle("Read receipts", isOn: $receipts)
            }
        }
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaFormSection") {
    FabulaFormSectionExample()
}

struct FabulaFormSectionExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaFormSectionExample()
    }
}
