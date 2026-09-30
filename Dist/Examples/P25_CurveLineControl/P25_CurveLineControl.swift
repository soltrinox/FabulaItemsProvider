// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P25
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

public struct FabulaExample25_CurveLine: View {
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            CurveLineControlView(canvasSize: proxy.size)
        }
    }
}

fileprivate
struct CurveLine: Shape {
    
    var startPoint: CGPoint
    var control1: CGPoint
    var control2: CGPoint
    var endPoint: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        p.move(to: startPoint)
        p.addCurve(to: endPoint, control1: control1, control2: control2)
        
        return p
    }
}

fileprivate
struct CurveControlLine: Shape {
    
    var startPoint: CGPoint
    var control1: CGPoint
    var control2: CGPoint
    var endPoint: CGPoint
    
    func path(in rect: CGRect) -> Path {
        
        var p = Path()
        p.move(to: startPoint)
        p.addLine(to: control1)
        p.move(to: endPoint)
        p.addLine(to: control2)
        p.addLine(to: control1)
        
        return p
    }
}

fileprivate
struct CurveControlDragButton: View {
    let title: String
    let subTitle: String
    var body: some View {
        Circle()
            .stroke(lineWidth: 2)
            .fill(LocalTheme.fore1)
            .background(LocalTheme.back1)
            .overlay(
                ZStack {
                    Text(title)
                        .font(.callout)
                        .foregroundColor(LocalTheme.fore1)
                    Text(subTitle)
                        .font(.caption)
                        .foregroundColor(LocalTheme.fore2)
                        .offset(x: 36, y: 36)
                }
            )
    }
}

fileprivate
struct CurveLineControlView: View {
    
#if os(iOS)
    @Environment(\.horizontalSizeClass) var sizeClass
#endif
    let size: CGFloat = 36.0
    var canvasSize: CGSize = .zero
    
    @State private var startPointNew: CGPoint = .zero
    @State private var startPointCurrent: CGPoint = .zero
    
    @State private var control1New: CGPoint = .zero
    @State private var control1Current: CGPoint = .zero
    
    @State private var control2New: CGPoint = .zero
    @State private var control2Current: CGPoint = .zero
    
    @State private var endPointNew: CGPoint = .zero
    @State private var endPointCurrent: CGPoint = .zero
    
    @State private var phase: CGFloat = 0
    
    var startDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.startPointCurrent = CGPoint(x: value.translation.width + self.startPointNew.x,
                                                 y: value.translation.height + self.startPointNew.y)
            }
            .onEnded { value in
                self.startPointCurrent = CGPoint(x: value.translation.width + self.startPointNew.x,
                                                 y: value.translation.height + self.startPointNew.y)
        // print removed
                self.startPointNew = self.startPointCurrent
            }
    }
    
    var endDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.endPointCurrent = CGPoint(x: value.translation.width + self.endPointNew.x,
                                               y: value.translation.height + self.endPointNew.y)
            }
            .onEnded { value in
                self.endPointCurrent = CGPoint(x: value.translation.width + self.endPointNew.x,
                                               y: value.translation.height + self.endPointNew.y)
        // print removed
                self.endPointNew = self.endPointCurrent
            }
    }
    
    var control1Drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.control1Current = CGPoint(x: value.translation.width + self.control1New.x,
                                               y: value.translation.height + self.control1New.y)
            }
            .onEnded { value in
                self.control1Current = CGPoint(x: value.translation.width + self.control1New.x,
                                               y: value.translation.height + self.control1New.y)
        // print removed
                self.control1New = self.control1Current
            }
    }
    
    var control2Drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.control2Current = CGPoint(x: value.translation.width + self.control2New.x,
                                               y: value.translation.height + self.control2New.y)
            }
            .onEnded { value in
                self.control2Current = CGPoint(x: value.translation.width + self.control2New.x,
                                               y: value.translation.height + self.control2New.y)
        // print removed
                self.control2New = self.control2Current
            }
    }
    
    var body: some View {
        ZStack {
            Color.clear
            CurveLine(startPoint: startPointCurrent,
                      control1: control1Current,
                      control2: control2Current,
                      endPoint: endPointCurrent)
                .stroke(lineWidth: 2)
                .fill(LocalTheme.primary)
            
            CurveControlLine(startPoint: startPointCurrent,
                             control1: control1Current,
                             control2: control2Current,
                             endPoint: endPointCurrent)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [4], dashPhase: phase))
                .fill(LocalTheme.fore1.opacity(0.5))
            
            GeometryReader { proxy in
                CurveControlDragButton(title: "S", subTitle: getPointInfo(self.startPointCurrent))
                    .frame(width: size, height: size)
                    .offset(x: self.startPointCurrent.x - size / 2, y: self.startPointCurrent.y - size / 2)
                    .gesture(startDrag)
                CurveControlDragButton(title: "E", subTitle: getPointInfo(self.endPointCurrent))
                    .frame(width: size, height: size)
                    .offset(x: self.endPointCurrent.x - size / 2, y: self.endPointCurrent.y - size / 2)
                    .gesture(endDrag)
                CurveControlDragButton(title: "C1", subTitle: getPointInfo(self.control1Current))
                    .frame(width: size, height: size)
                    .offset(x: self.control1Current.x - size / 2, y: self.control1Current.y - size / 2)
                    .gesture(control1Drag)
                CurveControlDragButton(title: "C2", subTitle: getPointInfo(self.control2Current))
                    .frame(width: size, height: size)
                    .offset(x: self.control2Current.x - size / 2, y: self.control2Current.y - size / 2)
                    .gesture(control2Drag)
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                initPosition()
            }
        }
    }
    
    private func initPosition() {
        
        var start = CGPoint(x: canvasSize.width * 0.2, y: canvasSize.height / 1.5)
        var control1 = CGPoint(x: canvasSize.width * 0.45, y: canvasSize.height * 0.3)
        var control2 = CGPoint(x: canvasSize.width * 0.55, y: canvasSize.height * 0.7)
        var end = CGPoint(x: canvasSize.width * 0.8, y: canvasSize.height / 2)
        
#if os(iOS)
        if sizeClass == .compact {
            start = CGPoint(x: canvasSize.width / 1.5, y: canvasSize.height * 0.1)
            control1 = CGPoint(x: canvasSize.width * 0.8, y: canvasSize.height * 0.3)
            control2 = CGPoint(x: canvasSize.width * 0.2, y: canvasSize.height * 0.6)
            end = CGPoint(x: canvasSize.width / 2, y: canvasSize.height * 0.8)
        }
#endif
        
        startPointNew = start
        startPointCurrent = start
        
        control1New = control1
        control1Current = control1
        
        control2New = control2
        control2Current = control2
        
        endPointNew = end
        endPointCurrent = end
    }
    
    private func getPointInfo(_ point: CGPoint) -> String {
        String(format: "X:%1.f Y:%1.f", point.x, point.y)
    }
}

struct FabulaExample25_CurveLine_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample25_CurveLine()
    }
}
