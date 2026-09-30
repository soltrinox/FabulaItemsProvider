// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P205
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

public struct FabulaExample205_ButtonStyle: View {
    
    @State private  var text: String = "-"
    
    public init() {}
    public var body: some View {
        VStack {
            Text(text)
                .bold()
                .font(.title)
            Divider()
            
            SectionGroupView(sectionTitle: "Button Style") {
                Button("bordered") {
                    text = "bordered"
                }
                .buttonStyle(.bordered)
                
                Button("borderless") {
                    text = "borderless"
                }
                .buttonStyle(.borderless)
                
                if #available(macOS 12.0, *) {
                    Button("borderedProminent") {
                        text = "borderedProminent"
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Text("@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)")
                }
            }
            .padding()
        }
        .frame(maxWidth: 500)
        .padding()
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

struct FabulaExample205_ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample205_ButtonStyle()
    }
}
