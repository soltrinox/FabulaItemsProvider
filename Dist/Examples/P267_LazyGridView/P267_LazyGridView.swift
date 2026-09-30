// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P267
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

public struct FabulaExample267_LazyGridView: View {
    let datas = [GridData(vTitle: "Sticky-Section-Primary", color: LocalTheme.primary),
                 GridData(vTitle: "Sticky-Section-Secondary", color: LocalTheme.secondary),
                 GridData(vTitle: "Sticky-Section-yellow", color: .yellow),
                 GridData(vTitle: "Sticky-Section-blue", color: .blue),
                 GridData(vTitle: "Sticky-Section-pink", color: .pink)]
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    public init() {}
    public var body: some View {
        VStack {
            Text("LazyVGrid")
            ScrollView {
                LazyVGrid(columns: columns,
                          spacing: 20,
                          pinnedViews: .sectionHeaders) {
                    
                    ForEach(datas, id: \.self) { data in
                        gridItem(gridData: data)
                    }
                }.padding()
            }
            .background(LocalTheme.back2)
            .cornerRadius(10)
            .padding(.horizontal)
                
            
            Text("LazyHGrid")
            ScrollView(.horizontal) {
                LazyHGrid(rows: columns,
                          spacing: 20,
                          pinnedViews: .sectionHeaders) {
                    ForEach(datas, id: \.self) { data in
                        gridItem(gridData: data, isHorizontal: true)
                    }
                }
            }
            .background(LocalTheme.back2)
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
    
    private func gridItem(gridData: GridData, isHorizontal: Bool = false) -> some View {
        return Section(header:
                        Text(isHorizontal ? gridData.hTitle : gridData.vTitle).foregroundColor(gridData.color)) {
            ForEach(0..<10) {i in
                if isHorizontal {
                    Capsule()
                        .fill(gridData.color)
                        .frame(width: 20, height: 20)
                } else {
                    Capsule()
                        .fill(gridData.color)
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
    
}

struct GridData: Equatable, Hashable {
    var vTitle: String
    var hTitle: String = "Sticky\nSection"
    var color: Color
}

struct FabulaExample267_LazyGridView_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample267_LazyGridView()
    }
}
