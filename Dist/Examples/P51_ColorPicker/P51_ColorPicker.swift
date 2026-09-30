// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P51
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample51_ColorPicker: View {
    
    @State private var currentColor = Color.clear
    
    public init() {}
    public var body: some View {
        ZStack {
            currentColor
            ColorPicker("Select Color", selection: $currentColor.animation())
                .frame(maxWidth: 300)
                .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct FabulaExample51_ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample51_ColorPicker()
    }
}
