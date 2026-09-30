// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P200
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

struct FabulaExample200_DynamicTypeSize: View {
    
    var body: some View {
        if #available(macOS 12.0, *) {
            DynamicTypeSizeView()
        } else {
            Text("@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)")
        }
    }
}

@available(macOS 12.0, *)
fileprivate
struct DynamicTypeSizeView: View {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @State private var currentTypeSize: DynamicTypeSize = .xSmall
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("System : ").font(.caption).foregroundColor(LocalTheme.fore2)
                Text("\(dynamicTypeSize.name)")
                Spacer().frame(height: 20)
                Text("Current : ").font(.caption).foregroundColor(LocalTheme.fore2)
                Text("\(currentTypeSize.name)")
                    .dynamicTypeSize(currentTypeSize)
            }
            .frame(height: 200)
            
            Divider()
            Picker("DynamicTypeSize", selection: $currentTypeSize) {
                Group {
                    Text(DynamicTypeSize.xSmall.name).tag(DynamicTypeSize.xSmall)
                    Text(DynamicTypeSize.small.name).tag(DynamicTypeSize.small)
                    Text(DynamicTypeSize.medium.name).tag(DynamicTypeSize.medium)
                    Text(DynamicTypeSize.large.name).tag(DynamicTypeSize.large)
                    Text(DynamicTypeSize.xLarge.name).tag(DynamicTypeSize.xLarge)
                    Text(DynamicTypeSize.xxLarge.name).tag(DynamicTypeSize.xxLarge)
                    Text(DynamicTypeSize.xxxLarge.name).tag(DynamicTypeSize.xxxLarge)
                }
                Group {
                    Text(DynamicTypeSize.accessibility1.name).tag(DynamicTypeSize.accessibility1)
                    Text(DynamicTypeSize.accessibility2.name).tag(DynamicTypeSize.accessibility2)
                    Text(DynamicTypeSize.accessibility3.name).tag(DynamicTypeSize.accessibility3)
                    Text(DynamicTypeSize.accessibility4.name).tag(DynamicTypeSize.accessibility4)
                    Text(DynamicTypeSize.accessibility5.name).tag(DynamicTypeSize.accessibility5)
                }
            }
            .pickerStyle(InlinePickerStyle())
        }
        .padding()
    }
}

@available(macOS 12.0, *)
fileprivate
extension DynamicTypeSize {
    var name: String {
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
        @unknown default: return "Unknown"
        }
    }
}

struct FabulaExample200_DynamicTypeSize_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample200_DynamicTypeSize()
    }
}
