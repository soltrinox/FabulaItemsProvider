// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P80
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample80_DefaultMinListRowHeight: View {
    
    public init() {}
    public var body: some View {
        HStack {
            VStack {
                Text("Default")
                    .font(.callout)
                    .opacity(0.5)
                DefaultMinListRowHeightView()
            }
            Divider()
            VStack {
                Text("Custom height : 100")
                    .font(.callout)
                    .opacity(0.5)
                DefaultMinListRowHeightView()
                    .environment(\.defaultMinListRowHeight, 100)
            }
        }
        .padding()
    }
}

fileprivate
struct DefaultMinListRowHeightView: View {
    
    @Environment(\.defaultMinListRowHeight) private var defaultMinListRowHeight: CGFloat
    
    var body: some View {
        List(0...100, id: \.self) { index in
            Text("Index : \(index)")
        }
    }
}

struct FabulaExample80_DefaultMinListRowHeight_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample80_DefaultMinListRowHeight()
    }
}
