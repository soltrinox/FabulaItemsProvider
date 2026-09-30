// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P235
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample235_TabViewSelected: View {
    
    @State private var text: String = ""
    @State private var selectionValue: Int = 0
    private var selection: Binding<Int> { Binding(
        get: { self.selectionValue },
        set: {
            text = "--------------------------\n" + text
            text = "Already selected : \(self.selectionValue == $0)\n" + text
            text = "Selection : \($0)\n" + text
            self.selectionValue = $0
        })
    }
    
    public init() {}
    public var body: some View {
        VStack {
            TextEditor(text: $text)
                .frame(height: 200)
                .padding()
                .background(Color.gray.opacity(0.2))
            TabView(selection: selection) {
                Text("Screen 0")
                    .tag(0)
                    .tabItem {
                        Text("Tab0")
                    }
                Text("Screen 1")
                    .tag(1)
                    .tabItem {
                        Text("Tab1")
                    }
                Text("Screen 2")
                    .tag(2)
                    .tabItem {
                        Text("Tab2")
                    }
            }
        }
#if os(macOS)
        .padding()
#endif
    }
}

struct FabulaExample235_TabViewSelected_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample235_TabViewSelected()
    }
}
