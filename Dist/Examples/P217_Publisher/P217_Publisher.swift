// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P217
// Adapted: local theme; print removed; no third-party.

import SwiftUI
import Combine

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
import Combine

public struct FabulaExample217_Publisher: View {
    
    let provider = (0...10).publisher
    @State private var value: String = ""
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading) {
            Text("let provider = (0...10).publisher\n\nprovider.sink { _ in\n        self.value = 'Receive data complete'\n} receiveValue: { value in\n        self.value += '\\\\(value)\\\\n'\n}")
                .font(.headline)
            Divider().frame(width: 44)
            VStack(alignment: .leading) {
                Text("Results : ")
                Text("\(value)")
            }
            .font(.headline)
            .foregroundColor(LocalTheme.primary)
        }
        .onAppear {
            let _ = provider.sink { _ in
                self.value += "Receive data complete"
            } receiveValue: { value in
                self.value += "\(value)\n"
            }
        }
    }
}

struct FabulaExample217_Publisher_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample217_Publisher()
    }
}
