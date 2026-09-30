// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P59
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample59_DisclosureGroup: View {
    
    private var spacerView: some View {
#if os(iOS)
        Spacer()
#else
        EmptyView()
#endif
    }
    
    @State private var expanded: Bool = false
    
    public init() {}
    public var body: some View {
        DisclosureGroup("Group", isExpanded: $expanded) {
            DisclosureGroup("1 Depth") {
                HStack {
                    Text("Item 1")
                    spacerView
                }
                HStack {
                    Text("Item 2")
                    spacerView
                }
                DisclosureGroup("2 Depth") {
                    HStack {
                        Text("Item 1")
                        spacerView
                    }
                    HStack {
                        Text("Item 2")
                        spacerView
                    }
                    HStack {
                        Text("Item 3")
                        spacerView
                    }
                }
                .foregroundColor(Color.blue)
                .padding(.leading, 20)
            }
            .foregroundColor(Color.green)
            .padding(.leading, 20)
        }
        .font(.custom("Helvetica SemiBold", size: 20))
        .foregroundColor(Color.red)
        .padding(.leading, 20)
        .frame(maxWidth: 500)
        .padding(.trailing, 20)
        .animation(.easeInOut, value: expanded)
    }
}

struct FabulaExample59_DisclosureGroup_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample59_DisclosureGroup()
    }
}
