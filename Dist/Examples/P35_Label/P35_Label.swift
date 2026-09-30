// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P35
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample35_Label: View {
    
    let types: [LabelStyleType] = [.titleAndIcon, .titleOnly, .iconOnly]
    @State private var currentType: LabelStyleType = .titleAndIcon
    
    public init() {}
    public var body: some View {
        VStack {
            ZStack {
                switch currentType {
                case .titleAndIcon:
                    Label("Person", systemImage: "person.crop.circle")
                        .font(.title)
                        .labelStyle(DefaultLabelStyle())
                case .titleOnly:
                    Label("Person", systemImage: "person.crop.circle")
                        .font(.title)
                        .labelStyle(TitleOnlyLabelStyle())
                case .iconOnly:
                    Label("Person", systemImage: "person.crop.circle")
                        .font(.title)
                        .labelStyle(IconOnlyLabelStyle())
                }
            }
            .frame(height: 50)
            Divider().padding()
            Picker("Label Style", selection: $currentType) {
                ForEach(types, id: \.self) { type in
                    Text(String(describing: type))
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
        .frame(maxWidth: 500, maxHeight: 500)
    }
}

extension P35_Label {
    enum LabelStyleType {
        case titleAndIcon
        case titleOnly
        case iconOnly
    }
}

struct FabulaExample35_Label_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample35_Label()
    }
}
