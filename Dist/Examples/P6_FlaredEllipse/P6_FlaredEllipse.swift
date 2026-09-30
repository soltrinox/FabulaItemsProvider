// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P6
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

public struct FabulaExample6_FlaredEllipse: View {
    
    let spacing: CGFloat = 20
    
    public init() {}
    public var body: some View {
        HStack(spacing: spacing) {
            VStack(spacing: spacing) {
                getView("1")
                getView("2")
            }
            HStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    getView("3")
                    getView("4")
                }
                getView("5")
            }
        }
        .padding(.vertical, spacing * 3)
        .padding(.horizontal, spacing)
    }
    
    private func getView(_ text: String) -> some View {
        FlaredEllipse {
            Text(text)
                .font(.title2)
                .foregroundColor(LocalTheme.fore1)
        }
    }
}

fileprivate
struct FlaredEllipse<Content>: View where Content: View {
    var backgroundColor: Color = Color(hex: 0x232834).opacity(0.8)
    var intensity: CGFloat = 0.5
    var gradient = Gradient(colors: [
        Color.white,
        Color(hex: 0xA85F89),
        Color(hex: 0xA85F89).opacity(0)
    ])
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            Ellipse()
                .fill(backgroundColor)
                .overlay(
                    GeometryReader { proxy in
                        ZStack(alignment: .topLeading) {
                            LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                                .mask(
                                    Ellipse()
                                )
                                .opacity(0.12)
                            
                            LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                                .mask(
                                    Ellipse()
                                        .strokeBorder(lineWidth: 1)
                                )
                                .opacity(0.6)
                        }
                        .mask(
                            LinearGradient(gradient: Gradient(colors: [
                                Color.black,
                                Color.black.opacity(0),
                                Color.black.opacity(0)
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        
                    }
                        .opacity(intensity)
                )
            content()
        }
    }
}

struct FabulaExample6_FlaredEllipse_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample6_FlaredEllipse().preferredColorScheme(.dark)
    }
}
