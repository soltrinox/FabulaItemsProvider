// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P31
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample31_StaticText: View {
    
#if os(iOS)
    private let attributedString = try! AttributedString(
        markdown: "_Hamlet_ by William Shakespeare")
#endif
    public init() {}
    public var body: some View {
        HStack {
            VStack {
                Group {
                    Text("largeTitle")
                        .font(.largeTitle)
                    Text("title")
                        .font(.title)
                    Text("title2")
                        .font(.title2)
                    Text("title3")
                        .font(.title3)
                    Text("headline")
                        .font(.headline)
                    Text("subheadline")
                        .font(.subheadline)
                    Text("body")
                        .font(.body)
                    Text("callout")
                        .font(.callout)
                    Text("caption")
                        .font(.caption)
                    Text("caption2")
                        .font(.caption2)
                }
                Text("footnote")
                    .font(.footnote)
            }
            Divider()
            VStack {
                Text("by William Shakespeare")
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .italic()
                Divider()
#if os(iOS)
                Text(attributedString)
                    .font(.system(size: 12, weight: .light, design: .serif))
                Divider()
#endif
                Text("To be, or not to be, that is the question:")
                    .frame(width: 100)
                Divider()
                Text("To be, or not to be, that is the question:")
                    .frame(width: 100, height: 30)
                    .truncationMode(.middle)
                Divider()
                Text("Brevity is the soul of wit.")
                    .frame(width: 100)
                    .lineLimit(1)
            }
        }
        .padding()
        .frame(maxWidth: 500, maxHeight: 500)
    }
}

struct FabulaExample31_StaticText_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample31_StaticText().preferredColorScheme(.dark)
    }
}
