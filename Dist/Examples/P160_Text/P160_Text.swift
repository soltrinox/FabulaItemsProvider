// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P160
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample160_Text: View {
    
    public init() {}
    public var body: some View {
        Text(Date(), style: .date)
            .font(.title)
            .bold()
            .foregroundColor(.orange)
            .italic()
            .strikethrough(true, color: Color.blue)
            .underline(true, color: Color.purple)
            .kerning(2)
            .tracking(4)
            .baselineOffset(5)
    }
}

struct FabulaExample160_Text_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample160_Text()
    }
}
