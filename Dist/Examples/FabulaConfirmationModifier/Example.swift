//
//  Example.swift
//  Dist/Examples/FabulaConfirmationModifier
//
//  Adapted from FabulaItemsProvider P110_ConfirmationDialog. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaConfirmationModifierExample: View {
    @State private var isPresented = false
    @State private var choice = "None"

    var body: some View {
        VStack(spacing: 16) {
            Text(choice)
            Button("Show Dialog") { isPresented = true }
        }
        .fabulaConfirmationDialog("Select a menu", isPresented: $isPresented) {
            Button("Menu 1") { choice = "Menu 1" }
            Button("Menu 2") { choice = "Menu 2" }
            Button("Cancel", role: .cancel) {}
        }
        .padding()
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaConfirmationModifier") {
    FabulaConfirmationModifierExample()
}

struct FabulaConfirmationModifierExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaConfirmationModifierExample()
    }
}
