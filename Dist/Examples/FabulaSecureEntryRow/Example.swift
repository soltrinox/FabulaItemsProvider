//
//  Example.swift
//  Dist/Examples/FabulaSecureEntryRow
//
//  Adapted from FabulaItemsProvider P151_SecureField. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaSecureEntryRowExample: View {
    @State private var token = ""

    var body: some View {
        Form {
            FabulaSecureEntryRow("API Token", text: $token, allowsReveal: true)
            Text("Length: \(token.count)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaSecureEntryRow") {
    FabulaSecureEntryRowExample()
}

struct FabulaSecureEntryRowExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaSecureEntryRowExample()
    }
}
