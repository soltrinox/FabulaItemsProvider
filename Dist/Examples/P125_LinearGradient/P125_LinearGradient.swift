// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P125
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample125_LinearGradient: View {
    
    let gradient = Gradient(colors: [.red, .green, .blue])
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(
                    gradient: gradient,
                    startPoint: .leading,
                    endPoint: .trailing))
        }
        .padding()
        .frame(maxWidth: 300, maxHeight: 300)
    }
}

struct FabulaExample125_LinearGradient_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample125_LinearGradient()
    }
}
