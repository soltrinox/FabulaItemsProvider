//
//  Example.swift
//  Dist/Examples/FabulaRoundedTextFieldStyle
//
//  Adapted from FabulaItemsProvider P259_TextFieldStyle. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaRoundedTextFieldStyleExample: View {
    @State private var text = "Sample"

    var body: some View {
        VStack(spacing: 16) {
            TextField("Label", text: $text)
                .fabulaRoundedTextFieldStyle()
            Text("Preview value: \(text)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(FabulaTheme.fabulaDefault.back1)
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaRoundedTextFieldStyle") {
    FabulaRoundedTextFieldStyleExample()
}

struct FabulaRoundedTextFieldStyleExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaRoundedTextFieldStyleExample()
    }
}
