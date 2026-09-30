// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P27
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

public struct FabulaExample27_Spring: View {
    
    @State var center: CGPoint = .zero
    @State private var phase: CGFloat = 0
    
    var drag: some Gesture {
        DragGesture().onChanged { value in
            withAnimation(Animation.easeOut(duration: 0.1)) {
                center = CGPoint(x: value.translation.width, y: value.translation.height)
            }
        }
        .onEnded { value in
            withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 200.0, damping: 10, initialVelocity: 0)) {
                center = .zero
            }
        }
    }
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                ZStack {
                    Color.clear
                    WaterdropShape(x: center.x, y: center.y, count: 8)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [4], dashPhase: phase))
                        .fill(LocalTheme.primary)
                        .offset(x: proxy.minSize / 2, y: proxy.minSize / 2)
                    Circle()
                        .fill(LocalTheme.primary)
                        .overlay(
                            Text("DRAG")
                                .font(.custom("Helvetica Bold", fixedSize: proxy.minSize * 0.03))
                        )
                        .frame(width: proxy.minSize * 0.2, height: proxy.minSize * 0.2)
                        .offset(x: center.x, y: center.y)
                        .gesture(drag)
                }
                .frame(width: proxy.minSize, height: proxy.minSize)
            }
        }
        .padding()
    }
}

fileprivate
struct WaterdropShape: Shape {
    
    var x: CGFloat
    var y: CGFloat
    var count: Int = 8
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(x, y) }
        set {
            x = newValue.first
            y = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let pointSets = getPointSet(rect)
        for (index, pointSet) in pointSets.enumerated() {
            if index == 0 {
                p.move(to: pointSet.0)
            }
            p.addQuadCurve(to: pointSet.2, control: pointSet.1)
        }
        p.closeSubpath()
        return p
    }
    
    private func getPointSet(_ rect: CGRect) -> [(CGPoint, CGPoint, CGPoint)] {

        var pointSets = [(CGPoint, CGPoint, CGPoint)]()

        let pointRadius : CGFloat = rect.width/2
        let rectCenter = CGPoint(x: 0, y: 0)
        let pointStep = CGFloat(2 * CGFloat.pi) / CGFloat(count)

        for i in 0..<count {
            let pX1 = cos(CGFloat(pointStep) * CGFloat(i)) * pointRadius + rectCenter.x
            let pY1 = sin(CGFloat(pointStep) * CGFloat(i)) * pointRadius + rectCenter.y

            let pX2 = cos(CGFloat(pointStep) * CGFloat(i + 1)) * pointRadius + rectCenter.x
            let pY2 = sin(CGFloat(pointStep) * CGFloat(i + 1)) * pointRadius + rectCenter.y

            let pointSet = (
                CGPoint(x: pX1, y: pY1),
                CGPoint(x: x, y: y),
                CGPoint(x: pX2, y: pY2)
            )
            pointSets.append(pointSet)
            
        }
        
        return pointSets
    }
}

struct FabulaExample27_Spring_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample27_Spring().preferredColorScheme(.dark)
    }
}
