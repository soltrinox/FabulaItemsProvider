// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P152
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

public struct FabulaExample152_SequenceGesture: View {
    
    @State private var message = "Long press & drag"
    @State private var position: CGPoint? = nil
    
    public init() {}
    public var body: some View {
        let longPress = LongPressGesture()
            .onEnded { _ in
                message = "Drag is possible"
            }
        
        let drag = DragGesture()
            .onEnded { _ in
                message = "Long press & drag"
            }
            .onChanged { value in
                message = "Dragging"
                position = value.location
            }
        
        GeometryReader { proxy in
            VStack {
                Text(message)
                    .fontWeight(.bold)
                    .foregroundColor(LocalTheme.primary)
                Circle()
                    .frame(width: 100, height: 100)
            }
            .position(position ?? CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2))
            .animation(.easeOut, value: position)
            .gesture(longPress.sequenced(before: drag))
        }
    }
}

struct FabulaExample152_SequenceGesture_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample152_SequenceGesture()
    }
}
