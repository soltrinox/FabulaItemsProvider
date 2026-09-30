// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P39
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample39_ZStackAlignment: View {
    
    let horizontalAlignments: [HorizontalAlignment] = [.leading, .center, .trailing]
    let verticalAlignments: [VerticalAlignment] = [.top, .center, .bottom]
    
    @State private var hIndex: Int = 1
    @State private var vIndex: Int = 1
    
    public init() {}
    public var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: horizontalAlignments[hIndex],
                                        vertical: verticalAlignments[vIndex])) {
                Color.clear
                Image(systemName: "umbrella")
                    .font(.largeTitle)
            }
            
            VStack {
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
                
                Picker("Vertical", selection: $vIndex.animation()) {
                    ForEach(0...2, id: \.self) { index in
                        switch index {
                        case 0: Text("top")
                        case 1: Text("center")
                        case 2: Text("bottom")
                        default:
                            EmptyView()
                        }
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .frame(maxWidth: 600)
        }
        .padding()
    }
}

struct FabulaExample39_ZStackAlignment_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample39_ZStackAlignment()
    }
}
