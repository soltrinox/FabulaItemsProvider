//
//  Example.swift
//  Dist/Examples/FabulaRadioGroup
//
//  Adapted from FabulaItemsProvider P265_RadioComponent. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaRadioGroupExample: View {
    @State private var selection: Int? = 0

    var body: some View {
        FabulaRadioGroup(selection: $selection) {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(0..<3, id: \.self) { index in
                    HStack {
                        FabulaRadioItem(tag: index)
                        Text("Option \(index)")
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .fabulaRadioTag(index)
                }
            }
        }
        .padding()
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaRadioGroup") {
    FabulaRadioGroupExample()
}

struct FabulaRadioGroupExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaRadioGroupExample()
    }
}
