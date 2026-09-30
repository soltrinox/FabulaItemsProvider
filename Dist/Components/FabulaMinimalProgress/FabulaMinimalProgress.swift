//
//  FabulaMinimalProgress.swift
//  Dist/Components/FabulaMinimalProgress
//
//  Adapted from FabulaItemsProvider P50_ProgressView. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// Minimal `ProgressView` with optional label and a `Double` progress binding in `0...1`.
public struct FabulaMinimalProgress: View {
    @Binding private var progress: Double
    private let label: String?

    @Environment(\.fabulaTheme) private var theme

    public init(progress: Binding<Double>, label: String? = nil) {
        self._progress = progress
        self.label = label
    }

    public var body: some View {
        Group {
            if let label {
                ProgressView(value: clamped) {
                    Text(label)
                        .foregroundStyle(theme.fore2)
                }
            } else {
                ProgressView(value: clamped)
            }
        }
        .tint(theme.primary)
        .onAppear { clamp() }
        .onChange(of: progress) { _, _ in clamp() }
    }

    private var clamped: Double {
        min(max(progress, 0), 1)
    }

    private func clamp() {
        let next = min(max(progress, 0), 1)
        if next != progress { progress = next }
    }
}
