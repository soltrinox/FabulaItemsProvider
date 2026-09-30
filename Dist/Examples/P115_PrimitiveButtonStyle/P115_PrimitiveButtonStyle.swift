// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P115
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

public struct FabulaExample115_PrimitiveButtonStyle: View {
    
    public init() {}
    public var body: some View {
        VStack {
            Button("Button Style 1") { }
            .buttonStyle(LongPrimitiveButtonStyle())
            
            Divider().frame(width: 44)
            
            Button("Button Style 2") { }
            .buttonStyle(LongPrimitiveButtonStyle(minDuration: 1.5, pressedColor: Color.red))
        }
    }
}

fileprivate
struct  LongPrimitiveButtonStyle: PrimitiveButtonStyle {
    
    var minDuration = 0.5
    var pressedColor: Color = Color.blue
    
    func makeBody(configuration: Configuration) -> some View {
        ButtonStyleBody(configuration: configuration,
                        minDuration: minDuration,
                        pressedColor: pressedColor)
    }
    
    private struct ButtonStyleBody: View {
        
        let configuration: Configuration
        let minDuration: CGFloat
        let pressedColor: Color
        @GestureState private var isPressed = false
        
        var body: some View {
            let longPress = LongPressGesture(minimumDuration: minDuration)
                .updating($isPressed) { value, state, _ in
                    state = value
                }
                .onEnded { _ in
                    self.configuration.trigger()
                }
            return configuration.label
                .padding()
                .background(
                    GeometryReader { proxy in
                        RoundedRectangle(cornerRadius: isPressed ? proxy.size.height / 2 : 8)
                            .fill(isPressed ? pressedColor : LocalTheme.primary)
                    }
                    
                )
                .foregroundColor(.white)
                .gesture(longPress)
                .scaleEffect(isPressed ? 0.7 : 1.0)
                .animation(.easeInOut, value: isPressed)
        }
    }
}

struct FabulaExample115_PrimitiveButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample115_PrimitiveButtonStyle()
    }
}
