// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P77
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample77_Locale: View {
    
    public init() {}
    public var body: some View {
        VStack {
            LocaleView()
            Divider().frame(width: 40)
            LocaleView()
                .environment(\.locale, Locale(identifier: "ko"))
        }
    }
}

fileprivate
struct LocaleView: View {
    
    @Environment(\.locale) private var locale: Locale
    
    var body: some View {
        Text(locale.description)
    }
}

struct FabulaExample77_Locale_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample77_Locale()
    }
}
