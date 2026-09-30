// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P255
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

#if os(macOS)
public struct FabulaExample255_DoubleClick: View {

    @State private var shapeIndex: Int = 0

    private var tap0: some Gesture {
        TapGesture(count: 2)
            .onEnded {
                self.shapeIndex = 0
            }
    }

    private var tap1: some Gesture {
        TapGesture(count: 2)
            .modifiers([.command])
            .onEnded {
                self.shapeIndex = 1
            }
    }

    private var tap2: some Gesture {
        TapGesture(count: 2)
            .modifiers([.option])
            .onEnded {
                self.shapeIndex = 2
            }
    }

    private var tap3: some Gesture {
        TapGesture(count: 2)
            .modifiers([.control])
            .onEnded {
                self.shapeIndex = 3
            }
    }

    private var tap4: some Gesture {
        TapGesture(count: 2)
            .modifiers([.control, .option])
            .onEnded {
                self.shapeIndex = 4
            }
    }

    private var tap5: some Gesture {
        TapGesture(count: 2)
            .modifiers([.control, .option, .command])
            .onEnded {
                self.shapeIndex = 5
            }
    }

    public init() {}
    public var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 11).fill(LocalTheme.fore1)
                    .frame(width: 100, height: 100)
                // The order in which the gestures are added is important. If tab0 is placed first, the tab1,2,3,4,5 gestures will never be triggered.
                    .gesture(tap5)
                    .gesture(tap4)
                    .gesture(tap3)
                    .gesture(tap2)
                    .gesture(tap1)
                    .gesture(tap0)

                Text("\(self.shapeIndex)")
                    .foregroundColor(LocalTheme.primary)
                    .font(.title)
                    .bold()
            }

            Divider()

            Text("Double Click ⟶ 0")
            Text("Double Click + CMD ⟶ 1")
            Text("Double Click + ALT ⟶ 2")
            Text("Double Click + CTRL ⟶ 3")
            Text("Double Click + CTRL + ALT ⟶ 4")
            Text("Double Click + CTRL + ALT + CMD ⟶ 5")

        }
        .font(.callout)
        .foregroundColor(LocalTheme.fore2)
    }
}
#else
public struct FabulaExample255_DoubleClick: View {
    public init() {}
    public var body: some View {
        EmptyView()
    }
}
#endif

struct FabulaExample255_DoubleClick_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample255_DoubleClick()
    }
}
