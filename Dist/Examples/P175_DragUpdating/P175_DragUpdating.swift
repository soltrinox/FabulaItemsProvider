// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P175
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample175_DragGesture: View {
    
    @GestureState private var dragAmount = CGSize.zero
    
    public init() {}
    public var body: some View {
        ZStack {
            Color.clear
            VStack {
                Image(systemName: "umbrella.fill")
                    .font(.system(size: 100))
                Text("W: \(Int(dragAmount.width)) · H: \(Int(dragAmount.height))")
            }
            .offset(dragAmount)
            .animation(.easeInOut, value: dragAmount)
        }
        .gesture(
            DragGesture()
                .updating($dragAmount) { value, state, transaction in
                    state = value.translation
                }
        )
    }
}

struct FabulaExample175_DragGesture_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample175_DragGesture()
    }
}
