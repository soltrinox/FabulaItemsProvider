// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P148
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample148_ScrollView: View {
    
    public init() {}
    public  var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: true) {
            VStack(alignment: .leading) {
                ForEach(0..<10) {
                    Text("Row \($0)")
                }
            }
        }
    }
}

struct FabulaExample148_ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample148_ScrollView()
    }
}
