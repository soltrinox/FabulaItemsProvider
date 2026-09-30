// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P187
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

public struct FabulaExample187_HierarchyTree: View {
    
    @State private var item = TreeItem(name: "Root", children: [])
    
    public init() {}
    public var body: some View {
        ScrollView([.vertical, .horizontal]) {
            TreeView(item: item)
        }
        .onAppear {
            item = TreeItem(name: "Root", children: [])
        }
    }
}

fileprivate
class TreeItem: ObservableObject, Identifiable {
    
    var id: UUID = UUID()
    @Published var name: String
    @Published var children: [TreeItem]
    
    init(name: String, children: [TreeItem]) {
        self.children = children
        self.name = name
    }
}

fileprivate
struct TreeView: View {
    
    @ObservedObject var item: TreeItem
    typealias Key = PreferKey<TreeItem.ID, Anchor<CGPoint>>
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            HStack(spacing: 5) {
                Image(systemName: "minus.circle")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            item.children = []
                        }
                    }
                TextField("", text: $item.name)
                    .padding(.vertical, 6).padding(.horizontal, 10)
                    .background(Color.white.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundColor(Color.white)
                    .fixedSize()
                Image(systemName: "plus.circle")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        let treeItem = TreeItem(name: "Child", children: [])
                        withAnimation(.easeInOut(duration: 0.4)) {
                            item.children.append(treeItem)
                        }
                    }
            }
            .padding(12)
            .background(LocalTheme.primary)
            .clipShape(Capsule())
            .anchorPreference(key: Key.self, value: .center, transform: {
                [self.item.id: $0]
            })

            HStack(alignment: .top, spacing: 10) {
                ForEach(Array(item.children.enumerated()), id:\.offset) { index, i in
                    HStack {
                        TreeView(item: i)
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.4), value: item.name)
        .backgroundPreferenceValue(Key.self, { (centers: [TreeItem.ID: Anchor<CGPoint>]) in
            GeometryReader { proxy in
                ForEach(self.item.children) { child in
                    Line(
                        startPoint: proxy[centers[self.item.id]!],
                        endPoint: proxy[centers[child.id]!]
                    )
                        .stroke(lineWidth: 1)
                        .fill(LocalTheme.primary)
                }
            }
        })
    }
}

fileprivate
struct PreferKey<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key: Value] { [:] }
    static func reduce(value: inout [Key: Value], nextValue: () -> [Key: Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

fileprivate
struct Line: Shape {
    var startPoint: CGPoint
    var endPoint: CGPoint
    var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
        get { AnimatablePair(startPoint.animatableData, endPoint.animatableData) }
        set { (startPoint.animatableData, endPoint.animatableData) = (newValue.first, newValue.second) }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.startPoint)
            p.addLine(to: self.endPoint)
        }
    }
}

struct FabulaExample187_HierarchyTree_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample187_HierarchyTree()
    }
}
