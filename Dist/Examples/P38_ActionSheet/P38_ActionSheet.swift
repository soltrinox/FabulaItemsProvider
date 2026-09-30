// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P38
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

public struct FabulaExample38_ActionSheet: View {
    
    @State private var showActionSheet = false
    @State private var stateText: String = "-"
    
    public init() {}
    public var body: some View {
#if os(iOS)
        VStack{
            Text(stateText)
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Title"),
                                message: Text("This is a ActionSheet message"),
                                buttons: [
                                    .default(
                                        Text("Ok"), action: {
                                            stateText = "Ok"
                                        }
                                    ),
                                    .cancel(
                                        Text("Cancel"), action: {
                                            stateText = "Cancel"
                                        }
                                    )])
                }
            Divider()
            Text("Show Action Sheet")
                .onTapGesture {
                    showActionSheet = true
                }
        }
        .padding()
#else
        EmptyView()
#endif
    }
}

struct FabulaExample38_ActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample38_ActionSheet()
    }
}
