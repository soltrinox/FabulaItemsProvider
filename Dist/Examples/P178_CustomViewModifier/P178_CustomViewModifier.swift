// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P178
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample178_CustomViewModifier: View {
    
    public init() {}
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .redText(font: .largeTitle)
    }
}

fileprivate
struct RedTextModifier: ViewModifier {
    
    let font: Font
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .padding()
            .foregroundColor(Color.red)
            .cornerRadius(6.0)
    }
}

fileprivate
extension View {
    func redText(font: Font = .callout) -> some View {
        modifier(RedTextModifier(font: font))
    }
}

struct FabulaExample178_CustomViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample178_CustomViewModifier()
    }
}
