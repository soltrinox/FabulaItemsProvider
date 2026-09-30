// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P262
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

public struct FabulaExample262_BarGraph: View {
    @State var progress: CGFloat = 50   //init Value
    @State var height: CGFloat = 10     //init Value
    
    public init() {}
    public var body: some View {
        VStack {
            CustomSliderView(type: .height, sliderColor: LocalTheme.primary, value: $height)
                .padding(.bottom, 20)
            CustomSliderView(type: .progress, sliderColor: LocalTheme.secondary, value: $progress)
                .padding(.bottom, 40)
            
            BarGraph(height: height, progress: $progress, barColor: LocalTheme.secondary)
        }
        .padding(.horizontal, 30)
    }
}

fileprivate struct CustomSliderView: View {
    enum SliderType {
        case height
        case progress
        
        var title: String {
            switch self {
                case .height: return "Height"
                case .progress: return "Progress"
            }
        }
    }

    var type: SliderType
    var sliderColor: Color
    @Binding var value: CGFloat
    
    var body: some View {
        VStack{
            Text(type.title).font(.headline)
            CustomSlider().accentColor(sliderColor)
            Text("\(String(format: "%.1f", value))").font(.subheadline)
        }
        .foregroundColor(sliderColor)
    }
    
    
    fileprivate func CustomSlider() -> Slider<Text, Text> {
        
        return Slider(value: $value,
                      in: 0...100,
                      minimumValueLabel: Text("0"),
                      maximumValueLabel: Text("100"),
                      label: {Text(type.title)})
        
    }
}

fileprivate struct BarGraph: View {
    var height: CGFloat
    @Binding var progress: CGFloat
    var barColor: Color
    private let bgColor = Color.gray
    
    var body: some View {
        GeometryReader { geom in
            ZStack(alignment: .leading) {
                bgColor
                    .gesture(
                    DragGesture()
                        .onChanged{ value in
                            let dragedProgress = value.location.x / geom.size.width * 100
                            if (dragedProgress < 0) {
                                progress = 0
                            } else if (dragedProgress > 100) {
                                progress = 100
                            } else {
                                progress = dragedProgress
                            }
                        }
                )
                barColor.frame(width: geom.size.width * progress / 100)
                    .allowsHitTesting(false)
            }
        }
        .frame(height: height)
        .cornerRadius(height)
    }
}


struct FabulaExample262_BarGraph_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample262_BarGraph()
    }
}
