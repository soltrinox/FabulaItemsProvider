//
//  Example.swift
//  Dist/Examples/FabulaSwitch
//
//  Adapted from FabulaItemsProvider P280_SwitchComponent. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaSwitchExample: View {
    @State private var isOn = false

    var body: some View {
        HStack {
            Text(isOn ? "On" : "Off")
            FabulaSwitch(isOn: $isOn)
                .frame(width: 64, height: 36)
        }
        .padding()
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaSwitch") {
    FabulaSwitchExample()
}

struct FabulaSwitchExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaSwitchExample()
    }
}
