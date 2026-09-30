// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P21
// Adapted: local theme; print removed; no third-party.

import SwiftUI

#if canImport(UIKit)
import UIKit
fileprivate enum LocalDevice {
    static var isPad: Bool { UIDevice.current.userInterfaceIdiom != .phone }
}
#else
fileprivate enum LocalDevice {
    static var isPad: Bool { false }
}
#endif

#if canImport(UIKit)
fileprivate enum LocalHaptics {
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        let g = UIImpactFeedbackGenerator(style: style)
        g.prepare()
        g.impactOccurred()
    }
}
#else
fileprivate enum LocalHaptics {
    static func impact() {}
}
#endif

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

public struct FabulaExample21_FabulaRadioSectionGroup: View {
    
    @AppStorage("colorSchemeIndex") var colorSchemeIndex = 1
    
    fileprivate
    let colorModes = [
        FabulaRadioButtonTitleSet("System Mode", "Automatically apply the display mode(Dark/Light) set in the OS settings."),
        FabulaRadioButtonTitleSet("Dark Mode"),
        FabulaRadioButtonTitleSet("Light Mode")]
    
    public init() {}
    public var body: some View {
        Form {
            FabulaRadioSectionGroup(sectionTitle: "Themes", items: colorModes,
                                    selectedItem: colorModes[colorSchemeIndex].title,
                                    selectedColor: LocalTheme.primary) { index, item in
                colorSchemeIndex = index
            }
        }
        .padding()
        .frame(maxWidth: 500)
    }
}

fileprivate
struct SettingSpacer<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content
    var body: some View {
#if os(iOS)
        Spacer()
#endif
        content()
#if os(macOS)
        Spacer()
#endif
    }
}

fileprivate
struct FabulaRadioButton: View {
    let titleSet: FabulaRadioButtonTitleSet
    let isSelected: Bool
    let selectedColor: Color
    let action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(LocalizedStringKey(titleSet.title))
                    if let subTitle = titleSet.subTitle {
                        HStack {
                            Text(LocalizedStringKey(subTitle))
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(LocalTheme.fore2)
                            Spacer()
                        }
                    }
                }
                .padding(.vertical, 8)
                Spacer()
                ZStack(alignment: .center) {
                    Circle()
                        .strokeBorder(lineWidth: 2.0)
                        .scaleEffect(isSelected ? 1 : 0.8)
                        .foregroundColor(LocalTheme.fore1)
                        .opacity(isSelected ? 0.8 : 0.0)
                    Circle()
                        .strokeBorder(lineWidth: 2.0)
                        .scaleEffect(isSelected ? 0.8 : 1)
                        .foregroundColor(LocalTheme.fore1)
                        .opacity(isSelected ? 0.0 : 0.8)
                    Circle()
                        .fill(selectedColor)
                        .scaleEffect(isSelected ? 0.65 : 0.001)
                        .opacity(isSelected ? 1 : 0)
                }
                .animation(.spring(), value: isSelected)
                .frame(width: 23, height: 23)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

fileprivate
struct FabulaRadioButtonTitleSet {
    var title: String
    var subTitle: String? = nil
    
    init(_ title: String, _ subTitle: String? = nil) {
        self.title = title
        self.subTitle = subTitle
    }
}

fileprivate
struct FabulaRadioSectionGroup: View {
    
    let sectionTitle: String
    let items: [FabulaRadioButtonTitleSet]
    @State var selectedItem: String = ""
    let selectedColor: Color
    let action: ((Int, String) -> Void)?
    
    var body: some View {
        GeneralSetSection(section: LocalizedStringKey(sectionTitle)) {
#if os(iOS)
            getContent()
#else
            VStack(spacing: 5) {
                getContent()
                    .padding(.trailing, 16)
            }
#endif
        }
    }
    
    private func getContent() -> some View {
        ForEach(Array(items.enumerated()), id: \.offset) { index, item in
            FabulaRadioButton(titleSet: item, isSelected: selectedItem == item.title, selectedColor: selectedColor) {
                self.selectedItem = item.title
                action?(index, selectedItem)
                LocalHaptics.impact()
            }
        }
    }
    
    func LocalHaptics.impact() {
#if os(iOS)
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
#endif
    }
}

fileprivate
struct GeneralSetSection<Content>: View where Content: View {
    let section: LocalizedStringKey
    @ViewBuilder var content: () -> Content
    var body: some View {
        Group {
            Section(header:
                        HStack(spacing: 0) {
                SettingSpacer {
                    Text(section)
#if os(iOS)
                        .font(.caption)
#endif
                        .foregroundColor(LocalTheme.fore1.opacity(0.5))
                }
            }
                        .frame(height: 16)
            ) {
#if os(macOS)
                HStack {
                    Spacer().frame(width: 16)
                    content()
                }
#else
                content()
#endif
            }
#if os(macOS)
            Spacer().frame(height: 10)
#endif
        }
    }
}

fileprivate
struct GeneralSetArrow: View {
    var body: some View {
        Image(systemName: "chevron.right")
            .font(.callout)
            .foregroundColor(LocalTheme.fore1.opacity(0.5))
    }
}

struct FabulaExample21_FabulaRadioSectionGroup_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample21_FabulaRadioSectionGroup()
    }
}
