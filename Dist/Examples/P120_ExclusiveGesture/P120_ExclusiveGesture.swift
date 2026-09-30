// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P120
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample120_ExclusiveGesture: View {
    
    @State private var isSunDay: Bool = true
    @State private var angle = Angle(degrees: 0.0)
    
    public init() {}
    public var body: some View {
        VStack {
            Text("Current Angle: \(angle.degrees)")
            Divider().frame(width: 44).padding()
            Image(systemName: isSunDay ? "sun.min.fill" : "moon.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .rotationEffect(angle)
                .animation(.easeOut, value: isSunDay)
                .animation(.easeOut, value: angle)
                .gesture(
                    TapGesture(count: 1)
                        .onEnded { _ in
                            self.isSunDay.toggle()
                        }
                        .exclusively(before:
                                        RotationGesture()
                                        .onChanged { angle in
                                            self.angle = angle
                                        }
                                    )
                )
        }
    }
}

struct FabulaExample120_ExclusiveGesture_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample120_ExclusiveGesture()
    }
}
