// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P40
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample40_VStackAlignment: View {
    
    let horizontalAlignments: [HorizontalAlignment] = [.leading, .center, .trailing]
    @State private var hIndex: Int = 1
    
    public init() {}
    public var body: some View {
        VStack {
            Spacer()
            VStack(alignment: horizontalAlignments[hIndex]) {
                Color.clear.frame(height: 1)
                Image(systemName: "sun.max")
                    .font(.largeTitle)
                Image(systemName: "cloud.heavyrain")
                    .font(.largeTitle)
                Image(systemName: "umbrella")
                    .font(.largeTitle)
            }
            
            Spacer()
            Picker("Horizontal", selection: $hIndex.animation()) {
                ForEach(0...2, id: \.self) { index in
                    switch index {
                    case 0: Text("leading")
                    case 1: Text("center")
                    case 2: Text("trailing")
                    default:
                        EmptyView()
                    }
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(maxWidth: 600)
        }
        .padding()
    }
}

struct FabulaExample40_VStackAlignment_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample40_VStackAlignment()
    }
}
