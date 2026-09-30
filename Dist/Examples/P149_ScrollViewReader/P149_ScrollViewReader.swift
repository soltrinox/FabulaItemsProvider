// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P149
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample149_ScrollViewReader: View {
    
    @Namespace var topID
    @Namespace var bottomID
    
    public init() {}
    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                Button("Scroll to Bottom") {
                    withAnimation {
                        proxy.scrollTo(bottomID)
                    }
                }
                .id(topID)
                .padding()
                
                Button("Jump to #75") {
                    withAnimation {
                        proxy.scrollTo(75, anchor: .center)
                    }
                }
                .padding()
                
                VStack(spacing: 0) {
                    ForEach(0..<100) { i in
                        backgroundColor(Double(i) / 100)
                            .frame(height: 32)
                            .overlay(
                                Text("Row \(i)")
                                    .foregroundColor(foregroundColor(Double(i) / 100))
                            ).id(i)
                    }
                }
                
                Button("Scroll to Top") {
                    withAnimation {
                        proxy.scrollTo(topID)
                    }
                }
                .id(bottomID)
                .padding()
            }
        }
        .frame(maxWidth: 500)
    }
    
    private func backgroundColor(_ fraction: Double) -> Color {
        Color(red: 1 - fraction, green: 1 - fraction, blue: 1 - fraction)
    }
    
    private func foregroundColor(_ fraction: Double) -> Color {
        Color(red: fraction, green: fraction, blue: fraction)
    }
}

struct FabulaExample149_ScrollViewReader_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample149_ScrollViewReader()
    }
}
