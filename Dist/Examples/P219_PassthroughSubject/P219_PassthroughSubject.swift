// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P219
// Adapted: local theme; print removed; no third-party.

import SwiftUI
import Combine


import SwiftUI
import Combine

public struct FabulaExample219_PassthroughSubject: View {
    
    let subject = PassthroughSubject<String, Error>()
    @State private var value: String = ""
    @State var cancellable: AnyCancellable? = nil
    
    public init() {}
    public var body: some View {
        VStack {
            Text("\(value)")
                .multilineTextAlignment(.center)
            Divider().frame(width: 44)
            Button {
                subject.send("A")
                subject.send("B")
                subject.send("C")
                subject.send("D")
//                cancellable?.cancel()
                subject.send("E")
                subject.send("F")
                subject.send(completion: .finished)
            } label: {
                Text("Send")
            }
            .buttonStyle(PlainButtonStyle())
        }
        .onAppear {
            cancellable = subject.sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.value += "An error has occurred.\n"
                case .finished:
                    self.value += "Publishing of data is complete.\n"
                }
            }, receiveValue: { value in
                self.value += "\(value)\n"
            })
        }
    }
}

struct FabulaExample219_PassthroughSubject_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample219_PassthroughSubject()
    }
}
