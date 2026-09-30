// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P154
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

public struct FabulaExample154_Slider: View {
    
    @State private var positionX = 0.5
    @State private var isEditing = false
    
    public init() {}
    public var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack {
                    Circle()
                        .fill(LocalTheme.primary)
                        .frame(width: 50, height: 50)
                    Text("\(positionX)")
                        .foregroundColor(isEditing ? .red : .blue)
                }
                .position(x: proxy.size.width * positionX,
                          y: 100 * sin(positionX * CGFloat.pi * 2))
                .animation(.easeInOut, value: positionX)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.bottom, 200)

            Slider(
                value: $positionX,
                in: 0...1,
                onEditingChanged: { editing in
                    isEditing = editing
                }
            )
        }
        .padding()
        .padding(.horizontal, 50)
        .frame(maxWidth: 500)
    }
}

struct FabulaExample154_Slider_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample154_Slider()
    }
}
