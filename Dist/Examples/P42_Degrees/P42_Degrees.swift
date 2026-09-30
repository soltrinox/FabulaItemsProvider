// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P42
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

public struct FabulaExample42_Angle: View {
    
    @State private var degrees: CGFloat = 0
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                ZStack {
                    ArcShape(endDegrees: degrees)
                        .stroke(LocalTheme.primary, lineWidth: 10)
                        .rotationEffect(Angle(degrees: -90))
                    Rectangle()
                        .fill(LocalTheme.primary)
                        .rotationEffect(Angle(degrees: degrees))
                        .frame(width: 100, height: 100)
                    Text("\(Int(degrees))°")
                        .font(.title)
                        .animation(.none, value: degrees)
                }
                .frame(width: proxy.minSize * 0.8, height: proxy.minSize * 0.8)
            }
        }
        .onTapGesture {
            setAnimation(degrees == 0 ? 360.0 : 0.0)
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation(.linear(duration: 5.0)) {
                    setAnimation(360)
                }
            }
        }
    }
    
    private func setAnimation(_ degrees: CGFloat) {
        withAnimation(.linear(duration: 5.0)) {
            self.degrees = degrees
        }
    }
}

fileprivate
struct ArcShape: Shape {
    
    var endDegrees: CGFloat
    
    var animatableData: CGFloat {
        get {
            endDegrees
        } set {
            endDegrees = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                     radius: rect.width / 2 ,
                     startAngle: Angle.zero,
                     endAngle: Angle(degrees: endDegrees),
                     clockwise: false)
        }
    }
}

struct FabulaExample42_Angle_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample42_Angle()
    }
}
