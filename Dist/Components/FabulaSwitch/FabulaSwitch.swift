//
//  FabulaSwitch.swift
//  Dist/Components/FabulaSwitch
//
//  Adapted from FabulaItemsProvider P280_SwitchComponent. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// Custom switch bound to `Bool`. Uses `theme.primary` when on. No logging.
public struct FabulaSwitch: View {
    @Binding private var isOn: Bool
    private let onChange: ((Bool) -> Void)?

    @GestureState private var isPressed = false
    @Environment(\.fabulaTheme) private var theme

    public init(isOn: Binding<Bool>, onChange: ((Bool) -> Void)? = nil) {
        self._isOn = isOn
        self.onChange = onChange
    }

    public var body: some View {
        switchTrack
            .gesture(pressGesture)
            .animation(.default, value: isOn)
            .animation(.default, value: isPressed)
            .accessibilityElement()
            .accessibilityLabel("Switch")
            .accessibilityValue(Text(isOn ? "On" : "Off"))
            .accessibilityAddTraits(.isButton)
            .accessibilityAddTraits(isOn ? .isSelected : [])
            .accessibilityAction { toggle() }
    }

    private var backgroundColor: Color {
        isOn ? theme.primary : theme.bar1
    }

    private var handleColor: Color {
        isOn ? theme.foreWB100 : theme.fore2
    }

    private var pressGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .updating($isPressed) { _, state, _ in
                state = true
            }
            .onEnded { _ in
                toggle()
            }
    }

    private func toggle() {
        isOn.toggle()
        onChange?(isOn)
    }

    @ViewBuilder
    private var switchTrack: some View {
        GeometryReader { geo in
            let handleGap = geo.size.height * 0.075
            ZStack(alignment: isOn ? .trailing : .leading) {
                Capsule()
                    .fill(backgroundColor)
                Capsule()
                    .fill(handleColor)
                    .padding(handleGap)
                    .frame(width: handleWidth(geo.size))
                    .shadow(
                        color: Color.black.opacity(0.35),
                        radius: handleGap * 0.5,
                        x: 0,
                        y: 0
                    )
            }
        }
        .frame(idealWidth: 51, idealHeight: 31)
    }

    private func handleWidth(_ size: CGSize) -> CGFloat {
        let w = size.width
        let h = size.height
        return isPressed ? h + (w - h) * 0.3 : h
    }
}
