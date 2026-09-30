// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P11
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample11_AngularGradient: View {
    
    let colors: [Color] = [.yellow, .red,.blue, .purple]
    
    public init() {}
    public var body: some View {
        Circle()
            .fill(AngularGradient(gradient: Gradient(colors: colors), center: .center,startAngle: .degrees(0), endAngle: .degrees(360)))
            .padding(60)
            .shadow(radius: 6)
        
    }
}

struct FabulaExample11_AngularGradient_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample11_AngularGradient()
    }
}
