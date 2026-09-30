// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P53
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

public struct FabulaExample53_ContextMenu: View {
    
    @State private var actionTitle: String = "-"
    
    var menuItems: some View {
        Group {
            Section {
                Button("1. Button", action: select1)
                Button("2. Button", action: select2)
            }
            Section {
                Button("3. Button", action: select3)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    public init() {}
    public var body: some View {
        VStack(spacing: 25) {
            Text(actionTitle)
                .font(.title)
                .foregroundColor(actionTitle == "-" ? Color.gray.opacity(0.5) : LocalTheme.primary)
            Divider().frame(width: 44)
            Text(getButtonTitle())
                .contextMenu {
                    menuItems
                }
        }
        .padding()
    }
    
    private func getButtonTitle() -> String {
#if os(iOS)
        return "Long Press"
#else
        return "Right Click"
#endif
    }
    
    private func select1() {
        actionTitle = "Button 1"
    }
    private func select2() {
        actionTitle = "Button 2"
    }
    private func select3() {
        actionTitle = "Button 3"
    }
}

struct FabulaExample53_ContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample53_ContextMenu()
    }
}
