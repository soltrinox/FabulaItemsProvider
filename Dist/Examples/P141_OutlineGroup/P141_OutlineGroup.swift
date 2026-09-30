// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P141
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample141_OutlineGroup: View {
    struct FileItem: Hashable, Identifiable, CustomStringConvertible {
        var id: Self { self }
        var name: String
        var children: [FileItem]? = nil
        var description: String {
            switch children {
            case nil:
                return "📄 \(name)"
            case .some(let children):
                return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
            }
        }
    }
    
    let data =
    FileItem(name: "users", children:
                [FileItem(name: "user1234", children:
                            [FileItem(name: "Photos", children:
                                        [FileItem(name: "photo001.jpg"),
                                         FileItem(name: "photo002.jpg")]),
                             FileItem(name: "Movies", children:
                                        [FileItem(name: "movie001.mp4")]),
                             FileItem(name: "Documents", children: [])
                            ]),
                 FileItem(name: "newuser", children:
                            [FileItem(name: "Documents", children: [])
                            ])
                ])
    
    public init() {}
    public var body: some View {
        OutlineGroup(data, children: \.children) { item in
            Text("\(item.description)")
        }
        .padding()
        .frame(maxWidth: 500)
    }
}

struct FabulaExample141_OutlineGroup_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample141_OutlineGroup()
    }
}
