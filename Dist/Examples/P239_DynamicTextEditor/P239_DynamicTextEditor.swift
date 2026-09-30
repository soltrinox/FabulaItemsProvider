// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P239
// Adapted: local theme; print removed; no third-party.

import SwiftUI

fileprivate enum LocalTheme {
    static let primary = Color(red: 0.969, green: 0.475, blue: 0.278)
    static let secondary = Color(red: 0.122, green: 0.753, blue: 0.843)
    static let back0 = Color(red: 0.980, green: 0.980, blue: 0.980)
    static let back1 = Color(red: 0.941, green: 0.941, blue: 0.941)
    static let back2 = Color(red: 0.902, green: 0.902, blue: 0.902)
    static let fore1 = Color(red: 0.125, green: 0.125, blue: 0.196)
    static let fore2 = Color(red: 0.565, green: 0.561, blue: 0.580)
    static let bar1 = Color(red: 0.952, green: 0.952, blue: 0.956)
    static let bar2 = Color(red: 0.894, green: 0.897, blue: 0.895)
    static let foreWB100 = Color.black
    static let backWB100 = Color.white
}


import SwiftUI

public struct FabulaExample239_DynamicTextEditor: View {
    
    @State private var text: String = ""
    @State var height : CGFloat = 20
    
    public init() {}
    public var body: some View {
        
        ZStack(alignment: .leading) {
            Text(text)
                .font(.callout)
                .padding(8)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewHeightKey.self,
                                           value: $0.frame(in: .local).size.height)
                })
                .hidden()
            TextEditor(text: $text)
                .font(.callout)
                .frame(height: max(38,height))
                .padding(.horizontal, 3)
            
        }
        .background(LocalTheme.fore2.opacity(0.3))
        .cornerRadius(8)
        .onAppear {
#if os(iOS)
            UITextView.appearance().backgroundColor = .clear
#endif
        }
        .onDisappear {
#if os(iOS)
            UITextView.appearance().backgroundColor = nil
#endif
        }
        .onPreferenceChange(ViewHeightKey.self) { height = $0 }
        .padding()
    }
    
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct FabulaExample239_DynamicTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample239_DynamicTextEditor()
    }
}
