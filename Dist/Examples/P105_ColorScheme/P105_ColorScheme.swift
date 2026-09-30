// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P105
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample105_ColorScheme: View {
    
    public init() {}
    public var body: some View {
        VStack {
            ColorSchemeView()
            Divider()
                .frame(width: 44)
                .padding()
            ColorSchemeView()
                .environment(\.colorScheme, .light)
            Divider()
                .frame(width: 44)
                .padding()
            ColorSchemeView()
                .environment(\.colorScheme, .dark)
        }
    }
}

fileprivate
struct ColorSchemeView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        Text(colorScheme == .dark ? "Dark mode" : "Light mode")
    }
}

struct FabulaExample105_ColorScheme_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample105_ColorScheme()
    }
}
