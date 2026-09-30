// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P174
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

public struct FabulaExample174_CustomStepper: View {
    
    @State private var count: Int = 1
    @State private var stepperHeight: CGFloat = 50
    @State private var startCount: CGFloat = 0
    @State private var endCount: CGFloat = 10
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading) {
            CustomStepper(count: $count,
                          range: Range(Int(startCount)...Int(endCount)))
                .frame(height: CGFloat(stepperHeight))
            
            Divider()
                .padding(.top, 30)
                .padding(.vertical)
            
            Slider(value: $startCount, in: -10...10)
                .modifier(SliderModifier(title: "Start Count: ", value: $startCount))
            
            Slider(value: $endCount, in: 20...2000)
                .modifier(SliderModifier(title: "End Count: ", value: $endCount))
            
            Divider().padding(.vertical)
            
            Slider(value: $stepperHeight, in: 36...150)
                .modifier(SliderModifier(title: "Stepper Height: ", value: $stepperHeight))
        }
        .padding()
        .frame(maxWidth: 500)
        .animation(.easeInOut, value: startCount)
        .animation(.easeInOut, value: endCount)
    }
}

fileprivate
extension P174_CustomStepper {
    struct CustomStepper: View {
        
        @Binding var count: Int
        let range: Range<Int>
        
        var displayCount: String {
            if count == 0 {
                return "0"
            } else if count > 0 {
                return String(format: "%0\("\(range.upperBound)".count)d", count)
            }else {
                return String(format: "%0\("\(range.lowerBound)".count)d", count)
            }
        }
        
        var body: some View {
            GeometryReader { proxy in
                let size = proxy.size
                ZStack {
                    Color.clear
                    HStack(spacing: -size.height * 0.16) {
                        HStack(spacing: 0) {
                            if count > range.lowerBound {
                                Button {
                                    let count = self.count - 1
                                    self.count = max(count, range.lowerBound)
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: size.height * 0.5))
                                        .frame(width: size.height * 0.9, height: size.height)
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(PlainButtonStyle())
                                .transition(.scale.combined(with: .opacity))
                                Spacer()
                            }
                        }

                        Text(displayCount)
#if os(macOS)
                            .baselineOffset(-size.height * 0.1)
#endif
                            .font(.custom("Helvetica Bold", size: size.height * 0.55))
                            .foregroundColor(LocalTheme.primary)
                            .padding(.leading, count <= range.lowerBound ? size.height * 0.6 : 0)
                            .padding(.trailing, count >= (range.upperBound - 1) ? size.height * 0.6 : 0)
                            .fixedSize()
                        
                        HStack(spacing: 0) {
                            Spacer()
                            if count < range.upperBound - 1 {
                                Button {
                                    let count = self.count + 1
                                    self.count = min(count, range.upperBound - 1)
                                } label: {
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: size.height * 0.5))
                                        .frame(width: size.height * 0.9, height: size.height)
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(PlainButtonStyle())
                                .transition(.scale.combined(with: .opacity))
                            }
                        }
                    }
                    .fixedSize()
                    .overlay(
                        Capsule()
                            .strokeBorder(lineWidth: size.height * 0.045, antialiased: true)
                    )
                    .clipShape(Capsule())
                }
            }
            .frame(idealHeight: 40)
            .frame(minHeight: 36)
            .animation(.easeInOut, value: count)
        }
    }
    
    struct SliderModifier: ViewModifier {
        let title: String
        @Binding var value: CGFloat
        func body(content: Content) -> some View {
            VStack(alignment: .leading, spacing: 5) {
                Text(title + " (\(Int(value)))")
                    .font(.callout)
                    .opacity(0.5)
                content
            }
        }
    }
}

struct FabulaExample174_CustomStepper_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample174_CustomStepper()
    }
}
