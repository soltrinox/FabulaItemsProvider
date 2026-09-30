// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P128
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample128_ImagePaint: View {
    
    public init() {}
    public var body: some View {
        ZStack {
            if #available(macOS 12.0, *) {
                Rectangle()
                    .fill(ImagePaint(image: Image(systemName: "bicycle.circle")))
            }else {
                Text("Rectangle().fill(ImagePaint(image: Image('image')))")
            }
        }
        .background(Color.green)
    }
}

struct FabulaExample128_ImagePaint_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample128_ImagePaint()
    }
}
