// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P111
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample111_Sheet: View {
    
    @State private var isShowSheet = false
    
    public init() {}
    public var body: some View {
        Button(action: {
            isShowSheet.toggle()
        }) {
            Text("Show Sheet")
        }
        .sheet(isPresented: $isShowSheet,
               onDismiss: didDismiss) {
            SheetDetailView(isShowSheet: $isShowSheet)
        }
    }
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}

fileprivate
struct SheetDetailView: View {
    
    @Binding var isShowSheet: Bool
    
    var body: some View {
        VStack {
            Text("Sheet Detail Screen")
                .font(.title)
                .padding(50)
            Button("Dismiss",
                   action: {
                isShowSheet.toggle()
                
            })
                .padding()
        }
    }
}

struct FabulaExample111_Sheet_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample111_Sheet()
    }
}
