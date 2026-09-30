// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P92
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample92_MultilineTextAlignment: View {
    
    public init() {}
    public var body: some View {
        VStack {
            MultilineTextAllignmentView()
                .environment(\.multilineTextAlignment, .trailing)
            Divider()
                .frame(width: 200)
                .padding()
            MultilineTextAllignmentView()
                .multilineTextAlignment(.leading)
        }
        .padding()
    }
}

fileprivate
struct MultilineTextAllignmentView: View {
    
    @Environment(\.multilineTextAlignment) private var multilineTextAlignment: TextAlignment
    
    var body: some View {
        Text("This is a block of text that will show up in a text element as multiple lines.\("\n") Here we have chosen to center this text.")
            .frame(width: 200, height: 160, alignment: .leading)
    }
}

struct FabulaExample92_MultilineTextAlignment_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample92_MultilineTextAlignment()
    }
}
