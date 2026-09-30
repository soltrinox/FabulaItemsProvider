//
//  Example.swift
//  Dist/Examples/FabulaMinimalProgress
//
//  Adapted from FabulaItemsProvider P50_ProgressView. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaMinimalProgressExample: View {
    @State private var progress = 0.42

    var body: some View {
        VStack(spacing: 20) {
            FabulaMinimalProgress(progress: $progress, label: "Loading")
            Slider(value: $progress, in: 0...1)
        }
        .padding()
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaMinimalProgress") {
    FabulaMinimalProgressExample()
}

struct FabulaMinimalProgressExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaMinimalProgressExample()
    }
}
