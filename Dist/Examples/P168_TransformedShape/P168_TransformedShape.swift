// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P168
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample168_TransformedShape: View {
    
    @State private var switching: Bool = false
    
    public init() {}
    public var body: some View {
        ZStack {
            if switching {
                TransformedShape(shape: Rectangle(), transform: CGAffineTransform(rotationAngle: 0.5))
                    .fill(Color.blue)
                    .frame(width: 150, height: 150)
                    .background(Color.yellow)
                    .border(Color.orange)
            }else {
                TransformedShape(shape: Rectangle(), transform: CGAffineTransform(rotationAngle: 0))
                    .fill(Color.blue)
                    .frame(width: 150, height: 150)
                    .background(Color.yellow)
                    .border(Color.orange)
            }
        }
        .animation(.easeInOut, value: switching)
        .onTapGesture {
            switching.toggle()
        }
    }
}

struct FabulaExample168_TransformedShape_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample168_TransformedShape()
    }
}
