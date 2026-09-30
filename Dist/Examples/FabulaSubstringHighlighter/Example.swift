//
//  Example.swift
//  Dist/Examples/FabulaSubstringHighlighter
//
//  Adapted from FabulaItemsProvider P281_TextSubstringHighlighter. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

struct FabulaSubstringHighlighterExample: View {
    private let sample = "The quick brown fox jumps over the lazy dog"
    private let highlights = ["quick", "fox", "dog"]

    var body: some View {
        Text(
            fabulaHighlighting: sample,
            highlights: highlights,
            color: .orange,
            font: .system(size: 22, weight: .bold)
        )
        .font(.system(size: 18, weight: .regular))
        .padding()
        .fabulaTheme(.fabulaDefault)
    }
}

#Preview("FabulaSubstringHighlighter") {
    FabulaSubstringHighlighterExample()
}

struct FabulaSubstringHighlighterExample_Previews: PreviewProvider {
    static var previews: some View {
        FabulaSubstringHighlighterExample()
    }
}
