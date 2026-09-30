// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P129
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample129_LabelStyle: View {
    
    public init() {}
    public var body: some View {
        VStack {
            Label("Sun", systemImage: "sun.max")
                .labelStyle(WeatherLabelStyle(color: .green))
            Divider().frame(width: 44).padding()
            Label("Cloud", systemImage: "cloud.drizzle")
                .labelStyle(WeatherLabelStyle(color: .red))
        }
        .font(.title)
    }
}

fileprivate
struct WeatherLabelStyle: LabelStyle {
    
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
                .foregroundColor(color)
        }
    }
}

struct FabulaExample129_LabelStyle_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample129_LabelStyle()
    }
}
