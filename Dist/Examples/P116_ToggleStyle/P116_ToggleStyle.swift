// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P116
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

public struct FabulaExample116_ToggleStyle: View {
    
    @State private var isOn: Bool = false
    
    public init() {}
    public var body: some View {
        Toggle("Vertical Toggle", isOn: $isOn)
            .toggleStyle(VerticalToggleStyle())
            .fixedSize()
    }
}

fileprivate
struct VerticalToggleStyle: ToggleStyle {
    
    @Environment(\.colorScheme) private var colorScheme
    let idealSize: CGFloat = 36
    
    func makeBody(configuration: Configuration) -> some View {
        let isOn = configuration.isOn
        return HStack {
            configuration.label
            Spacer()
            
            GeometryReader { proxy in
                ZStack(alignment: isOn ? .top : .bottom) {
                    Capsule()
                        .fill(colorScheme == .dark ? Color.black.opacity(0.5) : Color.black.opacity(0.1))

                    Circle()
                        .fill(isOn ? LocalTheme.primary : getNormalColor().opacity(0.15))
                        .frame(width: proxy.size.width, height: proxy.size.width)
                        .padding(2)
                }
            }
            .frame(idealWidth: idealSize, idealHeight: idealSize * 2)
            .onTapGesture {
                withAnimation {
                    configuration.isOn.toggle()
                }
            }
        }
    }
    
    private func getNormalColor() -> Color {
        colorScheme == .dark ? Color.white : Color.black
    }
}

struct FabulaExample116_ToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample116_ToggleStyle()
    }
}
