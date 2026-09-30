// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P33
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample33_TextFormat: View {
    
    @State private var numbers = [Int]()
    
    public init() {}
    public var body: some View {
#if os(iOS)
        VStack {
            Text(numbers, format: .list(memberStyle: .number, type: .and))
            VStack {
                if !numbers.isEmpty {
                    Button("RemoveAll") {
                        numbers = []
                    }
                    .buttonStyle(FabulaExample33_ButtonStyle(backgroundColor: Color.red))
                }
                Button("Add") {
                    let result = Int.random(in: 1000...3000)
                    numbers.append(result)
                }
                .buttonStyle(FabulaExample33_ButtonStyle(backgroundColor: Color.blue))
                
                
            }
            .animation(.easeInOut(duration: 0.3), value: numbers)
        }
        .padding()
#else
        EmptyView()
#endif
    }
}

fileprivate
struct FabulaExample33_ButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .background(backgroundColor)
            .foregroundColor(Color.white)
            .cornerRadius(10)
    }
}

struct FabulaExample33_TextFormat_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample33_TextFormat().preferredColorScheme(.dark)
    }
}
