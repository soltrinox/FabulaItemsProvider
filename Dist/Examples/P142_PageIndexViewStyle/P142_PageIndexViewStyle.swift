// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P142
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

public struct FabulaExample142_PageIndexViewStyle: View {
    
#if os(iOS)
    @State private var items = ["Screen 1", "Screen 2", "Screen 3"]
    
    @State private var tabViewStyleIndex: Int = 0
    @State private var indexViewStyleIndex: Int = 0
    
    public init() {}
    public var body: some View {
        VStack {
            TabView {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(LocalTheme.primary)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: getTabViewStyleIndexWithIndex(tabViewStyleIndex).1))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: getIndexDisplayModeWithIndex(indexViewStyleIndex).1))
            
            HStack {
                VStack(alignment: .leading) {
                    Text("PageTabViewStyle")
                        .font(.caption)
                        .opacity(0.5)
                    Picker("PageTabViewStyle", selection: $tabViewStyleIndex) {
                        ForEach(0...2, id: \.self) { index in
                            Text(getTabViewStyleIndexWithIndex(index).0).tag(index)
                        }
                    }
                }
                
                Divider().frame(height: 36).padding()
                
                VStack(alignment: .leading) {
                    Text("PageIndexViewStyle")
                        .font(.caption)
                        .opacity(0.5)
                    Picker("PageIndexViewStyle", selection: $indexViewStyleIndex) {
                        ForEach(0...3, id: \.self) { index in
                            Text(getIndexDisplayModeWithIndex(index).0).tag(index)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    private func getTabViewStyleIndexWithIndex(_ index: Int) -> (String, PageTabViewStyle.IndexDisplayMode) {
        switch index {
        case 0: return ("always", PageTabViewStyle.IndexDisplayMode.always)
        case 1: return ("automatic", PageTabViewStyle.IndexDisplayMode.automatic)
        case 2: return ("never", PageTabViewStyle.IndexDisplayMode.never)
        default : return ("automatic", PageTabViewStyle.IndexDisplayMode.automatic)
        }
    }
    
    private func getIndexDisplayModeWithIndex(_ index: Int) -> (String, PageIndexViewStyle.BackgroundDisplayMode) {
        switch index {
        case 0: return ("always", PageIndexViewStyle.BackgroundDisplayMode.always)
        case 1: return ("automatic", PageIndexViewStyle.BackgroundDisplayMode.automatic)
        case 2: return ("interactive", PageIndexViewStyle.BackgroundDisplayMode.interactive)
        case 3: return ("never", PageIndexViewStyle.BackgroundDisplayMode.never)
        default: return ("automatic", PageIndexViewStyle.BackgroundDisplayMode.automatic)
        }
    }
#else
    public init() {}
    public var body: some View {
        EmptyView()
    }
#endif
}

struct FabulaExample142_PageIndexViewStyle_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample142_PageIndexViewStyle()
    }
}
