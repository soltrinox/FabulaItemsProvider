// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P127
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample127_Image: View {
    
    let divideValue = 2.0
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                HStack(spacing: 0) {
                    Image(systemName: "sun.dust")
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.size.width / divideValue, height: proxy.size.height / divideValue)
                        .scaleEffect(0.5)
                        .clipped()
                    Image(systemName: "moon.stars")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(width: proxy.size.width / divideValue, height: proxy.size.height / divideValue)
                        .scaleEffect(0.5)
                        .clipped()
                }
            }
        }
        .padding()
    }
}

struct FabulaExample127_Image_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample127_Image()
    }
}
