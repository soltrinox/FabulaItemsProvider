// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P198
// Adapted: local theme; print removed; no third-party.

import SwiftUI

fileprivate enum LocalTheme {
    static let primary = Color(red: 0.969, green: 0.475, blue: 0.278)
    static let secondary = Color(red: 0.122, green: 0.753, blue: 0.843)
    static let back0 = Color(red: 0.980, green: 0.980, blue: 0.980)
    static let back1 = Color(red: 0.941, green: 0.941, blue: 0.941)
    static let back2 = Color(red: 0.902, green: 0.902, blue: 0.902)
    static let fore1 = Color(red: 0.125, green: 0.125, blue: 0.196)
    static let fore2 = Color(red: 0.565, green: 0.561, blue: 0.580)
    static let bar1 = Color(red: 0.952, green: 0.952, blue: 0.956)
    static let bar2 = Color(red: 0.894, green: 0.897, blue: 0.895)
    static let foreWB100 = Color.black
    static let backWB100 = Color.white
}


import SwiftUI

public struct FabulaExample198_PolygonShape: View {
    @State private var sideCount: Double = 3
    public init() {}
    public var body: some View {
        VStack {
            Spacer()
            PolygonShape(sideCount: Double(Int(sideCount)))
                .fill(LocalTheme.primary)
                .overlay(
                    PolygonShape(sideCount: Double(Int(sideCount)))
                        .stroke(LocalTheme.primary, lineWidth: 2)
                )
                .rotationEffect(Angle(degrees: 180))
            Divider().frame(width: 44)
            Slider(value: $sideCount, in: 1...15)
            Spacer()
        }
        .animation(.easeInOut(duration: 0.5), value: sideCount)
        .padding()
    }
}

fileprivate
struct PolygonShape: Shape {
    
    var sideCount: Double
    
    var animatableData: Double {
        get { return sideCount }
        set { sideCount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {

        let size = Double(min(rect.size.width, rect.size.height) / 2.0)
        let center = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        var path = Path()
        let correction = sideCount != round(sideCount) ? 1 : 0
        for i in 0..<Int(sideCount) + correction {
            let angle = (Double.pi / 180 * (360.0 / sideCount) * Double(i))
            let vertex = CGPoint(x: center.x + Double(sin(angle) * size),
                             y: center.y + Double(cos(angle) * size))

            if i == 0 {
                path.move(to: vertex)
            } else {
                path.addLine(to: vertex)
            }
        }
        
        path.closeSubpath()
        return path
    }
}

struct FabulaExample198_PolygonShape_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample198_PolygonShape()
    }
}
