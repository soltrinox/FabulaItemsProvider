//
//  FabulaBoundedStepper.swift
//  Dist/Components/FabulaBoundedStepper
//
//  Adapted from FabulaItemsProvider P114_Stepper. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// `Stepper` with an explicit `ClosedRange` and production `Binding`.
public struct FabulaBoundedStepper<Label: View>: View {
    @Binding private var value: Int
    private let range: ClosedRange<Int>
    private let step: Int
    private let label: () -> Label

    @Environment(\.fabulaTheme) private var theme

    public init(
        value: Binding<Int>,
        in range: ClosedRange<Int>,
        step: Int = 1,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self._value = value
        self.range = range
        self.step = max(step, 1)
        self.label = label
    }

    public var body: some View {
        Stepper(value: $value, in: range, step: step) {
            label()
                .foregroundStyle(theme.fore1)
        }
        .tint(theme.primary)
        .onAppear { clamp() }
        .onChange(of: value) { _, _ in clamp() }
    }

    private func clamp() {
        if value < range.lowerBound { value = range.lowerBound }
        if value > range.upperBound { value = range.upperBound }
    }
}

/// Convenience stepper that shows `title` and the live value.
public struct FabulaBoundedStepperLabeled: View {
    private let title: String
    @Binding private var value: Int
    private let range: ClosedRange<Int>
    private let step: Int

    public init(
        _ title: String,
        value: Binding<Int>,
        in range: ClosedRange<Int>,
        step: Int = 1
    ) {
        self.title = title
        self._value = value
        self.range = range
        self.step = step
    }

    public var body: some View {
        FabulaBoundedStepper(value: $value, in: range, step: step) {
            Text("\(title): \(value)")
        }
    }
}
