// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P167
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample167_ToolBar: View {
    
    public init() {}
    public var body: some View {
        Text("Hello, World!").padding()
            .navigationTitle("SwiftUI")
#if os(iOS)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("First Navigation") {
        // print removed
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("First Bottom") {
        // print removed
                    }
                    Spacer()
                    Button("Second Bottom") {
        // print removed
                    }
                }
            }
#else
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Automatic") {
        // print removed
                    }
                }
//                ToolbarItemGroup(placement: .status) {
//                    Button("Status") {
//                        ()
//                    }
//                }
//                ToolbarItemGroup(placement: .cancellationAction) {
//                    Button("CancellationAction") {
//                        ()
//                    }
//                }
//                ToolbarItemGroup(placement: .destructiveAction) {
//                    Button("DestructiveAction") {
//                        ()
//                    }
//                }
//                ToolbarItemGroup(placement: .primaryAction) {
//                    Button("PrimaryAction") {
//                        ()
//                    }
//                }
            }
#endif
    }
}

struct FabulaExample167_ToolBar_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample167_ToolBar()
    }
}
