//
//  FabulaConfirmationModifier.swift
//  Dist/Components/FabulaConfirmationModifier
//
//  Adapted from FabulaItemsProvider P110_ConfirmationDialog. MIT © 2022 jasudev.
//
//  Portable Dist component — standalone; no provider package import; no SPM resource bundle.
//

import SwiftUI

/// View modifier wrapping `confirmationDialog` with a production presentation binding.
public struct FabulaConfirmationModifier<Actions: View, Message: View>: ViewModifier {
    private let title: String
    @Binding private var isPresented: Bool
    private let titleVisibility: Visibility
    private let actions: () -> Actions
    private let message: () -> Message

    public init(
        _ title: String,
        isPresented: Binding<Bool>,
        titleVisibility: Visibility = .visible,
        @ViewBuilder message: @escaping () -> Message,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self.title = title
        self._isPresented = isPresented
        self.titleVisibility = titleVisibility
        self.message = message
        self.actions = actions
    }

    public func body(content: Content) -> some View {
        content
            .confirmationDialog(
                title,
                isPresented: $isPresented,
                titleVisibility: titleVisibility,
                actions: actions,
                message: message
            )
    }
}

public extension View {
    func fabulaConfirmationDialog<Actions: View>(
        _ title: String,
        isPresented: Binding<Bool>,
        titleVisibility: Visibility = .visible,
        @ViewBuilder actions: @escaping () -> Actions
    ) -> some View {
        modifier(
            FabulaConfirmationModifier(
                title,
                isPresented: isPresented,
                titleVisibility: titleVisibility,
                message: { EmptyView() },
                actions: actions
            )
        )
    }

    func fabulaConfirmationDialog<Actions: View, Message: View>(
        _ title: String,
        isPresented: Binding<Bool>,
        titleVisibility: Visibility = .visible,
        @ViewBuilder message: @escaping () -> Message,
        @ViewBuilder actions: @escaping () -> Actions
    ) -> some View {
        modifier(
            FabulaConfirmationModifier(
                title,
                isPresented: isPresented,
                titleVisibility: titleVisibility,
                message: message,
                actions: actions
            )
        )
    }
}
