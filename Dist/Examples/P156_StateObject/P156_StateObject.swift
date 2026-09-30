// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P156
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample156_StateObject: View {
    
    class ViewModel: ObservableObject {
        @Published var value: Bool = false
    }
    
    @ObservedObject var viewModel = ViewModel()
    
    public init() {}
    public var body: some View {
        VStack {
            DetailView()
            Divider().padding()
            Toggle("Toggle", isOn: $viewModel.value)
        }
        .environmentObject(viewModel)
        .padding()
        .frame(maxWidth: 500)
    }
}

fileprivate
extension P156_StateObject {
    
    struct DetailView: View {
        
        @EnvironmentObject var viewModel: ViewModel
        
        var body: some View {
            Text("The value is: ") +
            Text("\(String(describing: viewModel.value))")
                .foregroundColor(viewModel.value ? Color.green : Color.gray)
        }
    }
}


struct FabulaExample156_StateObject_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample156_StateObject()
    }
}
