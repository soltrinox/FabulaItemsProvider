// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P188
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

public struct FabulaExample188_LineAnimation: View {

    @State var startPoint: CGPoint = .zero
    @State var endPoint: CGPoint = .zero
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                Line(startPoint: startPoint, endPoint: endPoint)
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .fill(LocalTheme.primary)
                
                Button("Animation") {
                    withAnimation {
                        changePoints(size: proxy.size)
                    }
                }
                .padding()
                .background(LocalTheme.primary)
                .foregroundColor(Color.white)
                .clipShape(Capsule())
                .buttonStyle(PlainButtonStyle())
            }
            .onAppear {
                changePoints(size: proxy.size)
            }
        }
    }
    
    private func changePoints(size: CGSize) {
        startPoint = CGPoint(x: CGFloat.random(in: 0..<size.width), y: CGFloat.random(in: 0..<size.height))
        endPoint = CGPoint(x: CGFloat.random(in: 0..<size.width), y: CGFloat.random(in: 0..<size.height))
    }
}

fileprivate
struct Line: Shape {
    var startPoint: CGPoint
    var endPoint: CGPoint
    var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
        get { AnimatablePair(startPoint.animatableData, endPoint.animatableData) }
        set { (startPoint.animatableData, endPoint.animatableData) = (newValue.first, newValue.second) }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.startPoint)
            p.addLine(to: self.endPoint)
        }
    }
}

struct FabulaExample188_LineAnimation_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample188_LineAnimation()
    }
}
