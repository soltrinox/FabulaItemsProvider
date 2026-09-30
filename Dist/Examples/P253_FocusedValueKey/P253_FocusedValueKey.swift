// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P253
// Adapted: local theme; print removed; no third-party.

import SwiftUI

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

public struct FabulaExample253_FocusedValueKey: View {
    
    public init() {}
    public var body: some View {
        ZStack {
            LocalTheme.back1
                .dismissKeyboardOnTap()
            VStack {
                Text("Memo")
                    .font(.title)
                Spacer()
                MemoPreview()
                    .foregroundColor(LocalTheme.fore1)
                Divider()
                MemoEditor()
                Divider()
                MemoButtons()
                    .frame(height: 32)
                    .padding()
                Spacer()
            }
        }
    }
}

//MARK: - subview
fileprivate
struct MemoEditor: View {
    
    @State private var title = ""
    @State private var bodyText = ""
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .focusedValue(\.activeField, .title)
                .focusedValue(\.textValue, title)
                .focusedValue(\.textBinding, $title)
                .textFieldStyle(.roundedBorder)
            TextEditor(text: $bodyText)
                .focusedValue(\.activeField, .body)
                .focusedValue(\.textValue, bodyText)
                .focusedValue(\.textBinding, $bodyText)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke()
                        .fill(LocalTheme.fore1.opacity(0.1))
                )
        }
        .padding()
    }
}

fileprivate
struct MemoButtons: View {
    @FocusedBinding(\.textBinding) var text
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                text = ""
            } label: {
                Text("Clear Title")
                    .padding()
                    .background(LocalTheme.secondary)
                    .cornerRadius(11)
            }
            .buttonStyle(.plain)
            Spacer()
        }
    }
}

fileprivate
struct MemoPreview: View {
    @FocusedValue(\.activeField) private var activeField
    @FocusedValue(\.textValue) private var text
    
    var body: some View {
        VStack {
            Group {
                if let activeField = activeField {
                    Text("\(activeField.rawValue) is focused.")
                        .bold()
                } else {
                    Text("Field is not focused.")
                }
            }
            .foregroundColor(LocalTheme.primary)
            Text(text ?? "")
        }
        .padding()
    }
}

//MARK: - enum
fileprivate
enum ActiveField: String {
    case title = "Title"
    case body = "Body"
}

//MARK: - FocusedValueKey
fileprivate
struct ActiveFieldKey : FocusedValueKey {
    typealias Value = ActiveField
}

fileprivate
struct FocusedMemoKey: FocusedValueKey {
    typealias Value = String
}

fileprivate
struct FocusedTextBinding: FocusedValueKey {
    typealias Value = Binding<String>
}

//MARK: - FocusedValues
fileprivate
extension FocusedValues {
    var textValue: FocusedMemoKey.Value? {
        get { self[FocusedMemoKey.self] }
        set { self[FocusedMemoKey.self] = newValue }
    }
    var activeField: ActiveFieldKey.Value? {
        get { self[ActiveFieldKey.self] }
        set { self[ActiveFieldKey.self] = newValue }
    }
    var textBinding: FocusedTextBinding.Value? {
        get { self[FocusedTextBinding.self] }
        set { self[FocusedTextBinding.self] = newValue }
    }
}

//MARK: - dismissKeyboard
fileprivate
struct DismissKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
#if os(macOS)
        return content
#else
        return content.gesture(tapGesture)
#endif
    }
    
    private var tapGesture: some Gesture {
        TapGesture().onEnded(endEditing)
    }
    
    private func endEditing() {
#if os(iOS)
        UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .map {$0 as? UIWindowScene}
            .compactMap({$0})
            .first?.windows
            .filter {$0.isKeyWindow}
            .first?.endEditing(true)
#endif
    }
}

fileprivate
extension View {
    func dismissKeyboardOnTap() -> some View {
        modifier(DismissKeyboardOnTap())
    }
}

struct FabulaExample253_FocusedValueKey_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample253_FocusedValueKey()
    }
}


