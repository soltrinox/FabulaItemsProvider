// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P220
// Adapted: local theme; print removed; no third-party.

import SwiftUI
import Combine


import SwiftUI
import Combine

public struct FabulaExample220_CurrentValueSubject: View {
    
    let currentStatus = CurrentValueSubject<Bool, Error>(true)
    @State private var value: String = ""
    @State var cancellable: AnyCancellable? = nil
    
    public init() {}
    public var body: some View {
        VStack {
            Text("\(value)")
                .multilineTextAlignment(.center)
            Divider().frame(width: 44)
            Button {
                self.value += "init \(currentStatus.value)\n"
                currentStatus.send(false)
                currentStatus.value = true
                currentStatus.send(completion: .finished)
            } label: {
                Text("Send")
            }
            .buttonStyle(PlainButtonStyle())
        }
        .onAppear {
            cancellable = currentStatus.sink(receiveCompletion: { completion in
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

struct FabulaExample220_CurrentValueSubject_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample220_CurrentValueSubject()
    }
}
