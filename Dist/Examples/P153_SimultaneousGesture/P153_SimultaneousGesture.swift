// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P153
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

public struct FabulaExample153_SimultaneousGesture: View {
    
    @State private var normalText: String = ""
    @State private var simultaneousText: String = ""
    
    public init() {}
    public var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Normal")
                        .font(.caption)
                        .opacity(0.5)
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 200, height: 200)
                        .overlay(
                            Text("Tap")
                        )
                        .onTapGesture {
                            normalText += "Circle tapped" + "\n"
                        }
                }
                ScrollView {
                    Text(normalText)
                        .font(.caption)
                        .lineLimit(nil)
                        .foregroundColor(LocalTheme.primary)
                        .padding(.trailing, 12)
                }
                .frame(maxHeight: 200)
                .animation(.none, value: normalText)
            }
            .animation(.easeInOut, value: normalText)
            .onTapGesture {
                normalText += "HStack tapped" + "\n"
            }
            
            Divider().padding()
            
            HStack {
                VStack {
                    Text("Simultaneous")
                        .font(.caption)
                        .opacity(0.5)
                    Circle()
                        .fill(Color.green)
                        .frame(width: 200, height: 200)
                        .overlay(
                            Text("Tap")
                        )
                        .onTapGesture {
                            simultaneousText += "Circle tapped" + "\n"
                        }
                }
                ScrollView {
                    Text(simultaneousText)
                        .font(.caption)
                        .lineLimit(nil)
                        .foregroundColor(LocalTheme.primary)
                        .padding(.trailing, 12)
                }
                .frame(maxHeight: 200)
                .animation(.none, value: simultaneousText)
            }
            .animation(.easeInOut, value: simultaneousText)
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        simultaneousText += "HStack tapped" + "\n"
                    }
            )
        }
    }
}

struct FabulaExample153_SimultaneousGesture_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample153_SimultaneousGesture()
    }
}
