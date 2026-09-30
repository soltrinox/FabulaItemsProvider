// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P272
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

public struct FabulaExample272_CollapsibleView: View {
    
    public init() {}
    public var body: some View {
        CollapsibleView(
            Image(systemName: "snow")
                .resizable()
                .scaledToFit()
                .foregroundColor(LocalTheme.secondary)
                .frame(width: 250)
        )
    }
}

fileprivate struct CollapsibleView<Content: View>: View {
    let theView: Content
    let collapsedHeight: CGFloat
    @State private var theViewHeight: CGFloat = .greatestFiniteMagnitude
    @State private var isCollapsed = true
    
    init(_ collapsedView: Content, collapsedHeight: CGFloat = 50) {
        self.theView = collapsedView
        self.collapsedHeight = collapsedHeight
    }
    
    var body: some View {
        VStack {
            theView
                .background(GeometryReader { theViewGeo in
                    Color.clear.onAppear {
                        self.theViewHeight = theViewGeo.size.height
                    }
                })
                .fixedSize()
                .frame(height: isCollapsed ? collapsedHeight : theViewHeight, alignment: .top)
                .clipped()
            
            expandingButton
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 6.0)
            .stroke(LocalTheme.fore1))
        .animation(.easeOut, value: isCollapsed)
    }
    
    private var expandingButton: some View {
        Button(isCollapsed ? "Show" : "Hide") { isCollapsed.toggle() }
            .id("expandingButtonView")
            .buttonStyle(.borderedProminent)
            
    }
}

struct FabulaExample272_CollapsibleView_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample272_CollapsibleView()
    }
}
