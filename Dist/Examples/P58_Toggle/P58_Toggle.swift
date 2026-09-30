// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P58
// Adapted: local theme; print removed; no third-party.

import SwiftUI

fileprivate enum LocalTheme {
    static let primary = Color(red: 0.969, green: 0.475, blue: 0.278)
    static let secondary = Color(red: 0.122, green: 0.753, blue: 0.843)
    static let back0 = Color(red: 0.980, green: 0.980, blue: 0.980)
    static let back1 = Color(red: 0.941, green: 0.941, blue: 0.941)
    static let back2 = Color(red: 0.902, green: 0.902, blue: 0.902)
    static let fore1 = Color(red: 0.125, green: 0.125, blue: 0.196)
    static let fore2 = Color(red: 0.565, green: 0.561, blue: 0.580)
    static let bar1 = Color(red: 0.952, green: 0.952, blue: 0.956)
    static let bar2 = Color(red: 0.894, green: 0.897, blue: 0.895)
    static let foreWB100 = Color.black
    static let backWB100 = Color.white
}


import SwiftUI

public struct FabulaExample58_Toggle: View {
    
    @State private var status = true
    @State private var styleTag: Int = 0
    
    public init() {}
    public var body: some View {
        VStack(spacing: 30) {
            if #available(macOS 12.0, *) {
                Toggle(isOn: $status) {
                    Text("ButtonToggleStyle")
                }
                .toggleStyle(ButtonToggleStyle())
                .tint(LocalTheme.primary)
                
                Toggle(isOn: $status) {
                    Text("SwitchToggleStyle")
                }
                .toggleStyle(SwitchToggleStyle())
                .tint(LocalTheme.primary)
            }
            
            Toggle(isOn: $status) {
                Text("DefaultToggleStyle")
            }
            .toggleStyle(DefaultToggleStyle())
            
            
#if os(macOS)
            Toggle(isOn: $status) {
                Text("CheckboxToggleStyle")
            }
            .toggleStyle(CheckboxToggleStyle())
#endif
        }
        .padding(40)
        .frame(maxWidth: 500)
        .animation(.easeInOut, value: status)
    }
}

struct FabulaExample58_Toggle_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample58_Toggle()
    }
}
