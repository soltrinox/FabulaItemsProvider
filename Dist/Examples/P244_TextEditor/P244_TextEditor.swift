// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P244
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

public struct FabulaExample244_WarningTextEditor: View {
    
    @State private var interval: CGFloat = 0
    
    @State private var limitNumber: Int = 30
    @State private var baseText: String = "Text"
    
    public init() {}
    public var body: some View {
        let text = Binding(
            get: { self.baseText },
            set: {
                if $0.count > limitNumber {
                    interval += 1
                }
                self.baseText = String($0.prefix(limitNumber)).components(separatedBy: .newlines).joined() }
        )
        VStack {
            Text("Number of characters : \(text.wrappedValue.count)")
                .foregroundColor(text.wrappedValue.count == limitNumber ? .red : LocalTheme.foreWB100)
            Rectangle()
                .fill(LocalTheme.fore2)
                .overlay(
                    TextEditor(text: text)
                        .padding(1)
                )
                .warning(interval)
        }
        .padding()
    }
}

struct FabulaExample244_WarningTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample244_WarningTextEditor()
    }
}

fileprivate
extension View {
    func warning(_ interval: CGFloat) -> some View {
        self.modifier(WarningEffect(interval))
            .animation(Animation.default, value: interval)
    }
}

fileprivate
struct WarningEffect: GeometryEffect {
    
    var animatableData: CGFloat
    var amount: CGFloat = 3
    var shakeCount = 6
    
    init(_ interval: CGFloat) {
        self.animatableData = interval
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * CGFloat(shakeCount) * .pi), y: 0))
    }
}
