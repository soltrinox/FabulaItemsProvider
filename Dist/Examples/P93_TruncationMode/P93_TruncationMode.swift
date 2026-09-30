// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P93
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample93_TruncationMode: View {
    
    public init() {}
    public var body: some View {
        VStack {
            TruncationModeView()
                .environment(\.truncationMode, .head)
            Divider()
                .frame(width: 200)
                .padding()
            TruncationModeView()
                .truncationMode(.middle)
            Divider()
                .frame(width: 200)
                .padding()
            TruncationModeView()
                .truncationMode(.tail)
        }
        .padding()
    }
}

fileprivate
struct TruncationModeView: View {
    
    @Environment(\.multilineTextAlignment) private var multilineTextAlignment: TextAlignment
    
    var body: some View {
        Text("A value that indicates how the layout truncates the last line of text to fit into the available space.")
            .frame(width: 200, height: 20, alignment: .leading)
    }
}

struct FabulaExample93_TruncationMode_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample93_TruncationMode()
    }
}
