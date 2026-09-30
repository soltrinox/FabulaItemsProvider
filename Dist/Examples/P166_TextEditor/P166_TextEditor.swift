// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P166
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

public struct FabulaExample166_TextEditor: View {
    
    @State private var text = ""
    @State private var wordCount: Int = 0
    
    public init() {}
    public var body: some View {
        VStack(alignment: .trailing) {
            if wordCount > 0 {
                Text("\(wordCount) words")
                    .font(.headline)
                    .foregroundColor(wordCount == 0 ? Color.secondary : LocalTheme.primary)
                    .transition(.scale.combined(with: .opacity))
            }
            TextEditor(text: $text)
                .font(.body)
                .padding()
                .background(Color.black.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .onChange(of: text) { value in
                    let words = text.split { $0 == " " || $0.isNewline }
                    self.wordCount = words.count
                }
#if os(iOS)
                .onAppear {
                    UITextView.appearance().backgroundColor = UIColor.clear
                }
#endif
        }
        .animation(.easeInOut, value: wordCount)
        .padding()
        .frame(maxWidth: 500, maxHeight: 500)
    }
}

struct FabulaExample166_TextEditor_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample166_TextEditor()
    }
}
