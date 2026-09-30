// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P73
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

#if os(iOS)
public struct FabulaExample73_DynamicTypeSize: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize: DynamicTypeSize
    @State private var currentTypeSize: DynamicTypeSize = .xSmall
    let types: [DynamicTypeSize] = [.xSmall, .small, .medium, .large, .xLarge, .xxLarge, .xxxLarge, .accessibility1, .accessibility2, .accessibility3, .accessibility4, .accessibility5]
    
    public init() {}
    public var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top, spacing: 8) {
                    VStack(alignment: .center) {
                        DynamicTypeSizeView()
                        Divider().frame(width: 44)
                        Text("Settings\n-> Display & Brightness\n-> Text Size")
                            .font(.caption)
                            .opacity(0.5)
                    }
                    Divider()
                    VStack(alignment: .center) {
                        DynamicTypeSizeView()
                            .environment(\.dynamicTypeSize, currentTypeSize)
                    }
                }
                Picker("Dynamic Type Size", selection: $currentTypeSize) {
                    ForEach(types, id:\.self) { type in
                        Text(type.typeName())
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
            }
        }
    }
}

fileprivate
extension DynamicTypeSize {
    func typeName() -> String {
        switch self {
        case .xSmall: return "xSmall"
        case .small: return "small"
        case .medium: return "medium"
        case .large: return "large"
        case .xLarge: return "xLarge"
        case .xxLarge: return "xxLarge"
        case .xxxLarge: return "xxxLarge"
        case .accessibility1: return "accessibility1"
        case .accessibility2: return "accessibility2"
        case .accessibility3: return "accessibility3"
        case .accessibility4: return "accessibility4"
        case .accessibility5: return "accessibility5"
        default: return ""
        }
    }
}

fileprivate
struct DynamicTypeSizeView: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize: DynamicTypeSize
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("." + dynamicTypeSize.typeName())
                .foregroundColor(LocalTheme.primary)
            VStack(alignment: .center, spacing: 8.0) {
                Group {
                    Text("largeTitle")
                        .font(.largeTitle)
                    Text("Title")
                        .font(.title)
                    Text("Title 2")
                        .font(.title2)
                    Text("Title 3")
                        .font(.title3)
                    Text("Headline")
                        .font(.headline)
                    Text("Subheadline")
                        .font(.subheadline)
                    Text("Body")
                        .font(.body)
                    Text("Callout")
                        .font(.callout)
                    Text("Footnote")
                        .font(.footnote)
                    Text("Caption")
                        .font(.caption)
                }
                Text("Caption 2")
                    .font(.caption2)
            }
        }
        .padding()
    }
}

#else
public struct FabulaExample73_DynamicTypeSize: View {
    
    public init() {}
    public var body: some View {
        EmptyView()
    }
}
#endif

struct FabulaExample73_DynamicTypeSize_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample73_DynamicTypeSize()
    }
}
