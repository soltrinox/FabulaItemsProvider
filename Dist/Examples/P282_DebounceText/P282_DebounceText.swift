// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P282
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample282_DebouncedText: View {
    
    @State private var text: String = ""
    @State private var debouncedText: String = ""
    @State private var debounceFinished: Bool = true
    
    public init() {}
    public var body: some View {
        VStack {
            Text("Debounced Text : \(debouncedText)")
                .foregroundColor(debounceFinished ? .blue : .red)
            TextField("Enter your text.", text: $text)
                .textFieldStyle(.roundedBorder)
                .debouncedText(text: $text, debouncedText: $debouncedText)
            
        }
        .onChange(of: text) { newValue in
            debounceFinished = false
        }
        .onChange(of: debouncedText) { newValue in
            debounceFinished = true
        }
        .padding()
    }
}

fileprivate
struct DebouncedTextModifier: ViewModifier {
    
    @Binding var text: String
    @Binding var debouncedText: String
    @State private var debouncer: Debouncer
    
    init(text: Binding<String>, debouncedText: Binding<String>, delay: CGFloat) {
        self._text = text
        self._debouncedText = debouncedText
        _debouncer = State(initialValue: Debouncer(delay: delay))
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: text) { text in
                debouncer.run(action: {
                    debouncedText = text
        // print removed
                })
            }
    }
    
    class Debouncer {
        
        private let delay: TimeInterval
        private var workItem: DispatchWorkItem?
        
        init(delay: TimeInterval) {
            self.delay = delay
        }
        func run(action: @escaping () -> Void) {
            workItem?.cancel()
            let workItem = DispatchWorkItem(block: action)
            self.workItem = workItem
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
        }
    }
}

fileprivate
extension View {
    func debouncedText(text: Binding<String>, debouncedText: Binding<String>, delay: CGFloat = 0.5) -> some View {
        modifier(DebouncedTextModifier(text: text, debouncedText: debouncedText, delay: TimeInterval(delay)))
    }
}

struct FabulaExample282_DebouncedText_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample282_DebouncedText()
    }
}
