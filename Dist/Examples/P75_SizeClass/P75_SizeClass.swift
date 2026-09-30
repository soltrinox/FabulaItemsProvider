// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P75
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

public struct FabulaExample75_SizeClass: View {
    
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.verticalSizeClass) private var verticalSizeClass: UserInterfaceSizeClass?
    
    public init() {}
    public var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .center, spacing: 3) {
                Text("horizontalSizeClass")
                    .font(.caption)
                    .opacity(0.5)
                if horizontalSizeClass == .compact {
                    Text("Compact").foregroundColor(LocalTheme.primary)
                } else {
                    Text("Regular")
                }
            }
            VStack(alignment: .center, spacing: 3) {
                Text("verticalSizeClass")
                    .font(.caption)
                    .opacity(0.5)
                if verticalSizeClass == .compact {
                    Text("Compact").foregroundColor(LocalTheme.primary)
                } else {
                    Text("Regular")
                }
            }
        }
    }
#else
    public init() {}
    public var body: some View {
        EmptyView()
    }
#endif
}

struct FabulaExample75_SizeClass_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample75_SizeClass()
    }
}
