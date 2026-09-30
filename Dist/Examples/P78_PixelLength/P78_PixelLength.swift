// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P78
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample78_PixelLength: View {
    
    @Environment(\.pixelLength) private var pixelLength: CGFloat
    
    public init() {}
    public var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(".pixelLength")
                .font(.caption)
                .opacity(0.5)
            Text("\(pixelLength)")
        }
    }
}

struct FabulaExample78_PixelLength_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample78_PixelLength()
    }
}
