//
//  FabulaRadioGroup.swift
//  Dist/Components/FabulaRadioGroup
//
//  Adapted from FabulaItemsProvider P265_RadioComponent (rewritten). MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// Radio group with optional `Hashable` selection. No selection logging.
public struct FabulaRadioGroup<T: Hashable, Content: View>: View {
    @Binding private var selection: T?
    private let content: () -> Content
    @StateObject private var store: FabulaRadioStore<T>

    public init(
        selection: Binding<T?>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selection = selection
        self.content = content
        self._store = StateObject(wrappedValue: FabulaRadioStore(initial: selection.wrappedValue))
    }

    public var body: some View {
        content()
            .environmentObject(store)
            .onAppear {
                store.selection = selection
                store.onSelect = { selection = $0 }
            }
            .onChange(of: selection) { _, newValue in
                if store.selection != newValue {
                    store.selection = newValue
                }
            }
            .onChange(of: store.selection) { _, newValue in
                if selection != newValue {
                    selection = newValue
                }
            }
    }
}

/// Visual radio indicator for a given tag.
public struct FabulaRadioItem<T: Hashable>: View {
    private let tag: T
    @EnvironmentObject private var store: FabulaRadioStore<T>
    @Environment(\.fabulaTheme) private var theme

    public init(tag: T) {
        self.tag = tag
    }

    public var body: some View {
        let isSelected = store.selection == tag
        ZStack {
            Circle()
                .fill(theme.foreWB100)
            Circle()
                .strokeBorder(theme.fore2.opacity(0.5), lineWidth: 1)
            if isSelected {
                Circle()
                    .fill(theme.primary)
                    .frame(width: 8, height: 8)
                    .transition(.scale)
            }
        }
        .frame(width: 16, height: 16)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
        .accessibilityHidden(true)
    }
}

@MainActor
fileprivate final class FabulaRadioStore<T: Hashable>: ObservableObject {
    @Published var selection: T?
    var onSelect: ((T?) -> Void)?

    init(initial: T?) {
        self.selection = initial
    }

    func select(_ tag: T) {
        selection = tag
        onSelect?(tag)
    }
}

fileprivate struct FabulaRadioTagModifier<T: Hashable>: ViewModifier {
    private let tag: T
    @EnvironmentObject private var store: FabulaRadioStore<T>

    init(tag: T) {
        self.tag = tag
    }

    func body(content: Content) -> some View {
        Button {
            store.select(tag)
        } label: {
            content
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(store.selection == tag ? [.isSelected, .isButton] : .isButton)
    }
}

public extension View {
    /// Marks the view as a selectable radio row for `tag` within a `FabulaRadioGroup`.
    func fabulaRadioTag<T: Hashable>(_ tag: T) -> some View {
        modifier(FabulaRadioTagModifier(tag: tag))
    }
}
