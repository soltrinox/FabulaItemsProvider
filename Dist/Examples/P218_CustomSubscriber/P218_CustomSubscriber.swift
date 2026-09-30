// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P218
// Adapted: local theme; print removed; no third-party.

import SwiftUI
import Combine


import SwiftUI
import Combine

public struct FabulaExample218_CustomSubscriber: View {
    
    fileprivate
    let subscriber = CustomSubscriber()
    let publisher = ["A", "B", "C", "D", "E", "F", "G"].publisher
    
    @State private var value: String = ""
    
    public init() {}
    public var body: some View {
        Text("\(value)")
            .onAppear {
                publisher.subscribe(subscriber)
                let _ = publisher.sink { _ in
                    self.value += "Publication of all data is complete.\n"
                } receiveValue: { value in
                    self.value += "Receive: \(value)\n"
                }
            }
    }
}

fileprivate
class CustomSubscriber: Subscriber {
    
    typealias Input = String // success type
    typealias Failure = Never // failure type
    
    func receive(completion: Subscribers.Completion<Failure>) {
        // print removed
    }
    func receive(subscription: Subscription) {
        // print removed
        subscription.request(.unlimited)
    }
    func receive(_ input: Input) -> Subscribers.Demand {
        // print removed
        return .none
    }
}

struct FabulaExample218_CustomSubscriber_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample218_CustomSubscriber()
    }
}
