// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P91
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample91_LegibilityWeight: View {
    
    @Environment(\.legibilityWeight) private var legibilityWeight: LegibilityWeight?
    
    public init() {}
    public var body: some View {
        VStack {
            LegibilityWeightView()
                .environment(\.legibilityWeight, .bold)
            Divider()
                .frame(width: 44)
                .padding()
            LegibilityWeightView()
                .environment(\.legibilityWeight, .regular)
        }
    }
}

fileprivate
struct LegibilityWeightView: View {
    
    @Environment(\.legibilityWeight) private var legibilityWeight: LegibilityWeight?
    
    var body: some View {
        VStack {
            if legibilityWeight == .bold {
                Text("legibilityWeight: bold")
                    .fontWeight(.bold)
            } else {
                Text("legibilityWeight: regular")
                    .fontWeight(.regular)
            }
        }
    }
}

struct FabulaExample91_LegibilityWeight_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample91_LegibilityWeight()
    }
}
