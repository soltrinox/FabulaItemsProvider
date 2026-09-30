// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P99
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample99_DisableAutocorrection: View {
    
    @State private var name = ""
    
    public init() {}
    public var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("disableAutocorrection == true")
                    .font(.callout)
                    .opacity(0.5)
                TextField("Enter your name", text: $name)
                    .disableAutocorrection(true)
            }
            Divider()
                .padding()
            VStack(alignment: .leading) {
                Text("disableAutocorrection == false")
                    .font(.callout)
                    .opacity(0.5)
                TextField("Enter your name", text: $name)
                    .disableAutocorrection(false)
            }
        }
        .frame(maxWidth: 500)
        .padding()
    }
}

struct FabulaExample99_DisableAutocorrection_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample99_DisableAutocorrection()
    }
}
