// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P266
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

public struct FabulaExample266_ViscosityCanvas: View {

    @State private var scale1: CGFloat = 1
    @State private var scale2: CGFloat = 1
    @State private var isFillMode: Bool = true
    
    public init() {}
    public var body: some View {
        ZStack {
            viscosityView(color: LocalTheme.primary, scale: $scale1)
            viscosityView(color: LocalTheme.secondary, scale: $scale2)
                .blendMode(.screen)
            
            Toggle(isOn: $isFillMode) {
                EmptyView()
            }
            .labelsHidden()
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func viscosityView(color: Color, scale: Binding<CGFloat>) -> some View {
        GeometryReader { geo in
            if isFillMode {
                ViscosityCanvas(color: color) {
                    circle(cnavasSize: geo.size, scale: scale)
                }
            } else {
                ViscosityCanvas(color: color, thresholdMin: 0.5, thresholdMax: 0.7) {
                    circle(cnavasSize: geo.size, scale: scale)
                }
            }
        }
    }
    
    @ViewBuilder
    private func circle(cnavasSize: CGSize, scale: Binding<CGFloat>) -> some View {
        let min = min(cnavasSize.width, cnavasSize.height) * 0.09
        let width: CGFloat = .random(in: min...(min * 2.6))
        let height: CGFloat = .random(in: min...(min * 2.6))
        
        ForEach(0..<60, id: \.self) { index in
            Circle()
                .frame(width: width, height: height)
                .scaleEffect(scale.wrappedValue * .random(in: 0.1..<1.5))
                .animation(Animation.easeInOut(duration: 3)
                    .repeatForever()
                    .speed(.random(in: 0.2...1.0))
                    .delay(.random(in: 0...2)), value: scale.wrappedValue)
                .position(CGPoint(x: .random(in: 0..<cnavasSize.width),
                                  y: .random(in: 0..<cnavasSize.height)))
                .tag(index)
        }
        .onAppear {
            scale.wrappedValue = scale.wrappedValue == 1.2 ? 1.0 : 1.2
        }
    }
}

fileprivate
struct ViscosityCanvas<Symbols: View> : View {
    
    let color: Color
    let thresholdMin: CGFloat
    let thresholdMax: CGFloat?
    let radius: CGFloat
    let symbols: () -> Symbols
    
    var body: some View {
        Canvas { context, size in
            if let thresholdMax = thresholdMax {
                context.addFilter(.alphaThreshold(min: thresholdMin, max: thresholdMax, color: color))
            } else {
                context.addFilter(.alphaThreshold(min: thresholdMin, color: color))
            }
            context.addFilter(.blur(radius: 12))
            context.drawLayer { ctx in
                for index in 0..<60 {
                    if let view = context.resolveSymbol(id: index) {
                        ctx.draw(view, at: CGPoint(x: size.width / 2, y: size.height / 2))
                    }
                }
            }
        } symbols: {
            symbols()
        }
    }
    
    init(color: Color, thresholdMin: CGFloat = 0.5, thresholdMax: CGFloat? = nil, radius: CGFloat = 12, @ViewBuilder symbols: @escaping () -> Symbols) {
        self.color = color
        self.thresholdMin = thresholdMin
        self.thresholdMax = thresholdMax
        self.radius = radius
        self.symbols = symbols
    }
}

struct FabulaExample266_ViscosityCanvas_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample266_ViscosityCanvas()
    }
}
