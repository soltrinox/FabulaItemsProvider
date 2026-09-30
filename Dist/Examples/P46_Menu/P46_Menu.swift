// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P46
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample46_Menu: View {
    
    public init() {}
    public var body: some View {
        VStack(spacing: 10) {
            Menu("DefaultMenuStyle") {
                Button("Menu 1", action: { })
                Button("Menu 2", action: { })
            }
            .menuStyle(DefaultMenuStyle())
            Menu("BorderlessButtonMenuStyle") {
                Button("Menu 1", action: { })
                Button("Menu 2", action: { })
            }
            .menuStyle(BorderlessButtonMenuStyle())
        }
        .frame(maxWidth: 600)
    }
}

struct FabulaExample46_Menu_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample46_Menu()
    }
}
