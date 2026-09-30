// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P131
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

public struct FabulaExample131_LazyVGrid: View {
    
    var rows: [GridItem] = Array(repeating: .init(.fixed(80), spacing: 5), count: 2)
    
    public init() {}
    public var body: some View {
        ZStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: rows, spacing: 5) {
                    ForEach((0...79), id: \.self) {
                        let codepoint = $0 + 0x1f600
                        let codepointString = String(format: "%02X", codepoint)
                        let emoji = String(Character(UnicodeScalar(codepoint)!))
                        VStack {
                            Text("\(emoji)")
                                .font(.largeTitle)
                                .environment(\.imageScale, .large)
                            Text("\(codepointString)")
                                .font(.footnote)
                                .foregroundColor(Color.black)
                        }
                        .frame(width: 80, height: 80)
                    }
                    .background(Color.white)
                }
                .padding(5)
                .background(LocalTheme.primary)
                .fixedSize()
                .padding(.trailing, 10)
            }
        }
        .padding()
    }
}

struct FabulaExample131_LazyVGrid_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample131_LazyVGrid()
    }
}
