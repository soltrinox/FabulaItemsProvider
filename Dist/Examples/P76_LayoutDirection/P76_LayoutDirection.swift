// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P76
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

public struct FabulaExample76_LayoutDirection: View {
    
    @Environment(\.layoutDirection) private var layoutDirection: LayoutDirection
    
    public init() {}
    public var body: some View {
        VStack {
            OtherLocaleView()
                .foregroundColor(LocalTheme.primary)
                .environment(\.locale, Locale(identifier: "ar"))
                .environment(\.layoutDirection, .rightToLeft)
            Divider()
                .frame(width: 44)
                .padding()
            OtherLocaleView()
        }
    }
}

fileprivate
struct OtherLocaleView: View {
    
    @Environment(\.layoutDirection) private var layoutDirection: LayoutDirection
    
    var body: some View {
        switch layoutDirection {
        case .leftToRight:
            Text("leftToRight")
        case .rightToLeft:
            Text("rightToLeft")
        default:
            EmptyView()
        }
    }
}

struct FabulaExample76_LayoutDirection_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample76_LayoutDirection()
    }
}
