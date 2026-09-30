// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P165
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

public struct FabulaExample165_AnimatablePair: View {
    
    @State private var trimmedTo1: CGFloat = 1.0
    @State private var trimmedTo2: CGFloat = 2.0
    @State private var isHidden: Bool = false
    
    public init() {}
    public var body: some View {
        VStack {
            GeometryReader { proxy in
                let min = min(proxy.size.width, proxy.size.height)
                ZStack {
                    Color.clear
                    MyCircle(trimmedTo1: trimmedTo1, trimmedTo2: trimmedTo2)
                        .fill(LocalTheme.primary)
                        .padding()
                        .animation(.easeInOut(duration: 3), value: trimmedTo1)
                        .animation(.easeInOut(duration: 6), value: trimmedTo2)
                        .frame(width: min, height: min)
                    MyCircle(trimmedTo1: trimmedTo1, trimmedTo2: trimmedTo2)
                        .fill(LocalTheme.primary)
                        .opacity(0.5)
                        .padding()
                        .animation(.easeInOut(duration: 3), value: trimmedTo1)
                        .animation(.easeInOut(duration: 6), value: trimmedTo2)
                        .frame(width: min / 2, height: min / 2)
                        .rotationEffect(Angle(degrees: 90))
                }
            }
            
            Button {
                trimmedTo1 = isHidden ? 1.0 : 0.0
                trimmedTo2 = isHidden ? 2.0 : 0.0
                isHidden.toggle()
            } label: {
                Text("Animate!")
                    .padding()
                    .background(LocalTheme.primary)
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
        }
        .padding()
    }
}

fileprivate
extension P165_AnimatablePair{
    struct MyCircle: Shape {
        
        var trimmedTo1: CGFloat
        var trimmedTo2: CGFloat
        
        var animatableData: AnimatablePair<CGFloat, CGFloat> {
            get { AnimatablePair(trimmedTo1, trimmedTo2) }
            set {
                trimmedTo1 = newValue.first
                trimmedTo2 = newValue.second
            }
        }
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = rect.width / 2
            let start = Angle(radians: .pi * trimmedTo1 * 2)
            let end = Angle(radians: .pi * trimmedTo2 * 3)
            
            path.addArc(center: center, radius: radius, startAngle: start, endAngle: end, clockwise: false)
            return path
                .trimmedPath(from: 0.0, to: trimmedTo1)
                .trimmedPath(from: trimmedTo1, to: trimmedTo2)
                .strokedPath(.init(lineWidth: 6, lineCap: .round))
        }
    }
}

struct FabulaExample165_AnimatablePair_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample165_AnimatablePair()
    }
}
