// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P81
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

public struct FabulaExample81_DefaultMinListHeaderHeight: View {
    
    public init() {}
    public var body: some View {
        HStack {
            VStack {
                Text("Default")
                    .font(.callout)
                    .opacity(0.5)
                DefaultMinListHeaderHeightView()
            }
            Divider()
            VStack {
                Text("Custom height : 100")
                    .font(.callout)
                    .opacity(0.5)
                DefaultMinListHeaderHeightView()
                    .environment(\.defaultMinListHeaderHeight, 100)
            }
        }
        .padding()
    }
}

fileprivate
struct DefaultMinListHeaderHeightView: View {
    
    @Environment(\.defaultMinListHeaderHeight) private var defaultMinListHeaderHeight: CGFloat?
    
    var body: some View {
        List(0...100, id: \.self) { index in
            Section {
                Text("Index : \(index)")
                    .opacity(0.5)
            } header: {
                Text("Section Index : \(index)")
                    .foregroundColor(LocalTheme.primary)
            }
        }
    }
}

struct FabulaExample81_DefaultMinListHeaderHeight_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample81_DefaultMinListHeaderHeight()
    }
}
