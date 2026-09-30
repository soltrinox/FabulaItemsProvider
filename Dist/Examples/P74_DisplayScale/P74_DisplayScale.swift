// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P74
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample74_DisplayScale: View {
    
    @Environment(\.displayScale) private var displayScale: CGFloat
    
    public init() {}
    public var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("displayScale")
                .font(.caption)
                .opacity(0.5)
            Text("\(displayScale)")
        }
    }
}

struct FabulaExample74_DisplayScale_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample74_DisplayScale()
    }
}
