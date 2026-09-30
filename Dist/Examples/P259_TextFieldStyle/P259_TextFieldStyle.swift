// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P259
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample259_TextFieldStyle: View {
    
    @State private var text = ""
    
    public init() {}
    public var body: some View {
        VStack {
            Text("Text: \(text)")
            Divider()
            TextField(".plain", text: $text)
                .textFieldStyle(.plain)
            TextField(".automatic", text: $text)
                .textFieldStyle(.automatic)
            TextField(".roundedBorder", text: $text)
                .textFieldStyle(.roundedBorder)
#if os(macOS)
            TextField(".squareBorder", text: $text)
                .textFieldStyle(.squareBorder)
#endif
        }
        .padding()
    }
}

struct FabulaExample259_TextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample259_TextFieldStyle()
    }
}
