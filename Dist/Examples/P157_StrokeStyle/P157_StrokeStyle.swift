// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P157
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample157_StrokeStyle: View {
    
    public init() {}
    public var body: some View {
        ZStack {
            StrokeCapsuleView()
                .foregroundColor(Color.purple)
                .frame(width: 200, height: 100)
            StrokeCapsuleView()
                .foregroundColor(Color.orange)
                .frame(width: 100, height: 200)
        }
        .padding()
    }
}

fileprivate
extension P157_StrokeStyle {
    
    struct StrokeCapsuleView: View {
        let style = StrokeStyle(lineWidth: 1,
                                lineCap: .round,
                                lineJoin: .miter,
                                miterLimit: 0,
                                dash: [2, 6],
                                dashPhase: 0)
        var body: some View {
            Capsule()
                .stroke(style: style)
        }
    }
}


struct FabulaExample157_StrokeStyle_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample157_StrokeStyle()
    }
}

