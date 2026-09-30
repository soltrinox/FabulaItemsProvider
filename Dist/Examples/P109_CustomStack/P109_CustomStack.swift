// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P109
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample109_CustomStack: View {
    
    public init() {}
    public var body: some View {
        CustomVStack {
            Text("CustomVStack!")
            Text("CustomVStack!")
            CustomHStack {
                Text("CustomHStack!")
                    .frame(height: 70)
                Text("CustomHStack!")
            }
        }
    }
}

fileprivate
struct CustomVStack<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            content
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
        }
    }
}

fileprivate
struct CustomHStack<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            content
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .foregroundColor(Color.white)
        }
    }
}

struct FabulaExample109_CustomStack_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample109_CustomStack()
    }
}
