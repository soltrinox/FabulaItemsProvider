// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P71
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample71_Calendar: View {
    
    @Environment(\.calendar) private var calendar: Calendar
    
    public init() {}
    public var body: some View {
        VStack {
            Text(calendar.description).padding()
            KoreaView().padding()
                .environment(\.calendar, {
                    let calendar = Calendar(identifier: .japanese)
                    return calendar
                }())
        }
    }
}

fileprivate
struct KoreaView: View {
    
    @Environment(\.calendar) private var calendar: Calendar
    
    var body: some View {
        Text(calendar.description)
    }
}

struct FabulaExample71_Calendar_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample71_Calendar()
    }
}
