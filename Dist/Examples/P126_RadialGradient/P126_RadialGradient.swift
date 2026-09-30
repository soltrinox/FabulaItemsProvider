// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P126
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample126_RadialGradient: View {
    
    let gradient = Gradient(colors: [.red, .green, .blue])
    
    public init() {}
    public var body: some View {
        Circle()
            .fill(RadialGradient(gradient: gradient, center: .center, startRadius: 1, endRadius: 100))
            .frame(width: 200, height: 200)
    }
}

struct FabulaExample126_RadialGradient_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample126_RadialGradient()
    }
}
