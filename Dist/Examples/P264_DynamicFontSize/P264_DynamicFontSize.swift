// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P264
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

public struct FabulaExample264_DynamicFontSize: View {
    private let firstBgColor = LocalTheme.primary
    private let secondBgColor = LocalTheme.secondary
    private let text = "The font size is automatically converted to fit the view size. The font size is automatically converted to fit the view size. "
    @State private var lineLimit = ""
    
    public init() {}
    public var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Basic")
                dynamicFontViewGroup(bgColor: firstBgColor, text: text, lineLimit: 999)
            }
            VStack {
                Text("Set LineLimit")
                Section {
                    TextField("Enter LineLimit Value", text: $lineLimit)
                        .padding(10)
                        .background(LocalTheme.back1)
                }.padding(10)
                dynamicFontViewGroup(bgColor: secondBgColor, text: text, lineLimit: Int(lineLimit) ?? 0)
            }
            Spacer()
        }
    }
}

fileprivate struct dynamicFontViewGroup: View {
    var bgColor: Color?
    var text: String
    var lineLimit: Int
    
    var body: some View {
        GeometryReader { geom in
            HStack {
                Spacer()
                ZStack {
                    bgColor
                    Text(text).dynamicFont(lineLimit: lineLimit)
                }.frame(width: geom.size.width / 20, height: geom.size.width / 20)
                ZStack {
                    bgColor
                    Text(text).dynamicFont(lineLimit: lineLimit)
                }.frame(width: geom.size.width / 15, height: geom.size.width / 15)
                ZStack {
                    bgColor
                    Text(text).dynamicFont(lineLimit: lineLimit)
                }.frame(width: geom.size.width / 10, height: geom.size.width / 10)
                ZStack {
                    bgColor
                    Text(text).dynamicFont(lineLimit: lineLimit)
                }.frame(width: geom.size.width / 5, height: geom.size.width / 5)
                ZStack {
                    bgColor
                    Text(text).dynamicFont(lineLimit: lineLimit)
                }.frame(width: geom.size.width / 3, height: geom.size.width / 3)
                Spacer()
            }
        }
    }
}


fileprivate struct dyanmicFontModifier: ViewModifier {
    var lineLimit: Int
    var fontSize: CGFloat?

    func body(content: Content) -> some View {
        Spacer()
        content
            .font(.system(size: fontSize ?? 100))
            .lineLimit(lineLimit)
            .minimumScaleFactor(0.001)
        Spacer()
    }
}

fileprivate extension View {
    func dynamicFont(lineLimit: Int = 0, fontSize: CGFloat? = nil) -> some View {
        return modifier(dyanmicFontModifier(lineLimit: lineLimit))
    }
}


struct FabulaExample264_DynamicFontSize_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample264_DynamicFontSize()
    }
}
