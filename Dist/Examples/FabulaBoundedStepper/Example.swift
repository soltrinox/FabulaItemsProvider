//
//  Example.swift
//  Dist/Examples/FabulaBoundedStepper
//
//  Adapted from FabulaItemsProvider P114_Stepper. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaBoundedStepperExample: View {
    @State private var value = 20

    var body: some View {
        FabulaBoundedStepper(value: $value, in: 0...100, step: 5) {
            Text("Quantity: \(value)")
        }
        .padding()
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaBoundedStepper") {
    FabulaBoundedStepperExample()
}

struct FabulaBoundedStepperExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaBoundedStepperExample()
    }
}
