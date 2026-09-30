// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P94
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample94_LineSpacing: View {
    
    public init() {}
    public var body: some View {
        VStack {
            LineSpacingView()
                .environment(\.lineSpacing, 10)
            Divider()
                .frame(width: 160)
                .padding()
            LineSpacingView()
                .lineSpacing(1)
        }
        .padding()
    }
}

fileprivate
struct LineSpacingView: View {
    
    @Environment(\.lineSpacing) private var lineSpacing: CGFloat
    
    var body: some View {
        Text("The distance in points between the bottom of one line fragment and the top of the next.")
            .frame(width: 160, alignment: .leading)
    }
}

struct FabulaExample94_LineSpacing_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample94_LineSpacing()
    }
}
