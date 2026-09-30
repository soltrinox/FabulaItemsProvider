//
//  FabulaDebouncedText.swift
//  Dist/Components/FabulaDebouncedText
//
//  Adapted from FabulaItemsProvider P282_DebouncedText. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// Debounces a source `Binding` into a destination `Binding` after `delay`.
public struct FabulaDebouncedText: ViewModifier {
    @Binding private var text: String
    @Binding private var debouncedText: String
    private let delay: TimeInterval

    @State private var generation = 0

    public init(
        text: Binding<String>,
        debouncedText: Binding<String>,
        delay: TimeInterval = 0.5
    ) {
        self._text = text
        self._debouncedText = debouncedText
        self.delay = max(delay, 0)
    }

    public func body(content: Content) -> some View {
        content
            .onChange(of: text) { _, newValue in
                generation &+= 1
                let token = generation
                Task { @MainActor in
                    let nanos = UInt64(delay * 1_000_000_000)
                    try? await Task.sleep(nanoseconds: nanos)
                    guard token == generation else { return }
                    debouncedText = newValue
                }
            }
            .onAppear {
                if debouncedText != text {
                    debouncedText = text
                }
            }
    }
}

public extension View {
    func fabulaDebouncedText(
        text: Binding<String>,
        debouncedText: Binding<String>,
        delay: TimeInterval = 0.5
    ) -> some View {
        modifier(FabulaDebouncedText(text: text, debouncedText: debouncedText, delay: delay))
    }
}
