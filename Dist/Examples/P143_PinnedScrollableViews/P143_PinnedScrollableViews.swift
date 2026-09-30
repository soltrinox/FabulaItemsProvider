// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P143
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample143_PinnedScrollableViews: View {
    
    public init() {}
    public var body: some View {
        VStack {
            ScrollView {
                LazyVStack(pinnedViews: .sectionHeaders) {
                    Section(header: VerticalHeader(title: "Section 1")) {
                        ForEach(1...50, id: \.self) { number in
                            Text("Row \(number)")
                        }
                    }
                    Section(header: VerticalHeader(title: "Section 2")) {
                        ForEach(51...100, id: \.self) { number in
                            Text("Row \(number)")
                        }
                    }
                }
                .padding()
            }
            
            Divider()
            
            ScrollView(.horizontal) {
                LazyHStack(pinnedViews: .sectionHeaders) {
                    Section(header: HorizontalHeader(title: "Section 1")) {
                        ForEach(1...50, id: \.self) { number in
                            Text("Row \(number)")
                        }
                    }
                    Section(header: HorizontalHeader(title: "Section 2")) {
                        ForEach(51...100, id: \.self) { number in
                            Text("Row \(number)")
                        }
                    }
                }
                .padding()
            }
            .frame(height: 100)
        }
    }
}

fileprivate
struct VerticalHeader: View {
    
    let title: String
    
    var titleView: some View {
        HStack {
            Spacer()
            Text("-- \(title) --")
            Spacer()
        }
        .frame(height: 44)
    }
    
    var body: some View {
        if #available(macOS 12.0, *) {
            titleView
                .background(.ultraThinMaterial)
        } else {
            titleView
                .background(Color.black.opacity(0.3))
        }
    }
}

fileprivate
struct HorizontalHeader: View {
    
    let title: String
    
    var titleView: some View {
        HStack {
            Spacer()
            Text(title)
            Spacer()
        }
        .frame(height: 44)
    }
    
    var body: some View {
        if #available(macOS 12.0, *) {
            titleView
                .background(.ultraThinMaterial)
        } else {
            titleView
                .background(Color.black.opacity(0.3))
        }
    }
}


struct FabulaExample143_PinnedScrollableViews_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample143_PinnedScrollableViews()
    }
}
