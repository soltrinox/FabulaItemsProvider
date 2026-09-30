// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P140
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample140_OffsetShape: View {
    
    public init() {}
    public var body: some View {
        OffsetShape(shape: Circle(), offset: CGSize(width: 50, height: 0))
    }
}

struct FabulaExample140_OffsetShape_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample140_OffsetShape()
    }
}
