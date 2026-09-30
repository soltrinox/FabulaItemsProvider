// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P240
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample240_DisableAnimations: View {
    
    @State private var toggle: Bool = true
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.blue)
                    .border(.white, width: 2)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text("ON")
                            .font(.caption)
                            .bold()
                            .foregroundColor(Color.white)
                    )
                    .offset(x: toggle ? 0 : proxy.size.width - 40)
                Rectangle()
                    .fill(Color.red)
                    .border(.white, width: 2)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text("OFF")
                            .font(.caption)
                            .bold()
                            .foregroundColor(Color.white)
                    )
                    .offset(x: toggle ? 0 : proxy.size.width - 40)
                    .transaction { transaction in
                        transaction.animation = nil
                        // transaction.animation = .spring()
                    }
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Toggle")
                        .onTapGesture {
                            toggle.toggle()
                        }
                    Spacer()
                }
                Spacer()
            }
        }
        .padding()
        .animation(.easeInOut, value: toggle)
    }
}

struct FabulaExample240_DisableAnimations_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample240_DisableAnimations()
    }
}
