// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P95
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample95_AllowsTightening: View {
    
    public init() {}
    public var body: some View {
        VStack {
            AllowsTighteningView()
                .lineLimit(1)
                .environment(\.allowsTightening, true)
            Divider()
                .frame(width: 150)
                .padding()
            AllowsTighteningView()
                .lineLimit(1)
                .allowsTightening(false)
        }
        .padding()
    }
}

fileprivate
struct AllowsTighteningView: View {
    
    @Environment(\.allowsTightening) private var allowsTightening: Bool
    
    var body: some View {
        Text("This is a wide text element")
            .font(.body)
#if os(iOS)
            .frame(width: 200, height: 50, alignment: .leading)
#else
            .frame(width: 150, height: 50, alignment: .leading)
#endif
    }
}

struct FabulaExample95_AllowsTightening_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample95_AllowsTightening()
    }
}
