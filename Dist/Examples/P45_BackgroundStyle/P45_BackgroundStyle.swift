// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P45
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample45_BackgroundStyle: View {
    
    @Environment(\.colorScheme) private var systemColorScheme
    
    public init() {}
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(BackgroundStyle())
                .padding()
            Text(systemColorScheme == .dark ? "Dark" : "Light")
                .foregroundColor(Color.gray)
        }
    }
}

struct FabulaExample45_BackgroundStyle_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample45_BackgroundStyle()
            .preferredColorScheme(.dark)
    }
}
