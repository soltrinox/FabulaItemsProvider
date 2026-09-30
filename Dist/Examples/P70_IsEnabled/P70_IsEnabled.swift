// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P70
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample70_IsEnabled: View {
    
    public init() {}
    public var body: some View {
        VStack {
            Button {} label: {
                Text("Enabled == true")
            }
            .padding()
            .disabled(false)
            .buttonStyle(EnabledButtonStyle())
            
            Button {} label: {
                Text("Enabled == false")
            }
            .padding()
            .disabled(true)
            .buttonStyle(EnabledButtonStyle())
        }
    }
}

fileprivate
struct EnabledButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(isEnabled ? .accentColor : .gray)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut, value: configuration.isPressed)
    }
}

struct FabulaExample70_IsEnabled_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample70_IsEnabled()
    }
}
