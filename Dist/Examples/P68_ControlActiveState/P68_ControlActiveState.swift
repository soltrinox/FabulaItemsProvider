// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P68
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample68_ControlActiveState: View {
#if os(macOS)
    @Environment(\.controlActiveState) private var controlActiveState: ControlActiveState
    
    public init() {}
    public var body: some View {
        switch controlActiveState {
        case .key : Text("key")
        case .active : Text("active")
        case .inactive : Text("inactive")
        default: EmptyView()
        }
    }
#else
    public init() {}
    public var body: some View {
        EmptyView()
    }
#endif
}

struct FabulaExample68_ControlActiveState_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample68_ControlActiveState()
    }
}
