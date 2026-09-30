// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P271
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

public struct FabulaExample271_CollapsibleText: View {
    let foregroundColor: Color = LocalTheme.fore1
    let backgroundColor: Color = LocalTheme.primary
    
    public init() {}
    public var body: some View {
        CollapsibleText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        lineLimit: 2)
            .padding()
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .padding()
    }
}

fileprivate struct CollapsibleText: View {
    @State private var isCollapsed = true
    @State private var isTruncateable = true
    
    let text: String
    let lineLimit: Int
    
    init(_ text: String, lineLimit: Int) {
        self.text = text
        self.lineLimit = lineLimit
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            textWithHeightReading
            
            if isTruncateable {
                buttonView
            }
        }
    }
    
    private var textWithHeightReading: some View {
        Text(text)
            .lineLimit(isCollapsed ? lineLimit : nil)
            .background(
                Text(text)
                    .lineLimit(lineLimit)
                    .background(GeometryReader { collapsed in
                        ZStack {
                            Text(text)
                                .lineLimit(nil)
                                .background(GeometryReader { full in
                                    Color.clear.onAppear {
                                        isTruncateable = full.size.height > collapsed.size.height
                                    }
                                })
                        }
                        .frame(height: .greatestFiniteMagnitude)
                    })
                    .hidden()
            )
    }
    
    private var buttonView: some View {
        Button(isCollapsed ? "More" : "Less") {
            isCollapsed.toggle()
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct FabulaExample271_CollapsibleText_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample271_CollapsibleText()
    }
}
