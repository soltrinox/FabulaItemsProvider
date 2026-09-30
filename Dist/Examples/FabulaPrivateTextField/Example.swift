//
//  Example.swift
//  Dist/Examples/FabulaPrivateTextField
//
//  Adapted from FabulaItemsProvider P99_DisableAutocorrection. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaPrivateTextFieldExample: View {
    @State private var username = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
#if os(iOS)
            FabulaPrivateTextField("Username", text: $username, textContentType: .username)
                .textFieldStyle(.roundedBorder)
#else
            FabulaPrivateTextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
#endif
            Text("Chars: \(username.count)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaPrivateTextField") {
    FabulaPrivateTextFieldExample()
}

struct FabulaPrivateTextFieldExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaPrivateTextFieldExample()
    }
}
