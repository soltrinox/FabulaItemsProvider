// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P196
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample196_TextPreferenceKey: View {
    
    @State private var text: String = ""
    
    public init() {}
    public var body: some View {
        VStack {
            Text("\(text)")
            Divider().frame(width: 44)
            Text("TextKey")
                .setText("Share text to the parent view")
        }
        .onPreferenceChange(TextKey.self) { text in
            self.text = text
        }
    }
}

fileprivate
struct TextKey: PreferenceKey {
    static var defaultValue: String = ""
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

fileprivate
extension View {
    func setText(_ title: String) -> some View {
        self.preference(key: TextKey.self, value: title)
    }
}

struct FabulaExample196_TextPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample196_TextPreferenceKey()
    }
}
