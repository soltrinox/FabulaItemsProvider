// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P186
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample186_RotateGesture: View {
    
    @State private var angle: CGFloat = 0
    @State private var prevAngle: CGFloat = 0
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            let min = min(proxy.size.width, proxy.size.height)
            let size = CGSize(width: min * 0.5, height: min * 0.5)
            ZStack {
                Color.clear
                VStack {
                    Text("\(angle)")
                    Spacer().frame(height: min * 0.2)
                    Image(systemName: "wrench.and.screwdriver")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .rotationEffect(.degrees(Double(self.angle)))
                        .gesture(RotateGesture(angle: $angle, prevAngle: $prevAngle, size: size))
                }
            }
        }
    }
}

fileprivate
struct RotateGesture: Gesture {
    
    @Binding var angle: CGFloat
    @Binding var prevAngle: CGFloat

    let size: CGSize
    
    var body: some Gesture {
        DragGesture()
            .onChanged{ value in
                let loc = value.location
                let startLoc = value.startLocation
                let locAtan = atan2(loc.x - size.width * 0.5, size.height * 0.5 - loc.y)
                let startLocAtan = atan2(startLoc.x - size.width * 0.5, size.height * 0.5 - startLoc.y)
                let delta = (locAtan - startLocAtan) * 180 / .pi

                self.angle = self.prevAngle + delta
            }
            .onEnded { value in
                self.prevAngle = self.angle
            }
    }
}

struct FabulaExample186_RotateGesture_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample186_RotateGesture()
    }
}
