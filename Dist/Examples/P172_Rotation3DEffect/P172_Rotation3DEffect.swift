// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P172
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

public struct FabulaExample172_Rotation3DEffect: View {
    
    @State private var degreesX: Double = 0
    @State private var degreesY: Double = 0
    @State private var degreesZ: Double = 0
    @State private var x: Bool = false
    @State private var y: Bool = false
    @State private var z: Bool = false
    
    public init() {}
    public var body: some View {
        VStack(spacing: 25) {
            Text("100")
                .font(.system(size: 80))
                .bold()
                .padding()
                .background(Color.blue)
                .foregroundColor(LocalTheme.primary)
                .rotation3DEffect(.degrees(degreesX), axis: (x: x ? 1 : 0, y: 0, z: 0))
                .rotation3DEffect(.degrees(degreesY), axis: (x: 0, y: y ? 1 : 0, z: 0))
                .rotation3DEffect(.degrees(degreesZ), axis: (x: 0, y: 0, z: z ? 1 : 0))
            
            Divider()
                .frame(width: 44)
                .padding()
            
            VStack(alignment: .leading, spacing: 0) {
                Text(".rotation3DEffect(.degrees(\(degreesX), axis: (x: \(x ? 1 : 0), y: 0, z: 0)")
                Text(".rotation3DEffect(.degrees(\(degreesY), axis: (x: 0, y: \(y ? 1 : 0), z: 0)")
                Text(".rotation3DEffect(.degrees(\(degreesZ), axis: (x: 0, y: 0, z: \(z ? 1 : 0))")
            }
            .font(.caption)
            .opacity(0.5)
            
            Divider()
                .frame(width: 44)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .bottom, spacing: 0) {
                    Slider(value: $degreesX.animation(), in: 0...360).modifier(SliderModifier(title: "X Angle", value: $degreesX))
                        .saturation(x ? 1 : 0)
                        .opacity(x ? 1 : 0.5)
                    Toggle("", isOn: $x).frame(width: 80)
                }
                HStack(alignment: .bottom, spacing: 0) {
                    Slider(value: $degreesY.animation(), in: 0...360).modifier(SliderModifier(title: "Y Angle", value: $degreesY))
                        .saturation(y ? 1 : 0)
                        .opacity(y ? 1 : 0.5)
                    Toggle("", isOn: $y).frame(width: 80)
                }
                HStack(alignment: .bottom, spacing: 0) {
                    Slider(value: $degreesZ.animation(), in: 0...360).modifier(SliderModifier(title: "Z Angle", value: $degreesZ))
                        .saturation(z ? 1 : 0)
                        .opacity(z ? 1 : 0.5)
                    Toggle("", isOn: $z).frame(width: 80)
                }
            }
        }
        .padding()
        .padding(.horizontal)
        .frame(maxWidth: 500)
    }
}

extension P172_Rotation3DEffect {
    struct SliderModifier: ViewModifier {
        let title: String
        @Binding var value: Double
        func body(content: Content) -> some View {
            VStack(alignment: .leading, spacing: 5) {
                Text(title + " (\(value))")
                    .font(.callout)
                    .opacity(0.5)
                content
            }
        }
    }
}

struct FabulaExample172_Rotation3DEffect_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample172_Rotation3DEffect()
    }
}
