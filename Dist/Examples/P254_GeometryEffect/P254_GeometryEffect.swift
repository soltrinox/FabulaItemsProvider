// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P254
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

public struct FabulaExample254_GeometryEffect: View {
    
    @State private var animateIndex: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                let newPosition1 = newPosition1(proxy.minSize / 4)
                let newPosition2 = newPosition2(proxy.minSize / 4)
                Rectangle()
                    .foregroundColor(LocalTheme.primary)
                    .frame(width: proxy.minSize / 2, height: proxy.minSize / 2)
                    .overlay(PositionView())
                    .modifier(MyEffect(positionX: newPosition1.x,
                                       positionY: newPosition1.y))
                Rectangle()
                    .foregroundColor(LocalTheme.secondary)
                    .frame(width: proxy.minSize / 2, height: proxy.minSize / 2)
                    .overlay(PositionView())
                    .modifier(MyEffect(positionX: newPosition2.x,
                                       positionY: newPosition2.y))
            }
            .onReceive(timer, perform: { t in
                withAnimation(.easeInOut(duration: 1)) {
                    animateIndex += 1
                    if animateIndex >= 4 {
                        animateIndex = 0
                    }
                }
            })
        }
        .padding()
    }
    
    private func newPosition1(_ maxValue: CGFloat) -> CGPoint {
        switch animateIndex {
        case 0: return CGPoint(x: -maxValue, y: -maxValue)
        case 1: return CGPoint(x: -maxValue, y: maxValue)
        case 2: return CGPoint(x: maxValue, y: maxValue)
        case 3: return CGPoint(x: maxValue, y: -maxValue)
        default: return CGPoint.zero
        }
    }
    
    private func newPosition2(_ maxValue: CGFloat) -> CGPoint {
        switch animateIndex {
        case 0: return CGPoint(x: maxValue, y: maxValue)
        case 1: return CGPoint(x: maxValue, y: -maxValue)
        case 2: return CGPoint(x: -maxValue, y: -maxValue)
        case 3: return CGPoint(x: -maxValue, y: maxValue)
        default: return CGPoint.zero
        }
    }
}

fileprivate
struct MyEffect: GeometryEffect {
    
    var positionX: CGFloat = 0
    var positionY: CGFloat = 0
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(positionX, positionY)
        }
        set {
            positionX = newValue.first
            positionY = newValue.second
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(
            CGAffineTransform(translationX: positionX, y: positionY)
        )
    }
}

fileprivate
struct PositionView: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                VStack(alignment: .leading) {
                    Text("x = \(Int(proxy.frame(in: .global).minX))")
                    Text("y = \(Int(proxy.frame(in: .global).minY))")
                }
            }
            .foregroundColor(.white)
            .font(.title3)
        }
        .padding()
    }
}

struct FabulaExample254_GeometryEffect_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample254_GeometryEffect()
    }
}
