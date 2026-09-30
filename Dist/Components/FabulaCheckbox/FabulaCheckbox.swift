//
//  FabulaCheckbox.swift
//  Dist/Components/FabulaCheckbox
//
//  Adapted from FabulaItemsProvider P279_CheckboxComponent. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// Accessible checkbox control. No selection logging.
public struct FabulaCheckbox<Label: View>: View {
    @Binding private var isOn: Bool
    private let size: CGFloat
    private let label: () -> Label

    @Environment(\.fabulaTheme) private var theme

    public init(
        isOn: Binding<Bool>,
        size: CGFloat = 24,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self._isOn = isOn
        self.size = size
        self.label = label
    }

    public var body: some View {
        Button {
            isOn.toggle()
        } label: {
            HStack(alignment: .center, spacing: 12) {
                ZStack {
                    if isOn {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(theme.primary)
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(theme.foreWB100)
                            .padding(size * 0.18)
                            .transition(.scale)
                    } else {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .strokeBorder(theme.fore2, lineWidth: 1.5)
                    }
                }
                .frame(width: size, height: size)
                .animation(.default, value: isOn)

                label()
                    .foregroundStyle(theme.fore1)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text(isOn ? "Checked" : "Unchecked"))
        .accessibilityAddTraits(.isButton)
        .accessibilityAddTraits(isOn ? .isSelected : [])
        .accessibilityValue(Text(isOn ? "On" : "Off"))
        .accessibilityAction { isOn.toggle() }
    }
}

public extension FabulaCheckbox where Label == Text {
    init(_ title: String, isOn: Binding<Bool>, size: CGFloat = 24) {
        self.init(isOn: isOn, size: size) { Text(title) }
    }
}
