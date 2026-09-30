// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P47
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample47_ButtonStyle: View {
    
    public init() {}
    public var body: some View {
        VStack(spacing: 12) {
            Button("DefaultButtonStyle", action: action)
                .buttonStyle(DefaultButtonStyle())
            Button("BorderedButtonStyle", action: action)
                .buttonStyle(BorderedButtonStyle())
            Button("PlainButtonStyle", action: action)
                .buttonStyle(PlainButtonStyle())
#if os(macOS)
            if #available(macOS 12.0, *) {
                Button("BorderedProminentButtonStyle", action: action)
                    .buttonStyle(BorderedProminentButtonStyle())
            }
            Button("LinkButtonStyle", action: action)
                .buttonStyle(LinkButtonStyle())
#else
            Button("BorderedProminentButtonStyle", action: action)
                .buttonStyle(BorderedProminentButtonStyle())
#endif
        }
    }
    
    private func action() { }
}

struct FabulaExample47_ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample47_ButtonStyle()
    }
}
