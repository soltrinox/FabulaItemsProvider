// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P164
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

public struct FabulaExample164_Transition: View {

    var asymTransition: AnyTransition {
        let insertion = AnyTransition.offset(x: 0, y: 200).combined(with: .scale)
        let removal = AnyTransition.move(edge: .leading).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    public init() {}
    public var body: some View {
        VStack {
            TransitionView {
                Text("Combined")
                    .font(.title)
                    .bold()
                    .foregroundColor(LocalTheme.primary)
                    .transition(AnyTransition.slide.combined(with: .scale))
            }
            TransitionView {
                Text("Asymmetric")
                    .font(.title)
                    .bold()
                    .foregroundColor(LocalTheme.primary)
                    .transition(asymTransition)
            }
            
            TransitionView {
                Text("ViewModifier")
                    .font(.title)
                    .bold()
                    .foregroundColor(LocalTheme.primary)
                    .transition(.customScale)
            }
        }
    }
}

fileprivate
extension P164_Transition {
    struct TransitionView<Content: View>: View {
        
        @State private var showText: Bool = false
        let content: () -> Content
        
        var body: some View {
            VStack {
                if showText {
                    content()
                }
                
                Button {
                    withAnimation {
                        showText.toggle()
                    }
                } label: {
                    Text("Display Text On / Off")
                        .padding()
                        .background(LocalTheme.primary)
                        .foregroundColor(Color.white)
                        .clipShape(Capsule())
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

fileprivate
struct CustomScaleModifier: ViewModifier {
    let scale: CGFloat
    func body(content: Content) -> some View {
        content.scaleEffect(scale)
    }
}

fileprivate
extension AnyTransition {
    static var customScale: AnyTransition {
        AnyTransition.modifier(active: CustomScaleModifier(scale: 0), identity: CustomScaleModifier(scale: 1))
    }
}

struct FabulaExample164_Transition_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample164_Transition()
    }
}
