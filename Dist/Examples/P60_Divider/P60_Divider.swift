// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P60
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample60_Divider: View {
    
    public init() {}
    public var body: some View {
        HStack {
            VStack {
                Text("Space 1")
                Divider().background(Color.green)
                Text("Space 2")
            }
            Divider().background(Color.red)
            VStack {
                Text("Space 3")
                Divider().background(Color.blue)
                Text("Space 4")
            }
        }
        .padding()
        .frame(maxWidth: 400, maxHeight: 400)
    }
}

struct FabulaExample60_Divider_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample60_Divider()
    }
}
