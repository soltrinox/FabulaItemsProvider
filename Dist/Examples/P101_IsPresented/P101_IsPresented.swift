// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P101
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample101_IsPresented: View {
    
    @State private var showDetail: Bool = false
    
    public init() {}
    public var body: some View {
        Button {
            showDetail = true
        } label: {
            Text("Show Detail")
        }
        .sheet(isPresented: $showDetail) {
            if #available(macOS 12.0, *) {
                DetailView()
            } else {
                Text("Availability\niOS 15.0+\niPadOS 15.0+\nmacOS 12.0+\nMac Catalyst 15.0+\ntvOS 15.0+\nwatchOS 8.0+")
            }
        }
    }
}

@available(macOS 12.0, *)
fileprivate
struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss: DismissAction
    @Environment(\.isPresented) var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text(isPresented ? "isPresented == true" : "isPresented == false")
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
#if os(macOS)
        .frame(width: 300, height: 400)
#endif
    }
}

struct FabulaExample101_IsPresented_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample101_IsPresented()
    }
}
