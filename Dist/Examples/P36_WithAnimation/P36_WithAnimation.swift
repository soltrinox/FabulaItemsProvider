// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P36
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample36_WithAnimation: View {
    
    @State private var showIcon = false
    
    public init() {}
    public var body: some View {
        HStack {
            if showIcon {
                Image(systemName: "airplane")
                    .font(.largeTitle)
                    .transition(.slide.combined(with: .opacity))
            }
            
            Text(showIcon ? "Hide" : "Show")
                .font(.title)
                .padding()
                .animation(Animation.easeInOut, value: showIcon)
                .onTapGesture {
                    withAnimation(.easeInOut) { showIcon.toggle() }
                }
        }
    }
}

struct FabulaExample36_WithAnimation_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample36_WithAnimation()
    }
}
