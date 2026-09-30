// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P135
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample135_ListItemTint: View {
    
    public init() {}
    public var body: some View {
        List {
            // A tint Color that cannot be overriden by the system.
            Label("ListItemTint.fixed", systemImage: "cloud.heavyrain.fill")
                .listItemTint(ListItemTint.fixed(Color.orange))
            // A tint Color that can be overriden by the system.
            Label("ListItemTint.preferred", systemImage: "cloud.hail.fill")
                .listItemTint(ListItemTint.preferred(Color.green))
            // The standard gray tint effect.
            Label("ListItemTint.monochrome", systemImage: "cloud.snow.fill")
                .listItemTint(ListItemTint.monochrome)
        }
        .frame(maxWidth: 500, maxHeight: 200)
    }
}

struct FabulaExample135_ListItemTint_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample135_ListItemTint()
    }
}
