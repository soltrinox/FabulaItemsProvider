// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P34
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

public struct FabulaExample34_TextSpacing: View {
    
    @State private var spacing: Double = 1
    @State private var isOpen: Bool = false
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack(alignment: .leading) {
                Text(".kerning")
                    .font(.caption)
                Text("raffle")
                    .font(.custom("AmericanTypewriter", size: 24))
                    .kerning(spacing)
                    .opacity(0.5)
            }
            Divider()
            VStack(alignment: .leading) {
                Text(".tracking")
                    .font(.caption)
                Text("raffle")
                    .font(.custom("AmericanTypewriter", size: 24))
                    .tracking(spacing)
                    .opacity(0.5)
            }
            Slider(value: $spacing, in: 1...100) {
                Text("Spacing").modifier(FabulaSectionModifier())
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: 500)
        .animation(Animation.easeOut(duration: 0.1), value: spacing)
    }
}

fileprivate
struct FabulaSectionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(LocalTheme.fore1.opacity(0.5))
            .frame(height: 32)
    }
}

struct FabulaExample34_TextSpacing_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample34_TextSpacing()
    }
}
