// MIT © 2022 jasudev — adapted for Fabula Dist toolkit
// Upstream id: P88
// Adapted: local theme; print removed; no third-party.

import SwiftUI


import SwiftUI

#if os(iOS)
public struct FabulaExample88_DismissSearch: View {
    
    @State private var text: String = ""
    
    public init() {}
    public var body: some View {
        MainScreenView()
            .searchable(text: $text, prompt: Text("Search..."))
    }
}

fileprivate
struct MainScreenView: View {
    
    @State private var isPresented = false
    @Environment(\.isSearching) private var isSearching
    
    var body: some View {
        ZStack {
            if isSearching {
                Button {
                    isPresented = true
                } label: {
                    Text("Show SubView")
                        .padding()
                }
                .sheet(isPresented: $isPresented) {
                    NavigationView {
                        SubScreenView()
                    }
                }
            }else {
                Text("MainView")
            }
        }
    }
}

fileprivate
struct SubScreenView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.dismissSearch) private var dismissSearch
    
    var body: some View {
        Text("SubScreenView")
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading){
                    Button("dismiss") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("dismissSearch") {
                        dismissSearch()
                    }
                }
            }
    }
}
#else
public struct FabulaExample88_DismissSearch: View {
    
    public init() {}
    public var body: some View {
        EmptyView()
    }
}
#endif

struct FabulaExample88_DismissSearch_Previews: PreviewProvider {
    static var previews: some View {
        FabulaExample88_DismissSearch()
    }
}
