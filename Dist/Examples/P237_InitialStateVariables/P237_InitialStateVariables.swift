// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P237
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample237_InitialState: View {
    
    public init() {}
    public var body: some View {
        Example(value: 10.0)
    }
}

fileprivate
struct Example: View {
    
    @State private var value: CGFloat = 0
    
    init(value: CGFloat) {
        _value = State(initialValue: value)
    }
    
    var body: some View {
        Text("Initial Value : \(value)")
    }
}

struct FabulaExample237_InitialState_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample237_InitialState()
    }
}
