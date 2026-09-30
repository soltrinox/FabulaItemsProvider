// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P106
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample106_BackgroundMaterial: View {

    public init() {}
    public var body: some View {
        ZStack {
            Image(systemName: "scribble.variable")
                .resizable()
                .aspectRatio(contentMode: .fill)
            if #available(macOS 12.0, *) {
                BackgroundMaterialView()
                    .padding(.top, 100)
            } else {
                Text("Availability\niOS 15.0+\niPadOS 15.0+\nmacOS 12.0+\nMac Catalyst 15.0+\ntvOS 15.0+\nwatchOS 8.0+")
            }
        }
    }
}

@available(macOS 12.0, *)
fileprivate
struct BackgroundMaterialView: View {
    
    @Environment(\.backgroundMaterial) var backgroundMaterial: Material?
    
    var body: some View {
        Text("BackgroundMaterial")
            .foregroundColor(.secondary)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
    }
}

struct FabulaExample106_BackgroundMaterial_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample106_BackgroundMaterial()
    }
}
