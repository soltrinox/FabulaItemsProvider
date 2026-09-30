// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P155
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

public struct FabulaExample155_Spacer: View {
    
    enum SpacerAlignment {
        case left
        case right
    }
    
    @State private var alignment: SpacerAlignment = .left
    
    public init() {}
    public var body: some View {
        VStack {
            HStack {
                if alignment == .right {
                    Spacer()
                }
                ChecklistRow(name: "Margin")
                if alignment == .left {
                    Spacer()
                }
            }
            .padding()
            .border(LocalTheme.primary)
            
            Divider().padding()
            
            Picker("Margin", selection: $alignment) {
                Text("Left").tag(SpacerAlignment.left)
                Text("Right").tag(SpacerAlignment.right)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .animation(.easeInOut, value: alignment)
        .padding()
        .frame(maxWidth: 500)
    }
}

fileprivate
extension P155_Spacer {
    struct ChecklistRow: View {
        
        let name: String
        
        var body: some View {
            HStack {
                Image(systemName: "checkmark")
                Text(name)
            }
        }
    }
}


struct FabulaExample155_Spacer_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample155_Spacer()
    }
}
