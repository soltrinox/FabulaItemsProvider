// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P67
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample67_ControlSize: View {
    
    @Environment(\.controlSize) private var controlSize: ControlSize
    
    public init() {}
    public var body: some View {
        ZStack {
            switch controlSize {
            case .mini : Text(".mini")
            case .small : Text(".small")
            case .regular : Text(".regular")
            case .large : Text(".large")
            default : EmptyView()
            }
        }
    }
}

struct FabulaExample67_ControlSize_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample67_ControlSize()
    }
}
