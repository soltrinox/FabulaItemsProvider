// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P110
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample110_ConfirmationDialog: View {
    
    @State private var isShow = false
    @State private var selectMenu = "None"

    public init() {}
    public var body: some View {
        VStack {
            Text(selectMenu)
                .font(.title)
            if #available(macOS 12.0, *) {
                Button("Show Dialog") {
                    isShow = true
                }
                .confirmationDialog("Select a menu", isPresented: $isShow, titleVisibility: .visible) {
                    Button("Menu 1") {
                        selectMenu = "Menu 1"
                    }
                    
                    Button("Menu 2") {
                        selectMenu = "Menu 2"
                    }
                    
                    Button("Menu 3") {
                        selectMenu = "Menu 3"
                    }
                }
            } else {
                Text("iOS 15.0+\nmacOS 12.0+\nMac Catalyst 15.0+\ntvOS 15.0+\nwatchOS 8.0+")
            }
        }
    }
}

struct FabulaExample110_ConfirmationDialog_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample110_ConfirmationDialog()
    }
}
