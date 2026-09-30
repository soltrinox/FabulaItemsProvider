// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P113
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample113_Popover: View {
    
    @State private var isShowPopover = false
    
    public init() {}
    public var body: some View {
        Button("Show Popover", action: {
            self.isShowPopover = true
        })
            .padding(10)
            .popover(isPresented: $isShowPopover) {
                PopoverDetailView()
            }
    }
}

fileprivate
struct PopoverDetailView: View {
    var body: some View {
        Text("Popover Content")
            .padding()
    }
}

struct FabulaExample113_Popover_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample113_Popover()
    }
}
