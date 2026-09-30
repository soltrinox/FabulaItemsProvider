//
//  FabulaTheme.swift
//  Dist/Theme — injectable semantic tokens (no SPM module bundle).
//
//  Color values adapted from FabulaItemsProvider Colors.xcassets. MIT © 2022 jasudev.
//

import SwiftUI

public struct FabulaTheme: Equatable, Sendable {
    public var primary: Color
    public var secondary: Color
    public var back0: Color
    public var back1: Color
    public var back2: Color
    public var fore1: Color
    public var fore2: Color
    public var bar1: Color
    public var bar2: Color
    public var foreWB100: Color
    public var backWB100: Color

    public init(
        primary: Color = Color(red: 0.969, green: 0.475, blue: 0.278),
        secondary: Color = Color(red: 0.20, green: 0.60, blue: 0.86),
        back0: Color = Color(red: 0.07, green: 0.07, blue: 0.09),
        back1: Color = Color(red: 0.11, green: 0.11, blue: 0.14),
        back2: Color = Color(red: 0.16, green: 0.16, blue: 0.20),
        fore1: Color = Color(red: 0.95, green: 0.95, blue: 0.97),
        fore2: Color = Color(red: 0.70, green: 0.70, blue: 0.75),
        bar1: Color = Color(red: 0.25, green: 0.25, blue: 0.30),
        bar2: Color = Color(red: 0.35, green: 0.35, blue: 0.40),
        foreWB100: Color = .white,
        backWB100: Color = .black
    ) {
        self.primary = primary
        self.secondary = secondary
        self.back0 = back0
        self.back1 = back1
        self.back2 = back2
        self.fore1 = fore1
        self.fore2 = fore2
        self.bar1 = bar1
        self.bar2 = bar2
        self.foreWB100 = foreWB100
        self.backWB100 = backWB100
    }

    public static let fabulaDefault = FabulaTheme()
}

private struct FabulaThemeKey: EnvironmentKey {
    static let defaultValue = FabulaTheme.fabulaDefault
}

public extension EnvironmentValues {
    var fabulaTheme: FabulaTheme {
        get { self[FabulaThemeKey.self] }
        set { self[FabulaThemeKey.self] = newValue }
    }
}

public extension View {
    func fabulaTheme(_ theme: FabulaTheme) -> some View {
        environment(\.fabulaTheme, theme)
    }
}
