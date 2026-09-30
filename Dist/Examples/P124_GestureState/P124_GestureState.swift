// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P124
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample124_GestureState: View {
    
    @GestureState var isDetectingLongPress = false
    
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 2)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
            }
    }
    
    public init() {}
    public var body: some View {
        Circle()
            .fill(self.isDetectingLongPress ? Color.red : Color.green)
            .frame(width: 100, height: 100, alignment: .center)
            .scaleEffect(isDetectingLongPress ? 1.5 : 1.0)
            .gesture(longPress)
            .animation(.easeInOut, value: isDetectingLongPress)
    }
}

struct FabulaExample124_GestureState_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample124_GestureState()
    }
}
