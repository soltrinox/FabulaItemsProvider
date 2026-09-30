// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P280
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

public struct FabulaExample280_SwitchComponent: View {
    
    @State private var isOn: Bool = false
    
    public init() {}
    public var body: some View {
        Switch(isOn: $isOn) { value in
        // print removed
        }
        .frame(width: 200, height: 125)
        .padding()
    }
}

struct FabulaExample280_SwitchComponent_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample280_SwitchComponent()
    }
}

//MARK: - Switch
fileprivate
struct Switch: View {
   
   @Binding var isOn: Bool
   var onTapReceive: ((Bool) -> Void)?
   @GestureState private var isTapped = false
   
   var backgroundColor: Color {
      isOn ? LocalTheme.primary : Color(hex: 0x333333)
   }
   
   var handleColor: Color {
      isOn ? Color(hex: 0xFFFFFF) : Color(hex: 0xDDDDDD)
   }
   
   var gesture: some Gesture {
      DragGesture(minimumDistance: 0)
         .updating($isTapped) { (_, isTapped, _) in
            isTapped = true
         }
         .onEnded { _ in
            isOn.toggle()
            onTapReceive?(isOn)
         }
   }
   
   var body: some View {
      switchUIView()
         .gesture(gesture)
         .animation(.default, value: isOn)
         .animation(.default, value: isTapped)
   }
   
   @ViewBuilder
   private func switchUIView() -> some View {
      GeometryReader { geo in
         let handleGap = geo.size.height * 0.075
         ZStack(alignment: isOn ? .trailing : .leading) {
            Capsule()
               .fill(backgroundColor)
            Capsule()
               .fill(handleColor)
               .padding(handleGap)
               .frame(width: handleWidth(geo.size))
               .shadow(color: Color.black.opacity(0.4),
                       radius: handleGap * 0.5,
                       x: 0,
                       y: 0)
         }
      }
      .frame(idealWidth: 51, idealHeight: 31)
   }
   
   private func handleWidth(_ size: CGSize) -> CGFloat {
      let w = size.width
      let h = size.height
      return isTapped ? h + (w - h) * 0.3 : h
   }
}
