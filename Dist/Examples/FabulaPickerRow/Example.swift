//
//  Example.swift
//  Dist/Examples/FabulaPickerRow
//
//  Adapted from FabulaItemsProvider P55_Picker. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

private enum FabulaPickerDemoOption: String, CaseIterable, Identifiable {
    case alpha, beta, gamma
    var id: String { rawValue }
}

struct FabulaPickerRowExample: View {
    @State private var option: FabulaPickerDemoOption = .alpha

    var body: some View {
        Form {
            FabulaPickerRow("Flavor", selection: $option) {
                ForEach(FabulaPickerDemoOption.allCases) { item in
                    Text(item.rawValue.capitalized).tag(item)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding()
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaPickerRow") {
    FabulaPickerRowExample()
}

struct FabulaPickerRowExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaPickerRowExample()
    }
}
