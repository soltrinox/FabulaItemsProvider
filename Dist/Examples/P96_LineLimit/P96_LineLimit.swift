// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P96
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample96_LineLimit: View {
    
    public init() {}
    public var body: some View {
        VStack {
            LineLimitView()
                .environment(\.lineLimit, 2)
            Divider()
                .frame(width: 150)
                .padding()
            LineLimitView()
                .lineLimit(1)
            Divider()
                .frame(width: 150)
                .padding()
            LineLimitView()
                .lineLimit(nil)
        }
        .padding()
    }
}

fileprivate
struct LineLimitView: View {
    
    @Environment(\.lineLimit) private var lineLimit: Int?
    
    var body: some View {
        Text("The maximum number of lines that text can occupy in a view.")
            .font(.body)
            .frame(width: 150, height: 50, alignment: .leading)
    }
}

struct FabulaExample96_LineLimit_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample96_LineLimit()
    }
}
