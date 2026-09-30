// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P199
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample199_CustomFontSize: View {
    
    let name: String = "SFProText-Medium"
    let size: CGFloat = 14
    
    public init() {}
    public var body: some View {
#if os(iOS)
        VStack {
            Text("Dynamic Type Size")
                .customFont(name: name, size: size, isFixed: true)
            Divider()
            Text("Normal Size")
                .font(.custom(name, size: size))
            Divider()
            Text("Fixed Size")
                .customFont(name: name, size: size, isFixed: false)
        }
#else
        EmptyView()
#endif
    }
}

#if os(iOS)
fileprivate
struct CustomFontModifier: ViewModifier {
    
    var name: String
    var size: CGFloat
    var isFixed: Bool = false
    
    func body(content: Content) -> some View {
        let fontSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(isFixed ? .custom(name, size: fontSize) : .custom(name, fixedSize: size))
    }
}

fileprivate
extension View {
    func customFont(name: String, size: CGFloat, isFixed: Bool = false) -> some View {
        return self.modifier(CustomFontModifier(name: name, size: size, isFixed: isFixed))
    }
}
#endif

struct FabulaExample199_CustomFontSize_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample199_CustomFontSize()
    }
}
