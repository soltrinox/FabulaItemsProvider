// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P257
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

public struct FabulaExample257_InsettableShape: View {
    
    public init() {}
    public var body: some View {
        HStack {
            VStack {
                RactangleView(duration: 3.0)
                RactangleView(duration: 3.5)
            }
            VStack {
                RactangleView(duration: 4.0)
                RactangleView(duration: 4.5)
            }
        }
    }
}

fileprivate
struct RactangleView: View {
    
    @State private var value: CGFloat = 0
    @State private var color: Color = Bool.random() ? LocalTheme.secondary : LocalTheme.primary
    private let size: CGFloat = 100
    let duration: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .inset(by: value)
            .fill(color)
            .frame(width: size, height: size)
            .border(color)
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation(Animation.easeInOut(duration: duration).repeatForever()) {
                        value = size * 0.5
                        color = color == LocalTheme.primary ? LocalTheme.secondary : LocalTheme.primary
                    }
                }
            }
    }
}

struct FabulaExample257_InsettableShape_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample257_InsettableShape()
    }
}

