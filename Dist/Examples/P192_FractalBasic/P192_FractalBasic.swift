// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P192
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample192_FractalBasic: View {
    
    public init() {}
    public var body: some View {
        Item(count: 2)
            .padding()
    }
}

fileprivate
struct Item: View {
    let count: Int
    
    var body: some View {
        if count <= 0 {
            Rectangle()
                .fill(Color.random)
        }else {
            GeometryReader { proxy in
                let min = min(proxy.size.width, proxy.size.height)
                ZStack {
                    Color.clear
                    VStack {
                        HStack {
                            Item(count: count - 1)
                            Item(count: count - 1)
                            Item(count: count - 1)
                        }
                        HStack {
                            Item(count: count - 1)
                            Item(count: count - 1).hidden()
                            Item(count: count - 1)
                        }
                        
                        HStack {
                            Item(count: count - 1)
                            Item(count: count - 1)
                            Item(count: count - 1)
                        }
                    }
                    .frame(width: min, height: min)
                }
            }
        }
    }
}

struct FabulaExample192_FractalBasic_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample192_FractalBasic()
    }
}
