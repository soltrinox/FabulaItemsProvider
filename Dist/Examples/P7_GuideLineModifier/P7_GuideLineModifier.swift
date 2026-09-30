// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P7
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

public struct FabulaExample7_GuideLineModifier: View {
    
    let spacing: CGFloat = 30
    
    public init() {}
    public var body: some View {
        HStack(spacing: spacing) {
            VStack(spacing: spacing) {
                getCapsuleView("1")
                getCapsuleView("2")
            }
            HStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    getCapsuleView("3")
                    getCapsuleView("4")
                }
                getCapsuleView("5")
            }
        }
        .padding(.vertical, spacing * 3)
        .padding(.horizontal, spacing)
    }
    
    private func getCapsuleView(_ text: String) -> some View {
        Capsule()
            .strokeBorder(LocalTheme.secondary, lineWidth: 1.5, antialiased: true)
            .overlay(
                Text(text)
                    .font(.callout)
                    .foregroundColor(LocalTheme.primary)
            )
            .modifier(GuideLineModifier(direction: .height(.trailing)))
            .modifier(GuideLineModifier(direction: .width(.bottom)))
    }
}

extension P7_GuideLineModifier {
    enum GuideLineDirection {
        case width(VerticalAlignment)
        case height(HorizontalAlignment)
    }
    
    enum GuideLinePosition {
        case inside
        case outside
    }
    
    struct GuideLineModifier: ViewModifier {
        
        var direction: GuideLineDirection = .height(.trailing)
        var position: GuideLinePosition = .outside
        var color: Color = LocalTheme.fore2
        var textForegroundColor: Color = LocalTheme.fore1
        var textBackgroundColor: Color = LocalTheme.back1
        var space: CGFloat = 20
        
        let min: CGFloat = 1
        let max: CGFloat = 7
        let spacing: CGFloat = 3
        
        func body(content: Content) -> some View {
            ZStack {
                content
                GeometryReader { proxy in
                    ZStack {
                        switch direction {
                        case .width(let align):
                            HStack(alignment: .center, spacing: spacing) {
                                Rectangle()
                                    .frame(width: min, height: max)
                                Rectangle()
                                    .frame(height: min, alignment: .center)
                                getText(proxy.size.width)
                                Rectangle()
                                    .frame(height: min, alignment: .center)
                                Rectangle()
                                    .frame(width: min, height: max)
                            }
                            .frame(height: space)
                            .offset(x: 0, y: getYWidth(proxy, align: align))
                        case .height(let align):
                            VStack(alignment: .center, spacing: spacing) {
                                Rectangle()
                                    .frame(width: max, height: min)
                                Rectangle()
                                    .frame(width: min, alignment: .center)
                                getText(proxy.size.height)
                                Rectangle()
                                    .frame(width: min, alignment: .center)
                                Rectangle()
                                    .frame(width: max, height: min)
                            }
                            .frame(width: space)
                            .offset(x: getXHeight(proxy, align: align), y: 0)
                        }
                    }
                    .foregroundColor(color)
                }
            }
        }
        
        private func getText(_ value: CGFloat) -> some View {
            Text(String(format: "%.1f", value))
                .font(.caption)
                .foregroundColor(textForegroundColor)
                .fixedSize()
                .padding(.horizontal, 4)
                .background(textBackgroundColor)
                .clipShape(Capsule())
        }
        
        private func getYWidth(_ proxy: GeometryProxy, align: VerticalAlignment) -> CGFloat {
            if align == .bottom {
                return position == .outside ? proxy.size.height : proxy.size.height - space
            }else {
                return position == .outside ? -space : 0
            }
        }
        
        private func getXHeight(_ proxy: GeometryProxy, align: HorizontalAlignment) -> CGFloat {
            if align == .trailing {
                return position == .outside ? proxy.size.width : proxy.size.width - space
            }else {
                return position == .outside ? -space : 0
            }
        }
    }
}

struct FabulaExample7_GuideLineModifier_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample7_GuideLineModifier()
    }
}
