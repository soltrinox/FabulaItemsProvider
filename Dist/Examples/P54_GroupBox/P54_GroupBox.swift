// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P54
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample54_GroupBox: View {
    
    public init() {}
    public var body: some View {
        ZStack {
            Color.black.opacity(0.2)
            GroupBox(label: GroupBoxLabel()) {
                Text("GroupBox Content")
                    .padding()
            }
            .padding()
            .frame(maxWidth: 500)
            .padding()
        }
    }
}

fileprivate
struct GroupBoxLabel: View {
    var body: some View {
        HStack {
            Image(systemName: "archivebox")
            Text("Title")
        }
    }
}

struct FabulaExample54_GroupBox_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample54_GroupBox().preferredColorScheme(.dark)
    }
}
