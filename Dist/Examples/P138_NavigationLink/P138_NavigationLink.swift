// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P138
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

public struct FabulaExample138_NavigationLink: View {
    
    enum NaviItem {
        case left
        case right
        case up
        case down
    }
    
    var selectLink: some View {
        VStack(spacing: 10) {
            NavigationLink(
                destination:
                    Image(systemName: "arrow.left.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(LocalTheme.primary)
                    .navigationTitle("Left"),
                tag: NaviItem.left,
                selection: $selectItem
            ) {
                Text("Show Left")
            }
            
            NavigationLink(
                destination:
                    Image(systemName: "arrow.right.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(LocalTheme.primary)
                    .navigationTitle("Right"),
                tag: NaviItem.right,
                selection: $selectItem
            ) {
                Text("Show Right")
            }
            
            NavigationLink(
                destination:
                    Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(LocalTheme.primary)
                    .navigationTitle("Up"),
                tag: NaviItem.up,
                selection: $selectItem
            ) {
                Text("Show Up")
            }
            
            NavigationLink(
                destination:
                    Image(systemName: "arrow.down.square.fill")
                    .font(.system(size: 60))
                    .foregroundColor(LocalTheme.primary)
                    .navigationTitle("Down"),
                tag: NaviItem.down,
                selection: $selectItem
            ) {
                Text("Show Down")
            }
        }
    }
    
    @State private var selectItem: NaviItem? = nil
    
    struct HeartView: View {
        var body: some View {
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(LocalTheme.primary)
                .navigationTitle("Heart")
        }
    }
    
    public init() {}
    public var body: some View {
        VStack(spacing: 30){
#if os(iOS)
            NavigationLink(destination: HeartView()) {
                Text("Show Heart")
            }
#else
            NavigationView {
                NavigationLink(destination: HeartView()) {
                    Text("Show Heart")
                }
            }
#endif
            selectLink
        }
    }
}

struct FabulaExample138_NavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FabulaExample138_NavigationLink()
        }
    }
}
