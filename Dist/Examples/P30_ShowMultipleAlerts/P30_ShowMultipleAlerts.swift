// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P30
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

public struct FabulaExample30_MultipleAlert: View {
    
    @State private var showAlert1: Bool = false
    @State private var showAlert2: Bool = false
    
    public init() {}
    public var body: some View {
        VStack(spacing: 16) {
            Button("Show Alert1") {
                showAlert1 = true
            }
            .buttonStyle(FabulaButtonStyle())
            .alert(isPresented: $showAlert1) {
                Alert(title: Text("Alert1"), message: Text("This is a alert message 1"), dismissButton: .default(Text("Dismiss")))
            }
            
            Button("Show Alert2") {
                showAlert2 = true
            }
            .buttonStyle(FabulaButtonStyle())
            .alert(isPresented: $showAlert2) {
                Alert(title: Text("Alert2"), message: Text("This is a alert2 message 2"), dismissButton: .default(Text("Dismiss")))
            }
        }
    }
}

fileprivate
struct FabulaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
#if os(iOS)
            .font(.callout)
#endif
            .padding(10)
            .background(LocalTheme.secondary.opacity(0.7))
            .foregroundColor(LocalTheme.fore1)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
            .animation(.easeOut(duration: 0.05), value: configuration.isPressed)
        
    }
}
struct FabulaExample30_MultipleAlert_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample30_MultipleAlert()
    }
}
