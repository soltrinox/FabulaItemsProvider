// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P245
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample245_Mirror: View {
    
    @StateObject var dumpState = DumpState()
    
    public init() {}
    public var body: some View {
        VStack {
            Text(dumpState.text)
                .font(.caption)
            Divider().frame(width: 44)
            Text("Hello, world!")
                .dump(dumpState)
                .background(Color.yellow)
                .dump(dumpState)
                .font(.title)
                .dump(dumpState)
        }
        .padding()
    }
    
    class DumpState: ObservableObject {
        @Published var count: Int = 0
        @Published var text: String = ""
    }
}

fileprivate
extension View {
    func dump(_ dumpState: P245_Mirror.DumpState) -> some View {
        return self.onAppear() {
            dumpState.count += 1
            dumpState.text += "\(dumpState.count). \(mirror(Mirror(reflecting: self).description))\n"
        }
    }
    
    private func mirror(_ text: String) -> String {
        text.replacingOccurrences(of: "Mirror for ", with: "")
    }
}

struct FabulaExample245_Mirror_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample245_Mirror()
    }
}
