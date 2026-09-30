// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P83
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample83_HeaderProminence: View {
    
#if os(iOS)
    @State private var prominence: Prominence = .standard
    
    public init() {}
    public var body: some View {
        VStack {
            Picker("Prominence", selection: $prominence) {
                Text("standard")
                    .tag(Prominence.standard)
                Text("increased")
                    .tag(Prominence.increased)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            List {
                ForEach(0...5, id:\.self) { index in
                    Section(header: Text("Todo Section \(index)"), footer: Text("Fotter")) {
                        ForEach(0...Int.random(in: 1...6), id:\.self) { index in
                            Text("Task \(index)")
                        }
                    }
                    .headerProminence(prominence)
                }
                .listStyle(.insetGrouped)
            }
        }
        .padding()
    }
#else
    public init() {}
    public var body: some View {
        EmptyView()
    }
#endif
}

struct FabulaExample83_HeaderProminence_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample83_HeaderProminence()
    }
}
