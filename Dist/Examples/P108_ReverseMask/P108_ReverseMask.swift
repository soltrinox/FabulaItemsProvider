// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P108
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

public struct FabulaExample108_ReverseMask: View {
    var maskView: some View {
        Image(systemName: "facemask.fill")
            .font(.largeTitle)
            .padding()
            .border(LocalTheme.primary, width: 2)
            .padding()
            .border(LocalTheme.primary, width: 2)
    }
    
    public init() {}
    public var body: some View {
        ZStack {
            GeometryReader { proxy in
                Image(systemName: "scribble.variable")
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .aspectRatio(contentMode: .fill)
            }
#if os(iOS)
            VStack {
                Rectangle()
                    .fill(LocalTheme.primary)
                    .mask { maskView }
                Rectangle()
                    .fill(LocalTheme.primary)
                    .reverseMask { maskView }
            }
#endif
        }
    }
}

#if os(iOS)
fileprivate
extension View {
    func reverseMask<T: View>(alignment: Alignment = .center, @ViewBuilder _ maskView: () -> T) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    maskView()
                        .blendMode(.destinationOut)
                }
        }
    }
}
#endif

struct FabulaExample108_ReverseMask_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample108_ReverseMask()
    }
}
