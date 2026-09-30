// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P248
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

public struct FabulaExample248_AlignmentID: View {
    public init() {}
    public var body: some View {
        VStack {
            VerticalView()
            HorizontalView()
        }
    }
}

fileprivate
struct VerticalView: View {
    
    @State private var currentIndex = 1
    
    var body: some View {
        HStack(alignment: .verticalAlignment, spacing: 5) {
            Rectangle().frame(width: 5, height: 15).foregroundColor(LocalTheme.primary)
                .alignmentGuide(.verticalAlignment, computeValue: { d in
                    d[VerticalAlignment.center] })
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<6, id: \.self) { index in
                    Group {
                        if index == self.currentIndex {
                            Text("Menu \(index)")
                                .alignmentGuide(.verticalAlignment, computeValue: { d in
                                    d[VerticalAlignment.center] })
                        } else {
                            Text("Menu \(index)")
                                .onTapGesture {
                                    withAnimation {
                                        self.currentIndex = index
                                    }
                                }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

fileprivate
struct HorizontalView: View {
    
    @State private var currentIndex = 1
    
    var body: some View {
        VStack(alignment: .horizontalAlignment, spacing: 5) {
            HStack(alignment: .top, spacing: 15) {
                ForEach(0..<4, id: \.self) { index in
                    Group {
                        if index == self.currentIndex {
                            Text("Menu \(index)")
                                .alignmentGuide(.horizontalAlignment, computeValue: { d in
                                    d[HorizontalAlignment.center] })
                        } else {
                            Text("Menu \(index)")
                                .onTapGesture {
                                    withAnimation {
                                        self.currentIndex = index
                                    }
                                }
                        }
                    }
                }
            }
            Rectangle().frame(width: 55, height: 5).foregroundColor(LocalTheme.primary)
                .alignmentGuide(.horizontalAlignment, computeValue: { d in
                    d[HorizontalAlignment.center] })
        }
        .padding()
    }
}

fileprivate
extension VerticalAlignment {
    private enum CurrentAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[VerticalAlignment.center]
        }
    }
    static let verticalAlignment = VerticalAlignment(CurrentAlignment.self)
}

fileprivate
extension HorizontalAlignment {
    private enum CurrentAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[HorizontalAlignment.center]
        }
    }
    static let horizontalAlignment = HorizontalAlignment(CurrentAlignment.self)
}

struct FabulaExample248_AlignmentID_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample248_AlignmentID()
    }
}
