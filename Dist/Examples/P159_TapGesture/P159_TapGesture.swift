// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P159
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample159_TapGesture: View {
    
    @State var tapped = false
    
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in self.tapped = !self.tapped }
    }
    
    public init() {}
    public var body: some View {
        Circle()
            .fill(self.tapped ? Color.blue : Color.red)
            .frame(width: 200, height: 200, alignment: .center)
            .overlay(
                Text("Tap")
                    .bold()
            )
            .gesture(tap)
    }
}

struct FabulaExample159_TapGesture_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample159_TapGesture()
    }
}
