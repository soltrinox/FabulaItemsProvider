//
//  Example.swift
//  Dist/Examples/FabulaCheckbox
//
//  Adapted from FabulaItemsProvider P279_CheckboxComponent. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaCheckboxExample: View {
    @State private var agreed = false

    var body: some View {
        FabulaCheckbox("I agree to the terms", isOn: $agreed)
            .padding()
            .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaCheckbox") {
    FabulaCheckboxExample()
}

struct FabulaCheckboxExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaCheckboxExample()
    }
}
