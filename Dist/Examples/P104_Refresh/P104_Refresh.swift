// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P104
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample104_Refresh: View {
    
    @State private var posts = [PostItem(id: 0, title: "Item 0")]
    
    public init() {}
    public var body: some View {
        List(posts) { item in
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
            }
        }
#if os(iOS)
        .listStyle(GroupedListStyle())
        .refreshable {
            var newPosts = [PostItem]()
            for index in 0...3 {
                let index = posts.count + index
                newPosts.append(PostItem(id: index, title: "Item \(index)"))
            }
            posts += newPosts
        }
#endif
    }
}

fileprivate
struct PostItem: Decodable, Identifiable {
    let id: Int
    let title: String
}

struct FabulaExample104_Refresh_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample104_Refresh()
    }
}
