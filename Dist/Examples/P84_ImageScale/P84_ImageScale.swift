// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P84
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample84_ImageScale: View {
    
    public init() {}
    public var body: some View {
        HStack {
            HStack {
                Text("Small")
                ImageScaleView()
                    .environment(\.imageScale, .small)
            }
            Divider()
                .frame(height: 44)
                .padding()
            HStack {
                Text("Medium")
                ImageScaleView()
                    .imageScale(.medium)
            }
            Divider()
                .frame(height: 44)
                .padding()
            HStack {
                Text("Large")
                ImageScaleView()
                    .imageScale(.large)
            }
        }
    }
}

fileprivate
struct ImageScaleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "swift")
            Image(systemName: "swift")
            Image(systemName: "swift")
        }
    }
}


struct FabulaExample84_ImageScale_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample84_ImageScale()
    }
}
