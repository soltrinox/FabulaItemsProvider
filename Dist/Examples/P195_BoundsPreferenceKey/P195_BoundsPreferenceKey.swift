// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P195
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

public struct FabulaExample195_BoundsPreferenceKey: View {

    public init() {}
    public var body: some View {
        ZStack {
            Color.clear
                .border(LocalTheme.primary, width: 1)
            Text("BoundsPreferenceKey")
                .foregroundColor(Color.white)
                .padding()
                .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { $0 }
        }
        .frame(width: 300, height: 300)
        .backgroundPreferenceValue(BoundsPreferenceKey.self) { prefers in
            GeometryReader { proxy in
                prefers.map {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: proxy[$0].width, height: proxy[$0].height)
                        .offset(x: proxy[$0].minX, y: proxy[$0].minY)
                }
            }
        }
        .overlayPreferenceValue(BoundsPreferenceKey.self) { prefers in
            GeometryReader { proxy in
                prefers.map {
                    Rectangle()
                        .stroke(Color.black, lineWidth: 2)
                        .frame(width: proxy[$0].width, height: proxy[$0].height)
                        .offset(x: proxy[$0].minX, y: proxy[$0].minY)
                }
            }
        }
    }
}

fileprivate
struct BoundsPreferenceKey: PreferenceKey {
    typealias Value = Anchor<CGRect>?
    static var defaultValue: Value = nil
    static func reduce(value: inout Value,  nextValue: () -> Value) {
        value = nextValue()
    }
}

struct FabulaExample195_BoundsPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample195_BoundsPreferenceKey()
    }
}
