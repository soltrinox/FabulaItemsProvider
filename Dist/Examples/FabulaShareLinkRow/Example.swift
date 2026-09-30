//
//  Example.swift
//  Dist/Examples/FabulaShareLinkRow
//
//  Adapted from FabulaItemsProvider P268_ShareSheet. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaShareLinkRowExample: View {
    /// Example-only local URL — not a live network request.
    private let sampleURL = URL(string: "https://example.com/share-demo")!

    var body: some View {
        VStack(spacing: 16) {
            FabulaShareLinkRow("Share example.com", url: sampleURL)
            FabulaShareTextRow("Share note", text: "Synthetic preview payload")
        }
        .padding()
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaShareLinkRow") {
    FabulaShareLinkRowExample()
}

struct FabulaShareLinkRowExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaShareLinkRowExample()
    }
}
