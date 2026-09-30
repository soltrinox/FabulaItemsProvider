//
//  Example.swift
//  Dist/Examples/FabulaDebouncedText
//
//  Adapted from FabulaItemsProvider P282_DebouncedText. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaDebouncedTextExample: View {
    @State private var text = ""
    @State private var debounced = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("Type here", text: $text)
                .textFieldStyle(.roundedBorder)
                .fabulaDebouncedText(text: $text, debouncedText: $debounced, delay: 0.4)
            Text("Live length: \(text.count)")
            Text("Debounced length: \(debounced.count)")
                .foregroundStyle(.secondary)
        }
        .padding()
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaDebouncedText") {
    FabulaDebouncedTextExample()
}

struct FabulaDebouncedTextExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaDebouncedTextExample()
    }
}
