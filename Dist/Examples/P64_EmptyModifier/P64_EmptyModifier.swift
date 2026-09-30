// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P64
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample64_EmptyModifier: View {

    var modifier: some ViewModifier {
#if !DEBUG
        return CapsuleLayout()
#else
        return EmptyModifier()
#endif
    }
    
    public init() {}
    public var body: some View {
        Text("Hello, World!")
            .modifier(modifier)
    }
}

fileprivate
struct CapsuleLayout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.black)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
    }
}

struct FabulaExample64_EmptyModifier_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample64_EmptyModifier()
    }
}
