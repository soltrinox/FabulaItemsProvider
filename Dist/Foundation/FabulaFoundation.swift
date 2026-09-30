//
//  FabulaFoundation.swift
//  Dist/Foundation — portable Fabula toolkit
//
//  Adapted from FabulaItemsProvider Common.swift / GeometryProxy+Extensions /
//  Color+Extensions (hex helpers). MIT © 2022 jasudev.
//
//  Adaptation: removed AxisSheet coupling; no SPM module bundle; Swift 6–safe.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - Device

public enum FabulaDevice {
    public static var isPad: Bool {
#if os(iOS)
        UIDevice.current.userInterfaceIdiom != .phone
#else
        false
#endif
    }
}

// MARK: - Haptics

public enum FabulaHaptics {
#if os(iOS)
    public static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        let feedback = UIImpactFeedbackGenerator(style: style)
        feedback.prepare()
        feedback.impactOccurred()
    }
#else
    public static func impact() {}
#endif
}

// MARK: - Geometry

public extension GeometryProxy {
    var fabulaMinSize: CGFloat { min(size.width, size.height) }
    var fabulaMaxSize: CGFloat { max(size.width, size.height) }
}

// MARK: - Color hex (no asset catalog)

public extension Color {
    init(fabulaHex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((fabulaHex >> 16) & 0xff) / 255,
            green: Double((fabulaHex >> 8) & 0xff) / 255,
            blue: Double(fabulaHex & 0xff) / 255,
            opacity: alpha
        )
    }

    init(fabulaHex string: String) {
        let hex = string.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Bundle resolution (app / framework, never SPM module bundle)

public enum FabulaBundleResolver {
    /// Prefer the main app bundle; fall back to the bundle containing this type.
    public static var resources: Bundle {
        Bundle.main
    }
}
