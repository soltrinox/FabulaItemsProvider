// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P197
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

public struct FabulaExample197_BoundsPreferenceKey: View {
    
    @State private var willDisplayIndex: Int = 0
    
    public init() {}
    public var body: some View {
        VStack {
            Text("willDisplayIndex : \(willDisplayIndex)")
            Spacer().frame(height: 40)
            List(0...200, id: \.self) { index in
                HStack {
                    Spacer()
                    Text("\(index)")
                        .padding()
                    Spacer()
                }
                .background(index%2 == 0 ? Color.gray.opacity(0.5) : Color.gray)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .preference(key: IndexKey.self, value: index)
                .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { $0 }
            }
            .listStyle(PlainListStyle())
            .padding()
            .onPreferenceChange(IndexKey.self) { index in
                willDisplayIndex = index
            }
            .overlayPreferenceValue(BoundsPreferenceKey.self) { prefers in
                GeometryReader { proxy in
                    prefers.map {
                        Rectangle()
                            .stroke(LocalTheme.primary, lineWidth: 2)
                            .background(LocalTheme.primary.opacity(0.3))
                            .frame(width: proxy[$0].width, height: proxy[$0].height)
                            .offset(x: proxy[$0].minX, y: proxy[$0].minY)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: 500)
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

fileprivate
struct IndexKey: PreferenceKey {
    static var defaultValue: Int = 0
    static func reduce(value: inout Int, nextValue: () -> Int) {
        value = nextValue()
    }
}

struct FabulaExample197_BoundsPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample197_BoundsPreferenceKey()
    }
}
