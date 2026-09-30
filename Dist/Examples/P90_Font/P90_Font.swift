// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P90
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample90_Font: View {
    
    public init() {}
    public var body: some View {
        VStack {
            FontView()
                .environment(\.font, .system(
                    size: 24,
                    weight: .ultraLight,
                    design: .rounded))
            Divider()
                .frame(width: 44)
                .padding()
            FontView()
                .font(.custom("Georgia", size: 24, relativeTo: .headline))
        }
        
    }
}

fileprivate
struct FontView: View {
    
    @Environment(\.font) private var font: Font?
    
    var body: some View {
        HStack {
            Text("Font")
                .font(font?.uppercaseSmallCaps())
            Text("Font")
                .font(font?.lowercaseSmallCaps())
            Text("Font")
                .font(font?.smallCaps())
        }
    }
}

struct FabulaExample90_Font_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample90_Font()
    }
}
