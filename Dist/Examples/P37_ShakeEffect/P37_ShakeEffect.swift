// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P37
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample37_ShakeModifier: View {
    
    @State var numberOfShakes: CGFloat = 0
    
    public init() {}
    public var body: some View {
        VStack {
            Text("Shake")
                .font(.title2)
                .frame(width: 88, height: 88)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(21)
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 0)
                .modifier(ShakeEffect(delta: numberOfShakes))
                .onTapGesture {
                    withAnimation(.linear(duration: 3.0)) {
                        if numberOfShakes == 0 {
                            numberOfShakes = 14
                        }else {
                            numberOfShakes = 0
                        }
                    }
                }
        }
    }
}

fileprivate
struct ShakeEffect: AnimatableModifier {
    
    var delta: CGFloat = 0
    
    var animatableData: CGFloat {
        get {
            delta
        } set {
            delta = newValue
        }
    }
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: sin(delta * .pi * 4.0) * CGFloat.random(in: 2...4)))
            .offset(x: sin(delta * 1.5 * .pi * 1.2),
                    y: cos(delta * 1.5 * .pi * 1.1))
    }
}

struct FabulaExample37_ShakeModifier_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample37_ShakeModifier().preferredColorScheme(.dark)
    }
}
