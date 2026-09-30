// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P89
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

public struct FabulaExample89_KeyboardShortcut: View {
    
    @State private var text: String = "🍑"
    
    public init() {}
    public var body: some View {
        if #available(macOS 12.0, *) {
            VStack {
                Text(text)
                    .font(.largeTitle)
                Divider()
                    .frame(width: 44)
                    .padding()
                Button {
                    withAnimation {
                        text += "🍑"
                    }
                } label: {
                    Text("ShortcutButton - Enter Key")
                }
                .keyboardShortcut(.defaultAction)
                Divider()
                    .frame(width: 44)
                    .padding()
                Button {
        // print removed
                } label: {
                    Text("ShortcutButton")
                }
            }
            .buttonStyle(ShortcutButtonStyle())
            .padding()
        } else {
            Button {
        // print removed
            } label: {
                Text("Availability\niOS 15.0+\niPadOS 15.0+\nmacOS 12.0+\nMac Catalyst 15.0+")
            }
        }
    }
}

@available(macOS 12.0, *)
fileprivate
struct ShortcutButtonStyle: ButtonStyle {
    
    @Environment(\.keyboardShortcut) private var shortcut: KeyboardShortcut?

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(shortcut == .defaultAction ? LocalTheme.primary : Color.gray)
    }
}

struct FabulaExample89_KeyboardShortcut_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample89_KeyboardShortcut()
    }
}
