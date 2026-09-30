//
//  FabulaSubstringHighlighter.swift
//  Dist/Components/FabulaSubstringHighlighter
//
//  Adapted from FabulaItemsProvider P281_TextSubstringHighlighter. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// Builds `Text` with substring highlights applied via `AttributedString`.
public enum FabulaSubstringHighlighter {
    /// Returns attributed text with each highlight occurrence styled.
    public static func attributed(
        _ text: String,
        highlights: [String],
        highlightColor: Color,
        highlightFont: Font,
        caseInsensitive: Bool = false
    ) -> AttributedString {
        var attributed = AttributedString(text)
        guard !highlights.isEmpty else { return attributed }

        for highlight in highlights where !highlight.isEmpty {
            var searchStart = attributed.startIndex
            while searchStart < attributed.endIndex {
                let slice = attributed[searchStart...]
                let range: Range<AttributedString.Index>?
                if caseInsensitive {
                    range = slice.range(of: highlight, options: [.caseInsensitive])
                } else {
                    range = slice.range(of: highlight)
                }
                guard let match = range else { break }
                attributed[match].foregroundColor = highlightColor
                attributed[match].font = highlightFont
                searchStart = match.upperBound
            }
        }
        return attributed
    }
}

public extension Text {
    /// Creates highlighted `Text` for the given substrings.
    init(
        fabulaHighlighting text: String,
        highlights: [String],
        color: Color,
        font: Font,
        caseInsensitive: Bool = false
    ) {
        self.init(
            FabulaSubstringHighlighter.attributed(
                text,
                highlights: highlights,
                highlightColor: color,
                highlightFont: font,
                caseInsensitive: caseInsensitive
            )
        )
    }
}
