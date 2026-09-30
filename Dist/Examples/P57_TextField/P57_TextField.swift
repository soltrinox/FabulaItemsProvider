// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P57
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

public struct FabulaExample57_TextField: View {
    
    @State private var username: String = "dev.fabula@gmail.com"
    @State private var selectedTag: Int = 0
    
    var textField: some View {
        GroupBox {
            TextField("User name (email address)", text: $username)
                .padding(5)
                .disableAutocorrection(true)
            
        } label: {
            Text("TextField")
                .font(.caption)
                .opacity(0.5)
        }
    }
    
    public init() {}
    public var body: some View {
        VStack {
            VStack {
                Text(username)
                    .foregroundColor(LocalTheme.primary)
                
                Divider()
                
                switch selectedTag {
                case 0:
                    textField
                        .textFieldStyle(DefaultTextFieldStyle())
                case 1:
                    textField
                        .textFieldStyle(PlainTextFieldStyle())
                case 2:
                    textField
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                default:
                    EmptyView()
                }
            }
            .padding()
            .background(Color.blue.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            
            Picker("TextFieldStyle", selection: $selectedTag) {
                Text("DefaultTextFieldStyle")
                    .tag(0)
                Text("PlainTextFieldStyle")
                    .tag(1)
                Text("RoundedBorderTextFieldStyle")
                    .tag(2)
            }
#if os(iOS)
            .pickerStyle(WheelPickerStyle())
#else
            .pickerStyle(InlinePickerStyle())
#endif
            .padding()
        }
        .frame(maxWidth: 500)
        .animation(.easeInOut, value: username)
        .animation(.easeInOut, value: selectedTag)
    }
}

struct FabulaExample57_TextField_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample57_TextField()
            .background(LocalTheme.back1)
            .preferredColorScheme(.dark)
    }
}
