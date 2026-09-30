// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P208
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

public struct FabulaExample208_ButtonBorderShape: View {
    
    @State private  var text: String = "-"
    
    public init() {}
    public var body: some View {
#if os(iOS)
        VStack {
            Text(text)
                .bold()
                .font(.title)
            Divider()
            
            SectionGroupView(sectionTitle: "Button Border Shape") {
                Button("capsule", role: .destructive) {
                    text = "capsule"
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.capsule)
                
                Button("roundedRectangle", role: .destructive) {
                    text = "roundedRectangle"
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle)
                
                Button("roundedRectangle(radius: 16)", role: .destructive) {
                    text = "roundedRectangle(radius: 16)"
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle(radius: 16))
            }
            .padding()
        }
        .frame(maxWidth: 500)
        .padding()
#else
        EmptyView()
#endif
    }
}

fileprivate
struct SectionGroupView<Content>: View where Content: View {
    
    var sectionTitle: String
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack {
            Text(sectionTitle)
                .foregroundColor(LocalTheme.fore2)
                .font(.caption)
            
            Divider().frame(width: 44)
            content()
        }
    }
}

struct FabulaExample208_ButtonBorderShape_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample208_ButtonBorderShape()
    }
}
